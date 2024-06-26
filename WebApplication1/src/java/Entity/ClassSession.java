/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author admin
 */
public class ClassSession {

    private int csid;
    private Class classID;
    private SchoolYear yid;
    private Session sid;
    private Room rid;

    public ClassSession() {
    }

    public ClassSession(int csid, Class classID, SchoolYear yid, Session sid, Room rid) {
        this.csid = csid;
        this.classID = classID;
        this.yid = yid;
        this.sid = sid;
        this.rid = rid;
    }

    public int getCsid() {
        return csid;
    }

    public void setCsid(int csid) {
        this.csid = csid;
    }

    public Class getClassID() {
        return classID;
    }

    public void setClassID(Class classID) {
        this.classID = classID;
    }

    public SchoolYear getYid() {
        return yid;
    }

    public void setYid(SchoolYear yid) {
        this.yid = yid;
    }

    public Session getSid() {
        return sid;
    }

    public void setSid(Session sid) {
        this.sid = sid;
    }

    public void setRid(Room rid) {
        this.rid = rid;
    }

    public Room getRid() {
        return rid;
    }

    @Override
    public String toString() {
        return "ClassSession{" + "csid=" + csid + ", classID=" + classID + ", yid=" + yid + ", sid=" + sid + ", rid=" + rid + '}';
    }

}
