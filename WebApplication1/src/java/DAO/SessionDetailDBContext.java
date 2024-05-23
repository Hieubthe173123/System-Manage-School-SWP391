/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

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
                SessionDetails sesDetail = new SessionDetails();
                SessionDBContext session = new SessionDBContext();
                sesDetail.setSdid(rs.getInt("sdid"));
                sesDetail.setDetail(rs.getString("details"));
                sesDetail.setSessionNumber(rs.getInt("sessionNumber"));
                sesDetail.setSid(session.getSessionById(rs.getInt("sid")));
                sesionDe.add(sesDetail);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return sesionDe;
    }
}
