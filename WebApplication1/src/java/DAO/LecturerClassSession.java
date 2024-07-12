/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Lecturers_Class_Session;
import Entity.Parent;
import Entity.Student;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class LecturerClassSession extends DBContext {

    public Lecturers_Class_Session getLecturerByCsidById(int id) {
        Lecturers_Class_Session lec = new Lecturers_Class_Session();
        try {
            String sql = "SELECT [lclassID]\n"
                    + "      ,[lid]\n"
                    + "      ,[csid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Lecturers_Class_Session] Where csid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Class_SessionDBContext classSess = new Class_SessionDBContext();
                LecturersDBContext lectu = new LecturersDBContext();
                lec.setLclassID(rs.getInt("scid"));
                lec.setCsid(classSess.getClassSessionById(rs.getInt("csid")));
                lec.setLid(lectu.getLecturerByid(rs.getInt("csid")));
                return lec;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    public List<Student> getStudentsForLecturers(int lid) {
        List<Student> list = new ArrayList<>();
        String sql = "SELECT S.stuid, S.sname, S.dob, S.gender, P.phoneNumber, P.pname " +
                     "FROM Student S " +
                     "INNER JOIN Student_Class_Session SCS ON S.stuid = SCS.stuid " +
                     "INNER JOIN Class_Session CS ON SCS.csid = CS.csid " +
                     "INNER JOIN Lecturers_Class_Session LCS ON CS.csid = LCS.csid " +
                     "INNER JOIN Parent P ON S.pid = P.pid " +
                     "INNER JOIN Class CL ON CS.classID = CL.classID " +
                     "INNER JOIN SchoolYear SY ON CS.yid = SY.yid " +
                     "WHERE SY.dateEnd = (SELECT MAX(dateEnd) FROM SchoolYear) " +
                     "AND LCS.lid = ?";
        
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, lid); // Set lid parameter
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setDob(rs.getString("dob"));
                student.setGender(rs.getBoolean("gender"));

                Parent parent = new Parent();
                parent.setPname(rs.getString("pname"));
                parent.setPhoneNumber(rs.getString("phoneNumber"));

                // Set parent object to student
                student.setPid(parent);

                list.add(student);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log or handle the exception properly
        }
        return list;
    }
}
