/*
 * Created on 2006. 7. 13.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.reservation.bean;

/**
 * @author 이소연
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 * 
 * @history 
 * 	2008.07.16 금강산/개성관관 예약가능일자 조회에 관련된 BEAN 항목 추가
 */

import kr.co.imjk.util.Util;

public class Schedule_bean {
	
    // CONSTRUCT
    public Schedule_bean(){
        
    } 

	private int upjang_sid;
	private String upjang_cd;
	private String upjang_nm; 
	private int room_type_sid;
	private String room_type_cd;
	private String room_type_nm;
	private int one_day;
	private int tow_day;
	private int price1;
	private int price2;
	private int price3;
	private int price4;
	private int price5;
	private int price6;
	
	private String h_nm;
	private int h_val;
	private String r_nm;
	private int r_val;	
    private String ser_st_date;
    private String ser_ed_date;
	private int total;
	
	/************************************************************************************
	 * 2008.07.16 금강산/개성관관 예약가능일자 조회에 관련된 BEAN 항목 추가
	 */
	
	private String flag_ymd;									//달력을 표시하는 기준일자
	private String saup_sid;										//관광지
	private String goods_sid;										//관광상품
	private String caln_date;										//예약일자
	private String rsv_yn;											//예약가능여부
	private String weekend_yn;								//주말여부

	//GETTER FUNCTION
	public String getCaln_date() {
		return caln_date; 
	}
	public String getRsv_yn() {
		return rsv_yn;
	}
	public String getWeekend_yn() {
		return weekend_yn;
	}
	public String getGoods_sid() {
		return goods_sid;
	}
	public String getSaup_sid() {
		return saup_sid;
	}
	public String getFlag_ymd() {
		return flag_ymd;
	} 
	//GETTER FUNCTION END
	
	
	//SETTER FUNCTION
	public void setFlag_ymd(String flag_ymd) {
		this.flag_ymd = flag_ymd;
	}
	public void setSaup_sid(String saup_sid) {
		this.saup_sid = saup_sid;
	}
	public void setGoods_sid(String goods_sid) {
		this.goods_sid = goods_sid;
	}
	public void setCaln_date(String caln_date) {
		this.caln_date = caln_date;
	}
	public void setRsv_yn(String rsv_yn) {
		this.rsv_yn = rsv_yn;
	} 
	public void setWeekend_yn(String weekend_yn) {
		this.weekend_yn = weekend_yn;
	}
	//SETTER FUNCTION END

	/** 
	 *2008.07.16 금강산/개성관관 예약가능일자 조회에 관련된 BEAN 항목 추가 끝
	 ***********************************************************************************
	 */
     
    // STTER 
    public void setUpjang_sid(int upjang_sid) {
        this.upjang_sid = upjang_sid;
    }
    public void setUpjang_cd(String upjang_cd) {
        this.upjang_cd = upjang_cd;
    }  
    public void setUpjang_nm(String upjang_nm) {
        this.upjang_nm = upjang_nm; 
    }     
    public void setRoom_type_sid(int room_type_sid) {
        this.room_type_sid = room_type_sid;
    }
    public void setRoom_type_cd(String room_type_cd) {
        this.room_type_cd = room_type_cd;
    }    
    public void setRoom_type_nm(String room_type_nm) {
        this.room_type_nm = room_type_nm;
    }
    public void setOne_day(int one_day) {
        this.one_day = one_day;
    }
    public void setTow_day(int tow_day) {
        this.tow_day = tow_day;
    }     
    public void setH_nm(String h_nm) {
        this.h_nm = h_nm;
    }
    public void setH_val(int h_val) {
        this.h_val = h_val;
    }
    public void setR_nm(String r_nm) {
        this.r_nm = r_nm;
    } 
    public void setR_val(int r_val) {
        this.r_val = r_val;
    }    
    public void setSer_st_date(String ser_st_date) {
        this.ser_st_date = ser_st_date;
    }
    public void setSer_ed_date(String ser_ed_date) {
        this.ser_ed_date = ser_ed_date;
    }
    public void setTotal(int total) {
        this.total = total;
    }
    public void setPrice1(int price1) {
        this.price1 = price1;
    }
    public void setPrice2(int price2) {
        this.price2 = price2;
    }
    public void setPrice3(int price3) {
        this.price3 = price3;
    }
    public void setPrice4(int price4) {
        this.price4 = price4;
    }
    public void setPrice5(int price5) {
        this.price5 = price5;
    }
    public void setPrice6(int price6) {
        this.price6 = price6;
    }
    
    
    // GATTER
    public int getUpjang_sid(){
        return this.upjang_sid;
    }
    public String getUpjang_cd() {
        return Util.getString(this.upjang_cd, "");
    }   
    public String getUpjang_nm() { 
        return Util.getString(this.upjang_nm, "");
    }
    public int getRoom_type_sid(){
        return this.room_type_sid;
    }     
    public String getRoom_type_cd() {
        return Util.getString(this.room_type_cd, "");
    }    
    public String getRoom_type_nm() {
        return Util.getString(this.room_type_nm, "");
    }      
    public int getOne_day(){
        return this.one_day;
    }
    public int getTow_day(){
        return this.tow_day;
    }     
    public String getH_nm() {
        return Util.getString(this.h_nm, "");
    }
    public int getH_val(){
        return this.h_val;
    }
    public int getR_val(){
        return this.r_val;
    }    
    public String getR_nm() {
        return Util.getString(this.r_nm, "");
    }
    public String getSer_st_date() {
        return Util.getString(this.ser_st_date, "");
    }   
    public String getSer_ed_date() {
        return Util.getString(this.ser_ed_date, "");
    }   
    public int getTotal(){
        return this.total;
    }    
    public int getPrice1(){
        return this.price1;
    }    
    public int getPrice2(){
        return this.price2;
    }    
    public int getPrice3(){
        return this.price3;
    }    
    public int getPrice4(){
        return this.price4;
    }    
    public int getPrice5(){
        return this.price5;
    }     
    public int getPrice6(){
        return this.price6;
    }  
}
