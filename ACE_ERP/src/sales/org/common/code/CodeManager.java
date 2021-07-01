/*******************************************************************************
 * 1.클래스   명 : TestManager.java
 * 2.클래스 개요 :
 * 3.관련 테이블 :
 * 4.관련 클래스 :
 * 5.관련 페이지 :
 * 6.작   성  자 : 이태선
 * 7.작 성 일 자 : 2004-03-30
 * 8.수 정 일 자 :
 * . <날짜>       ; <수정 내용> (<개발자명>)
 * . 2004-03-24      ;
 * @author 이태선
 * @version 1.0 2006-02-02
 ******************************************************************************/

package sales.org.common.code;



import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

import sales.org.common.code.CodeDTO;
import sales.org.common.db.Connection;
import sales.org.common.db.DBConnection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;


public class CodeManager{
    private static HashMap codeMap = null;

    private CodeManager(){}

    public static void init(){
        codeMap = new HashMap();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CodeDTO dto = null;
        try{

            // Database Connection
            conn = DBConnection.getConnection();
            StringBuffer sql = new StringBuffer();
            sql.append("SELECT ");
            sql.append("CALN_DATE,YOIL_CD,YOIL_NM,HOLIDAY_NM ");
            sql.append("FROM SALES.TSY100 ");
            sql.append("ORDER BY CALN_DAT ");

            pstmt = new PreparedStatement(conn,sql.toString());

            LogUtil.debug(pstmt.toString());

            rs = pstmt.executeQuery();
            while(rs.next()){
                dto = new CodeDTO();
                //Setting Line 1
                dto.setCaln_date(rs.getString("CALN_DATE"));
                dto.setYoil_cd(rs.getString("YOIL_CD"));
                dto.setYoil_nm( rs.getString("YOIL_NM"));
                dto.setHoliday_nm(rs.getString("HOLIDAY_NM"));

                if(codeMap.get(dto.getCaln_date()) == null){
                    codeMap.put(dto.getCaln_date(),new HashMap());
                }
                ((HashMap)codeMap.get(dto.getCaln_date())).put(dto.getCaln_date(),dto);
            }
            LogUtil.info("Code init");
        }catch(Exception e){
            LogUtil.error(e);
        }finally{
            if(rs    != null){try{   rs.close();}catch(SQLException e){}}
            if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
            if(conn  != null){try{ conn.close();}catch(SQLException e){}}
        }
    }

    public static void testCode(){
        String caln_date;
        String holiday_nm;
        CodeDTO dto = null;
        Set set = codeMap.keySet();
        Iterator it = set.iterator();
        while(it.hasNext()){
            caln_date = (String)it.next();
            Set innerSet = ((HashMap)codeMap.get(caln_date)).keySet();
            Iterator innerIt = innerSet.iterator();
            while(innerIt.hasNext()){
                holiday_nm = (String)innerIt.next();
                dto = (CodeDTO)(((HashMap)codeMap.get(caln_date)).get(holiday_nm));
                LogUtil.debug("caln_date:"+dto.getCaln_date()+" holiday_nm:"+dto.getHoliday_nm());
            }
        }
    }

    public static HashMap getCodeHash(String major_code){
        return (HashMap)codeMap.get(major_code);
    }


    public static CodeDTO getCodeDTO(String major_code, String minor_code){
        return (CodeDTO)((HashMap)codeMap.get(major_code)).get(minor_code);
    }
}