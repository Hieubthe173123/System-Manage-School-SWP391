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
import java.beans.Statement;
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

    public StudentClassSession getStudentById(int id) {
    List<StudentClassSession> list = new ArrayList<>();
    try {
        String sql = "SELECT S.stuid, S.sname, S.dob, S.gender, S.Address, P.pname, CL.clname "
                   + "FROM Student S "
                   + "INNER JOIN Parent P ON S.pid = P.pid "
                   + "INNER JOIN Student_Class_Session SCS ON S.stuid = SCS.stuid "
                   + "INNER JOIN Class_Session CS ON SCS.csid = CS.csid "
                   + "INNER JOIN Class CL ON CS.classID = CL.classID "
                   + "WHERE S.stuid = ?";
        
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setInt(1, id);
        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            Student student = new Student();
            student.setStuid(rs.getInt("stuid"));
            student.setSname(rs.getString("sname"));
            student.setDob(rs.getString("dob"));
            student.setGender(rs.getBoolean("gender"));
            student.setAddress(rs.getString("Address"));

            Parent parent = new Parent();
            parent.setPid(rs.getInt("pid"));
            parent.setPname(rs.getString("pname"));
            student.setPid(parent);

            Class cl = new Class();
            cl.setClassid(rs.getInt("classID"));
            cl.setClname(rs.getString("clname"));
            
            ClassSession cs = new ClassSession();
            cs.setClassID(cl);
           StudentClassSession stuClass = new StudentClassSession();
                stuClass.setCsid(cs);
                stuClass.setStuid(student);
                list.add(stuClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RoomDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    
     public List<StudentClassSession> getStudentByName(String sname) {
    List<StudentClassSession> list = new ArrayList<>();
   
    try {
        String sql = "SELECT S.stuid, S.sname, S.dob, S.gender, S.Address, P.pname,CL.clname "
                   + "FROM Student S "
                   + "INNER JOIN Parent P ON S.pid = P.pid "
                   + "INNER JOIN Student_Class_Session SCS ON S.stuid = SCS.stuid "
                   + "INNER JOIN Class_Session CS ON SCS.csid = CS.csid "
                   + "INNER JOIN Class CL ON CS.classID = CL.classID "
                   + "WHERE S.sname LIKE ?";
        
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, "%" + sname + "%");
        ResultSet rs = stm.executeQuery();

        if (rs.next()) {
            Student student = new Student();
            student.setStuid(rs.getInt("stuid"));
            student.setSname(rs.getString("sname"));
            student.setDob(rs.getString("dob"));
            student.setGender(rs.getBoolean("gender"));
            student.setAddress(rs.getString("Address"));

            Parent parent = new Parent();
            parent.setPid(rs.getInt("pid"));
            parent.setPname(rs.getString("pname"));
            student.setPid(parent);

            Class cl = new Class();
            cl.setClassid(rs.getInt("classID"));
            cl.setClname(rs.getString("clname"));
            
            ClassSession cs = new ClassSession();
            cs.setClassID(cl);
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


   //Get list of students from last year and paging
    public List<StudentClassSession> getStudentClassSessionByLatestSchoolYearWithPaging(int index) {
        List<StudentClassSession> list = new ArrayList<>();
        try {
            String sql
            = "SELECT S.stuid, S.sname, S.dob, S.gender, S.[Address], p.pid, p.pname, cl.classID, cl.clname "
            + "FROM Student S "
            + "INNER JOIN Student_Class_Session scs ON S.stuid = scs.stuid "
            + "INNER JOIN Class_Session cs ON scs.csid = cs.csid "
            + "INNER JOIN Parent p ON S.pid = p.pid "
            + "INNER JOIN Class cl ON cs.classID = cl.classID "
            + "INNER JOIN SchoolYear sy ON cs.yid = sy.yid "
            + "WHERE sy.dateEnd = (SELECT MAX(dateEnd) FROM SchoolYear) " // Lấy năm học cuối cùng
            + "ORDER BY S.stuid OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, (index - 1) * 10);
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
                 parent.setPname(rs.getString("pname"));
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
    
    
    //Get list of students by class ID of the most recent school year and paginate
    public List<StudentClassSession> getStudentsByClassIdWithPaging(String classId, int index) {
        List<StudentClassSession> list = new ArrayList<>();
        try {
            String sql
                    = "SELECT S.stuid, S.sname, S.dob, S.gender, S.[Address], p.pid, p.pname, cl.classID, cl.clname "
                    + "FROM Student S "
                    + "INNER JOIN Student_Class_Session scs ON S.stuid = scs.stuid "
                    + "INNER JOIN Class_Session cs ON scs.csid = cs.csid "
                    + "INNER JOIN Parent p ON S.pid = p.pid "
                    + "INNER JOIN class cl ON cs.classID = cl.classID "
                    + "INNER JOIN SchoolYear sy ON cs.yid = sy.yid "
                    + "WHERE sy.dateEnd = (SELECT MAX(dateEnd) FROM SchoolYear) "
                    + "AND cl.classID = ? "
                    + "ORDER BY S.stuid OFFSET ? ROWS FETCH NEXT 10 ROWS ONLY";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, classId);
            stm.setInt(2, (index - 1) * 10);
            ResultSet rs = stm.executeQuery();
            
            while (rs.next()) {
                Student student = new Student();
                student.setStuid(rs.getInt("stuid"));
                student.setSname(rs.getString("sname"));
                student.setGender(rs.getBoolean("gender"));
                student.setDob(rs.getString("dob"));
                student.setAddress(rs.getString("Address"));

                Class classObj = new Class();
                classObj.setClassid(rs.getInt("classID"));
                classObj.setClname(rs.getString("clname"));

                ClassSession cs = new ClassSession();
                cs.setClassID(classObj);

                Parent parent = new Parent();
                parent.setPid(rs.getInt("pid"));
                parent.setPname(rs.getString("pname"));
                student.setPid(parent);

                StudentClassSession stuClass = new StudentClassSession();
                stuClass.setCsid(cs);
                stuClass.setStuid(student);
                list.add(stuClass);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
     
    //Get the total number of students in the most recent school year 
   public int getTotalStudentByLatestSchoolYear() {
    String sql = "SELECT COUNT(*) as total FROM Student S "
            + "INNER JOIN Student_Class_Session scs ON S.stuid = scs.stuid "
            + "INNER JOIN Class_Session cs ON scs.csid = cs.csid "
            + "INNER JOIN SchoolYear sy ON cs.yid = sy.yid "
            + "WHERE sy.dateEnd = (SELECT MAX(dateEnd) FROM SchoolYear)";
    try {
        PreparedStatement stm = connection.prepareStatement(sql);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            return rs.getInt("total");
        }
    } catch (SQLException ex) {
        Logger.getLogger(StudentClassSessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
    }
    return 0;
}

    //get total number of students by class ID
    public int getTotalStudentsByClassId(String classId) {
        int totalStudents = 0;
        try {
            String sql = "SELECT COUNT(DISTINCT scs.stuid) AS Total_Student "
                    + "FROM Student_Class_Session scs "
                    + "INNER JOIN Class_Session cs ON scs.csid = cs.csid "
                    + "INNER JOIN SchoolYear sy ON cs.yid = sy.yid "
                    + "WHERE sy.dateEnd = (SELECT MAX(dateEnd) FROM SchoolYear) "
                    + "AND cs.classID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, classId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                totalStudents = rs.getInt("Total_Student");
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return totalStudents;
    }

    //Get total number of students from database
    public int getTotalStudent() {
        try {
            String sql = "select count (*) from Student";

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

    public void addStudent(String sname, String dob, String gender, String address, String classID) {
        String sql = "INSERT INTO Student (sname, dob, gender, [Address]) "
                + "VALUES (?, ?, ?, ?); "
                + "INSERT INTO Student_Class_Session (stuid, csid) "
                + "VALUES ( "
                + "    (SELECT MAX(stuid) FROM Student), "
                + "    (SELECT csid FROM Class_Session WHERE classID = ? AND yid = (SELECT MAX(yid) FROM Class_Session)) "
                + ")";
        try {
            connection.setAutoCommit(false);
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, sname);
            stm.setString(2, dob);
            stm.setString(3, gender);
            stm.setString(4, address);
            stm.setString(5, classID);

            stm.executeUpdate();

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException e) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, e);
            }
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException ex) {
                Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    
  public void addParent(String pname, String gender, String dob, String phoneNumber, String IDcard, String Address, String Email, String NickName, String stuName, String stuDob, String stuGender,String stuAddress,String classId) {
    String sql = "INSERT INTO Parent (pname, gender, dob, phoneNumber, IDcard, [Address], Email, NickName) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    try {
        connection.setAutoCommit(false);
        PreparedStatement stm = connection.prepareStatement(sql);
        stm.setString(1, pname);
        stm.setString(2, gender);
        stm.setString(3, dob);
        stm.setString(4, phoneNumber);
        stm.setString(5, IDcard);
        stm.setString(6, Address);
        stm.setString(7, Email);
        stm.setString(8, NickName);

        stm.executeUpdate();
        
        // Lấy pid của phụ huynh vừa thêm vào
        ResultSet generatedKeys = stm.getGeneratedKeys();
        int pid = -1;
        if (generatedKeys.next()) {
            pid = generatedKeys.getInt(1);
        }

        connection.commit(); 
        addStudent(stuName, stuDob, stuGender, stuAddress,  classId);
    } catch (SQLException ex) {
        try {
            connection.rollback(); 
        } catch (SQLException e) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, e);
        }
        Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
    } finally {
        try {
            connection.setAutoCommit(true); 
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
  }
    
     public int countStudentInClass(String classID) {
        int totalStudent = 0;
        try {
            String sql = "SELECT COUNT(DISTINCT scs.stuid) AS Total_Student "
                    + "FROM Student_Class_Session scs "
                    + "INNER JOIN Class_Session cs ON scs.csid = cs.csid "
                    + "INNER JOIN SchoolYear sy ON cs.yid = sy.yid "
                    + "WHERE sy.dateEnd = (SELECT MAX(dateEnd) FROM SchoolYear) "
                    + "AND cs.classID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, classID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                totalStudent = rs.getInt("Total_Student");
            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentClassSessionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return totalStudent;
    }


      
}