/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Entity;

import java.sql.Date;

/**
 *
 * @author admin
 */
public class SchoolYear {
    private int yid;
    private String dateStart;
    private String dateEnd;

    public SchoolYear() {
    }

    public SchoolYear(int yid, String dateStart, String dateEnd) {
        this.yid = yid;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
    }

    public int getYid() {
        return yid;
    }

    public void setYid(int yid) {
        this.yid = yid;
    }

    public String getDateStart() {
        return dateStart;
    }

    public void setDateStart(String dateStart) {
        this.dateStart = dateStart;
    }

    public String getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(String dateEnd) {
        this.dateEnd = dateEnd;
    }

    @Override
    public String toString() {
        return "SchoolYear{" + "yid=" + yid + ", dateStart=" + dateStart + ", dateEnd=" + dateEnd + '}';
    }

  
    
    
    
}
