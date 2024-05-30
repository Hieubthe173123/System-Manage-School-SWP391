/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Lecturers;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class LecturersDBContext extends DBContext {

    public Lecturers getLecturerByid(int rid) {
        try {
            String sql = "SELECT [lid]\n"
                    + "      ,[lname]\n"
                    + "      ,[gender]\n"
                    + "      ,[dob]\n"
                    + "      ,[phoneNumber]\n"
                    + "      ,[IDcard]\n"
                    + "      ,[Address]\n"
                    + "      ,[Email]\n"
                    + "      ,[NickName]\n"
                    + "  FROM [SchoolManagement].[dbo].[Lecturers] Where Lid = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, rid);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Lecturers lec = new Lecturers();
                lec.setLid(rs.getInt("lid"));
                lec.setLname(rs.getString("lname"));
                lec.setGender(rs.getBoolean("gender"));
                lec.setDob(rs.getString("dob"));
                lec.setPhoneNumber(rs.getString("phoneNumber"));
                lec.setIDcard(rs.getString("IDcard"));
                lec.setEmail(rs.getString("Email"));
                lec.setAddress(rs.getString("Address"));
                lec.setNickname(rs.getString("NickName"));
                return lec;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Lecturers getLecturerByEmail(String email) {
        try {
            String sql = "SELECT [lid]\n"
                    + "      ,[lname]\n"
                    + "      ,[gender]\n"
                    + "      ,[dob]\n"
                    + "      ,[phoneNumber]\n"
                    + "      ,[IDcard]\n"
                    + "      ,[Address]\n"
                    + "      ,[Email]\n"
                    + "      ,[NickName]\n"
                    + "  FROM [SchoolManagement].[dbo].[Lecturers] Where Email = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Lecturers lec = new Lecturers();
                lec.setLid(rs.getInt("lid"));
                lec.setLname(rs.getString("lname"));
                lec.setGender(rs.getBoolean("gender"));
                lec.setDob(rs.getString("dob"));
                lec.setPhoneNumber(rs.getString("phoneNumber"));
                lec.setIDcard(rs.getString("IDcard"));
                lec.setEmail(rs.getString("Email"));
                lec.setAddress(rs.getString("Address"));
                lec.setNickname(rs.getString("NickName"));
                return lec;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void deleteLecturers(String lid) {
        try {
            connection.setAutoCommit(false);

            // Xóa các bản ghi liên quan trong bảng Lecturers_Class_Session
            String sql1 = "DELETE FROM Lecturers_Class_Session WHERE lid = ?";
            PreparedStatement stm1 = connection.prepareStatement(sql1);
            stm1.setString(1, lid);
            stm1.executeUpdate();

            // Xóa các bản ghi liên quan trong bảng Account
            String sql2 = "DELETE FROM Account WHERE lid = ?";
            PreparedStatement stm2 = connection.prepareStatement(sql2);
            stm2.setString(1, lid);
            stm2.executeUpdate();

            // Xóa bản ghi trong bảng Lecturers
            String sql3 = "DELETE FROM lecturers WHERE lid = ?";
            PreparedStatement stm3 = connection.prepareStatement(sql3);
            stm3.setString(1, lid);
            stm3.executeUpdate();

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException rollbackEx) {
                Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // dem so luonng giao vien trong database 
    public int getTotalLecturers() {
        try {
            String sql = "select count (*) from Lecturers";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;

    }

   public int getTotalLecturersBySchoolYear(String timeStart, String timeEnd) {
    String sql = "SELECT COUNT(*) FROM Lecturers " +
                 "INNER JOIN Lecturers_Class_Session ON Lecturers.lid = Lecturers_Class_Session.lid " +
                 "INNER JOIN Class_Session ON Lecturers_Class_Session.csid = Class_Session.csid " +
                 "INNER JOIN SchoolYear ON Class_Session.yid = SchoolYear.yid " +
                 "WHERE SchoolYear.dateStart LIKE ? AND SchoolYear.dateEnd LIKE ?";
    try {
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, timeStart + "%");
        stm.setString(2, timeEnd + "%");
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException ex) {
        Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
    return 0;
}
 


    public static void main(String[] args) {
        LecturersDBContext ldb = new LecturersDBContext();
        int count = ldb.getTotalLecturersBySchoolYear("2023","2024");
        System.out.println(count);
    }
}


