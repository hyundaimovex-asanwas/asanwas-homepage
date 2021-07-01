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
public class a200001_s2 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//구분
				str[2] = req.getParameter("v_str3");	//수령일자fr
				str[3] = req.getParameter("v_str4");	//수령일자to
				str[4] = req.getParameter("v_str5");	//은행명
				str[5] = req.getParameter("v_str6");	//은행코드
				str[6] = req.getParameter("v_str7");	//처리구분

				for(int i=0;i<=6;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","ATCODE","FUNDDIV","REFCODE2","BCDIV",
					"BANCOD","BANNAM","LOSDATE","LOSPLACE","RTNDATE",
					"RTNPLACE","GETDATE","GETMEN","STDIV","STDATE",
					"UPDT","UPID"
				}; 

				int[] intArrCN = new int[] { 
					 2,   7,   2,  30,   1,
					 6,	 66,   8,  30,   8,  
					30,   8,  20,   1,   8,	  
					 8,  10
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1
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
						sql.append( "  RTRIM(A.FDCODE)   FDCODE,     /*지점코드*/		\n");
						sql.append( "  RTRIM(A.ATCODE)   ATCODE,     /*계정과목*/		\n");
						sql.append( "  RTRIM(A.FUNDDIV)  FUNDDIV,    /*자금구분*/		\n");
						sql.append( "  RTRIM(A.REFCODE2) REFCODE2,   /*어음번호*/		\n");
						sql.append( "  RTRIM(C.BCDIV)    BCDIV,      /*구분*/				\n");
						sql.append( "  RTRIM(C.BANCOD)   BANCOD,     /*은행코드*/		\n");
						sql.append( "  RTRIM(B.CDNAM)    BANNAM,     /*은행명*/			\n");
						sql.append( "  RTRIM(A.LOSDATE)  LOSDATE,    /*분실일자*/		\n");
						sql.append( "  RTRIM(A.LOSPLACE) LOSPLACE,   /*분실장소*/		\n");
						sql.append( "  RTRIM(A.RTNDATE)  RTNDATE,    /*회수일자*/		\n");
						sql.append( "  RTRIM(A.RTNPLACE) RTNPLACE,   /*회수장소*/		\n");
						sql.append( "  RTRIM(C.GETDATE)  GETDATE,    /*수령일자*/		\n");
						sql.append( "  RTRIM(C.GETMEN)   GETMEN,     /*수령인*/			\n");
						sql.append( "  RTRIM(C.STATDIV)  STDIV,      /*처리구분*/		\n");
						sql.append( "  RTRIM(A.UPDT)     UPDT,       /*수정일자*/		\n");
						sql.append( "  RTRIM(A.UPID)     UPID        /*수정자*/			\n");
						sql.append( "  FROM ACCOUNT.ABILLOSS A											\n");
						sql.append( "  LEFT JOIN ACCOUNT.ABILLCHK C ON A.FDCODE=C.FDCODE AND A.ATCODE=C.ATCODE	\n");
						sql.append( "							   AND A.FUNDDIV=C.FUNDDIV AND A.REFCODE2=C.REFCODE2	\n");
						sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL B ON C.BANCOD=B.CDCODE AND B.CMTYPE='0022'		\n");
						sql.append( "  WHERE A.FDCODE IS NOT NULL	  																									\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE ='"+str[0]+"'	\n");	//지점
						if(!str[1].equals("")) sql.append( " AND C.BCDIV  ='"+str[1]+"' \n");	//구분
						if(!str[2].equals("")) sql.append( " AND A.LOSDATE BETWEEN '"+str[2]+"'	AND '"+str[3]+"'\n");	//분실일자
						if(!str[4].equals("")) sql.append( " AND B.CDNAM LIKE '"+str[4]+"%'	\n");	//은행명
						if(!str[5].equals("")) sql.append( " AND C.BANCOD='"+str[5]+"'			\n");	//은행코드
						if(!str[6].equals("")) sql.append( " AND C.STATDIV ='"+str[6]+"'		\n");	//처리구분
						sql.append( " ORDER BY FDCODE,BANNAM																\n");						

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