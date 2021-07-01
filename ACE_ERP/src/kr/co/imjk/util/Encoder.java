package kr.co.imjk.util;

import java.io.UnsupportedEncodingException;

import kr.co.imjk.lib.Header;


/**
 * CharSet Encode.java <br>
 *
 * - ������ ���̽��� �����͸� �ְų� ������ ��� DB Charset�� String�� Charset�� ���߾ <br>
 *    �ѱ��� ������ ���� �ذ����ִ� Ŭ����
 *
 * @ author : ������
 * @ e-mail : sim11@miraenet.com
 * @ create-date : 2001-04-25
 * @ modify-date : 2001-07-30
 */
public class Encoder{
    
    static final String [] DB_SID = Header.DB_SID;
    static final String [] DB_CHARSET = Header.DB_CHARSET;
    static final String [] DB_CHARSET_DEFAULT = {"KSC5601", "US7ASCII"};
    
    /**
     * DataBase�� �����͸� INSERT�Ҷ�
     */
    public static String setDb(String ko, String poolName) 
    {
    	String new_str = null;
	
        try {
            if(ko != null && !ko.equals("")){
                String charSet = getCharSet(poolName);
                // ������ ���̽��� KSC5601�϶�
                if(charSet.equals(DB_CHARSET_DEFAULT[0])){
                   new_str = ko; 
                // ������ ���̽��� US7ASCII �϶�
                }else{
                    new_str = new String (ko.getBytes("8859_1"), "KSC5601");
                }
            }else{
                new_str = ko;
            }
        } catch(UnsupportedEncodingException e) { }
        
    	return new_str;
    }
    
    /**
     * DataBase���� �����͸� SELECT�Ҷ�
     */
    public static String getDb(String ko, String poolName) 
    {
    	String new_str = null;		
        try {
            if(ko != null && !ko.equals("")){
                String charSet = getCharSet(poolName);
                // ������ ���̽��� KSC5601�϶�
                if(charSet.equals(DB_CHARSET_DEFAULT[0])){
                    new_str = ko;
                // ������ ���̽��� US7ASCII �϶�
                }else{
                    new_str = new String (ko.getBytes("KSC5601"), "8859_1");
                }
            }else{
                new_str = ko;
            }
        } catch(UnsupportedEncodingException e) { }			
    	return new_str;        
    }
    
    /**
     * URL���� URL ���ڵ��ؼ� �Ķ���͸� �ѱ涧 (�ѱ��϶� ���)
     */    
    public static String encodeURL(String en) 
    {
        String str = null;
        if(en == null) return str;
    	// jdk 1.2 or jdk 1.3
        str = java.net.URLEncoder.encode(en);         
         
        return str;
    }
    
    /**
     * URL���� URL ���ڵ��� �Ķ���͸� ������, �ѱ۷� ������
     */    
    public static String decodeURL(String en)
    {
		 return en;
    }
    
    private static String getCharSet(String poolName){
        String charset = null;  
        for(int i=0; i<DB_SID.length; i++){
            if(DB_SID[i].equals(poolName)){
                charset = DB_CHARSET[i];
                break;
            }
        }
        return charset;
    } 
}
