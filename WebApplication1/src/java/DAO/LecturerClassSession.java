/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Lecturers;
import Entity.Class;
import Entity.ClassSession;
import Entity.Lecturers_Class_Session;
import Entity.SchoolYear;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;
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

    public Lecturers_Class_Session getLecturerByid(String lid) {

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
                lecturer.setDob(rs.getString("dob")); // assuming dob is of type Date
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
                return lecClass;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public Lecturers_Class_Session getLecturerByidClass(String lid) {

        try {
            String sql = "SELECT *\n"
                    + "FROM\n"
                    + "Lecturers L\n"
                    + "LEFT JOIN\n"
                    + "Lecturers_Class_Session LCS ON L.lid = LCS.lid\n"
                    + "LEFT JOIN\n"
                    + "Class_Session CS ON LCS.csid = CS.csid\n"
                    + "LEFT JOIN\n"
                    + "Class C ON CS.classID = C.classID\n"
                    + "left join SchoolYear sy on cs.yid = sy.yid\n"
                    + "where L.lid = ? and sy.yid = (select Max(yid) from SchoolYear) and lcs.status is not null;";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lid);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturers l = new Lecturers();
                l.setLid(rs.getInt("lid"));
                l.setLname(rs.getString("lname"));
                l.setGender(rs.getBoolean("gender"));
                l.setAddress(rs.getString("address"));
                l.setDob(rs.getString("dob"));
                l.setEmail(rs.getString("email"));
                l.setPhoneNumber(rs.getString("phoneNumber"));
                l.setIDcard(rs.getString("IDcard"));
                l.setEmail(rs.getString("email"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID"));
                cl.setClname(rs.getString("clname"));

                SchoolYear sy = new SchoolYear();
                sy.setYid(rs.getInt("yid"));
                sy.setDateStart(rs.getString("dateStart"));
                sy.setDateEnd(rs.getString("dateEnd"));

                ClassSession cs = new ClassSession();
                cs.setCsid(rs.getInt("csid"));
                cs.setYid(sy);
                cs.setClassID(cl);

                Lecturers_Class_Session lcs = new Lecturers_Class_Session();
                lcs.setLid(l);
                lcs.setCsid(cs);
                return lcs;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Lecturers_Class_Session> getAllLecturerInNewSchoolYear() {
        List<Lecturers_Class_Session> list = new ArrayList<>();
        try {
            String sql = "WITH RankedClasses AS (SELECT l.lid,l.lname,l.Address,l.dob,l.gender,l.IDcard,l.phoneNumber,l.Email,lcs.csid,\n"
                    + "    ROW_NUMBER() OVER (PARTITION BY l.lid ORDER BY lcs.lclassID DESC) AS rn\n"
                    + "    FROM lecturers l\n"
                    + "    LEFT JOIN lecturers_class_session lcs ON l.lid = lcs.lid\n"
                    + "    LEFT JOIN Class_Session cs ON cs.csid = lcs.csid\n"
                    + "    LEFT JOIN SchoolYear sy ON sy.yid = cs.yid\n"
                    + "    WHERE l.status IS NOT NULL\n"
                    + "    AND sy.yid = (SELECT MAX(yid) FROM SchoolYear) and lcs.status is not null\n"
                    + ")\n"
                    + "SELECT *\n"
                    + "FROM lecturers l\n"
                    + "LEFT JOIN RankedClasses rc ON l.lid = rc.lid AND rc.rn = 1\n"
                    + "LEFT JOIN Class_Session cs ON rc.csid = cs.csid\n"
                    + "LEFT JOIN Class cl ON cs.classID = cl.classID\n"
                    + "LEFT JOIN SchoolYear sy ON cs.yid = sy.yid\n"
                    + "where l.status is not null\n"
                    + "ORDER BY l.lid ASC;";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturers l = new Lecturers();
                l.setLid(rs.getInt("lid"));
                l.setLname(rs.getString("lname"));
                l.setGender(rs.getBoolean("gender"));
                l.setAddress(rs.getString("address"));
                l.setDob(rs.getString("dob"));
                l.setEmail(rs.getString("email"));
                l.setPhoneNumber(rs.getString("phoneNumber"));
                l.setIDcard(rs.getString("IDcard"));
                l.setEmail(rs.getString("email"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID"));
                cl.setClname(rs.getString("clname"));

                SchoolYear sy = new SchoolYear();
                sy.setYid(rs.getInt("yid"));
                sy.setDateStart(rs.getString("dateStart"));
                sy.setDateEnd(rs.getString("dateEnd"));

                ClassSession cs = new ClassSession();
                cs.setCsid(rs.getInt("csid"));
                cs.setYid(sy);
                cs.setClassID(cl);

                Lecturers_Class_Session lcs = new Lecturers_Class_Session();
                lcs.setLid(l);
                lcs.setCsid(cs);

                list.add(lcs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Lecturers_Class_Session> getHistoryAllLecturer(String yid) {
        List<Lecturers_Class_Session> list = new ArrayList<>();
        try {
            String sql = "WITH RankedClasses AS (SELECT l.lid,l.lname,l.Address,l.dob,l.gender,l.IDcard,l.phoneNumber,l.Email,lcs.csid,\n"
                    + "    ROW_NUMBER() OVER (PARTITION BY l.lid ORDER BY lcs.lclassID DESC) AS rn\n"
                    + "    FROM lecturers l\n"
                    + "    LEFT JOIN lecturers_class_session lcs ON l.lid = lcs.lid\n"
                    + "    LEFT JOIN Class_Session cs ON cs.csid = lcs.csid\n"
                    + "    LEFT JOIN SchoolYear sy ON sy.yid = cs.yid\n"
                    + "    WHERE sy.yid = ? and lcs.status is not null\n"
                    + ")\n"
                    + "SELECT *\n"
                    + "FROM lecturers l\n"
                    + "LEFT JOIN RankedClasses rc ON l.lid = rc.lid AND rc.rn = 1\n"
                    + "LEFT JOIN Class_Session cs ON rc.csid = cs.csid\n"
                    + "LEFT JOIN Class cl ON cs.classID = cl.classID\n"
                    + "LEFT JOIN SchoolYear sy ON cs.yid = sy.yid\n"
                    + "ORDER BY l.lid ASC;\n"
                    + "";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, yid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturers l = new Lecturers();
                l.setLid(rs.getInt("lid"));
                l.setLname(rs.getString("lname"));
                l.setGender(rs.getBoolean("gender"));
                l.setAddress(rs.getString("address"));
                l.setDob(rs.getString("dob"));
                l.setEmail(rs.getString("email"));
                l.setPhoneNumber(rs.getString("phoneNumber"));
                l.setIDcard(rs.getString("IDcard"));
                l.setEmail(rs.getString("email"));
                l.setStatus(rs.getString("status"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID"));
                cl.setClname(rs.getString("clname"));

                SchoolYear sy = new SchoolYear();
                sy.setYid(rs.getInt("yid"));
                sy.setDateStart(rs.getString("dateStart"));
                sy.setDateEnd(rs.getString("dateEnd"));

                ClassSession cs = new ClassSession();
                cs.setCsid(rs.getInt("csid"));
                cs.setYid(sy);
                cs.setClassID(cl);

                Lecturers_Class_Session lcs = new Lecturers_Class_Session();

                lcs.setLid(l);
                lcs.setCsid(cs);

                list.add(lcs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Lecturers_Class_Session> getHistoryAllLecturerUpdate(String lid, String yid) {
        List<Lecturers_Class_Session> list = new ArrayList<>();
        try {
            String sql = "select l.lname,lcs.Status,cl.clname from Lecturers l \n"
                    + "left join Lecturers_Class_Session lcs on l.lid = lcs.lid\n"
                    + "left join Class_Session cs on cs.csid = lcs.csid \n"
                    + "left join Class cl on cl.classID = cs.classID\n"
                    + "left join SchoolYear sy on sy.yid = cs.yid \n"
                    + "where l.lid = ? and sy.yid = ? and lcs.Status is null;\n"
                    + " ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lid);
            stm.setString(2, yid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturers l = new Lecturers();
                l.setLname(rs.getString("lname"));
                Class cl = new Class();
                cl.setClname(rs.getString("clname"));
                SchoolYear sy = new SchoolYear();
                ClassSession cs = new ClassSession();
                cs.setYid(sy);
                cs.setClassID(cl);

                Lecturers_Class_Session lcs = new Lecturers_Class_Session();
                lcs.setStatus(rs.getString("Status"));
                lcs.setLid(l);
                lcs.setCsid(cs);

                list.add(lcs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public void addLecturer(String lname, String gender, String dob, String phoneNumber, String IDcard, String address, String email, String classID) {
        String sql = "INSERT INTO [dbo].[Lecturers] \n"
                + "([lname],[gender],[dob],[phoneNumber],[IDcard],[Address],[Email],[status])\n"
                + "VALUES (?,?,?,?,?,?,?,'active');\n"
                + "\n"
                + "INSERT INTO [dbo].[Account]([username],[password],[role],[lid])\n"
                + "SELECT phoneNumber, FLOOR(RAND()*100000),'2',lid\n"
                + "FROM Lecturers WHERE lid = (SELECT MAX(lid) FROM Lecturers);\n"
                + "\n"
                + "INSERT INTO [dbo].[Lecturers_Class_Session]([lid],[csid],[status])\n"
                + "VALUES ((select max(lid) from Lecturers)\n"
                + ",(SELECT csid FROM Class_Session WHERE classID = ? AND yid = (SELECT MAX(yid) FROM Class_Session)),'active');";

        try {
            connection.setAutoCommit(false);

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lname);
            stm.setString(2, gender);
            stm.setString(3, dob);
            stm.setString(4, phoneNumber);
            stm.setString(5, IDcard);
            stm.setString(6, address);
            stm.setString(7, email);
            stm.setString(8, classID);

            stm.executeUpdate();

            connection.commit();
        } catch (SQLException e) {
            System.out.println("SQL Error: " + e.getMessage());
        }
    }

    public SchoolYear getNewSchoolYear() {
        SchoolYear sc = new SchoolYear();
        try {
            String sql = "select * from SchoolYear where yid = (select max (yid) from SchoolYear)";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                sc.setYid(rs.getInt("yid"));
                sc.setDateStart(rs.getString("dateStart"));
                sc.setDateEnd(rs.getString("dateEnd"));
                return sc;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public int getTotalLecturerInClass(String classID) {
        try {
            String sql = "SELECT COUNT(*)\n"
                    + "FROM Lecturers l\n"
                    + "LEFT JOIN lecturers_class_session lcs ON l.lid = lcs.lid\n"
                    + "LEFT JOIN Class_Session cs ON cs.csid = lcs.csid\n"
                    + "LEFT JOIN Class cl ON cl.classID = cs.classID\n"
                    + "LEFT JOIN SchoolYear sy ON sy.yid = cs.yid\n"
                    + "WHERE cl.classID = ? and lcs.status is not null AND sy.yid = (SELECT MAX(yid) FROM SchoolYear) AND l.status IS NOT NULL;";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, classID);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return 0;

    }

    public boolean isPhoneNumberExists(String phoneNumber) {
        String sql = "SELECT COUNT(*) AS count FROM Lecturers WHERE phoneNumber = ?  and status is not null";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, phoneNumber);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isIDCardExists(String IDCard) {
        String sql = "SELECT COUNT(*) AS count FROM Lecturers WHERE IDcard = ? and status is not null";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, IDCard);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("count");
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateLecturers(String lname, String gender, String dob, String phoneNumber, String IDcard, String address, String email, String classid, String lid) {
        String updateLecturerSQL = "UPDATE [dbo].[Lecturers] "
                + "SET [lname] = ?, [gender] = ?, [dob] = ?, [phoneNumber] = ?, [IDcard] = ?, [Address] = ?, [Email] = ?, [status] = 'active' "
                + "WHERE [lid] = ?;";

        String updateLecturerClassSessionSQL = " UPDATE [dbo].[Lecturers_Class_Session]\n"
                + "   SET \n"
                + "      [csid] = (SELECT csid FROM Class_Session WHERE classID = ? AND yid = (SELECT MAX(yid) FROM Class_Session))\n"
                + " WHERE lid = ? AND yid = (SELECT MAX(yid) FROM Class_Session)";

        try (PreparedStatement stm1 = connection.prepareStatement(updateLecturerSQL); PreparedStatement stm2 = connection.prepareStatement(updateLecturerClassSessionSQL)) {

            connection.setAutoCommit(false);

            stm1.setString(1, lname);
            stm1.setString(2, gender);
            stm1.setString(3, dob);
            stm1.setString(4, phoneNumber);
            stm1.setString(5, IDcard);
            stm1.setString(6, address);
            stm1.setString(7, email);
            stm1.setString(8, lid);
            stm1.executeUpdate();

            stm2.setString(1, classid);
            stm2.setString(2, lid);
            stm2.executeUpdate();

            connection.commit();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateClass(String lid, String classID) {
        String sql = "	UPDATE [dbo].[Lecturers_Class_Session]\n"
                + "SET [status] = NULL\n"
                + "WHERE [lid] = ?;\n"
                + "\n"
                + "INSERT INTO [dbo].[Lecturers_Class_Session]\n"
                + "           ([lid]\n"
                + "           ,[csid]\n"
                + "           ,[status])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,(SELECT csid FROM Class_Session WHERE classID = ? AND yid = (SELECT MAX(yid) FROM Class_Session))\n"
                + "           ,'active');";

        try {
            connection.setAutoCommit(false);

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lid);
            stm.setString(2, lid);
            stm.setString(3, classID);
            stm.executeUpdate();

            connection.commit();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        LecturerClassSession lc = new LecturerClassSession();
        List<Lecturers_Class_Session> list = lc.getHistoryAllLecturerUpdate("2", "1");
        System.out.println(list);
    }

}
