/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author admin
 */
public class Lecturers_Class_Session {
    private int lclassID;
    private Lecturers lid;
    private ClassSession csid;

    public Lecturers_Class_Session() {
    }

    public Lecturers_Class_Session(int lclassID, Lecturers lid, ClassSession csid) {
        this.lclassID = lclassID;
        this.lid = lid;
        this.csid = csid;
    }

    public int getLclassID() {
        return lclassID;
    }

    public void setLclassID(int lclassID) {
        this.lclassID = lclassID;
    }

    public Lecturers getLid() {
        return lid;
    }

    public void setLid(Lecturers lid) {
        this.lid = lid;
    }

    public ClassSession getCsid() {
        return csid;
    }

    public void setCsid(ClassSession csid) {
        this.csid = csid;
    }
    
    
    
}
