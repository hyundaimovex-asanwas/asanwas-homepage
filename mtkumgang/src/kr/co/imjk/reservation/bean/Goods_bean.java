/**
 * By beans generator source file 
 * source file name : Goods_bean
 * 
 * ### BeanMaker 1.0 ###
 * @author : 이소연 대리
 * @date : 2006-09-07
 * @mail : arisu@imjk.co.kr
 * 
 */ 

package kr.co.imjk.reservation.bean;

import kr.co.imjk.util.Util;

public class Goods_bean{

    private int idx;
    private String g_corner; //진열코너
    private String g_name; //상품명
    private String g_std; //규격
    private int g_price; //가격
    private String g_maker; //제조사
    private String g_function;  //효능
    private String g_element;  //성분
    private String g_usage;  //사용법
    private String g_etc; //기타
    private String g_bigo; //비고
    private String g_imgfile; //사진파일명
    private String g_date; //등록일수
    private String g_unit; //단위
    private String g_kind; //종류
    private int g_viewcnt; //조회수
    private int total_count;
    private int rnum;	//Oracle 이전 추가 2014-11-03 심동현
    
    // CONSTRUCT
    public Goods_bean(){
        
    } 

    // STTER
    public void setIdx(int idx) {
        this.idx = idx;
    }
    public void setG_corner(String g_corner) {
        this.g_corner = g_corner;
    }
    public void setG_name(String g_name) {
        this.g_name = g_name;
    }
    public void setG_std(String g_std) {
        this.g_std = g_std;
    }
    public void setG_price(int g_price) {
        this.g_price = g_price;
    }
    public void setG_maker(String g_maker) {
        this.g_maker = g_maker;
    }
    public void setG_function(String g_function) {
        this.g_function = g_function;
    }
    public void setG_element(String g_element) {
        this.g_element = g_element;
    }    
    public void setG_usage(String g_usage) {
        this.g_usage = g_usage;
    }
    public void setG_bigo(String g_bigo) {
        this.g_bigo = g_bigo;
    }    
    public void setG_etc(String g_etc) {
        this.g_etc = g_etc;
    }
    public void G_bigo(String g_bigo) {
        this.g_bigo = g_bigo;
    }
    public void setG_imgfile(String g_imgfile) {
        this.g_imgfile = g_imgfile;
    }   
    public void setG_date(String g_date) {
        this.g_date = g_date;
    }
    public void setG_viewcnt(int g_viewcnt) {
        this.g_viewcnt = g_viewcnt;
    }
    public void setTotal_count(int total_count) {
        this.total_count = total_count;
    }
    public void setG_unit(String g_unit) {
        this.g_unit = g_unit;
    }    
    public void setG_kind(String g_kind) {
        this.g_kind = g_kind;
    }
    public void setRnum(int rnum) {
        this.rnum = rnum;
    }
    
    // GATTER
    public int getIdx(){
        return idx;
    }
    public String getG_corner() {
        return Util.getString(this.g_corner, "");
    }
    public String getG_name() {
        return Util.getString(this.g_name, "");
    }
    public String getG_std() {
        return Util.getString(this.g_std, "");
    }
    public int getG_price(){
        return g_price;
    }  
    public String getG_maker() {
        return Util.getString(this.g_maker, "");
    }
    public String getG_function() {
        return Util.getString(this.g_function, "");
    }
    public String getG_element() {
        return Util.getString(this.g_element, "");
    }   
    public String getG_usage() {
        return Util.getString(this.g_usage, "");
    }     
    public String getG_etc() {
        return Util.getString(this.g_etc, "");
    } 
    public String getG_bigo() {
        return Util.getString(this.g_bigo, "");
    }
    public String getG_imgfile() {
        return Util.getString(this.g_imgfile, "");
    }
    public String getG_date(){
        return Util.getString(this.g_date, "");
    }
    public int getG_viewcnt(){
        return g_viewcnt;
    }    
    public int getTotal_count() {
        return this.total_count;
    }
    public String getG_unit() {
        return Util.getString(this.g_unit, "");
    } 
    public String getG_kind() {
        return Util.getString(this.g_kind, "");
    }
    public int getRnum() {
        return this.rnum;
    }

}
