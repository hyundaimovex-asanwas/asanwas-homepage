/**
 * By beans generator source file 
 * source file name : Tbrd_board_ma_bean.java
 * 
 * ### BeanMaker 1.0 ###
 * @author : parksangbae
 * @date : 2006-04-21 13:58
 * @mail : odysseywapj@imjk.co.kr
 *
 */ 

package kr.co.imjk.board.bean;

import kr.co.imjk.util.Util;

public class Tbrd_attach_file_de_bean{

    /**
     * 
     * @uml.property name="attach_file_seq"
     */
    private int attach_file_seq;

    /**
     * 
     * @uml.property name="width"
     */
    private int width;

    /**
     * 
     * @uml.property name="height"
     */
    private int height;

    /**
     * 
     * @uml.property name="file_size"
     */
    private int file_size;

    /**
     * 
     * @uml.property name="real_name"
     */
    private String real_name;

    /**
     * 
     * @uml.property name="virtual_name"
     */
    private String virtual_name;

    /**
     * 
     * @uml.property name="thumbnail_real"
     */
    private String thumbnail_real_name;

    /**
     * 
     * @uml.property name="thumbnail_virtual_name"
     */
    private String thumbnail_virtual_name;    
    
    /**
     * 
     * @uml.property name="reg_date"
     */
    private java.util.Date reg_date;

    /**
     * 
     * @uml.property name="board_seq"
     */
    private int board_seq;


	// CONSTRUCT
    public Tbrd_attach_file_de_bean(){
        
    }

    /**
     * 
     * @uml.property name="attach_file_seq"
     */
    // STTER	
    public void setAttach_file_seq(int attach_file_seq) {
        this.attach_file_seq = attach_file_seq;
    }

    /**
     * 
     * @uml.property name="width"
     */
    public void setWidth(int width) {
        this.width = width;
    }

    /**
     * 
     * @uml.property name="height"
     */
    public void setHeight(int height) {
        this.height = height;
    }

    /**
     * 
     * @uml.property name="file_size"
     */
    public void setFile_size(int file_size) {
        this.file_size = file_size;
    }

    /**
     * 
     * @uml.property name="real_name"
     */
    public void setReal_name(String real_name) {
        this.real_name = real_name;
    }

   
    /**
     * 
     * @uml.property name="virtual_name"
     */
    public void setVirtual_name(String virtual_name) {
        this.virtual_name = virtual_name;
    }
 
    /**
     * 
     * @uml.property name="thumbnail_virtual_name"
     */
    public void setThumbnail_virtual_name(String thumbnail_virtual_name) {
        this.thumbnail_virtual_name = thumbnail_virtual_name;
    }
    
    /**
     * 
     * @uml.property name="thumbnail_real_name"
     */
    public void setThumbnail_real_name(String thumbnail_real_name) {
        this.thumbnail_real_name = thumbnail_real_name;
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
     * @uml.property name="board_seq"
     */
    public void setBoard_seq(int board_seq) {
        this.board_seq = board_seq;
    }
 
    /**
     * 
     * @uml.property name="attach_file_seq"
     */
    // GATTER
    public int getAttach_file_seq() {
        return this.attach_file_seq;
    }

    /**
     *  
     * @uml.property name="width"
     */
    public int getWidth() {
        return this.width;
    }

    /**
     * 
     * @uml.property name="height"
     */
    public int getHeight() {
        return this.height;
    }

    /**
     * 
     * @uml.property name="file_size"
     */
    public int getFile_size() {
        return this.file_size;
    }

    /**
     * 
     * @uml.property name="real_name"
     */
    public String getReal_name() {
        return Util.getString(this.real_name, "");
    }

    /**
     * 
     * @uml.property name="virtual_name"
     */
    public String getVirtual_name() {
        return Util.getString(this.virtual_name, "");
    }

    /**
     * 
     * @uml.property name="thumbnail_real_name"
     */
    public String getThumbnail_real_name() {
        return Util.getString(this.thumbnail_real_name, "");
    }

    /**
     * 
     * @uml.property name="virtual_name"
     */
    public String getThumbnail_virtual_name() {
        return Util.getString(this.thumbnail_virtual_name, "");
    }   
    
    /**
     * 
     * @uml.property name="reg_date"
     */
    public java.util.Date getReg_date() {
        return this.reg_date;
    }


	// DateType 'yyyy-MM-dd'
    public String getReg_date_String(){
        return Util.dateToString(reg_date, "yyyy-MM-dd");
    }

    /**
     * 
     * @uml.property name="board_seq"
     */
    public int getBoard_seq() {
        return this.board_seq;
    }

}