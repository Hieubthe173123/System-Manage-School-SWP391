/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Student;
import Entity.Class;
import Entity.ClassSession;
import Entity.Parent;
import Entity.StudentClassSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

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
    
    public List<StudentClassSession> pagingStudent(int index) {
    List<StudentClassSession> list = new ArrayList<>();
    try {
        String sql = "SELECT S.stuid, S.sname, S.dob, S.gender, S.[Address], P.pid, C.classID, C.clname "
                + "FROM Student S "
                + "INNER JOIN Student_Class_Session SCS ON S.stuid = SCS.stuid "
                + "INNER JOIN Class_Session CS ON SCS.csid = CS.csid "
                + "INNER JOIN Class C ON CS.classID = C.classID "
                + "INNER JOIN Parent P ON S.pid = P.pid "
                + "ORDER BY S.stuid OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY;";

        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, (index - 1) * 10);  // Calculate the correct offset
        ResultSet rs = stm.executeQuery();
        
        while (rs.next()) {
            Student student = new Student();
            student.setStuid(rs.getInt("stuid"));
            student.setSname(rs.getString("sname"));
            student.setGender(rs.getBoolean("gender"));
            student.setDob(rs.getString("dob"));
            student.setAddress(rs.getString("Address"));

            Class cl = new Class();
            cl.setClassid(rs.getInt("classID")); 
            cl.setClname(rs.getString("clname"));

            ClassSession cs = new ClassSession();
            cs.setClassID(cl);

            Parent parent = new Parent();
            parent.setPid(rs.getInt("pid"));
            student.setPid(parent);

            StudentClassSession stuClass = new StudentClassSession();
            stuClass.setCsid(cs);
            stuClass.setStuid(student);
            list.add(stuClass);
        }
    } catch (SQLException e) {
        Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, e);
    }
    return list;
}
}