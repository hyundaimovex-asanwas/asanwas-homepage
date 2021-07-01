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
public class a080003_s2 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//신청서번호
				str[2] = req.getParameter("v_str3");	//예산년도
				str[3] = req.getParameter("v_str4");	//예산월
				str[4] = req.getParameter("v_str5");	//예산본부
				str[5] = req.getParameter("v_str6");	//예산부서
				str[6] = req.getParameter("v_str7");	//계정과목
				str[7] = req.getParameter("v_str8");	//관리항목
				str[8] = req.getParameter("v_str9");	//세세목
				str[9] = req.getParameter("v_str10");	//예산타입

				for(int i=0;i<=9;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","BGTRQNO","BGTRQSEQ","BGTRQDIV","BGTRQAMT",
					"BGTTOMON","BGTFRMON","DVTFRACT",
					//"FSREFCD",
					"DVTFRSATCD","WHYRQNOTE","BGTRQST","ATKORNAM","CDNAM","JANAMT",
					"CHK","BGTFRDEPT","BGTDEPTNM"
				}; 

				int[] intArrCN = new int[] { 
					 2,  12,   2,   2,  15,   
					 2,		2,   7,   
					 //4,   
					 2,  60,	 1,   66,  40,  15,
					 1,   4,   66
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,   0,
					-1,  -1,  -1,  
					//-1,  
					-1,	 -1,  -1,  -1,  -1,   0,
					-1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																				\n");	
						sql.append( " 	RTRIM(A.FDCODE)     FDCODE,        /*지점코드*/					\n");
						sql.append( " 	RTRIM(A.BGTRQNO)    BGTRQNO,       /*신청서번호*/				\n");
						sql.append( " 	RTRIM(A.BGTRQSEQ)   BGTRQSEQ,      /*순번*/						\n");
						sql.append( " 	RTRIM(A.BGTRQDIV)   BGTRQDIV,      /*신청구분*/					\n");
						sql.append( " 	COALESCE(A.BGTRQAMT,0) BGTRQAMT,   /*신청금액*/			\n");
						sql.append( " 	RTRIM(A.BGTTOMON)   BGTTOMON,      /*배정월*/					\n");
						sql.append( " 	RTRIM(A.BGTFRMON)   BGTFRMON,      /*피전용월*/				\n");
						sql.append( " 	RTRIM(A.DVTFRACT)   DVTFRACT,      /*피전용계정*/				\n");
						sql.append( " 	RTRIM(A.DVTFRSATCD) DVTFRSATCD,    /*피전용세목*/			\n");
						sql.append( " 	RTRIM(A.WHYRQNOTE)  WHYRQNOTE,     /*신청사유*/				\n");
						sql.append( "		RTRIM(A.BGTRQST)    BGTRQST,       /*승인상태*/         		\n");
						sql.append( "   RTRIM(M.ATKORNAM)   ATKORNAM,      /*계정명*/	     			\n");
						sql.append( "   RTRIM(E.CDNAM)      CDNAM,         /*피전용세목명*/				\n");
						sql.append( "   0 AS JANAMT,																       	\n");
						sql.append( "   'F' AS CHK, 															       		\n");	
						sql.append( "   RTRIM(A.BGTFRDEPT)  BGTFRDEPT,     /*피전용부서*/      		\n");	
						sql.append( "   RTRIM(H.CDNAM)      BGTDEPTNM      /*피전용부서명*/     		\n");	
						sql.append( " FROM ACCOUNT.BGTRQDTL1 A   /*신청DTL1*/							\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTREFCODE  F ON A.DVTFRACT= F.ATCODE AND F.TYPE='B'					\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON A.DVTFRSATCD = E.CDCODE AND E.CMTYPE=F.CDCODE	\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL H ON A.BGTFRDEPT   = H.CDCODE AND H.CMTYPE='0003'		\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE  M ON A.DVTFRACT= M.ATCODE						\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																	\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'											\n");	//지점코드
						if(!str[1].equals("")) sql.append( " AND A.BGTRQNO = '"+str[1]+"'										\n");	//신청서번호
						sql.append( " ORDER BY FDCODE,BGTRQNO,BGTRQSEQ													\n");

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