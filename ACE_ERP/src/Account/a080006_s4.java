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
public class a080006_s4 extends HttpServlet {
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
				str[2] = req.getParameter("v_str3");	//예산월fr
				str[3] = req.getParameter("v_str4");	//예산월to
				str[4] = req.getParameter("v_str5");	//예산본부
				str[5] = req.getParameter("v_str6");	//예산부서
				str[6] = req.getParameter("v_str7");	//계정명
				str[7] = req.getParameter("v_str8");	//계정코드
				str[8] = req.getParameter("v_str9");	//세세목
				str[9] = req.getParameter("v_str10");	//전표상태

				for(int i=0;i<=9;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","FSDAT","FSNBR",   "ACTDAT","ATCODE",
					"DEPTNM","COMNM","FSWRKDIV","REMARK","DEAMT", 
					"CRAMT", "FSSTAT"
				}; 

				int[] intArrCN = new int[] { 
					 2,   9,   6,   8,   7,  
					40,  40, 	 2, 132,  15,  
					15,   1
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1, 
					-1,  -1,  -1,	 -1,   0,   
					 0,  -1
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
						sql.append( " RTRIM(A.FDCODE) FDCODE,												\n");
						sql.append( " RTRIM(A.FSDAT)  FSDAT,												\n");
						sql.append( " RTRIM(A.FSNBR)  FSNBR,												\n");
						sql.append( " RTRIM(A.ACTDAT) ACTDAT,	/*회계일자*/					\n");
						sql.append( " RTRIM(A.ATCODE) ATCODE,	/*부서코드*/					\n");
						sql.append( " I.CDNAM AS DEPTNM,			/*부서명*/						\n");
						sql.append( " I2.CDNAM AS COMNM,			/*거래처*/						\n");
						sql.append( " F.FSWRKDIV,							/*예산타입*/					\n");
						sql.append( " F.REMARK,								/*적요*/							\n");
						sql.append( " nvl(A.DEAMT,0) DEAMT,/*차변금액*/					\n");
						sql.append( " nvl(A.CRAMT,0) CRAMT,/*대변금액*/					\n");
						sql.append( " E.FSSTAT								/*전표상태*/					\n");
						sql.append( " FROM ACCOUNT.BGTGELED A    /*예산총계정원장*/	\n");
						sql.append( " LEFT JOIN ACCOUNT.BGTGEREF D ON A.FDCODE=D.FDCODE  /*예산관리항목원장*/				\n");
						sql.append( " 		 AND A.FSDAT =D.FSDAT   AND A.FSNBR=D.FSNBR AND A.FSSEQ=D.FSSEQ						\n");
						sql.append( " LEFT JOIN ACCOUNT.BGTGEREF D2 ON A.FDCODE=D2.FDCODE  /*예산관리항목원장*/			\n");
						sql.append( " 		 AND A.FSDAT =D2.FSDAT   AND A.FSNBR=D2.FSNBR AND A.FSSEQ=D2.FSSEQ				\n");
						sql.append( " LEFT JOIN ACCOUNT.FSLIPMST E ON A.FDCODE=E.FDCODE  /*전표MST*/								\n");
						sql.append( " 		 AND A.FSDAT =E.FSDAT   AND A.FSNBR=E.FSNBR																\n");
						sql.append( " LEFT JOIN ACCOUNT.FSLIPDTL F ON A.FDCODE=F.FDCODE  /*전표DTL*/								\n");
						sql.append( " 		 AND A.FSDAT =F.FSDAT   AND A.FSNBR=F.FSNBR AND A.FSSEQ=F.FSSEQ						\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE  H ON A.ATCODE=H.ATCODE  /*계정과목*/								\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL I ON D.FSREFVAL=I.CDCODE AND I.CMTYPE='0003'				\n");/*세세목*/
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL I2  ON D2.FSREFVAL=I2.CDCODE AND I2.CMTYPE ='0020' \n");/*부서정보*/
						sql.append( " WHERE A.FDCODE IS NOT NULL AND D.FSREFCD ='0003'	AND D2.FSREFCD ='0020'							\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE		= '"+str[0]+"'													\n");/*지점코드*/ 
						if(!str[1].equals("")) sql.append( " AND SUBSTR(A.ACTDAT,1,4)	= '"+str[1]+"'								\n");/*예산년도*/
						if(!str[2].equals("")) sql.append( " AND SUBSTR(A.ACTDAT,5,2)	BETWEEN '"+str[2]+"' AND '"+str[3]+"'	\n");/*예산월*/   
						if(!str[4].equals("")) sql.append( " AND F.BGTDIV		= '"+str[4]+"'													\n");/*예산본부*/
						if(!str[5].equals("")) sql.append( " AND F.DIVCD		= '"+str[5]+"'													\n");/*예산부서*/ 
						if(!str[6].equals("")) sql.append( " AND H.ATKORNAM LIKE '"+str[6]+"%'											\n");/*계정명*/
						if(!str[7].equals("")) sql.append( " AND A.ATCODE		= '"+str[7]+"'													\n");/*계정코드*/ 
						if(!str[8].equals("")) sql.append( " AND I.CDCODE   = '"+str[8]+"'													\n");/*세세목*/
						if(!str[9].equals("")) sql.append( " AND E.FSSTAT	  = '"+str[9]+"'													\n");/*전표상태*/ 						
						sql.append( " ORDER BY FDCODE,FSDAT,FSNBR																										\n");

						//logger.dbg.println(this,sql.toString());
							
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