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
public class a080002_s4 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//예산년도
				str[2] = req.getParameter("v_str3");	//예산월from
				str[3] = req.getParameter("v_str4");	//예산월to
				str[4] = req.getParameter("v_str5");	//예산본부
				str[5] = req.getParameter("v_str6");	//예산부서
				str[6] = req.getParameter("v_str7");	//계정명  
				str[7] = req.getParameter("v_str8");	//계정코드
				str[8] = req.getParameter("v_str9");	//세세목

				for(int i=0;i<=8;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
	 
					"DEPTNM","ATKORNAM","SATNM",  "BGTMM",  "INITBGT",
					"CHGBGT","BASICBGT","DEPTNM1"
				}; 

				int[] intArrCN = new int[] { 

					 30, 66, 40,  2, 15,  
					 15, 15, 40

				}; 
			
				int[] intArrCN2 = new int[]{ 

					-1,  -1,  -1,  -1,  0,  
					 0,   0,  -1

				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																									\n");	
						sql.append( " RTRIM(D.CDNAM) DEPTNM,																		\n");
						sql.append( " RTRIM(F.ATKORNAM) ATKORNAM,																\n");
						sql.append( " RTRIM(S.CDNAM)  SATNM,												/*세목*/  				\n");
						sql.append( " RTRIM(A.BGTMM)  BGTMM,												/*예산월*/			\n");
						sql.append( " SUM(A.INITBGT)  INITBGT,											/*신청액*/					\n");
						sql.append( " SUM(A.CHGBGT)   CHGBGT,												/*조정액*/			\n");
						sql.append( " SUM(A.BASICBGT) BASICBGT,											/*배정액-기본*/	\n");
						sql.append( " RTRIM(D.CDNAM)  DEPTNM1												/*부서*/		  		\n");
						sql.append( " FROM ACCOUNT.BGTDTL A																		\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE = F.ATCODE							\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL S ON A.SATCODE=S.CDCODE AND A.FSREFCD=S.CMTYPE /*세목*/	\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.BGTDPT=D.CDCODE AND D.CMTYPE='0003' /*예산부서*/	\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'										\n");	//지점코드 
						if(!str[1].equals("")) sql.append( " AND A.BGTYY   = '"+str[1]+"'										\n");	//예산년도 
						if(!str[2].equals("")) sql.append( " AND A.BGTMM BETWEEN '"+str[2]+"' AND '"+str[3]+"'		\n");	//예산월 
						if(!str[4].equals("")) sql.append( " AND A.BGTDIV  = '"+str[4]+"'										\n");	//예산본부 
						if(!str[5].equals("")) sql.append( " AND A.BGTDPT  = '"+str[5]+"'										\n");	//예산부서 
						if(!str[6].equals("")) sql.append( " AND F.ATKORNAM LIKE '"+str[6]+"%'								\n");	//계정명   
						if(!str[7].equals("")) sql.append( " AND A.ATCODE  = '"+str[7]+"'										\n");	//계정코드 
						if(!str[8].equals("")) sql.append( " AND A.SATCODE = '"+str[8]+"'										\n");	//세세목   
						sql.append( " GROUP BY F.ATKORNAM,S.CDNAM,A.BGTMM,D.CDNAM   							\n");	//D.CDNAM,
						sql.append( " ORDER BY BGTMM,ATKORNAM,SATNM													\n");

						//logger.dbg.println(this, sql.toString());

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