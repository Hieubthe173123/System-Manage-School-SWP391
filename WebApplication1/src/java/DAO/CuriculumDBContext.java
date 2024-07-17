/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Curiculum;
import Entity.SessionDetails;
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
            String sql = "SELECT COUNT(DISTINCT nameAct) AS distinct_nameAct_count\n"
                    + "FROM Curiculum;";

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

    public List<Curiculum> pagingCuriculum(String sid) {
        List<Curiculum> list = new ArrayList<>();
        try {
            String sql = " WITH RankedCuriculum AS (\n"
                    + "    SELECT \n"
                    + "        Curiculum.curID, \n"
                    + "        Curiculum.nameAct, \n"
                    + "        Curiculum.isFix, \n"
                    + "        ROW_NUMBER() OVER (PARTITION BY Curiculum.nameAct ORDER BY Curiculum.curID) AS rn\n"
                    + "    FROM \n"
                    + "        Curiculum\n"
                    + "    JOIN \n"
                    + "        Session_Details ON Session_Details.sdid = Curiculum.sdid\n"
                    + "    JOIN \n"
                    + "        Session ON Session.sid = Session_Details.sid\n"
                    + "    WHERE \n"
                    + "        Session.sid = ? AND Curiculum.statusCur IS NOT NULL \n"
                    + ")\n"
                    + "SELECT \n"
                    + "    curID, \n"
                    + "    nameAct, \n"
                    + "    isFix\n"
                    + "FROM \n"
                    + "    RankedCuriculum\n"
                    + "WHERE \n"
                    + "    rn = 1\n"
                    + "ORDER BY \n"
                    + "    curID ASC;";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum cur = new Curiculum();
                cur.setCurID(rs.getInt("curID"));
                cur.setNameAct(rs.getString("nameAct"));
                cur.setIsFix(rs.getBoolean("isFix"));
                list.add(cur);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public List<Curiculum> SearchByName(String sid, String nameAct) {
        List<Curiculum> list = new ArrayList<>();
        try {
            String sql = "WITH RankedCuriculum AS (\n"
                    + "    SELECT \n"
                    + "        Curiculum.curID, \n"
                    + "        Curiculum.nameAct, \n"
                    + "        Curiculum.isFix, \n"
                    + "        ROW_NUMBER() OVER (PARTITION BY Curiculum.nameAct ORDER BY Curiculum.curID) AS rn\n"
                    + "    FROM \n"
                    + "        Curiculum\n"
                    + "    JOIN \n"
                    + "        Session_Details ON Session_Details.sdid = Curiculum.sdid\n"
                    + "    JOIN \n"
                    + "        Session ON Session.sid = Session_Details.sid\n"
                    + "    WHERE \n"
                    + "        Session.sid = ? and Curiculum.nameAct like ? AND Curiculum.statusCur IS NOT NULL \n"
                    + ")\n"
                    + "SELECT \n"
                    + "    curID, \n"
                    + "    nameAct, \n"
                    + "    isFix\n"
                    + "FROM \n"
                    + "    RankedCuriculum\n"
                    + "WHERE \n"
                    + "    rn = 1";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sid);
            stm.setString(2, "%" + nameAct + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Curiculum cur = new Curiculum();
                cur.setCurID(rs.getInt("curID"));
                cur.setNameAct(rs.getString("nameAct"));
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
            String sql = "select Curiculum.curID,Curiculum.nameAct,  LEft(CONVERT(VARCHAR, TimeStart, 108),5)  as TimeStart, LEft(CONVERT(VARCHAR, TimeEnd, 108),5) as TimeEnd,Curiculum.isFix\n"
                    + "                                     from Curiculum\n"
                    + "                                    left join Session_Details on Curiculum.sdid = Session_Details.sdid\n"
                    + "                                  left join Session on Session_Details.sid = Session.sid\n"
                    + "                                where Session.sid = ? and Session_Details.sdid = ? and Curiculum.statusSes is not null\n"
                    + "                                order by Curiculum.TimeStart asc";

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

    public void deleteActivity(String nameAct) {
        try {
            String sql = "UPDATE [dbo].[Curiculum]\n"
                    + "SET [statusCur] = NULL\n"
                    + "WHERE [nameAct] = ?;";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, nameAct);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertCurriculum(String nameAct, String isFix) {
        String sql = " INSERT INTO [dbo].[Curiculum]\n"
                + "           ([nameAct]\n"
                + "           ,[isFix])\n"
                + "     VALUES\n"
                + "           (?, ?);";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, nameAct);
            stm.setString(2, isFix);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void promoteCuriculum(String nameAct, String sdid, String timeStart, String timeEnd) {
        try {
            String sql = "INSERT INTO [dbo].[Curiculum] ([nameAct], [sdid], [isFix], [TimeStart], [TimeEnd], [statusCur], [statusSes])\n"
                    + "SELECT distinct \n"
                    + "    ?,\n"
                    + "    ?,\n"
                    + "    isFix,\n"
                    + "    ?,\n"
                    + "     ?,\n"
                    + "    statusCur,\n"
                    + "    'active'\n"
                    + "FROM \n"
                    + "    Curiculum\n"
                    + "WHERE \n"
                    + "    nameAct = ? ;";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, nameAct);
            stm.setString(2, sdid);
            stm.setString(3, timeStart);
            stm.setString(4, timeEnd);
            stm.setString(5, nameAct);

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void addCuriculum(String nameAct, String sdid, String isFix, String timeStart, String timeEnd) {
        try {
            String sql = "INSERT INTO [dbo].[Curiculum]\n"
                    + "           ([nameAct]\n"
                    + "           ,[sdid]\n"
                    + "           ,[isFix]\n"
                    + "           ,[TimeStart]\n"
                    + "           ,[TimeEnd]\n"
                    + "           ,[statusSes])\n"
                    + "     VALUES\n"
                    + "           (? \n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,'active')";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, nameAct);
            stm.setString(2, sdid);
            stm.setString(3, isFix);
            stm.setString(4, timeStart);
            stm.setString(5, timeEnd);
        

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(LecturerClassSession.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkTimeSlotConflict(String sdid, String timeStart, String timeEnd) {
        String sql = "SELECT COUNT(*) FROM Curiculum WHERE sdid = ? AND timeStart =?  AND timeEnd = ? and statusSes is not null";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sdid);
            stm.setString(2, timeStart);
            stm.setString(3, timeEnd);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Curiculum> getAllActivity() {
        List<Curiculum> list = new ArrayList<>();
        try {
            String sql = "select * from Curiculum\n"
                    + "join Session_Details sd on Curiculum.sdid = sd.sdid\n"
                    + "order by sessionNumber asc";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                SessionDetails sd = new SessionDetails();
                sd.setSdid(rs.getInt("sdid"));
                sd.setSessionNumber(rs.getInt("sessionNumber"));

                Curiculum cur = new Curiculum();
                cur.setCurID(rs.getInt("curID"));
                cur.setNameAct(rs.getString("nameAct"));
                cur.setTimeStart(rs.getString("TimeStart"));
                cur.setTimeEnd(rs.getString("TimeEnd"));
                cur.setIsFix(rs.getBoolean("isFix"));
                cur.setSdid(sd);

                list.add(cur);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public List<Curiculum> getAllActivityHistory(String sid, String sdid) {
        List<Curiculum> list = new ArrayList<>();
        try {
            String sql = "select * from curiculum cur\n" +
"                    left join session_details sd on cur.sdid = sd.sdid\n" +
"                    where sd.sid = ? and sd.sdid = ? and cur.statusSes is not null";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sid);
            stm.setString(2, sdid);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                SessionDetails sd = new SessionDetails();
                sd.setSdid(rs.getInt("sdid"));
                sd.setSessionNumber(rs.getInt("sessionNumber"));

                Curiculum cur = new Curiculum();
                cur.setCurID(rs.getInt("curID"));
                cur.setNameAct(rs.getString("nameAct"));
                cur.setTimeStart(rs.getString("TimeStart"));
                cur.setTimeEnd(rs.getString("TimeEnd"));
                cur.setIsFix(rs.getBoolean("isFix"));
                cur.setSdid(sd);

                list.add(cur);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        CuriculumDBContext cur = new CuriculumDBContext();
        List<Curiculum> list = cur.getAllActivityInSession("1", "1");
        System.out.println(list);
    }

}
