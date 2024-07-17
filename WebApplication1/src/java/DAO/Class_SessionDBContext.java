/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.ClassSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import Entity.Class;
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
                    + "      ,[rid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Class_Session] Where csid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                SchoolYearDBContext scho = new SchoolYearDBContext();
                ClassDBContext cla = new ClassDBContext();
                SessionDBContext ses = new SessionDBContext();
                RoomDBContext r = new RoomDBContext();
                AgeDBContext age = new AgeDBContext();
                claSes.setCsid(rs.getInt("csid"));
                claSes.setClassID(cla.getClassById(rs.getInt("classID")));
                claSes.setYid(scho.getSchoolYearById(rs.getInt("yid")));
                claSes.setSid(ses.getSessionById(rs.getInt("sid")));
                claSes.setRid(r.getRoomByRid(rs.getInt("rid")));
                return claSes;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }
    
//  public List<ClassSession> getAllClassID() {
//    List<ClassSession> classIDs = new ArrayList<>();
//    try {
//        String sql = "SELECT cs.classID,  cl.clname"
//                   + "FROM Class_Session cs "
//                   + "INNER JOIN SchoolYear sy ON cs.yid = sy.yid "
//                   + "INNER JOIN Class cl ON cs.classID = cl.classID "
//                   + "WHERE cs.status = 1 "
//                   + "AND sy.dateEnd = (SELECT MAX(dateEnd) FROM SchoolYear)";
//
//        PreparedStatement stm = connection.prepareStatement(sql);
//        ResultSet rs = stm.executeQuery();
//        while (rs.next()) {
//            ClassSession classSession = new ClassSession();
//            ClassDBContext cla = new ClassDBContext();
//            classSession.setClassID(cla.getClassById(rs.getInt("classID")));
//            classIDs.add(classSession);
//        }
//    } catch (SQLException e) {
//        System.out.println(e);
//    }
//    return classIDs;
//}
//  public List<String> getAllClassNames() {
//        List<String> classNames = new ArrayList<>();
//        try {
//            String sql = "SELECT cl.clname "
//                       + "FROM Class_Session cs "
//                       + "INNER JOIN SchoolYear sy ON cs.yid = sy.yid "
//                       + "INNER JOIN Class cl ON cs.classID = cl.classID "
//                       + "WHERE cs.status = 1 "
//                       + "AND sy.dateEnd = (SELECT MAX(dateEnd) FROM SchoolYear)";
//            PreparedStatement stm = connection.prepareStatement(sql);
//            ResultSet rs = stm.executeQuery();
//            while (rs.next()) {
//                String className = rs.getString("clname");
//                classNames.add(className);
//            }
//        } catch (SQLException e) {
//            System.out.println(e);
//        }
//        return classNames;
//    }
//  
//  
//}

      public List<ClassSession> getAllClass() {
        List<ClassSession> list = new ArrayList<>();
        try {
            String sql = "select * from Class_Session cs\n"
                    + "inner join Class cl on cs.classID = cl.classID\n"
                    + "where cs.status = '1'";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID"));
                cl.setClname(rs.getString("clname"));
                ClassSession cs = new ClassSession();
                cs.setClassID(cl);
                list.add(cs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
}
