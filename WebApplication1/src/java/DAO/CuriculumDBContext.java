/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Curiculum;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class CuriculumDBContext extends DBContext {

    public List<Curiculum> getCuriculumById(int id) {
        List<Curiculum> curi = new ArrayList<>();
        try {
            String sql = "SELECT [curID]\n"
                    + "      ,[atid]\n"
                    + "      ,[nameAct]\n"
                    + "      ,[sdid]\n"
                    + "      ,[isFix]\n"
                    + "      ,[TimeStart]\n"
                    + "      ,[TimeEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[Curiculum] Where sdid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum curiculum = new Curiculum();
                SessionDetailDBContext sesD = new SessionDetailDBContext();

                curiculum.setCurID(rs.getInt("curID"));
                curiculum.setTimeEnd(rs.getString("TimeEnd"));
                curiculum.setTimeStart(rs.getString("TimeStart"));
                curiculum.setNameAct(rs.getString("nameAct"));
                curiculum.setSdid(sesD.getSessionDetailById(rs.getInt("sdid")));
                curiculum.setIsFix(rs.getBoolean("isFix"));
                curi.add(curiculum);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return curi;
    }

    public List<Curiculum> getCuriculumBySessionId(int id) {
        List<Curiculum> curi = new ArrayList<>();
        try {
            String sql = "SELECT [curID]\n"
                    + "      ,[atid]\n"
                    + "      ,[nameAct]\n"
                    + "      ,[sdid]\n"
                    + "      ,[isFix]\n"
                    + "      ,[TimeStart]\n"
                    + "      ,[TimeEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[Curiculum] Where sdid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum curiculum = new Curiculum();
                SessionDetailDBContext sesD = new SessionDetailDBContext();

                curiculum.setCurID(rs.getInt("curID"));
                curiculum.setTimeEnd(rs.getString("TimeEnd"));
                curiculum.setTimeStart(rs.getString("TimeStart"));
                curiculum.setNameAct(rs.getString("nameAct"));
                curiculum.setSdid(sesD.getSessionDetailById(rs.getInt("sdid")));
                curiculum.setIsFix(rs.getBoolean("isFix"));
                curi.add(curiculum);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return curi;
    }

    public int getTotalCuriculum() {
        try {
            String sql = "select count(*) FROM Curiculum";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Curiculum> pagingCuriculum(int index, String sid) {
        List<Curiculum> list = new ArrayList<>();
        try {
            String sql = "	WITH RankedCuriculum AS (\n"
                    + "    SELECT\n"
                    + "        Curiculum.curID,\n"
                    + "        Curiculum.nameAct,\n"
                    + "        LEFT(CONVERT(VARCHAR, Curiculum.TimeStart, 108), 5) AS TimeStart,\n"
                    + "        CONVERT(VARCHAR, Curiculum.TimeEnd, 108) AS TimeEnd,\n"
                    + "        Curiculum.isFix,\n"
                    + "        ROW_NUMBER() OVER (PARTITION BY Curiculum.nameAct ORDER BY Curiculum.curID) AS RowNum\n"
                    + "    FROM\n"
                    + "        Curiculum\n"
                    + "    LEFT JOIN\n"
                    + "        Session_Details ON Curiculum.sdid = Session_Details.sdid\n"
                    + "    LEFT JOIN\n"
                    + "        Session ON Session_Details.sid = Session.sid\n"
                    + "    WHERE\n"
                    + "        Session.sid = ?\n"
                    + ")\n"
                    + "SELECT\n"
                    + "    curID,\n"
                    + "    nameAct,\n"
                    + "    TimeStart,\n"
                    + "    TimeEnd,\n"
                    + "    isFix\n"
                    + "FROM\n"
                    + "    RankedCuriculum\n"
                    + "WHERE\n"
                    + "    RowNum = 1\n"
                    + "ORDER BY\n"
                    + "    curID\n"
                    + "OFFSET ? ROWS\n"
                    + "FETCH NEXT 10 ROWS ONLY;;";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sid); // Set the session ID parameter
            stm.setInt(2, (index - 1) * 10); // Calculate and set the offset

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum cur = new Curiculum();
                cur.setCurID(rs.getInt("curID"));
                cur.setNameAct(rs.getString("nameAct"));
                cur.setTimeStart(rs.getString("TimeStart")); // Use the correct column label
                cur.setTimeEnd(rs.getString("TimeEnd")); // Use the correct column label
                cur.setIsFix(rs.getBoolean("isFix"));
                list.add(cur);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Curiculum> getAllActivityInSession(String sid, String sdid) {
        List<Curiculum> list = new ArrayList<>();
        try {
            String sql = "select Curiculum.curID,Curiculum.nameAct,  LEft(CONVERT(VARCHAR, TimeStart, 108),5)  as TimeStart, LEft(CONVERT(VARCHAR, TimeStart, 108),5) as TimeEnd,Curiculum.isFix\n"
                    + "from Curiculum\n"
                    + "left join Session_Details on Curiculum.sdid = Session_Details.sdid\n"
                    + "left join Session on Session_Details.sid = Session.sid\n"
                    + "where Session.sid = ? and Session_Details.sdid = ?\n"
                    + "order by Curiculum.TimeStart asc";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sid); // Set the session ID parameter
            stm.setString(2, sdid); // Set the session details ID parameter
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum cur = new Curiculum();
                cur.setCurID(rs.getInt("curID"));
                cur.setNameAct(rs.getString("nameAct"));
                cur.setTimeStart(rs.getString("TimeStart")); // Use the correct column label
                cur.setTimeEnd(rs.getString("TimeEnd")); // Use the correct column label
                cur.setIsFix(rs.getBoolean("isFix"));
                list.add(cur);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        CuriculumDBContext cur = new CuriculumDBContext();
        List<Curiculum> sc = cur.getAllActivityInSession("1", "1");
        System.out.println(sc);

    }
}
