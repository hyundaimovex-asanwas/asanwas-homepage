/**
 * By beans generator source file 
 * source file name : TBRDCOMMENTDEBean.java
 * 
 * ### BeanMaker 1.0 ###
 * @author : Sim Jae Jin
 * @date : 2001-07-16 16:50
 * @mail : sim11@tnara.net
 *
 */

package kr.co.imjk.board.bean;

import java.sql.Clob;

import kr.co.imjk.util.Util;

public class Tbrd_comment_de_bean{

    /**
     * 
     * @uml.property name="comment_seq"
     */
    // MEMBER VARIABLE
    private int comment_seq;

    /**
     * 
     * @uml.property name="user_id"
     */
    private String user_id;

    /**
     * 
     * @uml.property name="user_nick"
     */
    private String user_nick;

    /**
     * 
     * @uml.property name="user_level"
     */
    private String user_level;

    /**
     * 
     * @uml.property name="user_icon"
     */
    private String user_icon;

    /**
     * 
     * @uml.property name="reg_date"
     */
    private java.util.Date reg_date;

    /**
     * 
     * @uml.property name="content"
     */
    private String content_de;
    //private Clob content;

    /**
     * 
     * @uml.property name="star_num"
     */
    private int star_num;

    /**
     * 
     * @uml.property name="board_seq"
     */
    private int board_seq;

    
    private String title;


	//  금강산  사이트 추가 
    private String best;

    //  금강산  사이트 추가 
    private String use_yn;

    //  금강산  사이트 추가 
    private String user_name;


    // CONSTRUCT
    public Tbrd_comment_de_bean(){
        
    }

    /**
     * 
     * @uml.property name="comment_seq"
     */
    // STTER
    public void setComment_seq(int comment_seq) {
        this.comment_seq = comment_seq;
    }

    /**
     * 
     * @uml.property name="user_id"
     */
    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    /**
     * 
     * @uml.property name="user_nick"
     */
    public void setUser_nick(String user_nick) {
        this.user_nick = user_nick;
    }

    /**
     * 
     * @uml.property name="user_level"
     */
    public void setUser_level(String user_level) {
        this.user_level = user_level;
    }

    /**
     * 
     * @uml.property name="user_icon"
     */
    public void setUser_icon(String user_icon) {
        this.user_icon = user_icon;
    }
    
    

    /**
     * 
     * @uml.property name="reg_date"
     */
    public void setReg_date(java.util.Date reg_date) {
        this.reg_date = reg_date;
    }

    /**
     * 
     * @uml.property name="content"
     */
    public void setContent_de(String content_de) {
        this.content_de = content_de;
    }

    /**
     * 
     * @uml.property name="star_num"
     */
    public void setStar_num(int star_num) {
        this.star_num = star_num;
    }

    /**
     * 
     * @uml.property name="board_seq"
     */
    public void setBoard_seq(int board_seq) {
        this.board_seq = board_seq;
    }
    
    
    public void setTitle(String title) {
        this.title = title;
    }


	public void setBest(String best) {
        this.best = best;
    } 

	public void setUser_name(String user_name) {
        this.user_name = user_name;
    }
	
	public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }
	
    /** 
     * 
     * @uml.property name="comment_seq"
     */
    // GATTER
    public int getComment_seq() {
    	return this.comment_seq;
    }

    /** 
     * 
     * @uml.property name="user_id"
     */
    public String getUser_id() {
        return Util.getString(this.user_id, "");
    }

    /**
     * 
     * @uml.property name="user_nick"
     */
    public String getUser_nick() {
        return Util.getString(this.user_nick, "");
    }

    /**
     * 
     * @uml.property name="user_level"
     */
    public String getUser_level() {
        return Util.getString(this.user_level, "");
    }

    /**
     * 
     * @uml.property name="user_icon"
     */
    public String getUser_icon() {
        return Util.getString(this.user_icon, "");
    }

 
    // DateType 'yyyy-MM-dd'
    public String getReg_date_String(){
        return Util.dateToString(reg_date, "yyyy-MM-dd");
    }
 
    /**
     * 
     * @uml.property name="reg_date"
     */
    public java.util.Date getReg_date() {
        return this.reg_date;
    }

    /**
     * 
     * @uml.property name="content"
     */
    public String getContent_de() {
        return Util.getString(this.content_de, "");
        //return Util.weblogicClobToString(this.content);
        
        //return ((weblogic.jdbc.vendor.oracle.OracleThinClob) this.content).getCharacterOutputStream();
        
        
        
        
    }

    /**
     * 
     * @uml.property name="star_num"
     */
    public int getStar_num() {
        return this.star_num;
    }

    /**
     * 
     * @uml.property name="board_seq"
     */
    public int getBoard_seq() {
    	 return this.board_seq;
    }
    
    public String getTitle() {
   	 return Util.getString(this.title, "");
   }

   public String getBest() {
        return Util.getString(this.best, "");
    }

   public String getUser_name() {
       return Util.getString(this.user_name, "");
   }
   
   
   public String getUse_yn() {
       return Util.getString(this.use_yn, "");
   }
}
