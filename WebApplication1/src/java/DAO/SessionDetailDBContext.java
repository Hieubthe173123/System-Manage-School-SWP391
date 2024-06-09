/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Session;
import Entity.SessionDetails;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class SessionDetailDBContext extends DBContext {

    public SessionDetails getSessionDetailById(int id) {
        SessionDetails sesDetail = new SessionDetails();
        try {
            String sql = "SELECT [sdid]\n"
                    + "      ,[details]\n"
                    + "      ,[sessionNumber]\n"
                    + "      ,[sid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Session_Details]\n"
                    + "  Where sdid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                SessionDBContext session = new SessionDBContext();
                sesDetail.setSdid(rs.getInt("sdid"));
                sesDetail.setDetail(rs.getString("details"));
                sesDetail.setSessionNumber(rs.getInt("sessionNumber"));
                sesDetail.setSid(session.getSessionById(rs.getInt("sid")));
                return sesDetail;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<SessionDetails> getAllSessionDetailBySessionID(int id) {
        List<SessionDetails> sesionDe = new ArrayList<>();
        try {
            String sql = "SELECT [sdid]\n"
                    + "      ,[details]\n"
                    + "      ,[sessionNumber]\n"
                    + "      ,[sid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Session_Details]\n"
                    + "  Where sid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return sesionDe;
    }

    public List<SessionDetails> getAllSessionDetails(String sid) {
        List<SessionDetails> list = new ArrayList<>();
        String sql = "SELECT *\n"
                + "                FROM Session s\n"
                + "                LEFT JOIN Session_Details sd ON s.sid = sd.sid \n"
                + "                WHERE s.sid = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, sid);
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    SessionDetails sesDetail = new SessionDetails();
                    sesDetail.setSdid(rs.getInt("sdid"));
                    sesDetail.setDetail(rs.getString("details"));
                    sesDetail.setSessionNumber(rs.getInt("sessionNumber"));

                    Session session = new Session();
                    session.setSid(rs.getInt("sid"));
                    session.setTotalSession(rs.getInt("totalSession"));
                    sesDetail.setSid(session);
                    list.add(sesDetail);
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Exception: " + e.getMessage());
        }
        return list;
    }

    public static void main(String[] args) {
        SessionDetailDBContext sd = new SessionDetailDBContext();
        List<SessionDetails> list = sd.getAllSessionDetails("1");
        System.out.println(list);
    }
}
