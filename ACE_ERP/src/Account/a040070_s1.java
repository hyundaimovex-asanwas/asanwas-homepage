package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a040070_s1 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String []  str	= new String [9];
				str[0] = req.getParameter("v_str1");		//지점
				str[1] = req.getParameter("v_str2");		//사업소
				str[2] = req.getParameter("v_str3");		//계산서기간 from
				str[3] = req.getParameter("v_str4");		//계산서기간 to
				str[4] = req.getParameter("v_str5");		//사업자등록번호
				str[5] = req.getParameter("v_str6");		//거래처명
				str[6] = req.getParameter("v_str7");		//거래처코드
				str[7] = req.getParameter("v_str8");		//id
				str[8] = req.getParameter("v_str9");		//관리자 구분 ( M 관리자) 

				for (int s=0;s<=8;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK",     "SLIPNO",    "VEND_CD",   "VEND_NM",    "VEND_ID",
					"TAXSUM",  "TAXVATAMT", "TAXTOT",     "REMARK",    "TAXNBR",  "CONVERSATION_ID"
				}; 

				int[] intArrCN = new int[] { 
					 1,  15,  13,   60,  15,
					 12, 12,  12,   132, 11, 35
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1, 
					 0,   0,   0,  -1,  -1, -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT 'F' AS CHK,                                      	\n");	
						sql.append( "        G.SSDAT || G.SSNBR AS SLIPNO,                    	\n");
						sql.append( "        RTRIM(A.VEND_CD) VEND_CD,                        	\n");
						sql.append( "        RTRIM(B.VEND_NM) VEND_NM,                        	\n");
						sql.append( "        RTRIM(B.VEND_ID) VEND_ID,                        	\n");
						sql.append( "        COALESCE(A.TAXSUM,0) TAXSUM,                     	\n");
						sql.append( "        COALESCE(A.TAXVATAMT,0) TAXVATAMT,               	\n");	
						sql.append( "        COALESCE(A.TAXTOT,0) TAXTOT,                     	\n");
						sql.append( "        RTRIM(A.REMARK) REMARK , A.TAXNBR ,'' CONVERSATION_ID \n");
						sql.append( "   FROM ACCOUNT.ATTAXMST A                               	\n");
						sql.append( "   LEFT JOIN ACCOUNT.GCZM_VENDER B ON A.VEND_CD=B.VEND_CD	\n");
						sql.append( "   LEFT JOIN ACCOUNT.FSLIPMST G ON A.FDCODE=G.FDCODE     	\n");
						sql.append( "                               AND A.FSDAT=G.FSDAT       	\n");	
						sql.append( "                               AND A.FSNBR=G.FSNBR       	\n");
						sql.append( "   LEFT JOIN HDASAN_EDI.XXSB_DTI_STATUS S ON A.CONVERSATION_ID = S.CONVERSATION_ID \n");
						sql.append( "                                         AND A.SUPBUY_TYPE = S.SUPBUY_TYPE         \n");
						sql.append( "                                         AND A.DIRECTION = S.DIRECTION             \n");
						if(!str[0].equals(""))sql.append( "  WHERE A.FDCODE ='"+str[0]+"'      	\n");
						if(!str[1].equals(""))sql.append( "    AND A.COCODE ='"+str[1]+"'       \n");
						sql.append( "    AND A.TAXIODIV='A'               \n");
						sql.append( "    AND A.TAXTOT<>0                  \n");
						sql.append( "    AND (S.DTI_STATUS ='' OR S.DTI_STATUS IS NULL OR S.DTI_STATUS='T' OR S.DTI_STATUS='W' OR S.DTI_STATUS='R' OR S.DTI_STATUS='O')  \n");
                        sql.append( "    AND A.GUBUN='1'                  \n");
						sql.append( "    AND (G.FSSTAT='N' OR G.FSSTAT IS NULL )\n");
						if(!str[4].equals(""))sql.append( "    AND B.VEND_ID ='"+str[4]+"'      \n");
						if(!str[6].equals(""))sql.append( "    AND A.VEND_CD ='"+str[6]+"'      \n");
						if(!str[5].equals(""))sql.append( "    AND RTRIM(B.VEND_NM) LIKE '"+str[5]+"%' 	\n");
						if(!str[2].equals("")&&!str[3].equals(""))sql.append( "     AND A.TAXDAT BETWEEN '"+str[2]+"'  AND '"+str[3]+"'  \n");
						if(!str[8].equals("M")){
							if(!str[7].equals(""))sql.append( "    AND A.EMPNO ='"+str[7]+"'      \n");
						}

						sql.append( " ORDER BY SLIPNO,A.TAXNBR					  				  \n");

						//logger.dbg.println(this,sql.toString());
						
						System.out.println("a040070_s1::"+sql.toString());

/*********************************************************************************************/
					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
			} catch(Exception e) {
				logger.err.println(this,e);
			} finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}