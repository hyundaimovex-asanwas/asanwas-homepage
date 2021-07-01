package sales.menu.sy;

import java.sql.Timestamp;

import sales.org.application.common.CommonDTO;


public class Sy210DTO extends CommonDTO {
    private long           brd_no;
    private String         brd_gu;
    private String         brd_subject;
    private String         brd_creator;
    private Timestamp      brd_cdate;
    private String         brd_contents;
    private String         real_file;
    private String         sys_file;
    private long           brd_viewcnt;
    private String         brd_passwd;
    private long           ref;
    private long           ref_step;
    private long           ref_level;
    private String         delyn;

    public long      getBrd_no(){return this.brd_no;}
    public String    getBrd_gu(){return this.brd_gu;}
    public String    getBrd_subject(){return this.brd_subject;}
    public String    getBrd_creator(){return this.brd_creator;}
    public Timestamp getBrd_cdate(){return this.brd_cdate;}
    public String    getBrd_contents(){return this.brd_contents;}
    public String    getReal_file(){return this.real_file;}
    public String    getSys_file(){return this.sys_file;}
    public long      getBrd_viewcnt(){return this.brd_viewcnt;}
    public String    getBrd_passwd(){return this.brd_passwd;}
    public long      getRef(){return this.ref;}
    public long      getRef_step(){return this.ref_step;}
    public long      getRef_level(){return this.ref_level;}
    public String    getDelyn(){return this.delyn;}


    public void setBrd_no(long      in){this.brd_no=in;}
    public void setBrd_gu(String    in){this.brd_gu=in;}
    public void setBrd_subject(String    in){this.brd_subject=in;}
    public void setBrd_creater(String    in){this.brd_creator=in;}
    public void setBrd_cdate(Timestamp    in){this.brd_cdate=in;}
    public void setBrd_contents(String    in){this.brd_contents=in;}
    public void setReal_file(String in){this.real_file=in;}
    public void setSys_file(String    in){this.sys_file=in;}
    public void setBrd_viewcnt(long    in){this.brd_viewcnt=in;}
    public void setBrd_passwd(String    in){this.brd_passwd=in;}
    public void setRef(long in){this.ref=in;}
    public void setRef_step(long    in){this.ref_step=in;}
    public void setRef_level(long    in){this.ref_level=in;}
    public void setDelyn(String    in){this.delyn=in;}


    //유저정보
}
