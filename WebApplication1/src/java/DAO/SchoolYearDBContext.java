/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Class;
import Entity.ClassSession;
import Entity.Lecturers_Class_Session;
import Entity.Room;
import Entity.SchoolYear;
import Entity.Session;
import Entity.Student;
import Entity.StudentClassSession;
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
public class SchoolYearDBContext extends DBContext {

    public ArrayList<Session> getAllSession() {
        ArrayList<Session> list = new ArrayList<>();
        try {
            String sql = "SELECT [sid], [sname], [totalSession], [ageid] FROM [SchoolManagement].[dbo].[Session]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Session s = new Session();
                AgeDBContext ageDB = new AgeDBContext();
                s.setSid(rs.getInt("sid"));
                s.setSname(rs.getString("sname"));
                s.setTotalSession(rs.getInt("totalSession"));
                s.setAge(ageDB.getAgeById(rs.getInt("ageid")));
                list.add(s);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Room> getAllRoom() {
        ArrayList<Room> list = new ArrayList<>();
        try {
            String sql = "SELECT [rid], [rname] FROM [SchoolManagement].[dbo].[Room]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRid(rs.getInt("rid"));
                room.setRname(rs.getString("rname"));
                list.add(room);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<Class> getAllClass() {
        ArrayList<Class> list = new ArrayList<>();
        try {
            String sql = "SELECT [classID], [clname] FROM [SchoolManagement].[dbo].[Class]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Class cls = new Class();
                cls.setClassid(rs.getInt("classID"));
                cls.setClname(rs.getString("clname"));
                list.add(cls);
            }

        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public SchoolYear getSchoolYearById(int id) {
        SchoolYear school = new SchoolYear();
        try {
            String sql = "SELECT [yid]\n"
                    + "      ,[dateStart]\n"
                    + "      ,[dateEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[SchoolYear] Where yid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                FoodDBContext food = new FoodDBContext();
                MealTimeDBContext meal = new MealTimeDBContext();
                AgeDBContext age = new AgeDBContext();
                school.setYid(rs.getInt("yid"));
                school.setDateStart(rs.getDate("dateStart"));
                school.setDateEnd(rs.getDate("dateEnd"));
                return school;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    //List  Function getAll Class in SchoolYear
    public ArrayList<SchoolYear> getAllSchoolYear() {
        ArrayList<SchoolYear> list = new ArrayList<>();
        try {
            String sql = "SELECT [yid]\n"
                    + "      ,[dateStart]\n"
                    + "      ,[dateEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[SchoolYear]";
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SchoolYear year = new SchoolYear();
                year.setYid(rs.getInt("yid"));
                year.setDateStart(rs.getDate("dateStart"));
                year.setDateEnd(rs.getDate("dateEnd"));
                list.add(year);

            }
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;

    }

    public ArrayList<SchoolYear> getSchoolYearById(String id) {
        ArrayList<SchoolYear> list = new ArrayList<>();
        try {
            String sql = "SELECT [yid]\n"
                    + "      ,[dateStart]\n"
                    + "      ,[dateEnd]\n"
                    + "  FROM [SchoolManagement].[dbo].[SchoolYear]\n"
                    + "  WHERE yid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                SchoolYear year = new SchoolYear();
                year.setYid(rs.getInt("yid"));
                year.setDateStart(rs.getDate("dateStart"));
                year.setDateEnd(rs.getDate("dateEnd"));
                list.add(year);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public ArrayList<ClassSession> getClassSessionByYid(String id) {
        ArrayList<ClassSession> list = new ArrayList<>();
        try {
            String sql = "SELECT [csid]\n"
                    + "      ,[classID]\n"
                    + "      ,[yid]\n"
                    + "      ,[sid]\n"
                    + "      ,[rid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Class_Session]\n"
                    + "  WHERE yid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClassSession cls = new ClassSession();
                ClassDBContext cldb = new ClassDBContext();
                RoomDBContext rdb = new RoomDBContext();
                SessionDBContext sedb = new SessionDBContext();
                SchoolYearDBContext yearDB = new SchoolYearDBContext();

                cls.setCsid(rs.getInt("csid"));
                cls.setClassID(cldb.getClassById(rs.getInt("classID")));
                cls.setRid(rdb.getRoomByRid(rs.getInt("rid")));
                cls.setSid(sedb.getSessionById(rs.getInt("sid")));
                cls.setYid(yearDB.getSchoolYearById(rs.getInt("yid")));

                list.add(cls);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;

    }

    public ArrayList<StudentClassSession> getStudentClassSessionbyCsid(int csid) {
        ArrayList<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = "SELECT [scid]\n"
                    + "      ,[stuid]\n"
                    + "      ,[csid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student_Class_Session]\n"
                    + "  WHERE csid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, csid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentClassSession stuclass = new StudentClassSession();
                StudentDBContext stud = new StudentDBContext();
                Class_SessionDBContext ses = new Class_SessionDBContext();
                stuclass.setScid(rs.getInt("scid"));

                stuclass.setStuid(stud.getStudentById(rs.getInt("stuid")));

                //stuclass.setCsid(ses.getClassSessionById(rs.getInt("csid")));
                stuclass.setCsid(ses.getClassSessionById(csid));

                list.add(stuclass);

            }
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public ArrayList<StudentClassSession> getAllStudentClassSession() {
        ArrayList<StudentClassSession> stu = new ArrayList();
        try {
            String sql = "SELECT [scid]\n"
                    + "      ,[stuid]\n"
                    + "      ,[csid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student_Class_Session]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                StudentClassSession student = new StudentClassSession();
                Class_SessionDBContext classSess = new Class_SessionDBContext();
                StudentDBContext stud = new StudentDBContext();
                student.setScid(rs.getInt("scid"));
                student.setCsid(classSess.getClassSessionById(rs.getInt("csid")));
                student.setStuid(stud.getStudentById(rs.getInt("stuid")));

                stu.add(student);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return stu;
    }

    public Lecturers_Class_Session getLecturerByCsid(int id) {
        Lecturers_Class_Session lec = new Lecturers_Class_Session();
        try {
            String sql = "SELECT [lclassID]\n"
                    + "      ,[lid]\n"
                    + "      ,[csid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Lecturers_Class_Session] Where csid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Class_SessionDBContext classSess = new Class_SessionDBContext();
                LecturersDBContext lectu = new LecturersDBContext();
                lec.setLclassID(rs.getInt("lclassID"));
                lec.setCsid(classSess.getClassSessionById(rs.getInt("csid")));
                lec.setLid(lectu.getLecturerByid(rs.getInt("lid")));
                return lec;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public ArrayList<Lecturers_Class_Session> getLecturersByCsid(int id) {
        ArrayList<Lecturers_Class_Session> lecturers = new ArrayList<>();
        try {
            String sql = "SELECT [lclassID], [lid], [csid] FROM [SchoolManagement].[dbo].[Lecturers_Class_Session] WHERE csid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturers_Class_Session lec = new Lecturers_Class_Session();
                Class_SessionDBContext classSess = new Class_SessionDBContext();
                LecturersDBContext lectu = new LecturersDBContext();
                lec.setLclassID(rs.getInt("lclassID"));
                lec.setCsid(classSess.getClassSessionById(rs.getInt("csid")));
                lec.setLid(lectu.getLecturerByid(rs.getInt("lid")));
                lecturers.add(lec);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return lecturers;
    }

    //Create New SchoolYear
    public int insertNewSchoolYearForClassSession(String dateStart, String dateEnd) {
        int newYid = 0;
        try {
            // Start transaction
            connection.setAutoCommit(false);

            // Insert new school year
            String insertNewYear = "INSERT INTO SchoolYear (dateStart, dateEnd) VALUES (?, ?);";
            PreparedStatement ps = connection.prepareStatement(insertNewYear, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, dateStart);
            ps.setString(2, dateEnd);
            ps.executeUpdate();

            // Retrieve the generated key
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                newYid = rs.getInt(1);
            }
            rs.close();
            ps.close();
            //if newYearID insert success => Insert new information
            if (newYid != 0) {
                // Insert new class session
                String insertNewCsid = "INSERT INTO Class_Session (classID, yid, sid, rid) "
                        + "SELECT cs.classID, ?, cs.sid, cs.rid "
                        + "FROM Class_Session cs "
                        + "WHERE cs.yid = 1 "
                        + "AND NOT EXISTS ( "
                        + "    SELECT 1 "
                        + "    FROM Class_Session cs2 "
                        + "    WHERE cs2.classID = cs.classID "
                        + "    AND cs2.yid = ? "
                        + ");";
                PreparedStatement ps2 = connection.prepareStatement(insertNewCsid);
                ps2.setInt(1, newYid);
                ps2.setInt(2, newYid);
                ps2.executeUpdate();
                ps2.close();
            }
            // Commit transaction
            connection.commit();
            connection.setAutoCommit(true);

        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
            try {
                // Rollback transaction in case of error
                connection.rollback();
                connection.setAutoCommit(true);
            } catch (SQLException rollbackEx) {
                Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            return 0; // Returning 0 in case of an error
        }
        return newYid; // Returning the new school year ID
    }

    public static void main(String[] args) {
        SchoolYearDBContext db = new SchoolYearDBContext();
        //db.insertNewSchoolYearForClassSession("2024-08-01", "2025-09-01");
    }

}
