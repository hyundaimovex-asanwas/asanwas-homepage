package com.hdasan.util;

import kr.co.imjk.util.Util;

public class MyParam{
    private String ssid; 	//����id
    private String ssn;		//�ֹ�
    private String aed;		//���̵�
       
   
    // CONSTRUCT
    public MyParam(){
        
    } 

    // SETTER
    public void setSSID(String ssid) {
        this.ssid = ssid;
    }
    public void setSSN(String ssn) {
        this.ssn = ssn;
    }     
    public void setAED(String aed) {
        this.aed = aed;
    }
    
    
    
    // GETTER
    public String getSSID() {
        return Util.getString(this.ssid, "");
    } 
    public String getSSN() {
        return Util.getString(this.ssn, "");
    }    
    public String getAED() {
        return Util.getString(this.aed, "");
    }
    
}
