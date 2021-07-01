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
public class trusttake_popup_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//계정코드
				str[2] = req.getParameter("v_str3");	//자금구분
				str[3] = req.getParameter("v_str4");	//어음번호

				for(int i=0;i<=3;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ATCODE","FUNDDIV","REFCODE2","STRDATE",
					"BANCOD","ORDDATE","ORDAMT","SLIPYN","DRAMT",
					"STRDATE2","ENDDATE","VEND_CD","VEND_NM","BANNAM"
				}; 

				int[] intArrCN = new int[] { 
					 2,   7,   2,  30,   8,
					 6,	  8,  15,   1,  15,  
					 8,   8,	13,  66,  66
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,   0,  -1,   0,  
					-1,  -1,  -1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT                                             	  \n");	
						sql.append( "  RTRIM(A.FDCODE)      FDCODE,     /*지점코드*/      	\n");
						sql.append( "  RTRIM(A.ATCODE)      ATCODE,     /*계정과목*/      	\n");
						sql.append( "  RTRIM(A.FUNDDIV)     FUNDDIV,    /*자금구분*/      	\n");
						sql.append( "  RTRIM(A.REFCODE2)    REFCODE2,   /*어음번호*/      	\n");
						sql.append( "  RTRIM(A.STRDATE)     STRDATE,    /*수탁일자*/      	\n");
						sql.append( "  RTRIM(A.BANCOD)      BANCOD,     /*수탁은행*/      	\n");
						sql.append( "  RTRIM(A.ORDDATE)     ORDDATE,    /*추심일자*/      	\n");
						sql.append( "  COALESCE(A.ORDAMT,0) ORDAMT,		  /*추심료*/        	\n");
						sql.append( "  RTRIM(A.SLIPYN)      SLIPYN,		  /*기표구분*/        \n");
						sql.append( "  COALESCE(B.DRAMT,0)  DRAMT,      /*(발행)차변금액*/	\n");
						sql.append( "  RTRIM(B.STRDATE)     STRDATE2,   /*발행일자*/      	\n");
						sql.append( "  RTRIM(B.ENDDATE)     ENDDATE,    /*만기일자*/      	\n");
						sql.append( "  RTRIM(B.VEND_CD)     VEND_CD,    /*거래처*/        	\n");
						sql.append( "  RTRIM(C.CDNAM)       VEND_NM,    /*거래처명*/      	\n");
						sql.append( "  RTRIM(D.CDNAM)       BANNAM      /*수탁은행*/      	\n");
						sql.append( "  FROM ACCOUNT.ABINSUT A                            	  \n");
						sql.append( "  LEFT JOIN ACCOUNT.AFUNDLDG B ON A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE	\n");
						sql.append( " 	                      AND A.FUNDDIV=B.FUNDDIV AND A.REFCODE2=B.REFCODE2	\n");
						sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL C ON B.VEND_CD=C.CDCODE AND C.CMTYPE='0020'		\n");
						sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL D ON A.BANCOD=D.CDCODE  AND D.CMTYPE='0022'		\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE   ='"+str[0]+"'	\n");	//지점코드
						if(!str[1].equals("")) sql.append( " AND A.ATCODE   ='"+str[1]+"'	\n");	//계정코드
						if(!str[2].equals("")) sql.append( " AND A.FUNDDIV  ='"+str[2]+"'	\n");	//자금구분
						if(!str[3].equals("")) sql.append( " AND A.REFCODE2 ='"+str[3]+"'	\n");	//어음번호
						sql.append( " ORDER BY REFCODE2																		\n");

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