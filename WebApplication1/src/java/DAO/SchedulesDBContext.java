/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Schedules;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class SchedulesDBContext extends DBContext {
    public static void main(String[] args) {
        SchedulesDBContext d = new SchedulesDBContext();
        System.out.println(d.getSchedulesByCsIdAndDate(1, "2024-05-21").getCsid().getCsid());
    }
    public Schedules getSchedulesByCsIdAndDate(int id, String date) {
        Schedules schel = new Schedules();
        try {
            String sql = "SELECT [scheID]\n"
                    + "      ,[sdid]\n"
                    + "      ,[Date]\n"
                    + "      ,[csid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Schedules] Where csid = ? and Date = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.setString(2, date);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                SessionDetailDBContext ses = new SessionDetailDBContext();
                Class_SessionDBContext cla = new Class_SessionDBContext();
                schel.setScheID(rs.getInt("scheID"));
                schel.setDate(rs.getDate("Date"));
                schel.setSdid(ses.getSessionDetailById(rs.getInt("sdid")));
                schel.setCsid(cla.getClassSessionById(rs.getInt("csid")));
                return schel;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
            

    
}
