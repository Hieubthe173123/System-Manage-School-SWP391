/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Menu;
import Entity.Session;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class SessionDBContext extends DBContext {
    public static void main(String[] args) {
        SessionDBContext s = new SessionDBContext();
        System.out.println(s.getAllSession().size());
    }

    public Session getSessionById(int id) {
        Session session = new Session();
        try {
            String sql = "SELECT [sid]\n"
                    + "      ,[sname]\n"
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
            String sql = "SELECT [sid]\n"
                    + "      ,[sname]\n"
                    + "      ,[totalSession]\n"
                    + "      ,[ageid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Session]";
            PreparedStatement stm = connection.prepareStatement(sql);
;
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Session session = new Session();
                AgeDBContext age = new AgeDBContext();
                session.setSid(rs.getInt("sid"));
                session.setSname(rs.getString("sname"));
                session.setTotalSession(rs.getInt("totalSession"));
                session.setAge(age.getAgeById(rs.getInt("ageid")));
                list.add(session);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

}
