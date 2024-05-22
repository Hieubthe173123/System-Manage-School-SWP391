/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.ActivityTime;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class ActivityTimeDBContext extends DBContext {

    
    public static void main(String[] args) {
        ActivityTimeDBContext a = new ActivityTimeDBContext();
        System.out.println(a.getActivityTimeById(1).getTimeEnd());
    }
    public ActivityTime getActivityTimeById(int id) {
        ActivityTime activity = new ActivityTime();
        try {
            String sql = "SELECT [atid], [TimeStart], [TimeEnd] FROM [SchoolManagement].[dbo].[ActitvityTime] WHERE atid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                activity.setAtid(rs.getInt("atid"));

                DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("HH:mm:ss.SSSSSSS");
                DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("HH:mm");

                // Parse the time strings into LocalTime
                LocalTime timeStart = LocalTime.parse(rs.getString("TimeStart"), inputFormatter);
                LocalTime timeEnd = LocalTime.parse(rs.getString("TimeEnd"), inputFormatter);

                // Format the LocalTime objects to the desired format
                activity.setTimeStart(timeStart.format(outputFormatter));
                activity.setTimeEnd(timeEnd.format(outputFormatter));

                return activity;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
