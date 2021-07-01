package sales.menu.my;

import java.sql.Timestamp;

import sales.org.application.common.CommonDTO;


public class My710DTO extends CommonDTO {
    private long           brd_no;
    private String         brd_gu;
    private String         brd_subject; 
    private String         brd_creator;
	private String         brd_recipient;
	private String         brd_creator_name;
	private String         brd_recipient_name;
    private Timestamp      brd_cdate;
    private String         brd_cdate2;
    private String         brd_contents;
    private String         real_file;
    private String         sys_file;
    private long           brd_viewcnt;
    private String         brd_passwd;
    private long           ref;
    private long           ref_step;
    private long           ref_level;
    private String         yn_del_recipient;
	private String         yn_del_creator;
	private String         yn_del_keep;
	private String         yn_keep_recipient;
	private String         yn_keep_creator;
	private String         requestedPage;
	private String         pageSize;
	private String         whereSql;
	private String         search_key;
	private String         v_login_id;
	private String         v_login_name;


    public long      getBrd_no(){return this.brd_no;}
    public String    getBrd_gu(){return this.brd_gu;}
    public String    getBrd_subject(){return this.brd_subject;}
    public String    getBrd_creator(){return this.brd_creator;}
	public String    getBrd_recipient(){return this.brd_recipient;}
	public String    getBrd_creator_name(){return this.brd_creator_name;}
	public String    getBrd_recipient_name(){return this.brd_recipient_name;}
    public Timestamp getBrd_cdate(){return this.brd_cdate;}
    public String 	 getBrd_cdate2(){return this.brd_cdate2;}
    public String    getBrd_contents(){return this.brd_contents;}
    public String    getReal_file(){return this.real_file;}
    public String    getSys_file(){return this.sys_file;}
    public long      getBrd_viewcnt(){return this.brd_viewcnt;}
    public String    getBrd_passwd(){return this.brd_passwd;}
    public long      getRef(){return this.ref;}
    public long      getRef_step(){return this.ref_step;}
    public long      getRef_level(){return this.ref_level;}
    public String    getYn_Del_Recipient(){return this.yn_del_recipient;}
	public String    getYn_Del_Creator(){return this.yn_del_creator;}
	public String    getYn_Del_Keep(){return this.yn_del_keep;}
	public String    getYn_Keep_Recipient(){return this.yn_keep_recipient;}
	public String    getYn_Keep_Creator(){return this.yn_keep_creator;}
	public String    getRequestedPage(){return this.requestedPage;}
	public String    getPageSize(){return this.pageSize;}
	public String    getWhereSql(){return this.whereSql;}
	public String    getSearchKey(){return this.search_key;}
	public String    getVLoginId(){return this.v_login_id;}
	public String    getVLoginName(){return this.v_login_name;}

	
    public void setBrd_no(long      in){this.brd_no=in;}
    public void setBrd_gu(String    in){this.brd_gu=in;}
    public void setBrd_subject(String    in){this.brd_subject=in;}
    public void setBrd_creator(String    in){this.brd_creator=in;}
	public void setBrd_recipient(String    in){this.brd_recipient=in;}
	public void setBrd_creator_name(String    in){this.brd_creator_name=in;}
	public void setBrd_recipient_name(String    in){this.brd_recipient_name=in;}
    public void setBrd_cdate(Timestamp    in){this.brd_cdate=in;}
    public void setBrd_cdate2(String    in){this.brd_cdate2=in;}
    public void setBrd_contents(String    in){this.brd_contents=in;}
    public void setReal_file(String in){this.real_file=in;}
    public void setSys_file(String    in){this.sys_file=in;}
    public void setBrd_viewcnt(long    in){this.brd_viewcnt=in;}
    public void setBrd_passwd(String    in){this.brd_passwd=in;}
    public void setRef(long in){this.ref=in;}
    public void setRef_step(long    in){this.ref_step=in;}
    public void setRef_level(long    in){this.ref_level=in;}
    public void setYn_Del_Recipient(String    in){this.yn_del_recipient=in;}
	public void setYn_Del_Creator(String    in){this.yn_del_creator=in;}
	public void setYn_Del_Keep(String    in){this.yn_del_keep=in;}
	public void setYn_Keep_Recipient(String    in){this.yn_keep_recipient=in;}
	public void setYn_Keep_Creator(String    in){this.yn_keep_creator=in;}
	public void setRequestedPage(String in){this.requestedPage=in;}
	public void setPageSize(String in){this.pageSize=in;}
	public void setWhereSql(String in){this.whereSql=in;}
	public void setSearchKey(String in){this.search_key=in;}
	public void setVLoginId(String in){this.v_login_id=in;}
	public void setVLoginName(String in){this.v_login_name=in;}

    //유저정보
}
