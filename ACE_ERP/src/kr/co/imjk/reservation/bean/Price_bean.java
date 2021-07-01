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

public class Price_bean{

    private int upjang_sid;
    private String menu_item1; //시즘
    private String menu_item2; //객실
    private String menu_item3; //연령
    private String menu_item4; //박수
    private String menu_item5; //
    private String menu_nm;  //객실명
    private int bgn_persons;  //정원
    private int end_persons;  //정원
    private int amt1; //성인요금
    private int amt2; //대학생요금
    private int amt3; //중고생요금
    private int amt4; //초등요금
    private int amt5; //아동요금
    private int amt6; //유아요금
    
    private String upjang_nm;  //호텔명
    private String upjang_cd;  //호텔코드
    private String persons_info;
    private String room_type_nm;
    private int std_persons;
    
    // CONSTRUCT
    public Price_bean(){
        
    } 

    // STTER
    public void setUpjang_sid(int upjang_sid) {
        this.upjang_sid = upjang_sid;
    }
    public void setMenu_item1(String menu_item1) {
        this.menu_item1 = menu_item1;
    }
    public void setMenu_item2(String menu_item2) {
        this.menu_item2 = menu_item2;
    }
    public void setMenu_item3(String menu_item3) {
        this.menu_item3 = menu_item3;
    }
    public void setMenu_item4(String menu_item4) {
        this.menu_item4 = menu_item4;
    }
    public void setMenu_item5(String menu_item5) {
        this.menu_item5 = menu_item5;
    }
    public void setMenu_nm(String menu_nm) {
        this.menu_nm = menu_nm;
    }
    public void setBgn_persons(int bgn_persons) {
        this.bgn_persons = bgn_persons;
    }    
    public void setEnd_persons(int end_persons) {
        this.end_persons = end_persons;
    }
    public void setAmt1(int amt1) {
        this.amt1 = amt1;
    }
    public void setAmt2(int amt2) {
        this.amt2 = amt2;
    }
    public void setAmt3(int amt3) {
        this.amt3 = amt3;
    }   
    public void setAmt4(int amt4) {
        this.amt4 = amt4;
    }
    public void setAmt5(int amt5) {
        this.amt5 = amt5;
    }
    public void setAmt6(int amt6) {
        this.amt6 = amt6;
    }
    public void setUpjang_nm(String upjang_nm) {
    	this.upjang_nm = upjang_nm;
    }
    public void setUpjang_cd(String upjang_cd) {
    	this.upjang_cd = upjang_cd;
    }
    
    public void setPersons_info(String persons_info) {
    	this.persons_info = persons_info;
    }    
    public void setRoom_type_nm(String room_type_nm) {
    	this.room_type_nm = room_type_nm;
    }    
    public void setStd_persons(int std_persons) {
        this.std_persons = std_persons;
    }
    
    
    // GATTER
    public int getUpjang_sid(){
        return upjang_sid;
    }
    public String getMenu_item1() {
        return Util.getString(this.menu_item1, "");
    }
    public String getMenu_item2() {
        return Util.getString(this.menu_item2, "");
    }
    public String getMenu_item3() {
        return Util.getString(this.menu_item3, "");
    }
    public String getMenu_item4() {
        return Util.getString(this.menu_item4, "");
    }
    public String getMenu_item5() {
        return Util.getString(this.menu_item5, "");
    }
    public String getMenu_nm() {
        return Util.getString(this.menu_nm, "");
    }
    public int getBgn_persons(){
        return bgn_persons;
    }    
    public int getEnd_persons(){
        return end_persons;
    }    
    public int getAmt1(){
        return amt1;
    }
    public int getAmt2(){
        return amt2;
    }
    public int getAmt3(){
        return amt3;
    }
    public int getAmt4(){
        return amt4;
    }
    public int getAmt5(){
        return amt5;
    }    
    public int getAmt6(){
        return amt6;
    }    
    public String getUpjang_nm() {
        return Util.getString(this.upjang_nm, "");
    }    
    public String getUpjang_cd() {
        return Util.getString(this.upjang_cd, "");
    }   
    public String getPersons_info() {
        return Util.getString(this.persons_info, "");
    }    
    public String getRoom_type_nm() {
        return Util.getString(this.room_type_nm, "");
    } 
    public int getStd_persons(){
        return std_persons;
    }
    
}
