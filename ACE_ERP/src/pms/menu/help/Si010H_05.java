package pms.menu.help;
/***********************************************************************
 * 	자산번호 팝
************************************************************************/

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import sales.common.HDUtil;
import sales.common.StringUtil;
import pms.common.SuperServlet;

public class Si010H_05 extends SuperServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
		for(int i=0; i<arr_sql.length; i++)
			arr_sql[i] = new StringBuffer();
		
			arr_sql[0].append (" SELECT A.H_ASTNBR, A.ASTNAME, C.ASTNM                            \n")  
 				      .append ("   FROM ACCOUNT.ASTMSTN A, ACCOUNT.ASTBASICN B, ACCOUNT.ASTNAME C , ACCOUNT.COMMDTIL D                       \n") 
 				      /*
					  .append ("      LEFT JOIN ACCOUNT.ASTNAME C ON (A.ASTNAME=C.ASTCD           \n")  
					  .append ("                                      AND A.AST2ND =C.AST2ND      \n") 
					  .append (" 							            AND A.AST3RD =C.AST3RD)   \n")
		              .append (" 	   LEFT JOIN ACCOUNT.COMMDTIL D ON B.COSTCD = D.CDCODE AND CMTYPE='0030' \n")
		              */
					  .append ("  WHERE A.FDCODE =B.FDCODE                                                   \n")
					  .append ("       AND A.AST1ST =B.AST1ST                                                    \n")  
					  .append ("       AND A.AST2ND =B.AST2ND                                                    \n")  
					  .append ("       AND A.AST3RD =B.AST3RD                                                    \n")
					  .append ("       AND A.ASTSEQ =B.ASTSEQ                                                   \n")  
					  .append ("       AND A.ASTNAME = C.ASTCD(+)    \n")
					  .append ("       AND A.AST2ND  = C.AST2ND(+)   \n")
					  .append ("       AND A.AST3RD  = C.AST3RD(+)   \n")
					  .append ("       AND B.COSTCD = D.CDCODE (+)   \n")
					  .append ("       AND D.CMTYPE ='0030'          \n")
					  .append ("       AND D.CDNAM  LIKE  ?                                                            \n")  
					  .append ("       AND A.ASAQSDAT >= '20110101'                                            \n")
					  .append ("       AND NOT EXISTS ( SELECT S.H_ASTNBR                              \n")  
					  .append ("                          FROM PMS.TSI010 S                              \n")  
					  .append ("                         WHERE S.H_ASTNBR = A.ASTNBR )         \n");
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
			String v_keyword		= HDUtil.nullCheckStr(greq.getParameter("v_keyword"));			

			//StringUtil.printMsg("v_keyword", v_keyword, this);
			//StringUtil.printMsg("v_keyword", arr_sql[0].toString(), this);

			switch(dsType) {
				case 1: //detail이 공백이 아닌 공통코드 검색
					
					// 쿼리 실행
					// 쿼리 실행
					cstmt = conn.prepareCall(arr_sql[0].toString());  
					cstmt.setString(1, "%"+v_keyword+"%");
					
					rs = cstmt.executeQuery(); // DataSet set
					gos.write(getDataSet(rs, ds1));
					break;
			}
			gos.close();
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
