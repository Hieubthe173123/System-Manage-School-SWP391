/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Parent;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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

    public void updateParent(Parent parent) {
        try {
            String sql = "UPDATE [Parent] SET pname = ?, gender = ?, dob = ?, phoneNumber = ?, IDcard = ?, Address = ?, Email = ?, NickName = ? WHERE pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, parent.getPname());
            stm.setBoolean(2, parent.isGender());
            stm.setString(3, parent.getDob());
            stm.setString(4, parent.getPhoneNumber());
            stm.setString(5, parent.getIDcard());
            stm.setString(6, parent.getAddress());
            stm.setString(7, parent.getEmail());
            stm.setString(8, parent.getNickname());
            stm.setInt(9, parent.getPid());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ParentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addParent(Parent parent) {
        try {
            String sql = "INSERT INTO Parent (pname, gender, dob, phoneNumber, IDcard, [Address], Email, NickName) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, parent.getPname());
            stm.setBoolean(2, parent.isGender());
            stm.setString(3, parent.getDob());
            stm.setString(4, parent.getPhoneNumber());
            stm.setString(5, parent.getIDcard());
            stm.setString(6, parent.getAddress());
            stm.setString(7, parent.getEmail());
            stm.setString(8, parent.getNickname());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ParentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public List<Parent> getAllParents(int index) {
        List<Parent> parentList = new ArrayList<>();
        try {
            String sql = "SELECT [pid], [pname], [gender], [dob], [phoneNumber], [IDcard], [Address], [Email], [NickName] "
                    + "FROM [SchoolManagement].[dbo].[Parent] "
                    + "ORDER BY [pid] "
                    + "OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 10);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
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
                parentList.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return parentList;
    }

    public List<Parent> getParentByName(String pname) {
        List<Parent> parentList = new ArrayList<>();
        try {
            String sql = "SELECT [pid], [pname], [gender], [dob], [phoneNumber], [IDcard], [Address], [Email], [NickName] "
                    + "FROM [SchoolManagement].[dbo].[Parent] "
                    + "WHERE [pname] LIKE ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + pname + "%");

            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
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
                parentList.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return parentList;
    }

    
    //Check if parent exists
    public boolean checkParentIdExists(int pid) {
        try {
            String sql = "SELECT COUNT(*) AS count FROM Parent WHERE pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    //Check if IDCard exists
    public boolean isIDCardExists(String idCard) {
        boolean exists = false;
        try {
            String sql = "SELECT COUNT(*) AS count FROM [SchoolManagement].[dbo].[Parent] WHERE [IDcard] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, idCard);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int count = rs.getInt("count");
                if (count > 0) {
                    exists = true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return exists;
    }

    //Count the number of parents for pagination
    public int getTotalParent() {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS count FROM [SchoolManagement].[dbo].[Parent]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException ex) {
            Logger.getLogger(ParentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }
}
