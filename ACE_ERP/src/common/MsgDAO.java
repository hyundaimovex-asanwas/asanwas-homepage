/*
 * 페이징 처리 : 2020-02-18 이동훈
 * 
 */
package common;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import kr.co.imjk.board.bean.Tbrd_board_ma_bean;

import common.MsgDTO;
import sales.common.HDUtil;
import sales.common.PagingHelper;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.util.StringUtil;


public class MsgDAO extends CommonDAO {
	
    public MsgDAO() {
    	
		super(); 
		
    }
    
    //게시물 리스트 조회시
    public ArrayList list(MsgDTO entity,String v_login_id, Connection conn) throws SQLException {
        
    	java.sql.PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;

		//System.out.println("v_login_id!!!!!!--->" + v_login_id);

        try {

			// 메세지 건수 조회- EHR 통합
        	sql.append(" SELECT	'50' AS detail,'인사' AS detail_nm, 	\n");   
        	sql.append("	COUNT(*) AS cnt							\n");      
        	sql.append("	 FROM ASNHR.T_AA_MESSAGE 			\n");
        	sql.append("	 WHERE 1=1							\n");
        	sql.append("		AND    ENO_NO = ?				\n");
        	sql.append("		AND    STATUS = 'N'		        \n");        	

			pstmt =  new PreparedStatement(conn,sql.toString());
			
			pstmt.setString(1, v_login_id);

        	rs = pstmt.executeQuery();
        	
        	System.out.println("sql--->" + sql.toString()  );
        	
	        while(rs.next()) {
	        	
	            data = new BaseDataClass();
	            
	            data.setValues(rs);
	            
	            arrBeans.add(data);
	            
	        }
	        
	        //System.out.println(sql.toString());

	    }catch(Exception e){
	    	
	    	e.printStackTrace();
	        //LogUtil.error(e);
	    	
	    }finally{
	    	
	        if(rs    != null){try{   rs.close();}catch(SQLException e){}}
	        if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
	        
	    }
        
    return arrBeans;
    
    }


}
