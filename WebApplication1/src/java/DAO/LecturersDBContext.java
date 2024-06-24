/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.ClassSession;
import Entity.Lecturers;
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
                lec.setLid(rs.getInt("pid"));
                lec.setLname(rs.getString("pname"));
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

    public List<Lecturers> getLecturerByID(String lid) {
        List<Lecturers> list = new ArrayList<>();
        try {
            String sql = "select * from Lecturers where lid = ?";

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

                list.add(lecturer);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Lecturers> getLecturerByName(String lname) {
        List<Lecturers> list = new ArrayList<>();
        try {
            String sql = "select * from Lecturers where lname like ?;";

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

                list.add(lecturer);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public Lecturers getLecturerById(String lid) {
        try {
            String sql = "SELECT [lid], [lname], [gender], [dob], [phoneNumber], [IDcard], [Address], [Email], [NickName] "
                    + "FROM [SchoolManagement].[dbo].[Lecturers] WHERE [lid] = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lid);

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
            Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateLecturers(Lecturers lecturers) {
        try {
            // Assuming 'connection' is initialized somewhere in your class
            String sql = "UPDATE [dbo].[Lecturers]\n"
                    + "   SET [lname] = ?,\n"
                    + "      [gender] = ?,\n"
                    + "      [dob] = ?,\n"
                    + "      [phoneNumber] = ?,\n"
                    + "      [IDcard] = ?,\n"
                    + "      [Address] = ?,\n"
                    + "      [Email] = ?\n" // Remove the comma here
                    + "      WHERE lid = ?";

            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, lecturers.getLname());
            stm.setBoolean(2, lecturers.isGender());
            stm.setString(3, lecturers.getDob());
            stm.setString(4, lecturers.getPhoneNumber());
            stm.setString(5, lecturers.getIDcard());
            stm.setString(6, lecturers.getAddress());
            stm.setString(7, lecturers.getEmail());
            stm.setInt(8, lecturers.getLid());

            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Lecturers> getAllLecturers() {
        List<Lecturers> list = new ArrayList<>();
        try {
            String sql = "select * from Lecturers";

            PreparedStatement stm = connection.prepareStatement(sql);
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

                list.add(lecturer);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;

    }

    public void deleteLecturers(String lid) {
        try {

            String sql = "UPDATE [dbo].[Lecturers]\n"
                    + "   SET [status] = null\n"
                    + " WHERE lid = ? ";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lid);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void main(String[] args) {
        LecturersDBContext ldb = new LecturersDBContext();
       ldb.deleteLecturers("1");

    }
}
