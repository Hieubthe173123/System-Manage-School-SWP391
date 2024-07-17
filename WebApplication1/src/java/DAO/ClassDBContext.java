/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.*;
import Entity.Class;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author admin
 */
public class ClassDBContext extends DBContext {

    public Class getClassById(int id) {
        Class cla = new Class();
        try {
            String sql = "SELECT [classID]\n"
                    + "      ,[clname] FROM [SchoolManagement].[dbo].[Class] where classID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                cla.setClassid(rs.getInt("classID"));
                cla.setClname(rs.getString("clname"));
              
                return cla;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
     public List<Class> getAllClasses() {
        List<Class> classes = new ArrayList<>();
        try {
            String sql = "SELECT classID, clname FROM class";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Class cl = new Class();
                cl.setClassid(rs.getInt("classID"));
                cl.setClname(rs.getString("clname"));
                classes.add(cl);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return classes;
    }
     
     
}