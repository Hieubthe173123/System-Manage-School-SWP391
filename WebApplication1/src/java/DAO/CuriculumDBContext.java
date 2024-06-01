/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Curiculum;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class CuriculumDBContext extends DBContext {

    public static void main(String[] args) {
        CuriculumDBContext db = new CuriculumDBContext();
        List<Curiculum> curi = db.getAllCuriculum();
        System.out.println(curi.size());
    }

    public List<Curiculum> getCuriculumById(int id) {
        List<Curiculum> curi = new ArrayList<>();
        
        try {
            String sql = "SELECT [curID]\n"
                    + "      ,[nameAct]\n"
                    + "      ,[sdid]\n"
                    + "      ,[isFix]\n"
                    + "      ,[TimeStart]\n"
                    + "      ,[TimeEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[Curiculum] Where sdid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum curiculum = new Curiculum();
                SessionDetailDBContext sesD = new SessionDetailDBContext();
                curiculum.setCurID(rs.getInt("curID"));
                curiculum.setTimeEnd(convertTime(rs.getString("TimeEnd"), "HH:mm:ss.SSSSSSS", "HH:mm"));
                curiculum.setTimeStart(convertTime(rs.getString("TimeStart"), "HH:mm:ss.SSSSSSS", "HH:mm"));
                curiculum.setNameAct(rs.getString("nameAct"));
                curiculum.setSdid(sesD.getSessionDetailById(rs.getInt("sdid")));
                curiculum.setIsFix(rs.getBoolean("isFix"));
                curi.add(curiculum);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return curi;
    }
    
    public List<Curiculum> getAllCuriculum() {
        List<Curiculum> curi = new ArrayList<>();
        
        try {
            String sql = "SELECT [curID]\n"
                    + "      ,[nameAct]\n"
                    + "      ,[sdid]\n"
                    + "      ,[isFix]\n"
                    + "      ,[TimeStart]\n"
                    + "      ,[TimeEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[Curiculum]";
            PreparedStatement stm = connection.prepareStatement(sql);
     
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum curiculum = new Curiculum();
                SessionDetailDBContext sesD = new SessionDetailDBContext();
                curiculum.setCurID(rs.getInt("curID"));
                curiculum.setTimeEnd(convertTime(rs.getString("TimeEnd"), "HH:mm:ss.SSSSSSS", "HH:mm"));
                curiculum.setTimeStart(convertTime(rs.getString("TimeStart"), "HH:mm:ss.SSSSSSS", "HH:mm"));
                curiculum.setNameAct(rs.getString("nameAct"));
                curiculum.setSdid(sesD.getSessionDetailById(rs.getInt("sdid")));
                curiculum.setIsFix(rs.getBoolean("isFix"));
                curi.add(curiculum);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return curi;
    }


    public List<Curiculum> getCuriculumBySessionId(int id) {
        List<Curiculum> curi = new ArrayList<>();
        try {
            String sql = "SELECT [curID]\n"
                    + "      ,[nameAct]\n"
                    + "      ,[sdid]\n"
                    + "      ,[isFix]\n"
                    + "      ,[TimeStart]\n"
                    + "      ,[TimeEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[Curiculum] Where sdid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum curiculum = new Curiculum();
                SessionDetailDBContext sesD = new SessionDetailDBContext();

                curiculum.setCurID(rs.getInt("curID"));
                curiculum.setTimeEnd(convertTime(rs.getString("TimeEnd"), "HH:mm:ss.SSSSSSS", "HH:mm"));
                curiculum.setTimeStart(convertTime(rs.getString("TimeStart"), "HH:mm:ss.SSSSSSS", "HH:mm"));
                curiculum.setNameAct(rs.getString("nameAct"));
                curiculum.setSdid(sesD.getSessionDetailById(rs.getInt("sdid")));
                curiculum.setIsFix(rs.getBoolean("isFix"));
                curi.add(curiculum);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return curi;
    }
    
    public String convertTime(String inputTime, String inputFormat, String outputFormat) {
        // Định dạng đầu vào
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern(inputFormat);
        // Định dạng đầu ra
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern(outputFormat);

        // Chuyển đổi thời gian từ chuỗi sang LocalTime
        LocalTime time = LocalTime.parse(inputTime, inputFormatter);
        // Định dạng lại thời gian sang định dạng mong muốn và trả về kết quả
        return time.format(outputFormatter);
    }
}
