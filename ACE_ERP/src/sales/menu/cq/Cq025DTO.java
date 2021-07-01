package sales.menu.cq;

import java.sql.Timestamp;

import sales.org.application.common.CommonDTO;


public class Cq025DTO extends CommonDTO {
	//전달해주는 값들 + 검색조건 
	//컬럼 값들.
    private String         cust_nm1;
    private String         birthday;
    private String         gender_nm;
    private String         comp_nm1;
    private String         tour_no;
    private String         sn_datetime;
    private String         ns_datetime;
    private String         address1;
    private String         north_purpose;
    private String			title_date;
    private String			title_class;
    private String			manage_no;
	private String			pic_addr;
    
    
    
    //검색조건.
	private String       sSaupSid	   ;	
	private String       sDepartDate   ;	
	private String       sDepartTime   ;	
	private String       sGoodsSid     ;	
	private String       sClass        ;	
	private String       sTeams        ;	
	private String       sPageNo       ;	
	private String       sCustGu       ;
    


    public String		getCust_nm1(){return this.cust_nm1;}
    public String		getBirthday(){return this.birthday;}
    public String		getGender_nm(){return this.gender_nm;}
    public String		getComp_nm1(){return this.comp_nm1;}
    public String		getTour_no(){return this.tour_no;}
    public String		getSn_datetime(){return this.sn_datetime;}
    public String		getNs_datetime(){return this.ns_datetime;}
    public String		getAddress1(){return this.address1;}
    public String		getNorth_purpose(){return this.north_purpose;}
    public String		getTitle_date(){return this.title_date;}
    public String		getTitle_class(){return this.title_class;}
    public String		getManage_no(){return this.manage_no;}
	public String		getPic_addr(){return this.pic_addr;}
    
   
	public String		getsSaupSid(){return this.sSaupSid	;}	
	public String		getsDepartDate(){return this.sDepartDate;}	
	public String		getsDepartTime(){return this.sDepartTime;}	
	public String		getsGoodsSid(){return this.sGoodsSid  ;}	
	public String		getsClass(){return this.sClass     ;}	
	public String		getsTeams(){return this.sTeams     ;}	
	public String		getsPageNo(){return this.sPageNo    ;}	
	public String		getsCustGu(){return this.sCustGu    ;}
    

	public void			setCust_nm1(String in){this.cust_nm1=in;}
    public void			setBirthday(String in){this.birthday=in;}
    public void			setGender_nm(String in){this.gender_nm=in;}
    public void			setComp_nm1(String in){this.comp_nm1=in;}
    public void			setTour_no(String in){this.tour_no=in;}
    public void			setSn_datetime(String in){this.sn_datetime=in;}
    public void			setNs_datetime(String in){this.ns_datetime=in;}
    public void			setAddress1(String in){this.address1=in;}
    public void			setNorth_purpose(String in){this.north_purpose=in;}
    public void			setTitle_date(String in){this.title_date=in;}
    public void			setTitle_class(String in){this.title_class=in;}
	public void			setManage_no(String in){this.manage_no=in;}
	public void			setPic_addr(String in){this.pic_addr=in;}
	
    
    public void			setsSaupSid	  (String in){this.sSaupSid	  =in;}	
    public void			setsDepartDate(String in){this.sDepartDate=in;}	
    public void			setsDepartTime(String in){this.sDepartTime=in;}	
    public void			setsGoodsSid  (String in){this.sGoodsSid  =in;}	
    public void			setsClass     (String in){this.sClass     =in;}	
    public void			setsTeams     (String in){this.sTeams     =in;}	
    public void			setsPageNo    (String in){this.sPageNo    =in;}	
    public void			setsCustGu    (String in){this.sCustGu    =in;}

}
