/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

/**
 *
 * @author admin
 */
public class ActivityTime {
    private int atid;
    private String timeStart;
    private String timeEnd;

    public ActivityTime() {
    }

    public ActivityTime(int atid, String timeStart, String timeEnd) {
        this.atid = atid;
        this.timeStart = timeStart;
        this.timeEnd = timeEnd;
    }

    public int getAtid() {
        return atid;
    }

    public void setAtid(int atid) {
        this.atid = atid;
    }

    public String getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(String timeStart) {
        this.timeStart = timeStart;
    }

    public String getTimeEnd() {
        return timeEnd;
    }

    public void setTimeEnd(String timeEnd) {
        this.timeEnd = timeEnd;
    }

    @Override
    public String toString() {
        return "ActivityTime{" + "atid=" + atid + ", timeStart=" + timeStart + ", timeEnd=" + timeEnd + '}';
    }
    
}
