package kr.co.imjk.util;

import java.io.UnsupportedEncodingException;

import kr.co.imjk.lib.Header;


/**
 * CharSet Encode.java <br>
 *
 * - 데이터 베이스에 데이터를 넣거나 수정할 경우 DB Charset과 String의 Charset을 맞추어서 <br>
 *    한글이 깨지는 것을 해결해주는 클래스
 *
 * @ author : 심재진
 * @ e-mail : sim11@miraenet.com
 * @ create-date : 2001-04-25
 * @ modify-date : 2001-07-30
 */
public class Encoder{
    
    static final String [] DB_SID = Header.DB_SID;
    static final String [] DB_CHARSET = Header.DB_CHARSET;
    static final String [] DB_CHARSET_DEFAULT = {"KSC5601", "US7ASCII"};
    
    /**
     * DataBase에 데이터를 INSERT할때
     */
    public static String setDb(String ko, String poolName) 
    {
    	String new_str = null;
	
        try {
            if(ko != null && !ko.equals("")){
                String charSet = getCharSet(poolName);
                // 데이터 베이스가 KSC5601일때
                if(charSet.equals(DB_CHARSET_DEFAULT[0])){
                   new_str = ko; 
                // 데이터 베이스가 US7ASCII 일때
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
     * DataBase에서 데이터를 SELECT할때
     */
    public static String getDb(String ko, String poolName) 
    {
    	String new_str = null;		
        try {
            if(ko != null && !ko.equals("")){
                String charSet = getCharSet(poolName);
                // 데이터 베이스가 KSC5601일때
                if(charSet.equals(DB_CHARSET_DEFAULT[0])){
                    new_str = ko;
                // 데이터 베이스가 US7ASCII 일때
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
     * URL에서 URL 인코딩해서 파라미터를 넘길때 (한글일때 사용)
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
     * URL에서 URL 인코딩된 파라미터를 받을때, 한글로 리턴함
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
