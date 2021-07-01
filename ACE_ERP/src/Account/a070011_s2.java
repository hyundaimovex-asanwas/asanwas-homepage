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
public class a070011_s2 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//계정명    
				str[2] = req.getParameter("v_str3");	//계정코드  
				str[3] = req.getParameter("v_str4");	//처리구분  
				str[4] = req.getParameter("v_str5");	//은행명    
				str[5] = req.getParameter("v_str6");	//은행코드  
				str[6] = req.getParameter("v_str7");	//차입일자fr
				str[7] = req.getParameter("v_str8");	//차입일자to

				for(int i=0;i<=7;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ATCODE","FUNDDIV","REFCODE2","BANCOD",
					"BANNAM","DRAMT","CRAMT","JANAMT01","STRDATE",
					"ENDDATE","OUTRATE","DRFAMT","CRFAMT","JANAMT02",
					"CURDIV","EXRATE","REMARK","RTNTERM_N","RTNTERM",
					"RTNUNIT","RTNSEQ","RTNDIV","FSTDATE"
				}; 

				int[] intArrCN = new int[] { 
					 2,   7,   2,  30,  6,  
					66,  15,  15,  15,  8,	  
					 8,   5,  15,  15, 15,
					 3,   6, 132,   3,  3,
					 3,   3,   1,   8
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,  
					-1,   0,   0,   0,  -1,  
					-1,   2,   0,   0,  -1,  
					-1,   2,  -1,   0,   0,
					 0,   0,  -1,  -1 
				}; 

				for (int i=0; i<strArrCN.length; i++) {
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																					\n");	
						sql.append( " RTRIM(A.FDCODE)     FDCODE,						/*지점코드*/			\n");
						sql.append( " RTRIM(A.ATCODE)     ATCODE,						/*계정과목*/			\n");
						sql.append( " RTRIM(A.FUNDDIV)    FUNDDIV,					/*자금구분*/				\n");
						sql.append( " RTRIM(A.REFCODE2)   REFCODE2,					/*계좌번호*/			\n");
						sql.append( " RTRIM(A.BANCOD)     BANCOD,						/*은행코드*/			\n");
						sql.append( " RTRIM(D.CDNAM)      BANNAM,						/*은행명*/				\n");
						sql.append( " nvl(A.DRAMT,0)   DRAMT,						/*원화상환*/					\n");
						sql.append( " nvl(A.CRAMT,0)   CRAMT,						/*원화차입*/					\n");
						sql.append( " nvl(A.CRAMT-A.DRAMT,0) JANAMT01,		/*원화잔액*/					\n");
						sql.append( " RTRIM(A.STRDATE)    STRDATE,					/*차입일자*/				\n");
						sql.append( " RTRIM(A.ENDDATE)    ENDDATE,					/*만기일자*/				\n");
						sql.append( " nvl(A.OUTRATE,0) OUTRATE,					/*여신이율*/					\n");
						sql.append( " nvl(A.DRFAMT,0)  DRFAMT,						/*외화상환*/				\n");
						sql.append( " nvl(A.CRFAMT,0)  CRFAMT,						/*외화차입*/				\n");
						sql.append( " nvl(A.CRFAMT-A.DRFAMT,0) JANAMT02, /*외화잔액*/						\n");
						sql.append( " RTRIM(A.CURDIV)	CURDIV, 							/*외화통화*/			\n");
						sql.append( " nvl(A.EXRATE,0)	EXRATE,						/*외화환율*/					\n");
						sql.append( " RTRIM(A.REMARK)	REMARK, 							/*적요*/				\n");
						sql.append( " nvl(B.RTNTERM_N,0) RTNTERM_N,      /*거치기간*/						\n");
						sql.append( " nvl(B.RTNTERM,0) RTNTERM,          /*상환기간*/							\n");
						sql.append( " nvl(B.RTNUNIT,0) RTNUNIT,          /*상환주기*/								\n");
						sql.append( " nvl(B.RTNSEQ,0)  RTNSEQ,           /*상환회차*/							\n");
						sql.append( " RTRIM(B.RTNDIV)   RTNDIV,             /*이자조건*/							\n");
						sql.append( " RTRIM(B.FSTDATE)  FSTDATE             /*최초상환일*/					\n");
						sql.append( " FROM ACCOUNT.AFUNDLDG A													\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE=F.ATCODE			\n");
						sql.append( " LEFT JOIN ACCOUNT.ADBTRTN B ON A.FDCODE=B.FDCODE AND A.ATCODE=B.ATCODE			\n");
						sql.append( "                       AND A.FUNDDIV=B.FUNDDIV AND A.REFCODE2=B.REFCODE2							\n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL D ON A.BANCOD=D.CDCODE AND D.CMTYPE='0022' --은행	\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL    										\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'					\n");	//지점코드
						if(!str[1].equals("")) sql.append( " AND A.ATCODE ='"+str[1]+"'					\n");	//계정코드
						if(!str[2].equals("")) sql.append( " AND F.ATKORNAM LIKE '"+str[2]+"%'			\n");	//계정명
						if(!str[3].equals("")) sql.append( " AND A.STATDIV='"+str[3]+"'						\n");	//처리구분
						if(!str[4].equals("")) sql.append( " AND A.BANCOD='"+str[4]+"'					\n");	//은행코드
						if(!str[5].equals("")) sql.append( " AND D.CDNAM LIKE '"+str[5]+"%'				\n");	//은행명
						if(!str[6].equals("")) sql.append( " AND A.STRDATE BETWEEN '"+str[6]+"'	AND '"+str[7]+"'	\n");	//발행일자
						sql.append( " ORDER BY REFCODE2																			\n");

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