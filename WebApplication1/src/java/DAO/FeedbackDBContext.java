/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Feedback;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class FeedbackDBContext extends DBContext {

   public Feedback getFeedbackByIdAndate(String date, int id) {
        Feedback feed = new Feedback();
        try {
            String sql = "SELECT [fid]\n"
                    + "      ,[ftitle]\n"
                    + "      ,[fcontent]\n"
                    + "      ,[dateFeedBack]\n"
                    + "      ,[stuid]\n"
                    + "  FROM [SchoolManagement].[dbo].[FeedBack]\n"
                    + "  where dateFeedBack = ? and stuid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, date);
            stm.setInt(2, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                StudentDBContext student = new StudentDBContext();
                feed.setFid(rs.getInt("fid"));
                feed.setFtitle(rs.getString("ftitle"));
                feed.setFcontent(rs.getString("fcontent"));
                feed.setStuid(student.getStudentById(rs.getInt("stuid")));
                feed.setDateFeedback(rs.getDate("dateFeedBack"));
                return feed;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

   
}
