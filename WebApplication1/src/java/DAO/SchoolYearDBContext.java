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
                school.setDateStart(rs.getString("dateStart"));
                school.setDateEnd(rs.getString("dateEnd"));
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
                year.setDateStart(rs.getString("dateStart"));
                year.setDateEnd(rs.getString("dateEnd"));
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
                year.setDateStart(rs.getString("dateStart"));
                year.setDateEnd(rs.getString("dateEnd"));
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

    //Lấy ra tất cả danh sách lớp học ở những năm cũ
    public ArrayList<ClassSession> getAllClassesFromPreviousYears(String id) {
        ArrayList<ClassSession> list = new ArrayList<>();
        try {
            String sql = "SELECT [csid]\n"
                    + "      ,[classID]\n"
                    + "      ,[yid]\n"
                    + "      ,[sid]\n"
                    + "      ,[rid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Class_Session]\n"
                    + "  WHERE yid < ?";
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

    public ArrayList<ClassSession> getClassSessionById(String id) {
        ArrayList<ClassSession> list = new ArrayList<>();
        try {
            String sql = "SELECT [csid]\n"
                    + "      ,[classID]\n"
                    + "      ,[yid]\n"
                    + "      ,[sid]\n"
                    + "      ,[rid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Class_Session]\n"
                    + "  WHERE csid = ?";
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

    //Lấy ra danh sách học sinh ở năm học cũ khi chọn năm học mới
    public ArrayList<StudentClassSession> getStudentsFromPreviousYears(String yid) {
        ArrayList<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "scs.scid, \n"
                    + "scs.stuid, \n"
                    + "s.sname,\n"
                    + "s.dob,\n"
                    + "s.gender,\n"
                    + "cs.csid, \n"
                    + "cs.classID, \n"
                    + "cl.clname,\n"
                    + "cs.sid, \n"
                    + "cs.yid,\n"
                    + "y.dateStart,\n"
                    + "y.dateEnd\n"
                    + "FROM Student_Class_Session scs\n"
                    + "join Student s on scs.stuid = s.stuid\n"
                    + "join Class_Session cs on scs.csid = cs.csid\n"
                    + "join SchoolYear y on cs.yid = y.yid\n"
                    + "join Class cl on cs.classID = cl.classID\n"
                    + "WHERE cs.yid = (SELECT MAX(yid) FROM SchoolYear WHERE yid < ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, yid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentClassSession studentClassSession = new StudentClassSession();
                // Set StudentClassSession ID
                studentClassSession.setScid(rs.getInt("scid"));

                // Set Student details
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setDob(rs.getString("dob"));
                student.setGender(rs.getBoolean("gender"));
                studentClassSession.setStuid(student);

                // Set ClassSession details
                Class cl = new Class();
                ClassSession classSession = new ClassSession();
                classSession.setCsid(rs.getInt("csid"));
                cl.setClassid(rs.getInt("classID"));
                cl.setClname(rs.getString("clname"));
                classSession.setClassID(cl);

                Session session = new Session();
                session.setSid(rs.getInt("sid"));
                classSession.setSid(session);

                SchoolYear schoolYear = new SchoolYear();
                schoolYear.setYid(rs.getInt("yid"));
                schoolYear.setDateStart(rs.getString("dateStart"));
                schoolYear.setDateEnd(rs.getString("dateEnd"));
                classSession.setYid(schoolYear);

                studentClassSession.setCsid(classSession);

                // Add the studentClassSession object to the list
                list.add(studentClassSession);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }


    //Add học sinh vào lớp mới trong bảng Student_Class_Session
    public void addStudentToClass(StudentClassSession student) {
        try {
            String sql = "INSERT INTO [dbo].[Student_Class_Session]\n"
                    + "           ([stuid]\n"
                    + "           ,[csid])\n"
                    + "     VALUES\n"
                    + "           (?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, student.getStuid().getStuid());
            ps.setInt(2, student.getCsid().getCsid());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    //Kiểm tra xem năm học này học sinh đã được add vào những lớp nào
    public ArrayList<StudentClassSession> getAssignedStudentId(String yid) {
        ArrayList<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = "select scs.stuid, cs.yid from Student_Class_Session scs \n"
                    + "	join Class_Session cs on scs.csid = cs.csid\n"
                    + "	where cs.yid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, yid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentClassSession scs = new StudentClassSession();

                Student s = new Student();
                s.setStuid(rs.getInt("stuid"));
                scs.setStuid(s);

                ClassSession cls = new ClassSession();
                SchoolYear year = new SchoolYear();
                year.setYid(rs.getInt("yid"));
                cls.setYid(year);

                scs.setCsid(cls);
                list.add(scs);

            }
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Lấy ra lịch sử của học sinh đã học những lớp nào trong năm học nào
    public ArrayList<StudentClassSession> getHistorySchoolYearbyStuid(String stuid) {
        ArrayList<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = "SELECT \n"
                    + "    s.stuid,\n"
                    + "    s.sname,\n"
                    + "    s.dob,\n"
                    + "    se.sid,\n"
                    + "    se.Sname,\n"
                    + "    c.classID,\n"
                    + "    c.clname,\n"
                    + "    y.yid,\n"
                    + "    y.dateStart,\n"
                    + "    y.dateEnd\n"
                    + "FROM \n"
                    + "    Student_Class_Session scs\n"
                    + "JOIN \n"
                    + "    Student s ON s.stuid = scs.stuid\n"
                    + "JOIN \n"
                    + "    Class_Session cs ON scs.csid = cs.csid\n"
                    + "JOIN \n"
                    + "	Session se on cs.sid = se.sid\n"
                    + "JOIN \n"
                    + "	Class c on cs.classID = c.classID\n"
                    + "JOIN \n"
                    + "    SchoolYear y ON cs.yid = y.yid\n"
                    + "WHERE s.stuid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, stuid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentClassSession scs = new StudentClassSession();
                ClassSession cls = new ClassSession();

                Student stu = new Student();
                stu.setStuid(rs.getInt("stuid"));
                stu.setSname(rs.getString("sname"));
                stu.setDob(rs.getString("dob"));
                scs.setStuid(stu);

                Session ses = new Session();
                ses.setSid(rs.getInt("sid"));
                ses.setSname(rs.getString("Sname"));
                cls.setSid(ses);
                scs.setCsid(cls);

                Class cla = new Class();
                cla.setClassid(rs.getInt("classID"));
                cla.setClname(rs.getString("clname"));
                cls.setClassID(cla);
                scs.setCsid(cls);

                SchoolYear year = new SchoolYear();
                year.setYid(rs.getInt("yid"));
                year.setDateStart(rs.getString("dateStart"));
                year.setDateEnd(rs.getString("dateEnd"));
                cls.setYid(year);
                scs.setCsid(cls);

                list.add(scs);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
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

    //Tạo Năm học mới
    public int insertNewSchoolYearForClassSession(String dateStart, String dateEnd) {
        int newYid = 0;  //tạo biến để lưu năm học mới khi được tạo
        try {
            // hàm kết nối để xử lý
            connection.setAutoCommit(false);

            // Insert bản ghi năm học mới
            String insertNewYear = "INSERT INTO SchoolYear (dateStart, dateEnd) VALUES (?, ?);";
            PreparedStatement ps = connection.prepareStatement(insertNewYear, PreparedStatement.RETURN_GENERATED_KEYS);
            ps.setString(1, dateStart);
            ps.setString(2, dateEnd);
            ps.executeUpdate();

            // tạo năm học mới => lấy ra id của năm học vừa đc insert
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                newYid = rs.getInt(1);
            }
            rs.close();
            ps.close();
            //nếu năm học mới được tạo => insert tiếp vào Class_Session
            if (newYid != 0) {
                // thêm yid mới => thêm các nội dung cho năm học mới đc tạo
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
            
            connection.commit();
            connection.setAutoCommit(true);

        } catch (SQLException ex) {
            Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, ex);
            try {
                
                connection.rollback();
                connection.setAutoCommit(true);
            } catch (SQLException rollbackEx) {
                Logger.getLogger(SchoolYearDBContext.class.getName()).log(Level.SEVERE, null, rollbackEx);
            }
            return 0;
        }
        return newYid; //Trả về ID của năm học mới được chèn
    }

    public static void main(String[] args) {
        SchoolYearDBContext db = new SchoolYearDBContext();
        ArrayList<StudentClassSession> list = db.getHistorySchoolYearbyStuid("1");
        System.out.println(list);

    }
}
