/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Entity.Student;
import Entity.Class;
import Entity.ClassSession;
import Entity.Parent;
import java.util.logging.Level;
import java.util.logging.Logger;
import Entity.StudentClassSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class StudentClassSessionDBContext extends DBContext {
//    public static void main(String[] args) {
//        StudentClassSessionDBContext d = new StudentClassSessionDBContext();
//        List<StudentClassSession> l = d.getStudentClassSessionByStuid(1);
//        System.out.println(l.size());
//    }
    public List<StudentClassSession> getStudentClassSessionById(int id) {
        List<StudentClassSession> stu = new ArrayList();
        try {
            String sql = "SELECT [scid]\n"
                    + "      ,[stuid]\n"
                    + "      ,[csid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student_Class_Session] Where csid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
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
    
    public List<StudentClassSession> getStudentClassSessionByStuid(int id) {
        List<StudentClassSession> stu = new ArrayList();
        try {
            String sql = "SELECT [scid]\n"
                    + "      ,[stuid]\n"
                    + "      ,[csid]\n"
                    + "  FROM [SchoolManagement].[dbo].[Student_Class_Session] Where stuid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
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
    
    public List<StudentClassSession> getAllStudentClassSession() {
        List<StudentClassSession> list = new ArrayList<>();

        try {
            String sql = "SELECT S.stuid, S.sname, S.dob, S.gender, S.[Address], P.pid, C.classID, C.clname "
                    + "FROM Student S "
                    + "INNER JOIN Student_Class_Session SCS ON S.stuid = SCS.stuid "
                    + "INNER JOIN Class_Session CS ON SCS.csid = CS.csid "
                    + "INNER JOIN Class C ON CS.classID = C.classID "
                    + "INNER JOIN Parent P ON S.pid = P.pid";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setGender(rs.getBoolean("gender"));
                student.setDob(rs.getString("dob"));
                student.setAddress(rs.getString("Address"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID")); 
                cl.setClname(rs.getString("clname"));

                ClassSession cs = new ClassSession();
                cs.setClassID(cl);

                Parent parent = new Parent();
                parent.setPid(rs.getInt("pid"));
                student.setPid(parent);

                StudentClassSession stuClass = new StudentClassSession();
                stuClass.setCsid(cs);
                stuClass.setStuid(student);
                list.add(stuClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        StudentClassSessionDBContext stu = new StudentClassSessionDBContext();
        List<StudentClassSession> list = stu.getAllStudentClassSession();
        System.out.println(list);
    }

    
    
      public List<StudentClassSession> getStudentClassSessionBySchoolYear(String timeStart, String timeEnd) {
        List<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = 
                    "SELECT S.stuid, S.sname, S.dob, S.gender, S.[Address], P.pid, C.clname "
                    + "FROM Student S "
                    + "Inner join Student_Class_Session scs ON S.stuid = scs.scid "
                    + "Inner join  Class_Session cs ON scs.scid = cs.csid "
                    + "Inner join Parent p ON s.stuid = p.pid "
                    + "Inner join class cl ON cs.csid = cl.classID "
                    + "Inner join SchoolYear sy ON cs.csid = sy.yid"
                    + "Where sy.dateStart LIKE ? AND sy.dateEnd LIKE ?" ;
                    
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, timeStart + "%");
            stm.setString(2, timeEnd + "%");
            ResultSet rs = stm.executeQuery();
            
             while (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setGender(rs.getBoolean("gender"));
                student.setDob(rs.getString("dob"));
                student.setAddress(rs.getString("Address"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID")); 
                cl.setClname(rs.getString("clname"));

                ClassSession cs = new ClassSession();
                cs.setClassID(cl);

                Parent parent = new Parent();
                parent.setPid(rs.getInt("pid"));
                student.setPid(parent);

                StudentClassSession stuClass = new StudentClassSession();
                stuClass.setCsid(cs);
                stuClass.setStuid(student);
                list.add(stuClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

     

 public List<StudentClassSession> getStudentClassSessionBySchoolYearWithPaging(String timeStart, String timeEnd, int index) {
        List<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = 
                    "SELECT S.stuid, S.sname, S.dob, S.gender, S.[Address], P.pid, C.clname "
                    + "FROM Student S "
                    + "Inner join Student_Class_Session scs ON S.stuid = scs.scid "
                    + "Inner join  Class_Session cs ON scs.scid = cs.csid "
                    + "Inner join Parent p ON s.stuid = p.pid "
                    + "Inner join class cl ON cs.csid = cl.classID "
                    + "Inner join SchoolYear sy ON cs.csid = sy.yid"
                    + "Where sy.dateStart LIKE ? AND sy.dateEnd LIKE ?" 
                    + "ORDER BY S.stuid OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
                    
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, timeStart + "%");
            stm.setString(2, timeEnd + "%");
             stm.setInt(3, (index - 1) * 10);
             ResultSet rs = stm.executeQuery();
         
            
             while (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setGender(rs.getBoolean("gender"));
                student.setDob(rs.getString("dob"));
                student.setAddress(rs.getString("Address"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID")); 
                cl.setClname(rs.getString("clname"));

                ClassSession cs = new ClassSession();
                cs.setClassID(cl);

                Parent parent = new Parent();
                parent.setPid(rs.getInt("pid"));
                student.setPid(parent);

                StudentClassSession stuClass = new StudentClassSession();
                stuClass.setCsid(cs);
                stuClass.setStuid(student);
                list.add(stuClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
 
 public List<StudentClassSession> getStudentClassSessionByName(String sname) {
        List<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = 
                    "SELECT S.stuid, S.sname, S.dob, S.gender, S.[Address], P.pid, C.clname "
                    + "FROM Student S "
                    + "Inner join Student_Class_Session scs ON S.stuid = scs.scid "
                    + "Inner join  Class_Session cs ON scs.scid = cs.csid "
                    + "Inner join Parent p ON s.stuid = p.pid "
                    + "Inner join class cl ON cs.csid = cl.classID "
                    + "Where S.sname LIKE ?;" ;
                    
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + sname + "%");
            ResultSet rs = stm.executeQuery();
            
             while (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setGender(rs.getBoolean("gender"));
                student.setDob(rs.getString("dob"));
                student.setAddress(rs.getString("Address"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID")); 
                cl.setClname(rs.getString("clname"));

                ClassSession cs = new ClassSession();
                cs.setClassID(cl);

                Parent parent = new Parent();
                parent.setPid(rs.getInt("pid"));
                student.setPid(parent);

                StudentClassSession stuClass = new StudentClassSession();
                stuClass.setCsid(cs);
                stuClass.setStuid(student);
                list.add(stuClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
 
     public List<StudentClassSession> getStudentClassSessionByID(String stuid) {
        List<StudentClassSession> list = new ArrayList<>();
        try {
            String sql = 
                    "SELECT S.stuid, S.sname, S.dob, S.gender, S.[Address], P.pid, C.clname "
                    + "FROM Student S "
                    + "Inner join Student_Class_Session scs ON S.stuid = scs.scid "
                    + "Inner join  Class_Session cs ON scs.scid = cs.csid "
                    + "Inner join Parent p ON s.stuid = p.pid "
                    + "Inner join class cl ON cs.csid = cl.classID "
                    + "Where S.stuid LIKE ?;" ;
                    
            PreparedStatement stm = connection.prepareStatement(sql);
              stm.setString(1, stuid);
            ResultSet rs = stm.executeQuery();
            
             while (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setGender(rs.getBoolean("gender"));
                student.setDob(rs.getString("dob"));
                student.setAddress(rs.getString("Address"));

                Class cl = new Class();
                cl.setClassid(rs.getInt("classID")); 
                cl.setClname(rs.getString("clname"));

                ClassSession cs = new ClassSession();
                cs.setClassID(cl);

                Parent parent = new Parent();
                parent.setPid(rs.getInt("pid"));
                student.setPid(parent);

                StudentClassSession stuClass = new StudentClassSession();
                stuClass.setCsid(cs);
                stuClass.setStuid(student);
                list.add(stuClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }


     }



     

     