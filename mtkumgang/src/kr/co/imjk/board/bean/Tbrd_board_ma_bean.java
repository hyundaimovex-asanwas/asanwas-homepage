/**
 * By beans generator source file 
 * source file name : Tbrd_board_ma_bean.java
 * 
 * ### BeanMaker 1.0 ###
 * @author : hslim
 * @date : 2001-07-16 16:50
 * @mail : hslim@imjk.co.kr
 *
 */ 

package kr.co.imjk.board.bean;

import kr.co.imjk.util.Util;

public class Tbrd_board_ma_bean{

    private String gubun;

    private int board_seq;

    private String board_type;

    private int ref_no;

    private int level_no;

    private int sort_no;

    private String title;

    private String content;
    //private Clob content;
    

    private String user_id;

    private String user_name;

    private String user_nick;

    private String user_level;

    private String user_icon;

    private java.util.Date reg_date;

    private int read_num;

    private int recomm_num;

    private int comment_num;

    private String from_date;

    private String to_date;


    private int board_top_no;


    private String edit_yn;


    private String use_yn;

    private int point;


    private String password;


    private int total_count;

    private String real_name;

    private String thumbnail_real_name;

    private String virtual_name;

    private String thumbnail_virtual_name;

    private int width;


    private float star_aver;


    private int file_num;
    //금강산  사이트 추가 
    private String email;
    
//  금강산  사이트 추가 
    private String status;
    
//  금강산  사이트 추가 
    private String best;
    
//  금강산  사이트 추가 
    private String type_code;
    
//  금강산  사이트 추가 
    private String open_yn;
      
//  금강산  사이트 추가 
    private String reply_yn;
    
//  금강산  사이트 추가 
    private String reply_content;
    
//  금강산  사이트 추가  
    private java.util.Date reply_reg_date;
    
//  금강산  사이트 추가  
    private String tel;
     
//  금강산  사이트 추가  2006-06-23 이소연 추가    
    private int pre_seq;
    
//  금강산  사이트 추가  2006-06-23 이소연 추가
    private int next_seq;
    
    private int rnum;	//Oracle 이전 추가 2014-11-03 심동현
    
    
    // CONSTRUCT
    public Tbrd_board_ma_bean(){
        
    } 


    // SETTER
    public void setGubun(String gubun) {
        this.gubun = gubun;
    }

 
    public void setBoard_seq(int board_seq) {
        this.board_seq = board_seq;
    }

 
    public void setBoard_type(String board_type) {
        this.board_type = board_type;
    }

 
    public void setRef_no(int ref_no) {
        this.ref_no = ref_no;
    }

  
    public void setLevel_no(int level_no) {
        this.level_no = level_no;
    }

  
    public void setSort_no(int sort_no) {
        this.sort_no = sort_no;
    }

    public void setTitle(String title) {
        this.title = title;
    }


    public void setContent(String content) {
        this.content = content;
    }



    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

   
    public void setUser_nick(String user_nick) {
        this.user_nick = user_nick;
    }

 
    public void setUser_level(String user_level) {
        this.user_level = user_level;
    }

    
    public void setUser_icon(String user_icon) {
        this.user_icon = user_icon;
    }

  
    public void setReg_date(java.util.Date reg_date) {
        this.reg_date = reg_date;
    }

  
    public void setRead_num(int read_num) {
        this.read_num = read_num;
    }

 
    public void setRecomm_num(int recomm_num) {
        this.recomm_num = recomm_num;
    }

    public void setComment_num(int comment_num) {
        this.comment_num = comment_num;
    }


    public void setFrom_date(String from_date) {
        this.from_date = from_date;
    }

  
    public void setTo_date(String to_date) {
        this.to_date = to_date;
    }

  
    public void setBoard_top_no(int board_top_no) {
        this.board_top_no = board_top_no;
    }

  
    public void setEdit_yn(String edit_yn) {
        this.edit_yn = edit_yn;
    }

    public void setUse_yn(String use_yn) {
        this.use_yn = use_yn;
    }

  
    public void setPoint(int point) {
        this.point = point;
    }

   
    public void setPassword(String password) {
        this.password = password;
    }

  
    public void setTotal_count(int total_count) {
        this.total_count = total_count;
    }

  
    public void setReal_name(String real_name) {
        this.real_name = real_name;
    }

    public void setThumbnail_real_name(String thumbnail_real_name) {
        this.thumbnail_real_name = thumbnail_real_name;
    }
 
    public void setVirtual_name(String virtual_name) {
        this.virtual_name = virtual_name;
    }

    public void setThumbnail_virtual_name(String Thumbnail_virtual_name) {
        this.thumbnail_virtual_name = Thumbnail_virtual_name;
    }
    
    public void setWidth(int width) {
        this.width = width;
    }

  
    public void setStar_aver(float star_aver) {
        this.star_aver = star_aver;
    }

  
    public void setFile_num(int file_num) {
        this.file_num = file_num;
    }

    public void setEmail(String email) {
        this.email = email;
    } 
    
    
    public void setStatus(String status) {
        this.status = status;
    } 
    
    public void setBest(String best) {
        this.best = best;
    } 
    
    public void setType_code(String type_code) {
        this.type_code = type_code;
    } 
    public void setOpen_yn(String open_yn) {
        this.open_yn = open_yn;
    } 
    
    public void setReply_yn(String reply_yn) {
        this.reply_yn = reply_yn;
    } 
    
    public void setReply_content(String reply_content) {
        this.reply_content = reply_content;
    } 
    
    public void setReply_reg_date(java.util.Date reply_reg_date) {
        this.reply_reg_date = reply_reg_date;
    }
    
    public void setTel(String tel) {
        this.tel = tel;
    } 
    public void setPre_seq(int pre_seq) {
        this.pre_seq = pre_seq;
    }
    
    public void setNext_seq(int next_seq) {
        this.next_seq = next_seq;
    }        
    public void setRnum(int rnum) {
        this.rnum = rnum;
    }
    

    // GETTER
    public String getGubun() {
        return Util.getString(this.gubun, "");
    }

  
    public int getBoard_seq() {
        return this.board_seq;
    }

    public String getBoard_type() {
        return Util.getString(this.board_type, "");
    }

    public int getRef_no() {
        return this.ref_no;
    }

  
    public int getLevel_no() {
        return this.level_no;
    }

  
    public int getSort_no() {
        return this.sort_no;
    }

  
    public String getTitle() {
        return Util.getString(this.title, "");
    }

    public String getContent() {
    	return Util.getString(this.content, "");
    	//return this.content;
        //return Util.weblogicClobToString(this.content); 
    }



    public String getUser_id() {
        return Util.getString(this.user_id, "");
    }

    public String getUser_name() {
        return Util.getString(this.user_name, "");
    }
 
   
    public String getUser_nick() {
        return Util.getString(this.user_nick, "");
    }

   
    public String getUser_level() {
        return Util.getString(this.user_level, "");
    }

   
    public String getUser_icon() {
        return Util.getString(this.user_icon, "");
    }


    // DateType 'yyyy-MM-dd'
    public String getReg_date_String(){
        return Util.dateToString(reg_date, "yyyy-MM-dd");
    }

  
    public java.util.Date getReg_date() {
        return this.reg_date;
    }

    public int getRead_num() {
        return this.read_num;
    }

  
    public int getRecomm_num() {
        return this.recomm_num;
    }

   
    public int getComment_num() {
        return this.comment_num;
    }

   
    public String getFrom_date() {
        return Util.getString(this.from_date, "");
    }

    
    public String getTo_date() {
        return Util.getString(this.to_date, "");
    }

    
    public int getBoard_top_no() {
        return this.board_top_no;
    }

   
    public String getEdit_yn() {
        return Util.getString(this.edit_yn, "");
    }
 
    public String getUse_yn() {
        return Util.getString(this.use_yn, "");
    }

   
    public int getPoint() {
        return this.point;
    }

   
    public String getPassword() {
        return Util.getString(this.password, "");
    }

  
    public int getTotal_count() {
        return this.total_count;
    }

    public String getReal_name() {
        return Util.getString(this.real_name, "");
    }

    public String getThumbnail_real_name() {
        return Util.getString(this.thumbnail_real_name, "");
    } 
   
    public String getVirtual_name() {
        return Util.getString(this.virtual_name, "");
    }

    public String getThumbnail_virtual_name() {
        return Util.getString(this.thumbnail_virtual_name, "");
    }
    
    public int getWidth() {
        return this.width;
    }

    
    public float getStar_aver() {
        return this.star_aver;
    }
 
   
    public int getFile_num() {
        return this.file_num;
    }
    
    public String getEmail() {
        return Util.getString(this.email, "");
    }
    
    public String getBest() {
        return Util.getString(this.best, "");
    }
    
    public String getStatus() {
        return Util.getString(this.status, "");
    }
    
    public String getType_code() {
        return Util.getString(this.type_code, "");
    }
    
    public String getOpen_yn() {
        return Util.getString(this.open_yn, "");
    }
    
    public String getReply_yn() {
        return Util.getString(this.reply_yn, "");
    }
    
    public String getReply_content() {
        return Util.getString(this.reply_content, "");
    }
    
    // DateType 'yyyy-MM-dd'
    public String getReply_reg_date_String(){
        return Util.dateToString(reply_reg_date, "yyyy-MM-dd");
    }

  
    public java.util.Date getReply_reg_date() {
        return this.reply_reg_date;
    } 
    
    public String getTel() {
        return Util.getString(this.tel, "");
    }
    
    public int getPre_seq() {
        return this.pre_seq;
    }
    public int getNext_seq() {
        return this.next_seq;
    }      
    public int getRnum() {
        return this.rnum;
    }

    
}
