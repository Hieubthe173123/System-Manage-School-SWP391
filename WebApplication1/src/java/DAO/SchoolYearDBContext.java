/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Class;
import Entity.ClassSession;
import Entity.Lecturers;
import Entity.Lecturers_Class_Session;
import Entity.SchoolYear;
import Entity.Session;
import Entity.Student;
import Entity.StudentClassSession;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
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
                school.setDateStart(rs.getString("dateStart"));
                school.setDateEnd(rs.getString("dateEnd"));
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
                school.setDateStart(rs.getString("dateStart"));
                school.setDateEnd(rs.getString("dateEnd"));
                list.add(school);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list; // Return the list
    }

    public ArrayList<StudentClassSession> getHistorySchoolYearbyStuid(String stuid) {
        ArrayList<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "s.stuid,\n"
                    + "s.sname,\n"
                    + "s.dob,\n"
                    + "se.sid,\n"
                    + "se.Sname,\n"
                    + "c.classID,\n"
                    + "c.clname,\n"
                    + "cs.csid,\n"
                    + "y.yid,\n"
                    + "l.lid,\n"
                    + "l.lname,\n"
                    + "y.dateStart,\n"
                    + "y.dateEnd\n"
                    + "FROM \n"
                    + "Student_Class_Session scs\n"
                    + "JOIN \n"
                    + "Student s ON s.stuid = scs.stuid\n"
                    + "JOIN \n"
                    + "Class_Session cs ON scs.csid = cs.csid\n"
                    + "join Lecturers_Class_Session lcs on lcs.csid = scs.csid \n"
                    + "join Lecturers l on l.lid = lcs.lid\n"
                    + "JOIN \n"
                    + "Session se on cs.sid = se.sid\n"
                    + "JOIN\n"
                    + "Class c on cs.classID = c.classID\n"
                    + "JOIN \n"
                    + "SchoolYear y ON cs.yid = y.yid\n"
                    + "WHERE s.stuid = ?;";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, stuid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentClassSession scs = new StudentClassSession();

                Student stu = new Student();
                stu.setStuid(rs.getInt("stuid"));
                stu.setSname(rs.getString("sname"));
                stu.setDob(rs.getString("dob"));
                scs.setStuid(stu);

                Session ses = new Session();
                ses.setSid(rs.getInt("sid"));
                ses.setSname(rs.getString("sname"));

                Class cla = new Class();
                cla.setClassid(rs.getInt("classID"));
                cla.setClname(rs.getString("clname"));

                SchoolYear year = new SchoolYear();
                year.setYid(rs.getInt("yid"));
                year.setDateStart(rs.getString("dateStart"));
                year.setDateEnd(rs.getString("dateEnd"));

                ClassSession cls = new ClassSession();
                cls.setCsid(rs.getInt("csid"));
                cls.setSid(ses);
                cls.setClassID(cla);
                cls.setYid(year);
                scs.setCsid(cls);

                Lecturers lec = new Lecturers();
                lec.setLid(rs.getInt("lid"));
                lec.setLname(rs.getString("lname"));
                

                Lecturers_Class_Session lcs = new Lecturers_Class_Session();
                lcs.setLid(lec);
                lcs.setCsid(cls);
                
                list.add(scs);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public static void main(String[] args) {
        SchoolYearDBContext sc = new SchoolYearDBContext();
        ArrayList<StudentClassSession> sc1 = sc.getHistorySchoolYearbyStuid("1");
        System.out.println(sc1);
    }
}
