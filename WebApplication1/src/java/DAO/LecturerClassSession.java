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
                    + "               L.lid,\n"
                    + "                  L.lname,\n"
                    + "              L.dob,\n"
                    + "              L.gender,\n"
                    + "                L.phoneNumber,\n"
                    + "                 L.IDcard,\n"
                    + "                    L.[Address],\n"
                    + "              L.NickName,\n"
                    + "                L.Email,\n"
                    + "                C.classID,\n"
                    + "                  C.clname\n"
                    + "              FROM\n"
                    + "                   Lecturers L\n"
                    + "               LEFT JOIN\n"
                    + "                   Lecturers_Class_Session LCS ON L.lid = LCS.lid\n"
                    + "              LEFT JOIN\n"
                    + "                 Class_Session CS ON LCS.csid = CS.csid\n"
                    + "                LEFT JOIN\n"
                    + "           Class C ON CS.classID = C.classID;";
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

    public List<Lecturers_Class_Session> pagingLecturers(int index) {
        List<Lecturers_Class_Session> list = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "Lecturers.lid,\n"
                    + "Lecturers.lname,\n"
                    + "Lecturers.gender,\n"
                    + "Lecturers.dob,\n"
                    + "Lecturers.phoneNumber,\n"
                    + "Lecturers.IDcard,\n"
                    + "Lecturers.Email,\n"
                    + "Lecturers.Address,\n"
                    + "Lecturers.NickName,\n"
                    + "Class.classID,\n"
                    + "Class.clname\n"
                    + "FROM Lecturers\n"
                    + "LEFT JOIN Lecturers_Class_Session ON Lecturers.lid = Lecturers_Class_Session.lid\n"
                    + "LEFT JOIN Class_Session ON Lecturers_Class_Session.csid = Class_Session.csid\n"
                    + "LEFT JOIN Class ON Class_Session.classID = Class.classID\n"
                    + "ORDER BY Lecturers.lid \n"
                    + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY;";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 10);  // Calculate the correct offset
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
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

    public List<Lecturers_Class_Session> getAllLecturerBySchoolYear(String timeStart, String timeEnd) {
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
                    + "LEFT JOIN\n"
                    + "    Lecturers_Class_Session LCS ON L.lid = LCS.lid\n"
                    + "LEFT JOIN\n"
                    + "    Class_Session CS ON LCS.csid = CS.csid\n"
                    + "LEFT JOIN\n"
                    + "    Class C ON C.classID = CS.classID\n"
                    + "LEFT JOIN\n"
                    + "    SchoolYear sy ON CS.yid = sy.yid\n"
                    + "WHERE\n"
                    + "    sy.dateStart LIKE ? AND sy.dateEnd LIKE ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, timeStart + "%");
            stm.setString(2, timeEnd + "%");
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
        List<Lecturers_Class_Session> list = lcs.getAllLecturerBySchoolYear("2023", "2024");
        System.out.println(list);
    }
}
