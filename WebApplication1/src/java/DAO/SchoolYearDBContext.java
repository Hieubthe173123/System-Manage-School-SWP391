/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.SchoolYear;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class SchoolYearDBContext extends DBContext {
    SchoolYear s = new SchoolYear();
    public static void main(String[] args) {
        SchoolYearDBContext s = new SchoolYearDBContext();
        System.out.println(s.getSchoolYearByDateNow("2024-06-03"));
    }

    public SchoolYear getSchoolYearById(int id) {
        SchoolYear school = new SchoolYear();
        try {
            String sql = "SELECT [yid]\n"
                    + "      ,[dateStart]\n"
                    + "      ,[dateEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[SchoolYear] Where yid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                FoodDBContext food = new FoodDBContext();
                MealTimeDBContext meal = new MealTimeDBContext();
                AgeDBContext age = new AgeDBContext();
                school.setYid(rs.getInt("yid"));
                school.setDateStart(s.formatDate(rs.getString("dateStart")));
                school.setDateEnd(s.formatDate(rs.getString("dateEnd")));
                return school;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public SchoolYear getSchoolYearByDateNow(String date) {
        SchoolYear school = new SchoolYear();
        try {
            String sql = "SELECT [yid]\n"
                    + "      ,[dateStart]\n"
                    + "      ,[dateEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[SchoolYear]\n"
                    + "  Where dateStart <= ? and dateEnd >= ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, date);
            stm.setString(2, date);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                FoodDBContext food = new FoodDBContext();
                MealTimeDBContext meal = new MealTimeDBContext();
                AgeDBContext age = new AgeDBContext();
                school.setYid(rs.getInt("yid"));
                school.setDateStart(s.formatDate(rs.getString("dateStart")));
                school.setDateEnd(s.formatDate(rs.getString("dateEnd")));
                return school;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public List<SchoolYear> getAllSchoolYear() {
        List<SchoolYear> sch = new ArrayList<SchoolYear>();
        try {
            String sql = "SELECT [yid]\n"
                    + "      ,[dateStart]\n"
                    + "      ,[dateEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[SchoolYear]";
            PreparedStatement stm = connection.prepareStatement(sql);


            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                SchoolYear school = new SchoolYear();
                FoodDBContext food = new FoodDBContext();
                MealTimeDBContext meal = new MealTimeDBContext();
                AgeDBContext age = new AgeDBContext();
                school.setYid(rs.getInt("yid"));
                school.setDateStart(s.formatDate(rs.getString("dateStart")));
                school.setDateEnd(s.formatDate(rs.getString("dateEnd")));
                sch.add(school);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return sch;
    }
}
