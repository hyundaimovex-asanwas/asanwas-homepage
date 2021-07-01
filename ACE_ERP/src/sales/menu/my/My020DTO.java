package sales.menu.my;


import java.sql.Timestamp;

import sales.org.application.common.CommonDTO;

public class My020DTO  extends CommonDTO {
    private long           brd_no;
    private String         brd_subject;
    private String         brd_contents;
    private String         real_file;
    private String         sys_file;
    private String         out_login_id;
    private String         send_login_id;
    private Timestamp      send_date;
    private String         send_ip;
    private String         out_yn; 

    public long      getBrd_no(){return this.brd_no;}
    public String    getBrd_subject(){return this.brd_subject;}
    public String    getBrd_contents(){return this.brd_contents;}
    public String    getReal_file(){return this.real_file;}
    public String    getSys_file(){return this.sys_file;}
    public String    getOut_login_id(){return this.out_login_id;}
    public String    getSend_login_id(){return this.send_login_id;}
    public Timestamp getSend_date(){return this.send_date;}
    public String    getSend_ip(){return this.send_ip;}
    public String    getOut_yn(){return this.out_yn;}


    public void setBrd_no(long in){this.brd_no=in;}
    public void setBrd_subject(String in){this.brd_subject=in;}
    public void setBrd_contents(String in){this.brd_contents=in;}
    public void setReal_file(String in){this.real_file=in;}
    public void setSys_file(String in){this.sys_file=in;}
    public void setOut_login_id(String in){this.out_login_id=in;}
    public void setSend_login_id(String in){this.send_login_id=in;}
    public void setSend_date(Timestamp in){this.send_date=in;}
    public void setSend_ip(String in){this.send_ip=in;}
    public void setOut_yn(String in){this.out_yn=in;}

    //유저정보
}