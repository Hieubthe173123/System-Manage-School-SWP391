/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author admin
 */
public class Curiculum {
    private int curID;
    private ActivityTime atid;
    private String nameAct;
    private SessionDetails sdid;
    private boolean isFix;

    public Curiculum() {
    }

    public Curiculum(int curID, ActivityTime atid, String nameAct, SessionDetails sdid, boolean isFix) {
        this.curID = curID;
        this.atid = atid;
        this.nameAct = nameAct;
        this.sdid = sdid;
        this.isFix = isFix;
    }

    public int getCurID() {
        return curID;
    }

    public void setCurID(int curID) {
        this.curID = curID;
    }

    public ActivityTime getAtid() {
        return atid;
    }

    public void setAtid(ActivityTime atid) {
        this.atid = atid;
    }

    public String getNameAct() {
        return nameAct;
    }

    public void setNameAct(String nameAct) {
        this.nameAct = nameAct;
    }

    public SessionDetails getSdid() {
        return sdid;
    }

    public void setSdid(SessionDetails sdid) {
        this.sdid = sdid;
    }

    public boolean isIsFix() {
        return isFix;
    }

    public void setIsFix(boolean isFix) {
        this.isFix = isFix;
    }
    
    
}
