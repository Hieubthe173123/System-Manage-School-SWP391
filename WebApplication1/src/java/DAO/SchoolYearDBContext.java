/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Lecturers_Class_Session;
import Entity.SchoolYear;
import Entity.Class;
import Entity.ClassSession;
import Entity.Lecturers;
import Entity.Room;
import Entity.Session;
import Entity.Student;
import Entity.StudentClassSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
                school.setYid(rs.getInt("yid"));
                school.setDateStart(rs.getDate("dateStart"));
                school.setDateEnd(rs.getDate("dateEnd"));
                return school;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<SchoolYear> getAllSchoolYear() {
        ArrayList<SchoolYear> list = new ArrayList<>();
        try {
            String sql = "SELECT [yid]\n"
                    + "      ,[dateStart]\n"
                    + "      ,[dateEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[SchoolYear]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SchoolYear year = new SchoolYear();
                year.setYid(rs.getInt("yid"));
                year.setDateStart(rs.getDate("dateStart"));
                year.setDateEnd(rs.getDate("dateEnd"));
                list.add(year);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    
}


