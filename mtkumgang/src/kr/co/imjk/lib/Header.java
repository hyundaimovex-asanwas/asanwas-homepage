/**
 * 환경 설정 클래스 <br>
 *
 * @ author : SIM JAE JIN <br>
 * @ modifier : jeong hwa, Kim <br>
 * @ e-mail : sim11@miraenet.com <br>
 * @ Create Date : 2001-03-23 <br>
 * @ Last Modify Date : 2003-10-21 <br>
 */
 
package kr.co.imjk.lib;

public class Header{
    /*
     * 데이터 베이스 환경 설정 정의
     */ 
    public static final String [] DB_CHARSET = {"KSC5601", "KSC5601"};
    public static final String [] DB_SID = {"tourds", "imjk"};//jdbc/ 이걸 빼줘야 JNDI를 찾는다. 
//tourtestds
//tourds    
    /*
     * Upload Encoding
     */
    public static final String UPLOAD_ENCODING = "KSC5601";
}
