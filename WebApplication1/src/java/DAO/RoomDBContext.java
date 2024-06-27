/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Room;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author admin
 */
public class RoomDBContext extends DBContext {

    public Room getRoomByRid(int rid) {
        try {
            String sql = "SELECT [rid]\n"
                    + "      ,[rname]\n"
                    + "  FROM [dbo].[Room]\n"
                    + "  Where rid = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, rid);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Room r = new Room(rs.getInt("rid"), rs.getString("rname"));
                return r;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Room getRoombyID(int rid) {
        try {
            String sql = "SELECT [rid]\n"
                    + "      ,[rname]\n"
                    + "  FROM [SchoolManagement].[dbo].[Room]\n"
                    + "  WHERE rid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Room r = new Room();
                r.setRid(rs.getInt("rid"));
                r.setRname(rs.getString("rname"));
                return r;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Room> getAllRoom() {
        ArrayList<Room> list = new ArrayList<>();
        try {
            String sql = "SELECT [rid]\n"
                    + "      ,[rname]\n"
                    + "  FROM [SchoolManagement].[dbo].[Room]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room r = new Room();
                r.setRid(rs.getInt("rid"));
                r.setRname(rs.getString("rname"));
                list.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public static void main(String[] args) {
        RoomDBContext r = new RoomDBContext();
        Room rb = r.getRoombyID(1);
        System.out.println(rb.getRname());
    }
}

