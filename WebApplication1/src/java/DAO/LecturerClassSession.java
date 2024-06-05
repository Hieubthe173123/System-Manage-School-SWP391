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

    public List<Lecturers_Class_Session> getLecturersBySchoolYearWithPaging(String timeStart, String timeEnd, int index) {
        List<Lecturers_Class_Session> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "l.lid,\n"
                + "l.lname,\n"
                + "l.gender,\n"
                + "l.dob,\n"
                + "l.phoneNumber,\n"
                + "l.IDcard,\n"
                + "l.Email,\n"
                + "l.Address,\n"
                + "l.NickName,\n"
                + "Cl.classID,\n"
                + "cl.clname\n"
                + "FROM Lecturers_Class_Session lcs\n"
                + "JOIN Lecturers l ON lcs.lid = l.lid\n"
                + "JOIN Class_Session cs ON lcs.csid = cs.csid\n"
                + "JOIN Class cl ON cl.classID = cs.classID\n"
                + "JOIN SchoolYear sy ON cs.yid = sy.yid\n"
                + "WHERE sy.dateStart LIKE ? AND sy.dateEnd LIKE ?\n"
                + "ORDER BY l.lid OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, timeStart + "%");
            stm.setString(2, timeEnd + "%");
            stm.setInt(3, (index - 1) * 10);
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
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Lecturers_Class_Session> getLecturerByid(String lid) {
        List<Lecturers_Class_Session> list = new ArrayList<>();
        try {
            String sql = "SELECT\n"
                    + "L.lid,\n"
                    + "L.lname,\n"
                    + "L.dob,\n"
                    + "L.gender,\n"
                    + "L.phoneNumber,\n"
                    + "L.IDcard,\n"
                    + "L.[Address],\n"
                    + "L.NickName,\n"
                    + "L.Email,\n"
                    + "C.classID,\n"
                    + "C.clname\n"
                    + "FROM\n"
                    + "Lecturers L\n"
                    + "LEFT JOIN\n"
                    + "Lecturers_Class_Session LCS ON L.lid = LCS.lid\n"
                    + "LEFT JOIN\n"
                    + "Class_Session CS ON LCS.csid = CS.csid\n"
                    + "LEFT JOIN\n"
                    + "Class C ON CS.classID = C.classID\n"
                    + "where L.lid = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturers lecturer = new Lecturers();
                lecturer.setLid(rs.getInt("lid"));
                lecturer.setLname(rs.getString("lname"));
                lecturer.setGender(rs.getBoolean("gender"));
                lecturer.setDob(rs.getDate("dob").toString()); // assuming dob is of type Date
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

    public List<Lecturers_Class_Session> getLecturerByName(String lname) {
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
                    + "    Class C ON CS.classID = C.classID\n"
                    + "WHERE\n"
                    + "    L.lname LIKE ?;";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + lname + "%"); // Adding wildcard characters here

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturers lecturer = new Lecturers();
                lecturer.setLid(rs.getInt("lid"));
                lecturer.setLname(rs.getString("lname"));
                lecturer.setGender(rs.getBoolean("gender"));
                lecturer.setDob(rs.getDate("dob").toString()); // assuming dob is of type Date
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
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public void insertLecturers(String lname, String gender, String dob, String phoneNumber, String IDcard, String address, String email, String nickName, String classID) {
        String sql = "INSERT INTO Lecturers (lname, gender, dob, phoneNumber, IDcard, [Address], Email, NickName)\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?);\n"
                + "INSERT INTO Lecturers_Class_Session (lid, csid)\n"
                + "VALUES (\n"
                + "    (SELECT MAX(lid) FROM Lecturers),\n"
                + "    (SELECT csid FROM Class_Session WHERE classID = ? AND yid = (SELECT MAX(yid) FROM Class_Session))\n"
                + ");";
        try {
            connection.setAutoCommit(false); // Begin transaction

            // Prepare statement for inserting lecturer
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lname);
            stm.setString(2, gender);
            stm.setString(3, dob);
            stm.setString(4, phoneNumber);
            stm.setString(5, IDcard);
            stm.setString(6, address);
            stm.setString(7, email);
            stm.setString(8, nickName);
            stm.setString(9, classID);

            // Execute the insert statements
            stm.executeUpdate();

            connection.commit(); // Commit transaction
        } catch (SQLException ex) {
            try {
                connection.rollback(); // Rollback transaction on error
            } catch (SQLException e) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, e);
            }
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true); // Restore default commit behavior
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void promoteLecturer(String lid, String classID) {
        try {
            String sql = "INSERT INTO Lecturers_Class_Session (lid, csid)\n"
                    + "                VALUES (\n"
                    + "                   ?,\n"
                    + "                (SELECT csid FROM Class_Session WHERE classID = ? AND yid = (SELECT MAX(yid) FROM Class_Session)));";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lid);
            stm.setString(2, classID);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void deleteLecturer(String lid) {
        try {
            String sql = "delete from Lecturers_Class_Session where lid= ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void updateLecturerinClass(int classID, int lid) {
        try {
            // Assuming 'connection' is initialized somewhere in your class
            String sql = "UPDATE [dbo].[Lecturers_Class_Session]\n"
                    + "   SET \n"
                    + "      [csid] = (SELECT csid FROM Class_Session WHERE classID = ? AND yid = (SELECT MAX(yid) FROM Class_Session))\n"
                    + " WHERE lid = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, classID);
            stm.setInt(2, lid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    

    public static void main(String[] args) {
        LecturerClassSession lc = new LecturerClassSession();
        lc.insertLecturers("Bùi Trung Lâm","1", "2003-01-02","01243","32423423","Hà Nội","Lâm@f","lam","");
         
    }

}
