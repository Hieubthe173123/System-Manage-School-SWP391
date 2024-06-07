package HomePage;

import DAO.AgeDBContext;
import DAO.FoodDBContext;
import DAO.MealTimeDBContext;
import DAO.MenuDBContext;
import Entity.AgeCategory;
import Entity.Food;
import Entity.MealTime;
import Entity.Menu;
import Entity.MenuFood;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

@WebServlet(name = "Menu", urlPatterns = {"/menu"})
public class AddMenu extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FoodDBContext foodDB = new FoodDBContext();
        MealTimeDBContext mealDB = new MealTimeDBContext();
        Date date = new Date();
        HttpSession session = request.getSession();
        SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
        AgeDBContext age = new AgeDBContext();
        List<AgeCategory> listAge = age.getAllAgeCategory();
        List<Food> listFood = foodDB.getAllFood();
        List<MealTime> listMeal = mealDB.getAllMealTime();
        MenuDBContext menu = new MenuDBContext();
        List<Menu> listMenu = menu.getMenuByDate(dateF.format(date));
        if (listFood == null || listMeal == null) {
            request.setAttribute("Mess", "Các món ăn trong danh sách food đang bị trống. Vui lòng nhập vào các món ăn trước khi nhập menu");
        } else {
            request.setAttribute("listFood", listFood);
            session.setAttribute("listMeal", listMeal);
            session.setAttribute("listAgeCategory", listAge);
            session.setAttribute("listMenu", listMenu);
        }

        List<MenuFood> listMenuFood = (List<MenuFood>) session.getAttribute("listMenuFood");
        if (listMenuFood == null) {
            listMenuFood = new ArrayList<>();
            session.setAttribute("listMenuFood", listMenuFood);
        }

        String foodid = request.getParameter("foodid");
        if (foodid != null) {
            request.setAttribute("fid", Integer.parseInt(foodid));
        }

        request.getRequestDispatcher("FE_Parent/Menu.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Date date = new Date();
        HttpSession session = request.getSession();
        SimpleDateFormat dateF = new SimpleDateFormat("yyyy-MM-dd");
        String mealID = request.getParameter("mealID");
        String foodid = request.getParameter("foodid");
        String save = request.getParameter("save");
        String age_raw = request.getParameter("ageid");
        String age = (String) session.getAttribute("ageid");
        MenuDBContext menuDB = new MenuDBContext();
        session.setAttribute("Err", "");
        session.setAttribute("warn", "");
        session.setAttribute("Mess", "");

        if (age_raw != null) {
            age = age_raw;
            session.setAttribute("ageid", age_raw);
        }

        FoodDBContext foodDB = new FoodDBContext();
        List<MenuFood> listMenuFood = (List<MenuFood>) session.getAttribute("listMenuFood");
        if (listMenuFood == null) {
            listMenuFood = new ArrayList<>();
        }

        if (save != null && "1".equals(save)) {
            StringBuilder menuF = new StringBuilder();

            if (!listMenuFood.isEmpty()) {
                for (MenuFood menuFood : listMenuFood) {
                    if (menuFood.getMealid() == Integer.parseInt(mealID)) {
                        Food food = menuFood.getFood();
                        if (food != null) {
                            menuF.append(food.getFname()).append(", ");
                        } else {
                            request.setAttribute("Mess", "Không có thực phẩm trong thực đơn. ");
                        }
                    }
                }
                
                if (menuF.length() > 0 && menuF.toString().endsWith(", ")) {
                    menuF.setLength(menuF.length() - 2);
                }

                boolean exists = false;
                List<Menu> listSubMenu = menuDB.getMenuByDate(dateF.format(date));
                if (age != null && mealID != null && !age.equalsIgnoreCase("0")) {
                    for (Menu menuFood : listSubMenu) {
                        if (menuFood.getMealID().getMealID() == Integer.parseInt(mealID)
                                && menuFood.getAgeid().getAgeid() == Integer.parseInt(age)) {
                            exists = true;
                            break;
                        }
                    }
                    if (exists == true) {
                        menuDB.update(dateF.format(date), menuF.toString(), Integer.parseInt(age), Integer.parseInt(mealID));
                        session.setAttribute("Mess", "Bữa ăn này đã tồn tại và được thay thế bằng bữa ăn bạn vừa nhập.");
                    } else if (exists == false) {
                        menuDB.insertMenu(Integer.parseInt(age), dateF.format(date), menuF.toString(), Integer.parseInt(mealID));
                        session.setAttribute("Mess", "Thêm thành công 1 bữa ăn!");
                    }
                    listMenuFood.clear();
                } else {
                    session.setAttribute("Err", "Bạn chưa nhập độ tuổi.");
                    listMenuFood.clear();
                }
            } else {
                session.setAttribute("Mess", "Danh sách thực đơn trống!");
                listMenuFood.clear();
            }
        }

        if (mealID != null && foodid != null && !foodid.equals("0")) {
            Food selectedFood = foodDB.getFoodById(Integer.parseInt(foodid));
            if (selectedFood != null) {
                int fid = selectedFood.getFoodid();
                boolean foodExists = false;

                // Check if the food already exists in the list for the given mealID
                for (MenuFood menuFood : listMenuFood) {
                    if (menuFood.getMealid() == Integer.parseInt(mealID) && menuFood.getFood().getFoodid() == fid) {
                        foodExists = true;
                        break;
                    }
                }

                if (foodExists) {
                    session.setAttribute("Err", "Món ăn đã tồn tại trong danh sách!");
                } else {
                    MenuFood mf = new MenuFood(Integer.parseInt(mealID), selectedFood);
                    listMenuFood.add(mf);
                    session.setAttribute("listMenuFood", listMenuFood);
                }
            }
        }

        response.sendRedirect("menu");
    }

    public String convertToStandardFormat(String dateString) {
        List<String> dateFormats = Arrays.asList(
                "yyyy-MM-dd",
                "dd-MM-yyyy",
                "MM-dd-yyyy",
                "dd/MM/yyyy",
                "MM/dd/yyyy",
                "yyyy/MM/dd",
                "yyyy.MM.dd",
                "dd.MM.yyyy",
                "MM.dd.yyyy"
        );

        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        for (String format : dateFormats) {
            DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern(format);
            try {
                LocalDate date = LocalDate.parse(dateString, inputFormatter);
                return date.format(outputFormatter);
            } catch (DateTimeParseException e) {
                // Ignore and try the next format
            }
        }

        return null; // Nếu không định dạng nào phù hợp
    }

    private final List<DateTimeFormatter> DATE_FORMATTERS = Arrays.asList(
            DateTimeFormatter.ofPattern("yyyy-MM-dd"),
            DateTimeFormatter.ofPattern("dd/MM/yyyy"),
            DateTimeFormatter.ofPattern("MM/dd/yyyy"),
            DateTimeFormatter.ofPattern("dd-MM-yyyy"),
            DateTimeFormatter.ofPattern("yyyy/MM/dd")
    // Add more formats as needed
    );

    public LocalDateTime parseDate(String dateString) {
        for (DateTimeFormatter formatter : DATE_FORMATTERS) {
            try {
                return LocalDate.parse(dateString, formatter).atStartOfDay();
            } catch (DateTimeParseException e) {
                // Continue to next formatter
            }
            try {
                return LocalDateTime.parse(dateString, formatter);
            } catch (DateTimeParseException e) {
                // Continue to next formatter
            }
        }
        throw new IllegalArgumentException("Date format not recognized: " + dateString);
    }

    public int compareDates(String dateStr1, String dateStr2) {
        try {
            LocalDateTime date1 = parseDate(dateStr1);
            LocalDateTime date2 = parseDate(dateStr2);

            return date1.compareTo(date2);
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
            return 0; // or handle error appropriately
        }
    }

    @Override
    public String getServletInfo() {
        return "Menu management servlet";
    }
}
