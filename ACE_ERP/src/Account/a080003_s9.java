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
public class a080003_s9 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//승인구분 
				str[2] = req.getParameter("v_str3");	//예산년도
				str[3] = req.getParameter("v_str4");	//예산월fr  
				str[4] = req.getParameter("v_str5");	//예산월fr
				str[5] = req.getParameter("v_str6");	//신청구분 
				str[6] = req.getParameter("v_str7");	//신청부서

				for(int i=0;i<=6;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK","BGTRQNO","FDCODE","BGTYY","BGTMM",
					"BGTDIV","BGTDPT","ATCODE","FSREFCD","SATCODE",
					"BGTRQST","ATKORNAM","SATNAM","DEPTNM",//"BGTRQSEQ",
					"BASICBGT","BGTRQAMT","CHGAMT","BRESULTS","RESULTS",
					"JANAMT"
				}; 

				int[] intArrCN = new int[] { 
				   1,  12,   2,   4,   2,
				   4,   4,   7,   4,   2,
				   1,  66,  40,  40,  // 2,
           15, 15,  15,  15,  15,
					15
				}; 
			
				int[] intArrCN2 = new int[]{ 
				  -1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  //-1,
					 0,   0,   0,   0,   0,
					 0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT																																			 \n");
						sql.append( "   'F' AS CHK,                       /*구분*/																 \n");
						sql.append( "   B.BGTRQNO,                        /*신청서번호*/													 \n");
						sql.append( "   A.FDCODE,                         /*지점*/																 \n");
						sql.append( "   A.BGTYY,                          /*예산년도*/														 \n");
						sql.append( "   A.BGTMM AS BGTMM,                 /*예산월*/															 \n");
						sql.append( "   A.BGTDIV,                         /*신청본부*/														 \n");
						sql.append( "   A.BGTDPT,                         /*신청부서*/														 \n");
						sql.append( "   RTRIM(A.ATCODE)   ATCODE,         /*계정코드*/														 \n");
						sql.append( "   RTRIM(A.FSREFCD)  FSREFCD,        /*관리항목*/														 \n");
						sql.append( "   RTRIM(A.SATCODE)  SATCODE,        /*세목*/																 \n");
						sql.append( "   RTRIM(B.BGTRQST)  BGTRQST,        /*승인구분*/														 \n");
						sql.append( "   RTRIM(F.ATKORNAM) ATKORNAM,       /*계정과목명*/													 \n");
						sql.append( "   RTRIM(E.CDNAM)    SATNAM,         /*세목명*/															 \n");
						sql.append( "   RTRIM(G.CDNAM)    DEPTNM,         /*부서명*/															 \n");
						sql.append( "   COALESCE(A.BASICBGT,0)   BASICBGT,						/*배정액*/									 \n");
						sql.append( "   COALESCE(K.BGTRQAMT,0)   BGTRQAMT,			       /*요청액*/									 \n");
						sql.append( "   COALESCE(A.BASICBGT-SUM(COALESCE(K.BGTRQAMT,0)),0) CHGAMT,/*조정액*/			 \n");
						sql.append( "   COALESCE(A.BRESULTS,0)   BRESULTS,						/*가용사용잔액*/						 \n");
						sql.append( "   COALESCE(A.RESULTS,0)    RESULTS,							/*실적*/										 \n");
						sql.append( "   COALESCE(A.BRESULTS-A.RESULTS,0) JANAMT				/*잔액*/										 \n");
						sql.append( " FROM ACCOUNT.BGTDTL A, ACCOUNT.ACTCODE F /*신청DTL1*/												 \n");
						sql.append( " LEFT JOIN ACCOUNT.BGTRQMST B ON A.FDCODE=B.FDCODE   AND A.BGTYY=B.BGTYY      \n");
						sql.append( "       AND A.BGTDIV=B.BGTDIV  AND A.BGTDPT=B.BGTDPT													 \n");
						sql.append( "       AND A.ATCODE=B.ATCODE  AND A.FSREFCD=B.FSREFCD AND A.SATCODE=B.SATCODE \n");
						sql.append( " LEFT JOIN ACCOUNT.BGTRQDTL1 C ON B.FDCODE=C.FDCODE   AND B.BGTRQNO=C.BGTRQNO \n");
						sql.append( " LEFT JOIN (SELECT K.BGTTOMON,SUM(K.BGTRQAMT) BGTRQAMT,K.FDCODE,K.BGTRQNO     \n");
						sql.append( "						 FROM ACCOUNT.BGTRQDTL1 K																					 \n");
						sql.append( " GROUP BY K.BGTTOMON,K.FDCODE,K.BGTRQNO)																	     \n");
						sql.append( " K ON B.FDCODE=K.FDCODE AND B.BGTRQNO=K.BGTRQNO AND A.BGTMM=K.BGTTOMON				 \n");//요청액
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL  E ON A.SATCODE=E.CDCODE  AND E.CMTYPE='1022'     \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL  G ON A.BGTDPT=G.CDCODE   AND G.CMTYPE='0003'     \n");
						sql.append( " WHERE A.FDCODE IS NOT NULL  AND A.ATCODE=F.ATCODE                                  \n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE   = '"+str[0]+"'												 \n");	//지점코드     
						if(!str[1].equals("")) sql.append( " AND B.BGTRQST  = '"+str[1]+"'												 \n");	//승인구분     
						if(!str[2].equals("")) sql.append( " AND A.BGTYY    = '"+str[2]+"'												 \n");	//예산년도
						if(!str[3].equals("")) sql.append( " AND A.BGTMM BETWEEN '"+str[3]+"'	AND '"+str[4]+"'		 \n");	//예산월fr~to
						if(!str[5].equals("")) sql.append( " AND C.BGTRQDIV = '"+str[5]+"'												 \n");	//신청구분 
						if(!str[6].equals("")) sql.append( " AND A.BGTDPT   = '"+str[6]+"'												 \n");	//신청부서     
						sql.append( " GROUP BY B.BGTRQNO,A.FDCODE,A.BGTYY,A.BGTMM,A.BGTDIV,A.BGTDPT,							 \n");
						sql.append( "          A.ATCODE,A.FSREFCD,A.SATCODE,B.BGTRQST,F.ATKORNAM,E.CDNAM,G.CDNAM	 \n");
						sql.append( "          ,A.BASICBGT,K.BGTRQAMT,A.BRESULTS,A.RESULTS												 \n");
						sql.append( " ORDER BY BGTMM,ATKORNAM,SATNAM,BGTRQNO																			 \n");

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