/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Menu;
import Entity.Session;
import Entity.SessionDetails;
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
public class SessionDBContext extends DBContext {

    public Session getSessionById(int id) {
        Session session = new Session();
        try {
            String sql = "SELECT [sid]\n"
                    + "      ,[sname]\n"
                    + "      ,[sesionDescription]\n"
                    + "      ,[totalSession]\n"
                    + "      ,[ageid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Session]"
                    + "  Where sid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                AgeDBContext age = new AgeDBContext();
                session.setSid(rs.getInt("sid"));
                session.setSname(rs.getString("sname"));
                session.setSessionDescription(rs.getString("sesionDescription"));
                session.setTotalSession(rs.getInt("totalSession"));
                session.setAge(age.getAgeById(rs.getInt("ageid")));
                return session;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Session> getAllSession() {
        List<Session> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM session";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            AgeDBContext ageContext = new AgeDBContext(); // Create AgeDBContext object outside the loop
            while (rs.next()) {
                Session session = new Session();
                session.setSid(rs.getInt("sid"));
                session.setSname(rs.getString("sname"));
                session.setTotalSession(rs.getInt("totalSession"));
                session.setAge(ageContext.getAgeById(rs.getInt("ageid"))); // Use AgeDBContext to get Age object
                list.add(session);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list; // Return the list, not null
    }
    public int SessionNumber(String sid) {
         try {
            String sql = "select totalSession from Session where sid = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sid);
            ResultSet rs = stm.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }


    public static void main(String[] args) {
        SessionDBContext se = new SessionDBContext();
        int sc = se.SessionNumber("1");
        System.out.println(sc);
    }
}
