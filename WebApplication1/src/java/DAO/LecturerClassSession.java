/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Lecturers;
import Entity.Class;
import Entity.ClassSession;
import Entity.Lecturers_Class_Session;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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

    public List<Lecturers_Class_Session> getAllLecturerClassSessions() {
        List<Lecturers_Class_Session> list = new ArrayList<>();

        try {
            String sql = "SELECT\n"
                    + "    L.lid,\n"
                    + "    L.lname,\n"
                    + "    L.dob,\n"
                    + "    L.gender,\n"
                    + "    L.phoneNumber,\n"
                    + "    L.IDcard,\n"
                    + "    L.[Address],\n"
                    + "    L.NickName,\n"
                    + "    L.Email,\n"
                    + "    C.classID,\n"
                    + "    C.clname\n"
                    + "FROM\n"
                    + "    Lecturers L\n"
                    + "INNER JOIN\n"
                    + "    Lecturers_Class_Session LCS ON L.lid = LCS.lid\n"
                    + "INNER JOIN\n"
                    + "    Class_Session CS ON LCS.csid = CS.csid\n"
                    + "INNER JOIN\n"
                    + "    Class C ON CS.classID = C.classID;";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                LecturerClassSession lecturerClassSession = new LecturerClassSession();

                Lecturers lecturer = new Lecturers();
                lecturer.setLid(rs.getInt("lid"));
                lecturer.setLname(rs.getString("lname"));
                lecturer.setGender(rs.getBoolean("gender"));
                lecturer.setDob(rs.getString("dob"));
                lecturer.setPhoneNumber(rs.getString("phoneNumber"));
                lecturer.setIDcard(rs.getString("IDcard"));
                lecturer.setEmail(rs.getString("Email"));
                lecturer.setAddress(rs.getString("Address"));
                lecturer.setNickname(rs.getString("NickName"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID"));
                cl.setClname(rs.getString("clname"));
                
                ClassSession cs = new ClassSession();
                cs.setClassID(cl);
                
                Lecturers_Class_Session lecClass = new Lecturers_Class_Session();
                lecClass.setLid(lecturer);
                lecClass.setCsid(cs);
                list.add(lecClass);
                 
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        LecturerClassSession lcs = new LecturerClassSession();
        List<Lecturers_Class_Session> list = lcs.getAllLecturerClassSessions();
        System.out.println(list);
    }
}
