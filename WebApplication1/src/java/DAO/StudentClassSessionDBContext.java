/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.StudentClassSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class StudentClassSessionDBContext extends DBContext {

    public static void main(String[] args) {
        StudentClassSessionDBContext d = new StudentClassSessionDBContext();
        StudentClassSession s = d.getStudentClassSessionByStuid(1, 2);
        System.out.println(s.getCsid().getCsid());
    }

    public List<StudentClassSession> getStudentClassSessionById(int id) {
        List<StudentClassSession> stu = new ArrayList();
        try {
            String sql = "SELECT [scid]\n"
                    + "      ,[stuid]\n"
                    + "      ,[csid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student_Class_Session] where stuid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                StudentClassSession student = new StudentClassSession();
                Class_SessionDBContext classSess = new Class_SessionDBContext();
                StudentDBContext stud = new StudentDBContext();
                student.setScid(rs.getInt("scid"));
                student.setCsid(classSess.getClassSessionById(rs.getInt("csid")));
                student.setStuid(stud.getStudentById(rs.getInt("stuid")));

                stu.add(student);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return stu;
    }

    public StudentClassSession getStudentClassSessionByStuid(int id, int yid) {
        StudentClassSession stu = new StudentClassSession();
        try {
            String sql = "  SELECT [scid] ,[stuid] , s.[csid] FROM [SchoolManagement].[dbo].[Student_Class_Session] s Inner Join Class_Session s1\n"
                    + "  ON s.csid = s1.csid Where s.stuid = ? and s1.yid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setInt(2, yid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                StudentClassSession student = new StudentClassSession();
                Class_SessionDBContext classSess = new Class_SessionDBContext();
                StudentDBContext stud = new StudentDBContext();
                student.setScid(rs.getInt("scid"));
                student.setCsid(classSess.getClassSessionById(rs.getInt("csid")));
                student.setStuid(stud.getStudentById(rs.getInt("stuid")));

                return student;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

}
