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

public class Agent_bean{
    //TCU030
	private String area_cd;
	private String agen_gu;
    private String client_sid;
    private String client_cd;
    private String client_nm;
    private String client_gu;
    private String e_mail;
    private String zip_cd;
    private String address1;
    private String address2;
    //TCU032
    private String branch_nm; //지점명
    private String branch_cd; //지점코드
    private String client_url; //지점URL
    private String tel_no;  //연락처
    private String mobile_no; //휴대연락처
    private String fax_no; //팩스번호
   
    
    
    // CONSTRUCT
    public Agent_bean(){
        
    } 

    // STTER
    public void setArea_cd(String area_cd) {
        this.area_cd = area_cd;
    }
    public void setAgen_gu(String agen_gu) {
        this.agen_gu = agen_gu;
    }     
    public void setClient_sid(String client_sid) {
        this.client_sid = client_sid;
    }
    public void setClient_cd(String client_cd) {
        this.client_cd = client_cd;
    }
    public void setClient_nm(String client_nm) {
        this.client_nm = client_nm;
    }
    public void setClient_gu(String client_gu) {
        this.client_gu = client_gu;
    }
    public void setE_mail(String e_mail) {
        this.e_mail = e_mail;
    }
    public void setZip_cd(String zip_cd) {
        this.zip_cd = zip_cd;
    }
    public void setAddress1(String address1) {
        this.address1 = address1;
    }
    public void setAddress2(String address2) {
        this.address2 = address2;
    }
    public void setBranch_nm(String branch_nm) {
        this.branch_nm = branch_nm;
    }
    public void setBranch_cd(String branch_cd) {
        this.branch_cd = branch_cd;
    }
    public void setClient_url(String client_url) {
        this.client_url = client_url;
    }    
    public void setTel_no(String tel_no) {
        this.tel_no = tel_no;
    }
    public void setMobile_no(String mobile_no) {
        this.mobile_no = mobile_no;
    }
    public void setFax_no(String fax_no) {
        this.fax_no = fax_no;
    }
    
    
    
    // GATTER
    public String getArea_cd() {
        return Util.getString(this.area_cd, "");
    } 
    public String getAgen_gu() {
        return Util.getString(this.agen_gu, "");
    }    
    public String getClient_sid() {
        return Util.getString(this.client_sid, "");
    }
    public String getClient_cd() {
        return Util.getString(this.client_cd, "");
    }
    public String getClient_nm() {
        return Util.getString(this.client_nm, "");
    }
    public String getClient_gu() {
        return Util.getString(this.client_gu, "");
    }
    public String getE_mail() {
        return Util.getString(this.e_mail, "");
    }
    public String getZip_cd() {
        return Util.getString(this.zip_cd, "");
    }
    public String getAddress1() {
        return Util.getString(this.address1, "");
    }
    public String getAddress2() {
        return Util.getString(this.address2, "");
    }
    public String getBranch_nm() {
        return Util.getString(this.branch_nm, "");
    }
    public String getBranch_cd() {
        return Util.getString(this.branch_cd, "");
    }
    public String getClient_url() {
        return Util.getString(this.client_url, "");
    }    
    public String getTel_no() {
        return Util.getString(this.tel_no, "");
    }
    public String getMobile_no() {
        return Util.getString(this.mobile_no, "");
    }
    public String getFax_no() {
        return Util.getString(this.fax_no, "");
    }
    
}
