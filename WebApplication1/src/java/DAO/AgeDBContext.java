/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.AgeCategory;
import Entity.Food;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class AgeDBContext extends DBContext {

    public AgeCategory getAgeById(int id) {
        AgeCategory age = new AgeCategory();
        try {
            String sql = "SELECT [ageid]\n"
                    + "      ,[aname]\n"
                    + "  FROM [SchoolManagement].[dbo].[Age_Category]"
                    + "  Where ageid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                age.setAgeid(rs.getInt("ageid"));
                age.setAname(rs.getString("aname"));
                return age;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
  
}
