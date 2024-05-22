/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Menu;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class MenuDBContext extends DBContext{
    public Menu getMenuById(int id, String date) {
        Menu menu = new Menu();
        try {
            String sql = "SELECT [mid]\n"
                    + "      ,[date]\n"
                    + "      ,[foodid]\n"
                    + "      ,[ageid]\n"
                    + "      ,[mealID]\n"
                    + "  FROM [SchoolManagement].[dbo].[Menu] Where ageid = ? and date = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setString(2, date);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                FoodDBContext food = new FoodDBContext();
                MealTimeDBContext meal = new MealTimeDBContext();
                AgeDBContext age = new AgeDBContext();
                menu.setMid(rs.getInt("mid"));
                menu.setDate(rs.getDate("date"));
                menu.setAgeid(age.getAgeById(rs.getInt("ageid")));
                menu.setFoodid(food.getFoodById(rs.getInt("foodid")));
                menu.setMealID(meal.getMealTimeById(rs.getInt("mealID")));
                return menu;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Menu> getMenuByAgeAndDate(int id, String date) {
        List<Menu> me = new ArrayList<>();
        try {
            String sql = "SELECT [mid]\n"
                    + "      ,[date]\n"
                    + "      ,[foodid]\n"
                    + "      ,[ageid]\n"
                    + "      ,[mealID]\n"
                    + "  FROM [SchoolManagement].[dbo].[Menu] Where ageid = ? and date = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setString(2, date);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                FoodDBContext food = new FoodDBContext();
                MealTimeDBContext meal = new MealTimeDBContext();
                AgeDBContext age = new AgeDBContext();
                Menu menu = new Menu();
                menu.setMid(rs.getInt("mid"));
                menu.setDate(rs.getDate("date"));
                menu.setAgeid(age.getAgeById(rs.getInt("ageid")));
                menu.setFoodid(food.getFoodById(rs.getInt("foodid")));
                menu.setMealID(meal.getMealTimeById(rs.getInt("mealID")));
                me.add(menu);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return me;
    }

}
