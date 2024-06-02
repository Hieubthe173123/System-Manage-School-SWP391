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
                school.setYid(rs.getInt("mid"));
                school.setDateStart(rs.getDate("dateStart"));
                school.setDateEnd(rs.getDate("dateEnd"));
                return school;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
       public List<SchoolYear> getAllSchoolYear() {
        List<SchoolYear> list = new ArrayList<>();
        try {
            String sql = "SELECT TOP (1000) [yid], [dateStart], [dateEnd] FROM [SchoolManagement].[dbo].[SchoolYear]";
            PreparedStatement stm = connection.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) { 
                SchoolYear school = new SchoolYear();
                school.setYid(rs.getInt("yid"));
                school.setDateStart(rs.getDate("dateStart"));
                school.setDateEnd(rs.getDate("dateEnd"));
                list.add(school); 
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list; // Return the list
    }

    public static void main(String[] args) {
        SchoolYearDBContext sc = new SchoolYearDBContext();
        List<SchoolYear> sc1 = sc.getAllSchoolYear();
        System.out.println(sc1);
    }
}
