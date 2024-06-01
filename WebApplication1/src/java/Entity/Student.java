/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author admin
 */
public class Student {
     private int stuid;
    private String sname;
    private boolean gender;
    private String dob;
    private String address;
    private Parent pid;

    public Student() {
    }

    public Student(int stuid, String sname, boolean gender, String dob, String address, Parent pid) {
        this.stuid = stuid;
        this.sname = sname;
        this.gender = gender;
        this.dob = dob;
        this.address = address;
        this.pid = pid;
    }

    public int getStuid() {
        return stuid;
    }

    public void setStuid(int stuid) {
        this.stuid = stuid;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }



    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Parent getPid() {
        return pid;
    }

    public void setPid(Parent pid) {
        this.pid = pid;
    }
    
    
}
