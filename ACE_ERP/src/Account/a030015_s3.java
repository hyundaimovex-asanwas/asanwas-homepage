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
public class a030015_s3 extends HttpServlet {
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
			  
			  String [] str = new String [8];
				str[0]	= req.getParameter("v_str1");		//지점
				str[1]	= req.getParameter("v_str2");		//계정FR
				str[2]	= req.getParameter("v_str3");		//계정TO
				str[3]	= req.getParameter("v_str4");		//회계일자FR
				str[4]	= req.getParameter("v_str5");		//회계일자TO
				str[5]	= req.getParameter("v_str6");		//거래처FR
				str[6]	= req.getParameter("v_str7");		//거래처TO
				str[7]	= req.getParameter("v_str8");		//정산완료1 미완료0
				
				String whereStr = " AND ";

				for (int s=0;s<=7;s++) {
					if(str[s]==null) str[s] = "";
				}
        

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
						"CHK"				,"FDCODE"		,"FSDAT"	,"FSNBR"	,"FSSEQ"	,
					"ATCODE"		,"ATKORNAM"	,"SSDAT"	,"SSNBR"	,"FSNUM"	,
					"GUBUN"			,"REMARK"		,"CHAAMT"	,"DAEAMT"	,"JANAMT"	,
					"BANJAEAMT"	,"DEPTCD"		,"DEPTNM"	,"VENDCD"	,"VENDNM"	,
					"FSREFCD"		,"FSREFVAL"	,"COCODE"	,"DIVCD"	,"SSNBR1"	,
					"ACTDAT"		,"FSSTAT"		,"ATDECR"	,"REFCD2"	,"REFVAL2",
					"BJANAMT"   ,"TSDAT",   "FSREFNM"
				}; 

				int[] intArrCN = new int[]{
					1,   2,    9,   6,   5, 
					7,   66,   9,   6,   3, 
					10,  132,  15,  15,  15,
					15,  20,   32,  4,   30,
					4,   20,     2,   4, 
					16,  8,    1 ,  
					 1,    4,   30,  
					15,   8,  40
				}; 
				int[] intArrCN2 = new int[]{
					-1, -1, -1, -1, -1,
					-1, -1, -1, -1, -1,
					-1, -1,  0,  0,  0,
					 0, -1, -1, -1, -1,
					-1, -1,  -1, -1, 
					-1 ,-1, -1, 
					 -1, -1, -1, 
					0,  -1, -1
				}; 
				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					
					sql.append(" \n SELECT ''CHK   , N.FDCODE  , N.TSDAT FSDAT, N.TSNBR FSNBR, N.TSSEQ FSSEQ,                  ");
					sql.append(" \n        N.ATCODE, C.ATKORNAM, N.SSDAT      , N.SSNBR      , N.FSNUM      ,                  ");
					sql.append(" \n        CASE WHEN N.STATUS='0' THEN 'N'                                                     ");
					sql.append(" \n             WHEN N.STATUS='1' THEN 'Y'  END  GUBUN, N.REMARK,                              ");
					sql.append(" \n        N.DEAMT CHAAMT, N.CRAMT DAEAMT,                                                     ");
					sql.append(" \n        CASE WHEN C.ATDECR = '1' THEN  COALESCE(N.DEAMT,0)- COALESCE(N.CRAMT,0)             ");
					sql.append(" \n             WHEN C.ATDECR = '2' THEN  COALESCE(N.CRAMT,0)- COALESCE(N.DEAMT,0) END  JANAMT,");
					sql.append(" \n        0 BANJAEAMT, N.VENDCD, E.CDNAM VENDNM, N.DEPTCD  , E2.CDNAM DEPTNM,                 ");
					sql.append(" \n        N.FSREFCD  , N.FSREFVAL, ''COCODE       , ''DIVCD ,                                 ");
					sql.append(" \n        N.SSDAT||'-'||N.SSNBR AS SSNBR1 , SUBSTR(N.SSDAT,2,9) ACTDAT, '' FSSTAT,            ");
					sql.append(" \n        C.ATDECR, N.FSREFCD2 AS REFCD2, N.FSREFVAL2 AS REFVAL2,                             ");
					sql.append(" \n        CASE WHEN C.ATDECR = '1' THEN  COALESCE(N.DEAMT,0)- COALESCE(Z.BJCRAMT,0)           ");
					sql.append(" \n             WHEN C.ATDECR = '2' THEN  COALESCE(N.CRAMT,0)- COALESCE(Z.BJDEAMT,0) END  BJANAMT, ");
					sql.append(" \n        SUBSTR(N.TSDAT,2,9) TSDAT,                                                           								");
					sql.append(" \n        CASE WHEN N.FSREFCD='0967'  THEN N.FSREFVAL ELSE P.CDNAM END AS FSREFNM             ");
					sql.append(" \n FROM ACCOUNT.BANJAEMST N                                              												");
					sql.append(" \n LEFT JOIN ACCOUNT.ACTCODE C ON N.ATCODE = C.ATCODE                    									");					
					sql.append(" \n LEFT JOIN ACCOUNT.COMMDTIL E ON N.VENDCD = E.CDCODE AND E.CMTYPE='0020'                    ");
					sql.append(" \n LEFT JOIN ACCOUNT.COMMDTIL E2 ON N.DEPTCD = E2.CDCODE AND E2.CMTYPE='0002'                 ");
					sql.append(" \n LEFT JOIN (                                                                                												");
					sql.append(" \n            SELECT                                                                          												");
					sql.append(" \n                   A.FDCODE, A.TSDAT, A.TSNBR, A.TSSEQ, SUM(A.BJDEAMT) BJDEAMT,             			");
					sql.append(" \n                   SUM(A.BJCRAMT)BJCRAMT,D.ATCODE                                           							");
					sql.append(" \n            FROM ACCOUNT.BANJAEREL A                                                        								");
					sql.append(" \n            LEFT JOIN ACCOUNT.FSLIPMST B ON A.FDCODE = B.FDCODE AND A.BTSDAT = B.FSDAT AND A.BTSNBR = B.FSNBR ");
					sql.append(" \n            LEFT JOIN ACCOUNT.FSLIPDTL D ON A.FDCODE = D.FDCODE AND A.BTSDAT = D.FSDAT AND A.BTSNBR = D.FSNBR AND A.BTSSEQ = D.FSSEQ ");
					sql.append(" \n            WHERE B.FSSTAT IS NOT NULL                                                              ");
			        if(str[0]!=null && !str[0].equals("")){
			          sql.append(" \n              "+whereStr+"  A.FDCODE ='"+str[0]+"'                                           			");
			          whereStr = " AND ";
			        }
			        if(str[4]!=null && !str[4].equals("")){
			          sql.append(" \n              "+whereStr+"  B.ACTDAT <='"+str[4]+"'                              						"); 			
			          whereStr = " AND ";
			        }
					if(str[1]!=null && str[2]!=null && !str[1].equals("") && !str[2].equals("")){
			          sql.append(" \n              "+whereStr+"  D.ATCODE>='"+str[1]+"' AND D.ATCODE<='"+str[2]+"'  		");
			          whereStr = " AND ";
			        }
		          	sql.append(" \n GROUP BY A.FDCODE, A.TSDAT, A.TSNBR, A.TSSEQ, D.ATCODE                                     ");
		          	sql.append(" \n           ) Z ON N.FDCODE = Z.FDCODE AND N.TSDAT = Z.TSDAT AND N.TSNBR = Z.TSNBR AND N.TSSEQ = Z.TSSEQ ");
					sql.append(" \n LEFT JOIN ACCOUNT.COMMDTIL P ON N.FSREFVAL=P.CDCODE AND N.FSREFCD=P.CMTYPE                 ");
					
					sql.append(" \n WHERE 1 = 1                                                                  							");
					if(str[0]!=null && !str[0].equals("")){
						sql.append(" \n   AND N.FDCODE='"+str[0]+"'                                                                ");
					}
					if(str[1]!=null && str[2]!=null && !str[1].equals("") && !str[2].equals("")){
						sql.append(" \n   AND N.ATCODE>='"+str[1]+"' AND N.ATCODE<='"+str[2]+"'                                    ");
					}
					if(str[3]!=null && str[4]!=null && !str[3].equals("") && !str[4].equals("")){
						//sql.append(" \n   AND SUBSTR(N.SSDAT,2,9) >='"+str[3]+"' AND  SUBSTR(N.SSDAT,2,9)<='"+str[4]+"'            ");
						sql.append(" \n   AND N.SSDAT >='A"+str[3]+"' AND  N.SSDAT<='A"+str[4]+"'            ");
					}
					if(str[5]!=null && str[6]!=null && !str[5].equals("") && !str[6].equals("")){
						sql.append(" \n   AND N.VENDCD>='"+str[5]+"' AND N.VENDCD<='"+str[6]+"'                                    ");
					}
					sql.append(" \n   ORDER BY N.ATCODE, N.FDCODE, FSREFNM, N.TSDAT, SSNBR1, N.TSNBR ,  N.TSSEQ                                ");

					//System.out.println("# Query : " + sql);
					//logger.dbg.println(this,sql.toString());
					
					//System.out.println("a030015_s3 : " + sql.toString());	
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