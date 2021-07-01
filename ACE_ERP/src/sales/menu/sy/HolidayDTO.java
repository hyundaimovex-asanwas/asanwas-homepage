/*******************************************************************************
 * 1.클래스   명 : NoticeDTO.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 백승철
 * 7.작 성 일 자 : 2005-02-09
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2006-02-09      ;
 * @author 백승철
 * @version 1.0 2006-02-09
 ******************************************************************************/

package sales.menu.sy;

import java.sql.Timestamp;

import sales.org.application.common.CommonDTO;


public class HolidayDTO extends CommonDTO{
    private String          caln_date;
    private String          yoil_cd;
    private String          yoil_nm;
    private String          holiday_nm;
    private String          u_empno;
    private Timestamp  u_date;
    private String          u_ip;

    public String    getCaln_date(){return this.caln_date;}
    public String    getYoil_cd(){return this.yoil_cd;}
    public String    getYoil_nm(){return this.yoil_nm;}
    public String    getHoliday_nm(){return this.holiday_nm;}
    public String    getU_empno(){return this.u_empno;}
    public Timestamp getU_date(){return this.u_date;}
    public String    getU_ip(){return this.u_ip;}

    public void setCaln_date(      String      in){this.caln_date=in;}
    public void setYoil_cd(        String    in){this.yoil_cd=in;}
    public void setYoil_nm(           String    in){this.yoil_nm=in;}
    public void setHoliday_nm(String    in){this.holiday_nm=in;}
    public void setU_empno(       String    in){this.u_empno=in;}
    public void setU_date(       Timestamp in){this.u_date=in;}
    public void setU_ip(         String    in){this.u_ip=in;}

    //유저정보
    private String reg_name;
    private String reg_buseo;
    private String reg_phone;

    public String getReg_name(){return this.reg_name;}
    public String getReg_buseo(){return this.reg_buseo;}
    public String getReg_phone(){return this.reg_phone;}

    public void setReg_name( String in){this.reg_name=in;}
    public void setReg_buseo(String in){this.reg_buseo= in;}
    public void setReg_phone(String in){this.reg_phone=in;}
}