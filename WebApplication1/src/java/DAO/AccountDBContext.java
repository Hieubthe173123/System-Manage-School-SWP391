/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Account;
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
public class AccountDBContext extends DBContext {

    public static void main(String[] args) {
        AccountDBContext ac = new AccountDBContext();
        System.out.println(ac.getByUsernamePassword("Admin", "123").getUsername());
    }

    public List<Account> getAllAccount() {
        List<Account> list = new ArrayList<>();

        return list;
    }
    
       //change password
    public void changePass(int id, String newPass) {
        try {
            String sql = "UPDATE Account SET password = ? WHERE pid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, newPass);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
     //change password lecturer
     public void changePassLecurers(int id, String newPass) {
        try {
            String sql = "UPDATE Account SET password = ? WHERE lid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, newPass);
            stm.setInt(2, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    public Account getByUsernamePassword(String username, String password) {
        try {
            String sql = "SELECT [aid]\n"
                    + "      ,[username]\n"
                    + "      ,[password]\n"
                    + "      ,[role]\n"
                    + "      ,[pid]\n"
                    + "      ,[lid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Account]\n"
                    + "  Where [username] = ? and [password] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, password);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Account account = new Account();
                account.setUsername(rs.getString("username"));
                account.setPassword(rs.getString("password"));
                account.setRole(rs.getInt("role"));
                account.setLid(rs.getInt("lid"));
                account.setPid(rs.getInt("pid"));
                return account;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updatePasswordByParentEmail(String email, String newPassword) {
        String sql = "UPDATE [dbo].[Account] SET [password] = ? WHERE pid = (SELECT pid FROM Parent WHERE email = ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updatePasswordByLecturerEmail(String email, String newPassword) {
        String sql = "UPDATE [dbo].[Account] SET [password] = ? WHERE lid = (SELECT lid FROM Lecturer WHERE email = ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newPassword);
            ps.setString(2, email);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AccountDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
