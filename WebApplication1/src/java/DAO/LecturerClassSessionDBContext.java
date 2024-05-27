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
public class LecturerClassSessionDBContext extends DBContext {

    public ArrayList<Lecturers> getLecturersByClassSessionId(int csid) {
        ArrayList<Lecturers> lecturers = new ArrayList<>();
        try {
            String sql = "SELECT L.lid, L.lname FROM Lecturers L\n"
                    + "	JOIN Lecturers_Class_Session LCS ON L.lid = LCS.lid\n"
                    + "	WHERE LCS.csid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, csid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Lecturers l = new Lecturers();
                l.setLid(rs.getInt("lid"));
                l.setLname(rs.getString("lname"));
                lecturers.add(l);
            }
        } catch (SQLException ex) {
            Logger.getLogger(Lecturers.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lecturers;
    }

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
                lec.setLclassID(rs.getInt("lclassID"));
                lec.setLid(lectu.getLecturerByid(rs.getInt("lid")));
                lec.setCsid(classSess.getClassSessionById(rs.getInt("csid")));

                return lec;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<LecturerClassSessionDBContext> getAllLecturerClassSessions() {
        List<LecturerClassSessionDBContext> list = new ArrayList<>();

        try {
            String sql = "SELECT\n"
                    + "Lecturers.lid,\n"
                    + "                  Lecturers.lname,\n"
                    + "                    Lecturers.dob,\n"
                    + "                     Lecturers.gender,\n"
                    + "                    Lecturers.phoneNumber,\n"
                    + "                   Lecturers.IDcard,\n"
                    + "                 Lecturers.[Address],\n"
                    + "                     Lecturers.NickName,\n"
                    + "                   Lecturers.Email,\n"
                    + "                    Class.classID,\n"
                    + "                     Class.clname\n"
                    + "                    FROM Lecturers\n"
                    + "                  INNER JOIN Lecturers_Class_Session ON Lecturers.lid = Lecturers_Class_Session.lid\n"
                    + "                    INNER JOIN Class_Session ON Lecturers_Class_Session.csid = Class_Session.csid\n"
                    + "                     INNER JOIN Class ON Class_Session.classID = Class.classID";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                LecturerClassSessionDBContext lecturerClassSession = new LecturerClassSessionDBContext();

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

                Lecturers_Class_Session lecClass = new Lecturers_Class_Session();
                lecClass.setLid(lecturer);
                ClassSession cs = new ClassSession();
                lecClass.setCsid(cs);
                cs.setClassID(cl);

                list.add(lecturerClassSession);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        LecturerClassSessionDBContext lcs = new LecturerClassSessionDBContext();
        ArrayList<Lecturers> list = lcs.getLecturersByClassSessionId(1);
        System.out.println(list);
    }
}
