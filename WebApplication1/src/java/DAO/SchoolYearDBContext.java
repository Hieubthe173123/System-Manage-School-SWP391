/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.ClassSession;
import Entity.SchoolYear;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
    
    public ArrayList<SchoolYear> getSchoolYearById(String id) {
        ArrayList<SchoolYear> list = new ArrayList<>();
        try {
            String sql = "SELECT [yid]\n"
                    + "      ,[dateStart]\n"
                    + "      ,[dateEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[SchoolYear]\n"
                    + "  WHERE yid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                SchoolYear year = new SchoolYear();
                year.setYid(rs.getInt("yid"));
                year.setDateStart(rs.getDate("dateStart"));
                year.setDateEnd(rs.getDate("dateEnd"));
                list.add(year);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }
    
    public ArrayList<ClassSession> getClassSessionByYid(String id) {
        ArrayList<ClassSession> list = new ArrayList<>();
        try {
            String sql = "SELECT [csid]\n"
                    + "      ,[classID]\n"
                    + "      ,[yid]\n"
                    + "      ,[sid]\n"
                    + "      ,[rid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Class_Session]\n"
                    + "  WHERE yid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClassSession cls = new ClassSession();
                ClassDBContext cldb = new ClassDBContext();
                RoomDBContext rdb = new RoomDBContext();
                SessionDBContext sedb = new SessionDBContext();
                SchoolYearDBContext yearDB = new SchoolYearDBContext();

                StudentClassSessionDBContext stuDB = new StudentClassSessionDBContext();
                LecturerClassSession lecDB = new LecturerClassSession();

                cls.setCsid(rs.getInt("csid"));
                cls.setClassID(cldb.getClassById(rs.getInt("classID")));
                cls.setRid(rdb.getRoomByRid(rs.getInt("rid")));
                cls.setSid(sedb.getSessionById(rs.getInt("sid")));
                cls.setYid(yearDB.getSchoolYearById(rs.getInt("yid")));

                list.add(cls);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;

    }

}
