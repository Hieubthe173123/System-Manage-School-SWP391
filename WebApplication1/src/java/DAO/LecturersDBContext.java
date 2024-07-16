/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Lecturers;
import Entity.Student;
import Entity.StudentClassSession;
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
public class LecturersDBContext extends DBContext {

    public Lecturers getLecturerByid(int lid) {
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
                + "  FROM [SchoolManagement].[dbo].[Lecturers] WHERE [lid] = ?";

        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, lid);

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
    public static void main(String[] args) {
        LecturersDBContext db = new LecturersDBContext();
        Lecturers ac = db.getLecturerByid(1);
        System.out.println(ac);
    }
   
}
