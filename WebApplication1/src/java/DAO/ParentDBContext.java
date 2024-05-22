/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Parent;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class ParentDBContext extends DBContext {

    public Parent getParentByid(int rid) {
        try {
            String sql = "SELECT [pid]\n"
                    + "      ,[pname]\n"
                    + "      ,[gender]\n"
                    + "      ,[dob]\n"
                    + "      ,[phoneNumber]\n"
                    + "      ,[IDcard]\n"
                    + "      ,[Address]\n"
                    + "      ,[Email]\n"
                    + "      ,[NickName]\n"
                    + "  FROM [SchoolManagement].[dbo].[Parent] Where pid = ?";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, rid);
            
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Parent p = new Parent();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setGender(rs.getBoolean("gender"));
                p.setDob(rs.getString("dob"));
                p.setPhoneNumber(rs.getString("phoneNumber"));
                p.setIDcard(rs.getString("IDcard"));
                p.setEmail(rs.getString("Email"));
                p.setAddress(rs.getString("Address"));
                p.setNickname(rs.getString("NickName"));
                return p;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public Parent getParentByGmail(String gmail) {
        try {
            String sql = "SELECT [pid]\n"
                    + "      ,[pname]\n"
                    + "      ,[gender]\n"
                    + "      ,[dob]\n"
                    + "      ,[phoneNumber]\n"
                    + "      ,[IDcard]\n"
                    + "      ,[Address]\n"
                    + "      ,[Email]\n"
                    + "      ,[NickName]\n"
                    + "  FROM [SchoolManagement].[dbo].[Parent] Where Email = ?";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, gmail);
            
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Parent p = new Parent();
                p.setPid(rs.getInt("pid"));
                p.setPname(rs.getString("pname"));
                p.setGender(rs.getBoolean("gender"));
                p.setDob(rs.getString("dob"));
                p.setPhoneNumber(rs.getString("phoneNumber"));
                p.setIDcard(rs.getString("IDcard"));
                p.setEmail(rs.getString("Email"));
                p.setAddress(rs.getString("Address"));
                p.setNickname(rs.getString("NickName"));
                return p;
            }
        } catch (SQLException ex) {
            Logger.getLogger(LecturersDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
