/*
* [ 수정일자 ][수정자] 내용
* [2018-04-17][이동훈] 
*/
package pms.new2018.common;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Connection;

import pms.new2018.common.DBDTO;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;


public class DBDAO extends CommonDAO {
    public DBDAO() {
    	
		super(); 
    }
    
    //게시물 리스트 조회시
    public ArrayList list(DBDTO entity, String where_sql,int requestedPage,int pageSize ,String v_login_id,String v_group,Connection conn) throws SQLException {

    	java.sql.PreparedStatement pstmt = null;
        ResultSet rs = null;
        StringBuffer sql = new StringBuffer();
        ArrayList arrBeans = new ArrayList();
        BaseDataClass data = null;

        
        sales.common.StringUtil.printMsg("사번","1");
    	System.out.println("여기서 조건절3333333333!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		
        try {

        	
			//프로젝트현황 조회
			sql.append("SELECT  															\n")
			   .append("	CASE WHEN A.PROP1 = '01' THEN '관광'							\n")
			   .append("      WHEN A.PROP1 = '02' THEN 'MICE'								\n")
			   .append("      WHEN A.PROP1 = '03' THEN '건설'								\n")
			   .append("      WHEN A.PROP1 = '04' THEN 'ODA'								\n")
			   .append("		ELSE '공통'	END GROUP_NM,									\n")
			   .append("    B.DETAIL_NM,													\n")
			   .append("    C.DPT_NM,														\n")
			   .append("    TO_CHAR(TO_DATE(A.CTRT_BGNDATE),'YYYY-MM-DD') STARTDT,			\n")
			   .append("    TO_CHAR(TO_DATE(A.CTRT_ENDDATE),'YYYY-MM-DD') ENDDT,			\n")
			   .append("    E.VEND_NM AS ORDER_NM,											\n") 
			   .append("    REPLACE(TO_CHAR(A.COST_FEE,'999,999,999,999,999'),' ','') COST, \n")			   
			   //.append("    (A.COST_FEE) AS COST,											\n")
			   .append("    D.ENO_NM ||' '||D.JOB_NM AS PM,									\n")			   
			   .append("    A.COST_CD, A.PLJ_NM, '수정' EDIT								\n")
			   .append(" FROM PMS.TSY200 A, PMS.TSY010 B, 									\n")	
			   .append("      ASNHR.T_CM_DEPT C, ASNHR.VI_T_CM_PERSON2 D,					\n")	
			   .append("      ACCOUNT.GCZM_VENDER E											\n")			   
			   .append(" WHERE A.COST_CD > '1800' AND A.COST_CD < '20'						\n")
			   .append("      AND A.PL_DEPT_CD = C.DPT_CD									\n")
			   .append("      AND B.HEAD = 'SY202'											\n")			   
			   .append("      AND B.DETAIL = A.PROP2										\n")
			   .append("      AND A.PM = D.ENO_NO											\n")
			   .append("      AND A.ORDER_COMP_CD = E.VEND_CD(+)								\n")			   				   
			   .append("      AND A.PROP1 LIKE '%'||?||'%'									\n")			   
			   .append("      ORDER BY A.COST_CD DESC 										\n");		

			pstmt =  new PreparedStatement(conn,sql.toString());
			
			//pstmt.setString(1, "01");	//
			
			pstmt.setString(1, v_group);	//
			
			sales.common.StringUtil.printMsg("v_group",v_group,this);
			sales.common.StringUtil.printMsg("pageSize",pageSize,this);			
			sales.common.StringUtil.printMsg("쿼리",sql.toString(),this);

        	rs = pstmt.executeQuery();
        	
	        while(rs.next()) {
	        	
	            data = new BaseDataClass();
	            
	            data.setValues(rs);
	            
	            arrBeans.add(data);
	            
	        }
	        
	        System.out.println(sql.toString());

/////////////////////////////////////////////////////////////////////////////////////////////////
	        
	    }catch(Exception e){
	    	
	    	e.printStackTrace();
	        LogUtil.error(e);
	        
	    }finally{
	    	
	        if(rs    != null){try{   rs.close();}catch(SQLException e){}}
	        if(pstmt != null){try{pstmt.close();}catch(SQLException e){}}
	        
	    }
    return arrBeans;
    }


}
