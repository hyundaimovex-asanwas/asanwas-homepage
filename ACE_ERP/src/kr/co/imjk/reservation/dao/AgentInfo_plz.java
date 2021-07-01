/*
 * Created on 2006. 6. 8.
 * 
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
//2010-03-26  PLZ 대리점만 검색 AGEN_GU IN ('4','6')
package kr.co.imjk.reservation.dao;

import java.sql.Connection; 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import kr.co.imjk.lib.exception.DbException;
import kr.co.imjk.util.DAOHome;
import kr.co.imjk.util.Selecter;
import kr.co.imjk.reservation.bean.Agent_bean;
 
/**
 * @author syLee
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class AgentInfo_plz  extends DAOHome{

    /**
     * 대리점 정보
     * @param area_cd 검색할 지역코드
     * @throws DbException
     * @throws Exception
     * @author syLee
     */
    public Agent_bean[] getAgentList(String area_cd , String keyword, String part) throws  Exception{
    	Connection dbconn = getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Agent_bean bean = null;
        Collection list = null; 
        String query = "";
        String subSql =" ";
        String subSql1 =" ";
        String tempPart = "";
        
        if(!area_cd.equals("")){
			subSql = " AND  AREA_CD LIKE '%"+area_cd+"%' \n";
        }else{
            
        }

    	if(part.trim().equals("client_nm")){
    	 	subSql1 = " AND CLIENT_NM LIKE '%"+keyword+"%' ";
    	 }else if(part.equals("address")){
    	 	subSql1 = " AND (ADDRESS1 LIKE '%"+keyword+"%' OR  ADDRESS2 LIKE '%"+keyword+"%')";
    	 }else if(part.equals("")){
    	 	subSql1 = " AND (CLIENT_NM LIKE '%"+keyword+"%' OR (ADDRESS1 LIKE '%"+keyword+"%' OR  ADDRESS2 LIKE '%"+keyword+"%') )";
    	 }else{
    	 	
    	 }
      
       //SQL  
        String sql = new StringBuffer()
	        
	        .append(" SELECT                                             \n")
	        .append("  CLIENT_CD,                                        \n")
	        .append("  AREA_CD,                                          \n")
	        .append("  CASE WHEN AGEN_GU = '1' THEN 'A'                  \n")
	        .append("  WHEN AGEN_GU = '2' THEN 'B'                       \n")
	        .append("  WHEN AGEN_GU = '3' THEN 'C'                       \n")
	        .append("  END AS AGEN_GU,                                   \n")
	        .append("  CLIENT_NM, ZIP_CD,                                \n")
	        .append("  ADDRESS1, ADDRESS2, TEL_NO, FAX_NO, CLIENT_URL    \n")
	        .append("  from sales.TCU030                                 \n")
            .append("  where client_gu='1' and use_yn='Y' AND AGEN_GU IN ('4','6')   \n")
	        .append(subSql)
	        .append(subSql1)			
			.append(" ORDER BY ADDRESS1 ASC                              ").toString();
        
        try {

            pstmt = dbconn.prepareStatement(sql);
            // 결과 담기
			//System.out.println("info_plzSQL"+sql);
            rs = pstmt.executeQuery();
            list = Selecter.execute(rs, new Agent_bean());

            rs.close();
            pstmt.close();
        } catch (SQLException e) {
            throw new DbException(e.getMessage());
        }finally{
            release(pstmt);
            freeConnection(dbconn);
        }
        return (Agent_bean [])list.toArray(new Agent_bean[0]);       
    }
 
}
