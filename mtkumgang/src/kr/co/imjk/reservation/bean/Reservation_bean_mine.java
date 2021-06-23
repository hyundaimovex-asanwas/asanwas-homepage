/**
 * By beans generator source file 
 * source file name : agent_bean
 * 
 * ### BeanMaker 1.0 ###
 * @author : syLee
 * @date : 2006-06-08
 * @mail : arisu@imjk.co.kr
 * 
 */ 

package kr.co.imjk.reservation.bean;

import kr.co.imjk.util.Util;

public class Reservation_bean_mine{
    //walib.wa_rsvinfo 
	private int idx; //신청번호
	private String idx_m;  //신청번호 조작
    private String rname;  //성명
    private String rpass;  //비밀번호
    private String rtel;   //연락처(유선)
    private String rmob;   //연락처(무선)
    private String rmail;  //이메일
    private String rstdt;  //출발일
    private String redt;   //도착일
    private String rstat;  //예약상태 (1: 정상, 2: 취소)
    private String daynight; //숙박일수
    private String regdate; //신청일자 (시각제외)
    private String regtime; //신청시각 (시각포함)
    private int cnt;
    private int tot_tour_amt;  //총관광금액
    private int tot_pay_amt;  //총입금금액
    private int accept_sid;   //신청SID
    private String depart_date; //출경일자
    private String arrive_date; //입경일자
    private String nights; //박수
    private String final_time; //결제마감일
    private String final_type; //결제마감일시여부
    private int cust_sid ;  //고객 SID
    private String group_cd; //신청서번호
    private int rsv_sid ;  //예약 SID
    private String rsv_sid_multi ;  //예약 SID (다중결제일경우)
    
    private String cust_nm; //고객 성명
    private String regi_no; //고객 주민번호
    private String regi_yn;
    private int upjang_sid; //영업장 SID
    private int room_type_sid; //객실타입
    private String tstdt; //개인정보기입여부 (1: 기입, 2: 미기입)
    private String goods_cd; //상품코드
    private String goods_nm; //상품
    private String rscod; //상품코드 (상품 SID)
    private String pay_cd;
    private String multi_yn; //단일결제 : n
    private String age_cd; //연령코드 (성인/대학생 : 01, 중고생 : 03, 초등생 : 04, 소아 : 05, 유아 : 06)
    private String join_cd; //연령코드 (본인 : 01, 지인 : 02)
    
    
    // 관광객 상세 정보 보기
    private String manage_no;
    private String tel_no;
    private String mobile_no;
    private String zip_cd;
	private int    zip_sid;
    private String address1;
    private String address2;
    private String company_nm;
    private String positions;
    
    //Othes's
    private String upjang_info; 
    private String hotel_nm;
    private String room_nm;
    private String cust_ip;
    
    //결제관련
	private int ol_card_sid = 0;
	private String pay_manage_no;
	private int pay_amt = 0;
	private String pay_amt_multi; //(다중결제일경우: 각 결제금액 받는 값..)
	private String order_nm = "";
	private String order_e_mail = "";
	private String order_tel_no = "";
	private String buyr_tel2 = "";
    private String resp_code = "";
    private String res_msg = "";
    private String van_idx_no = "";
    private String card_cd = "";
    private String card_name = "";
    private String app_time = "";
    private String app_no = "";
    private String quota = "";
    private String success = "";
    private String user_key = ""; 
    private String status_cd = "";  //결제취소여부 ( RR: 취소신청, RC:취소완료)
    private int sum_price = 0;
    private String accept_no = "";
    private String pay_yn = "";
    
    // CONSTRUCT
    public Reservation_bean_mine(){
        
    } 

    // STTER
    public void setIdx(int idx) {
        this.idx = idx;
    }
    public void setIdx_m(String idx_m) {
        this.idx_m = idx_m;
    }     
    public void setRname(String rname) {
        this.rname = rname;
    }
    public void setRpass(String rpass) {
        this.rpass = rpass;
    }
    public void setRtel(String rtel) {
        this.rtel = rtel;
    }
    public void setRmob(String rmob) {
        this.rmob = rmob;
    }
    public void setRmail(String rmail) {
        this.rmail = rmail;
    }
    public void setRstdt(String rstdt) {
        this.rstdt = rstdt;
    }
    public void setRedt(String redt) {
        this.redt = redt;
    }
    public void setRstat(String rstat) {
        this.rstat = rstat;
    }
    public void setDaynight(String daynight) {
        this.daynight = daynight;
    }
    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }
    public void setRegtime(String regtime) {
        this.regtime = regtime;
    }
    public void setCnt(int cnt) {
        this.cnt = cnt;
    }
    public void setTot_tour_amt(int tot_tour_amt) {
        this.tot_tour_amt = tot_tour_amt;
    }
    public void setTot_pay_amt(int tot_pay_amt) {
        this.tot_pay_amt = tot_pay_amt;
    }
    public void setAccept_sid(int accept_sid) {
        this.accept_sid = accept_sid;
    }
    public void setDepart_date(String depart_date) {
        this.depart_date = depart_date;
    }
    public void setArrive_date(String arrive_date) {
        this.arrive_date = arrive_date;
    }
    public void setNights(String nights) {
        this.nights = nights;
    }    
    public void setFinal_type(String final_type) {
        this.final_type = final_type;
    }     
    public void setFinal_time(String final_time) {
        this.final_time = final_time;
    }
    public void setUpjang_info(String upjang_info) {
        this.upjang_info = upjang_info;
    }    
    public void setHotel_nm(String hotel_nm) {
        this.hotel_nm = hotel_nm;
    } 
    public void setRoom_nm(String room_nm) {
        this.room_nm = room_nm;
    }  
    public void setCust_ip(String cust_ip) {
        this.cust_ip = cust_ip;
    }    
    public void setCust_sid(int cust_sid) {
        this.cust_sid = cust_sid;
    }
    public void setGroup_cd(String group_cd) {
        this.group_cd = group_cd;
    }    
    public void setRsv_sid(int rsv_sid) {
        this.rsv_sid = rsv_sid;
    }
    public void setRsv_sid_multi(String rsv_sid_multi) {
        this.rsv_sid_multi = rsv_sid_multi;
    }    
    public void setRsv_sid(String rsv_sid_multi) {
        this.rsv_sid_multi = rsv_sid_multi;
    }    
    public void setCust_nm(String cust_nm) {
        this.cust_nm = cust_nm;
    }     
    public void setRegi_no(String regi_no) {
        this.regi_no = regi_no;
    }
    public void setRegi_yn(String regi_yn) {
        this.regi_yn = regi_yn;
    }
    public void setUpjang_sid(int upjang_sid) {
        this.upjang_sid = upjang_sid;
    } 
    public void setRoom_type_sid(int room_type_sid) {
        this.room_type_sid = room_type_sid;
    }    
    public void setTstdt(String tstdt) {
        this.tstdt = tstdt;
    }   

    public void setManage_no(String manage_no) {
        this.manage_no = manage_no;
    } 
    public void setTel_no(String tel_no) {
        this.tel_no = tel_no;
    } 
    public void setMobile_no(String mobile_no) {
        this.mobile_no = mobile_no;
    } 
    public void setZip_cd(String zip_cd) {
        this.zip_cd = zip_cd;
    } 
	public void setZip_sid(int zip_sid) {
			this.zip_sid = zip_sid;
		} 
    
    public void setAddress1(String address1) {
        this.address1 = address1;
    } 
    public void setAddress2(String address2) {
        this.address2 = address2;
    } 
    public void setCompany_nm(String company_nm) {
        this.company_nm = company_nm;
    }  
    public void setPositions(String positions) {
        this.positions = positions;
    }
    public void setGoods_cd(String goods_cd) {
        this.goods_cd = goods_cd;
    }    
    public void setGoods_nm(String goods_nm) {
        this.goods_nm = goods_nm;
    }
    public void setRscod(String rscod) {
        this.rscod = rscod;
    } 
    public void setPay_cd(String pay_cd) {
        this.pay_cd = pay_cd;
    }    
    public void setOl_card_sid(int ol_card_sid) {
        this.ol_card_sid = ol_card_sid;
    } 
    public void setPay_manage_no(String pay_manage_no) {
        this.pay_manage_no = pay_manage_no;
    }  
    public void setPay_amt(int pay_amt) {
        this.pay_amt = pay_amt;
    }
    public void setPay_amt_multi(String pay_amt_multi) {
        this.pay_amt_multi = pay_amt_multi;
    }    
    public void setOrder_nm(String order_nm) {
        this.order_nm = order_nm;
    } 
    public void setOrder_e_mail(String order_e_mail) {
        this.order_e_mail = order_e_mail;
    }    
    public void setOrder_tel_no(String order_tel_no) {
        this.order_tel_no = order_tel_no;
    }    
    public void setBuyr_tel2(String buyr_tel2) {
        this.buyr_tel2 = buyr_tel2;
    }        
    public void setResp_code(String resp_code) {
        this.resp_code = resp_code;
    }
    public void setRes_msg(String res_msg) {
        this.res_msg = res_msg;
    }    
    public void setVan_idx_no(String van_idx_no) {
        this.van_idx_no = van_idx_no;
    }    
    public void setCard_cd(String card_cd) {
        this.card_cd = card_cd;
    }    
    public void setCard_name(String card_name) {
        this.card_name = card_name;
    } 
    public void setApp_time(String app_time) {
        this.app_time = app_time;
    }
    public void setApp_no(String app_no) {
        this.app_no = app_no;
    }    
    public void setQuota(String quota) {
        this.quota = quota;
    }    
    public void setSuccess(String success) {
        this.success = success;
    }    
    public void setUser_key(String user_key) {
        this.user_key = user_key;
    }
    public void setStatus_cd(String status_cd) {
        this.status_cd = status_cd;
    }    
    public void setMulti_yn(String multi_yn) {
        this.multi_yn = multi_yn;
    }    
    public void setAge_cd(String age_cd) {
        this.age_cd = age_cd;
    }   
    public void setJoin_cd(String join_cd) {
        this.join_cd = join_cd;
    }   
    public void setSum_price(int sum_price) {
        this.sum_price = sum_price;
    }
    public void setAccept_no(String accept_no) {
        this.accept_no = accept_no;
    }      
    public void setPay_yn(String pay_yn) {
        this.pay_yn = pay_yn;
    }    
    
    // GATTER
    public int getIdx(){
        return idx;
    }   
    public String getIdx_m() {
        return Util.getString(this.idx_m, "");
    }    
    public String getRname() {
        return Util.getString(this.rname, "");
    }
    public String getRpass() {
        return Util.getString(this.rpass, "");
    }
    public String getRtel() {
        return Util.getString(this.rtel, "");
    }
    public String getRmob() {
        return Util.getString(this.rmob, "");
    }
    public String getRmail() {
        return Util.getString(this.rmail, "");
    }
    public String getRstdt() {
        return Util.getString(this.rstdt, "");
    }
    public String getRedt() {
        return Util.getString(this.redt, "");
    }
    public String getRstat() {
        return Util.getString(this.rstat, "");
    }
    public String getDaynight() {
        return Util.getString(this.daynight, "");
    }
    public String getRegdate() {
        return Util.getString(this.regdate, "");
    }
    public String getRegtime() {
        return Util.getString(this.regtime, "");
    }    
    public int getCnt(){
        return cnt;
    } 
    public int getTot_tour_amt(){
        return tot_tour_amt;
    } 
    public int getTot_pay_amt(){
        return tot_pay_amt;
    }
    public int getAccept_sid(){
        return accept_sid;
    } 
    public String getDepart_date() {
        return Util.getString(this.depart_date, "");
    } 
    public String getArrive_date() {
        return Util.getString(this.arrive_date, "");
    } 
    public String getNights() {
        return Util.getString(this.nights, "");
    }
    public String getFinal_type() {
        return Util.getString(this.final_type, "");
    }
    public String getFinal_time() {
        return Util.getString(this.final_time, "");
    }
    public String getUpjang_info() {
        return Util.getString(this.upjang_info, "");
    }
    public String getHotel_nm() {
        return Util.getString(this.hotel_nm, "");
    }
    public String getRoom_nm() {
        return Util.getString(this.room_nm, "");
    }
    public String getCust_ip() {
        return Util.getString(this.cust_ip, "");
    }     
    public int getCust_sid(){
        return cust_sid;
    }
    public String getGroup_cd(){
        return group_cd;
    }    
    public int getRsv_sid(){ 
        return rsv_sid;
    }    
    public String getRsv_sid_multi(){
        return rsv_sid_multi;
    }    
    public String getCust_nm() {
        return Util.getString(this.cust_nm, "");
    }
    public String getRegi_no() {
        return Util.getString(this.regi_no, "");
    } 
    public String getRegi_yn() {
        return Util.getString(this.regi_yn, "");
    }
    public int getUpjang_sid(){
        return upjang_sid;
    }    
    public int getRoom_type_sid(){
        return room_type_sid;
    }   
    public String getTstdt() {
        return Util.getString(this.tstdt, "");
    }
    public String getManage_no() {
        return Util.getString(this.manage_no, "");
    }
    public String getTel_no() {
        return Util.getString(this.tel_no, "");
    }
    public String getMobile_no() {
        return Util.getString(this.mobile_no, "");
    }
    public String getZip_cd() {
        return Util.getString(this.zip_cd, "");
    }
	public int getZip_sid() {
		return zip_sid;
	}
    public String getAddress1() {
        return Util.getString(this.address1, "");
    }
    public String getAddress2() {
        return Util.getString(this.address2, "");
    }
    public String getCompany_nm() {
        return Util.getString(this.company_nm, "");
    }
    public String getPositions() {
        return Util.getString(this.positions, "");
    }
    public String getGoods_cd() {
        return Util.getString(this.goods_cd, "");
    }
    public String getGoods_nm() {
        return Util.getString(this.goods_nm, "");
    }
    public String getRscod() {
        return Util.getString(this.rscod, "");
    } 
    public String getPay_cd() {
        return Util.getString(this.pay_cd, "");
    }     
    public int getOl_card_sid(){
        return ol_card_sid;
    } 
    public String getPay_manage_no(){
    	return Util.getString(this.pay_manage_no, "");
    } 
    public int getPay_amt(){
        return pay_amt;
    }
    public String getPay_amt_multi() {
        return Util.getString(this.pay_amt_multi, "");
    }    
    public String getOrder_nm() {
        return Util.getString(this.order_nm, "");
    }
    public String getOrder_tel_no() {
        return Util.getString(this.order_tel_no, "");
    }    
    public String getOrder_e_mail() {
        return Util.getString(this.order_e_mail, "");
    }
    public String getBuyr_tel2() {
        return Util.getString(this.buyr_tel2, "");
    }
    public String getResp_code() {
        return Util.getString(this.resp_code, "");
    }    
    public String getRes_msg() {
        return Util.getString(this.res_msg, "");
    } 
    public String getVan_idx_no() {
        return Util.getString(this.van_idx_no, "");
    }
    public String getCard_cd() {
        return Util.getString(this.card_cd, "");
    }    
    public String getCard_name() {
        return Util.getString(this.card_name, "");
    }
    public String getApp_time() {
        return Util.getString(this.app_time, "");
    } 
    public String getQuota() {
        return Util.getString(this.quota, "");
    }    
    public String getApp_no() {
        return Util.getString(this.app_no, "");
    }    
    public String getSuccess() {
        return Util.getString(this.success, "");
    }
    public String getUser_key() {
        return Util.getString(this.user_key, "");
    } 
    public String getStatus_cd() {
        return Util.getString(this.status_cd, "");
    }
    public String getMulti_yn() {
        return Util.getString(this.multi_yn, "");
    }  
    public String getAge_cd() {
        return Util.getString(this.age_cd, "");
    }
    public String getJoin_cd() {
        return Util.getString(this.join_cd, "");
    }
    public int getSum_price(){
        return sum_price;
    }
    public String getAccept_no() {
        return Util.getString(this.accept_no, "");
    } 
    public String getPay_yn() {
        return Util.getString(this.pay_yn, "");
    }     
}
