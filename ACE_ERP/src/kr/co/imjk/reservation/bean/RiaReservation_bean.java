/*
 * Created on 2006. 7. 13.
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package kr.co.imjk.reservation.bean;

/**
 * @author ¿Ãº“ø¨
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */

import kr.co.imjk.util.Util;

public class RiaReservation_bean {

	private String curr_date;
	private String next_date;
	private String standard_date;
	private int upjang_sid;
	private String upjang_cd;
	private String upjang_nm;
	private int room_type_sid;
	private String room_type_cd;
	private String room_type_nm;
	private int one_day;
	private int two_day;
	private int price1;
	private int price2;
	private int price3;
	private int price4;
	private int price5;
	private int price6;
	
	private int price1_1;
	private int price2_1;
	private int price3_1;
	private int price4_1;
	private int price5_1;
	private int price6_1;	
	
	private String h_nm;
	private int h_val;
	private String r_nm;
	private int r_val;	
    private String ser_st_date;
    private String ser_ed_date;
	private int total;
    private String basis_date;
    private int rsv_yn;
	
    // CONSTRUCT
    public RiaReservation_bean(){
        
    } 
 
    
    // STTER
    public void setCurr_date(String curr_date) {
        this.curr_date = curr_date;
    }
    public void setNext_date(String next_date) {
        this.next_date = next_date;
    }
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
    public void setTwo_day(int two_day) {
        this.two_day = two_day;
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
    public void setPrice1_1(int price1_1) {
        this.price1_1 = price1_1;
    }
    public void setPrice2_1(int price2_1) {
        this.price2_1 = price2_1;
    }
    public void setPrice3_1(int price3_1) {
        this.price3_1 = price3_1;
    }
    public void setPrice4_1(int price4_1) {
        this.price4_1 = price4_1;
    }
    public void setPrice5_1(int price5_1) {
        this.price5_1 = price5_1;
    }
    public void setPrice6_1(int price6_1) {
        this.price6_1 = price6_1;
    }
    public void setBasis_date(String basis_date){
        this.basis_date = basis_date;
    }
    public void setRsv_yn(int rsv_yn){
        this.rsv_yn = rsv_yn;
    }
    public void setStandard_date(String standard_date)
    {
        this.standard_date = standard_date;
    }
    
    // GATTER
    public String getCurr_date() {
        return Util.getString(this.curr_date, "");
    }      
    public String getNext_date() {
        return Util.getString(this.next_date, "");
    }
    
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
    public int getTwo_day(){
        return this.two_day;
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
    public int getPrice1_1(){
        return this.price1_1;
    }    
    public int getPrice2_1(){
        return this.price2_1;
    }    
    public int getPrice3_1(){
        return this.price3_1;
    }    
    public int getPrice4_1(){
        return this.price4_1;
    }    
    public int getPrice5_1(){
        return this.price5_1;
    }     
    public int getPrice6_1(){
        return this.price6_1;
    }    
    public String getBasis_date(){
        return this.basis_date;
    }
    public int getRsv_yn(){
        return this.rsv_yn;
    }
    public String getStandard_date()
    {
        return this.standard_date;
    }
}
