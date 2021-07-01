package omsm.al;
/***********************************************************************
 * 	OMS FAQ 팝업상세
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import omsm.common.HDUtil;
import omsm.common.StringUtil;
import omsm.common.SuperServlet;

public class m_al0020_s2 extends SuperServlet {
	private static final long serialVersionUID = 1L;
	
	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();

			arr_sql[0].append (" SELECT A.AL_SID,A.AL_SEQ,A.AL_HIS_SEQ,    \n");
			arr_sql[0].append ("        A.B_LOGIS_GB,A.B_ITEM_NAME,A.B_CAR_KIND,A.B_SHIP_COMPANY,A.B_START_ADDR,A.B_END_ADDR,A.B_DRV_ID,A.B_REMARK,A.B_AL_YN,    \n");
			arr_sql[0].append ("        A.A_LOGIS_GB,A.A_ITEM_NAME,A.A_CAR_KIND,A.A_SHIP_COMPANY,A.A_START_ADDR,A.A_END_ADDR,A.A_DRV_ID,A.A_REMARK,A.A_AL_YN,    \n");
			arr_sql[0].append ("        A.CREATE_ID, TO_CHAR(A.CREATE_DATE,'YYYY-MM-DD HH24:MI:SSxFF') CREATE_DATE, \n");
			arr_sql[0].append ("        C.DETAIL_NAME||' '||C.ITEM1 AS B_START_NAME, D.DETAIL_NAME||' '||D.ITEM1 AS B_END_NAME,                 \n");
			arr_sql[0].append ("        E.DETAIL_NAME||' '||E.ITEM1 AS A_START_NAME, F.DETAIL_NAME||' '||F.ITEM1 AS A_END_NAME,                 \n");
			arr_sql[0].append ("        CASE WHEN A.B_LOGIS_GB=A.A_LOGIS_GB THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR1,          \n");
			arr_sql[0].append ("        CASE WHEN A.B_ITEM_NAME=A.A_ITEM_NAME THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR2,        \n");
			arr_sql[0].append ("        CASE WHEN A.B_CAR_KIND=A.A_CAR_KIND THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR3,          \n");
			arr_sql[0].append ("        CASE WHEN A.B_SHIP_COMPANY=A.A_SHIP_COMPANY THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR4,  \n");
			arr_sql[0].append ("        CASE WHEN A.B_START_ADDR=A.A_START_ADDR THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR5,      \n");
			arr_sql[0].append ("        CASE WHEN A.B_END_ADDR=A.A_END_ADDR THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR6,          \n");
			arr_sql[0].append ("        CASE WHEN A.B_DRV_ID=A.A_DRV_ID THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR7,          \n");
			arr_sql[0].append ("        CASE WHEN ((A.B_REMARK=A.A_REMARK) OR A.B_REMARK IS NULL ) THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR8,               \n");
			arr_sql[0].append ("        CASE WHEN ((A.B_AL_YN=A.A_AL_YN) OR A.B_AL_YN IS NULL)  THEN '#F2F5A9' ELSE '#FE9A2E' END COLOR9               \n");
			arr_sql[0].append ("     FROM OMS.T_AL0010 A, OMS.T_CO0030 C, OMS.T_CO0030 D, OMS.T_CO0030 E, OMS.T_CO0030 F   \n");
			arr_sql[0].append ("    WHERE 1=1                                                      \n");
			arr_sql[0].append ("      AND A.B_START_ADDR = C.DETAIL_CD(+) AND C.HEAD_CD(+) ='A016'                 \n");
			arr_sql[0].append ("      AND A.B_END_ADDR = D.DETAIL_CD(+) AND D.HEAD_CD(+) ='A016'                   \n");
			arr_sql[0].append ("      AND A.A_START_ADDR = E.DETAIL_CD(+) AND E.HEAD_CD(+) ='A016'                 \n");
			arr_sql[0].append ("      AND A.A_END_ADDR = F.DETAIL_CD(+) AND F.HEAD_CD(+) ='A016'                   \n");
	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		
	}
	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	
	}
			
	// 조회 method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		try {
			GauceInputStream gis = greq.getGauceInputStream();
            GauceOutputStream gos = gres.getGauceOutputStream();
			
			// DataSet 생성 			
			ds1 = new GauceDataSet(); 
			
			/**********************************************************************************
			 * Command 
			 **********************************************************************************
			 * Parameter 설정
			 * JSP에서 쿼리에 필요한 Request에 있는 파라미터를 설정한다  
			 **********************************************************************************/
			int dsType 				= HDUtil.nullCheckNum(greq.getParameter("dsType"));
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword")); //order_sts
						
			String v_parm1	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm1")); //AL_SID
			String v_parm2	    	= HDUtil.nullCheckStr(greq.getParameter("v_parm2")); //AL_SEQ
			
			if(!v_parm1.equals(""))    arr_sql[0].append (" AND  A.AL_SID = ? \n");
			if(!v_parm2.equals(""))    arr_sql[0].append (" AND  A.AL_SEQ = ? \n");
						
			
			//System.out.println("v_parm1"+v_parm1);
			//System.out.println("v_parm2"+v_parm2);
			
			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
				
					// 쿼리 실행
					//System.out.println("arr_sql[0].toString()"+arr_sql[0].toString());
					cstmt = conn.prepareCall(arr_sql[0].toString());
										
					cstmt.setString(1, v_keyword);
					int i_cnt=0;
					
					if(!v_parm1.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm1);}
					if(!v_parm2.equals(""))  {i_cnt+=1;	cstmt.setString(i_cnt, v_parm2);}
					
					rs = cstmt.executeQuery();     //DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
			}
		} catch (SQLException sqle){
			gres.addException(sqle);
			throw sqle;
		} catch (Exception e){
			gres.addException(e);
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}
