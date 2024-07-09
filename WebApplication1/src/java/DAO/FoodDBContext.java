/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

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
public class FoodDBContext extends DBContext {
    
    public static void main(String[] args) {
        FoodDBContext f = new FoodDBContext();
        System.out.println(f.getFoodById(4).getFname());
    }
    
    public Food getFoodById(int id) {
        Food food = new Food();
        try {
            String sql = "SELECT [foodid]\n"
                    + "      ,[fname]\n"
                    + "  FROM [SchoolManagement].[dbo].[Food]\n"
                    + "  Where foodid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                food.setFoodid(rs.getInt("foodid"));
                food.setFname(rs.getString("fname"));;
                return food;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
    public List<Food> getAllFood() {
         List<Food> food = new ArrayList<>();
        try {
            String sql = "SELECT [foodid]\n"
                    + "      ,[fname]\n"
                    + "  FROM [SchoolManagement].[dbo].[Food]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Food f = new Food();
                f.setFoodid(rs.getInt("foodid"));
                f.setFname(rs.getString("fname"));
                food.add(f);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return food;
    }
}
