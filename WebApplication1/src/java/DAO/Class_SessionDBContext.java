/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.ClassSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author admin
 */
public class Class_SessionDBContext extends DBContext {

    public ClassSession getClassSessionById(int id) {
        ClassSession claSes = new ClassSession();
        try {
            String sql = "SELECT [csid]\n"
                    + "      ,[classID]\n"
                    + "      ,[yid]\n"
                    + "      ,[sid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Class_Session] Where csid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                SchoolYearDBContext scho = new SchoolYearDBContext();
                ClassDBContext cla = new ClassDBContext();
                SessionDBContext ses = new SessionDBContext();
                AgeDBContext age = new AgeDBContext();
                claSes.setCsid(rs.getInt("csid"));
                claSes.setClassID(cla.getClassById(rs.getInt("classID")));
                claSes.setYid(scho.getSchoolYearById(rs.getInt("yid")));
                claSes.setSid(ses.getSessionById(rs.getInt("sid")));
                return claSes;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
}
