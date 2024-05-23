/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Student;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class StudentDBContext extends DBContext {

    public ArrayList<Student> getAllStudent() {
        ParentDBContext parent = new ParentDBContext();
        ArrayList<Student> students = new ArrayList<>();
        try {
            String sql = "SELECT [stuid]\n"
                    + "      ,[sname]\n"
                    + "      ,[age]\n"
                    + "      ,[dob]\n"
                    + "      ,[gender]\n"
                    + "      ,[Address]\n"
                    + "      ,[pid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setAge(rs.getInt("age"));
                student.setDob(rs.getString("dob"));
                student.setGender(rs.getBoolean("gender"));
                student.setAddress(rs.getString("Address"));
                student.setPid(parent.getParentByid(rs.getInt("pid")));
                students.add(student);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return students;
    }

    public Student getStudentById(int id) {
        ParentDBContext parent = new ParentDBContext();
        try {
            String sql = "SELECT [stuid]\n"
                    + "      ,[sname]\n"
                    + "      ,[age]\n"
                    + "      ,[dob]\n"
                    + "      ,[gender]\n"
                    + "      ,[Address]\n"
                    + "      ,[pid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student] where stuid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setAge(rs.getInt("age"));
                student.setDob(rs.getString("dob"));
                student.setGender(rs.getBoolean("gender"));
                student.setAddress(rs.getString("Address"));
                student.setPid(parent.getParentByid(rs.getInt("pid")));
                return student;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Student> getStudentByIdUser(int id) {
        ParentDBContext parent = new ParentDBContext();
        ArrayList<Student> students = new ArrayList<>();
        try {
            String sql = "SELECT [stuid]\n"
                    + "      ,[sname]\n"
                    + "      ,[age]\n"
                    + "      ,[dob]\n"
                    + "      ,[gender]\n"
                    + "      ,[Address]\n"
                    + "      ,[pid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student] where pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {  // Sửa đổi từ if sang while
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setAge(rs.getInt("age"));
                student.setDob(rs.getString("dob"));
                student.setGender(rs.getBoolean("gender"));
                student.setAddress(rs.getString("Address"));
                student.setPid(parent.getParentByid(rs.getInt("pid")));
                students.add(student);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return students;  // Trả về danh sách sinh viên
    }
    
    public List<Student> getStudentByPid(int id) {
          List<Student> list = new ArrayList<>();
        ParentDBContext parent = new ParentDBContext();
        try {
            String sql = "SELECT [stuid]\n"
                    + "      ,[sname]\n"
                    + "      ,[age]\n"
                    + "      ,[dob]\n"
                    + "      ,[gender]\n"
                    + "      ,[Address]\n"
                    + "      ,[pid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student] where pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setAge(rs.getInt("age"));
                student.setDob(rs.getString("dob"));
                student.setGender(rs.getBoolean("gender"));
                student.setAddress(rs.getString("Address"));
                student.setPid(parent.getParentByid(rs.getInt("pid")));
                list.add(student);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

}
