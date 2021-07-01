package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;

// class 이름은 화일명과 항상 동일해야 함.
public class h050004_s89 extends HttpServlet {

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
				String [] str = new String [2]; 
				str[0]	= req.getParameter("v_str1");		//FROM DT
				str[1]	= req.getParameter("v_str2");		//TO DT 

				for (int s=0;s<=1;s++) {
					if(str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EMPNO",  "EMPNMK", "DEPTCD", "DEPTNMK",
					                                "F_CLODAY", "F_CLOTIME",
					                                "T_ATTDAY", "T_ATTTIME", "T_CLODAY", "T_CLOTIME",
					                                "S_ATTDAY", "S_ATTTIME", "S_CLODAY", "S_CLOTIME",
					                                "M_ATTDAY", "M_ATTTIME",
					                                "ETC"	};

				int[] intArrCN = new int[]{  7, 20, 4, 30,
					                           8,  6, 
					                           8,  6, 8,  6,
					                           8,  6, 8,  6,
					                           8,  6, 
				                             30 }; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1,
					                           -1, -1, 
					                           -1, -1, -1, -1,
					                           -1, -1, -1, -1,
					                           -1, -1,
					                           -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 


        ///////////////////////////////////////////////////
				int yyyy = Integer.parseInt(str[0].substring(0,4));
				int mm = Integer.parseInt(str[0].substring(4,6))-1; //month의 경우 해당월수-1을 해줍니다. 
				int dd = Integer.parseInt(str[0].substring(6,8));

				String t_Dt="";  //토
				String t_yyyy="";
				String t_mm="";
				String t_dd="";

				Calendar cal2 = Calendar.getInstance ( ); 
				cal2.set ( yyyy, mm, dd );     // 기준일로 설정. 
				cal2.add ( Calendar.DATE, 1 ); // 1일 증가

				yyyy = cal2.get ( Calendar.YEAR );
				mm = cal2.get ( Calendar.MONTH ) + 1;
				dd = cal2.get ( Calendar.DATE );

				t_yyyy = String.valueOf(yyyy);
				if(mm<10) t_mm = "0"+ String.valueOf(mm);
				else t_mm = String.valueOf(mm);
				if(dd<10) t_dd = "0"+ String.valueOf(dd);
				else t_dd = String.valueOf(dd);
				t_Dt=t_yyyy+t_mm+t_dd;
     
        ///////////////////////////////////////////////////
				String s_Dt="";  //일
				String s_yyyy="";
				String s_mm="";
				String s_dd="";

				yyyy = Integer.parseInt(str[0].substring(0,4));
				mm = Integer.parseInt(str[0].substring(4,6))-1; //month의 경우 해당월수-1을 해줍니다. 
				dd = Integer.parseInt(str[0].substring(6,8));

				Calendar cal3 = Calendar.getInstance ( ); 
				cal3.set ( yyyy, mm, dd );     // 기준일로 설정. 
				cal3.add ( Calendar.DATE, 2 ); // 2일증가로 바뀜

				yyyy = cal3.get ( Calendar.YEAR );
				mm = cal3.get ( Calendar.MONTH ) + 1;
				dd = cal3.get ( Calendar.DATE );

				s_yyyy = String.valueOf(yyyy);
				if(mm<10) s_mm = "0"+ String.valueOf(mm);
				else s_mm = String.valueOf(mm);
				if(dd<10) s_dd = "0"+ String.valueOf(dd);
				else s_dd = String.valueOf(dd);
				s_Dt=s_yyyy+s_mm+s_dd;	
       
				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT X.EMPNO,                                                                                                     \n ");
					sql.append( "        RTRIM(MAX(CASE WHEN RTRIM(B.EMPNMK)=''OR B.EMPNMK IS NULL THEN C.EMPNMK ELSE B.EMPNMK END)) EMPNMK,          \n ");
					sql.append( "        MAX(CASE WHEN RTRIM(B.DEPTCD)=''OR B.DEPTCD IS NULL THEN C.DEPTCD ELSE B.DEPTCD END) DEPTCD,                 \n ");
					sql.append( "        RTRIM(MAX(CASE WHEN RTRIM(D.DEPTNMK)=''OR D.DEPTNMK IS NULL THEN E.DEPTNMK ELSE D.DEPTNMK END)) DEPTNMK,     \n ");
					sql.append( "        MAX(X.F_CLODAY)F_CLODAY, MAX(X.F_CLOTIME)F_CLOTIME,                                                          \n ");
					sql.append( "        MAX(X.T_ATTDAY)T_ATTDAY, MAX(X.T_ATTTIME)T_ATTTIME,MAX(X.T_CLODAY)T_CLODAY, MAX(X.T_CLOTIME)T_CLOTIME,       \n ");
					sql.append( "        MAX(X.S_ATTDAY)S_ATTDAY, MAX(X.S_ATTTIME)S_ATTTIME,MAX(X.S_CLODAY)S_CLODAY, MAX(X.S_CLOTIME)S_CLOTIME,       \n ");
					sql.append( "        MAX(X.M_ATTDAY)M_ATTDAY, MAX(X.M_ATTTIME)M_ATTTIME,                                                          \n ");
					sql.append( "        MIN(CASE WHEN RTRIM(G.MINORNM)=''OR G.MINORNM IS NULL THEN X.ETC ELSE G.MINORNM END) ETC                     \n ");
					sql.append( " FROM(                                                                                                               \n ");
					sql.append( " 		--금퇴근                                                                                                        \n ");
					sql.append( " 		SELECT EMPNO,                                                                                                   \n ");
					sql.append( " 					 '' F_ATTDAY, '' F_ATTTIME, CLODAY AS F_CLODAY, CLOTIME AS F_CLOTIME,                                     \n ");
					sql.append( " 					 '' T_ATTDAY, '' T_ATTTIME, '' AS T_CLODAY, '' AS T_CLOTIME,                                              \n ");
					sql.append( " 					 '' S_ATTDAY, '' S_ATTTIME, '' AS S_CLODAY, '' AS S_CLOTIME,                                              \n ");
					sql.append( " 					 '' M_ATTDAY, '' M_ATTTIME, '' AS M_CLODAY, '' AS M_CLOTIME,                                              \n ");
					sql.append( " 					 ''ETC                                                                                                    \n ");
					sql.append( " 			FROM PAYROLL.HLATTEND                                                                                         \n ");
					sql.append( " 		 WHERE ATTDAY ='"+str[0]+"'                                                                                     \n ");
					sql.append( " 		UNION ALL                                                                                                       \n ");
					sql.append( " 		--토                                                                                                            \n ");
					sql.append( " 		SELECT EMPNO,                                                                                                   \n ");
					sql.append( " 					 '' F_ATTDAY, '' F_ATTTIME, '' AS F_CLODAY, '' AS F_CLOTIME,                                              \n ");
					sql.append( " 					 ATTDAY T_ATTDAY, ATTTIME T_ATTTIME, CLODAY AS T_CLODAY, CLOTIME AS T_CLOTIME,                            \n ");
					sql.append( " 					 '' S_ATTDAY, '' S_ATTTIME, '' AS S_CLODAY, '' AS S_CLOTIME,                                              \n ");
					sql.append( " 					 '' M_ATTDAY, '' M_ATTTIME, '' AS M_CLODAY, '' AS M_CLOTIME,                                              \n ");
					sql.append( " 					 ''ETC                                                                                                    \n ");
					sql.append( " 			FROM PAYROLL.HLATTEND                                                                                         \n ");
					sql.append( " 		 WHERE ATTDAY ='"+t_Dt+"'                                                                                       \n ");
					sql.append( " 		UNION ALL                                                                                                       \n ");
					sql.append( " 		--일                                                                                                            \n ");
					sql.append( " 		SELECT EMPNO,                                                                                                   \n ");
					sql.append( " 					 '' F_ATTDAY, '' F_ATTTIME, '' AS F_CLODAY, '' AS F_CLOTIME,                                              \n ");
					sql.append( " 					 '' T_ATTDAY, '' T_ATTTIME, '' AS T_CLODAY, '' AS T_CLOTIME,                                              \n ");
					sql.append( " 					 ATTDAY S_ATTDAY, ATTTIME S_ATTTIME, CLODAY AS S_CLODAY, CLOTIME AS S_CLOTIME,                            \n ");
					sql.append( " 					 '' M_ATTDAY, '' M_ATTTIME, '' AS M_CLODAY, '' AS M_CLOTIME,                                              \n ");
					sql.append( " 					 ''ETC                                                                                                    \n ");
					sql.append( " 			FROM PAYROLL.HLATTEND                                                                                         \n ");
					sql.append( " 		 WHERE ATTDAY ='"+s_Dt+"'                                                                                       \n ");
					sql.append( " 		UNION ALL                                                                                                       \n ");
					sql.append( " 		--월출근                                                                                                        \n ");
					sql.append( " 		SELECT EMPNO,                                                                                                   \n ");
					sql.append( " 					 '' F_ATTDAY, '' F_ATTTIME, '' AS F_CLODAY, '' AS F_CLOTIME,                                              \n ");
					sql.append( " 					 '' T_ATTDAY, '' T_ATTTIME, '' AS T_CLODAY, '' AS T_CLOTIME,                                              \n ");
					sql.append( " 					 '' S_ATTDAY, '' S_ATTTIME, '' AS S_CLODAY, '' AS S_CLOTIME,                                              \n ");
					sql.append( " 					 ATTDAY M_ATTDAY, ATTTIME M_ATTTIME, '' AS M_CLODAY, '' AS M_CLOTIME,                                     \n ");
					sql.append( " 					 ETC                                                                                                      \n ");
					sql.append( " 			FROM PAYROLL.HLATTEND                                                                                         \n ");
					sql.append( " 		 WHERE ATTDAY ='"+str[1]+"'                                                                                     \n ");
					sql.append( " 	)X                                                                                                                \n ");
					sql.append( " LEFT JOIN PAYROLL.HIPERSON B ON X.EMPNO = B.EMPNO                                                                   \n ");
					sql.append( " LEFT JOIN PAYROLL.T_HIPERSON C ON X.EMPNO = C.EMPNO                                                                 \n ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT   D ON B.DEPTCD = D.DEPTCD  AND D.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)          \n ");
					sql.append( " LEFT JOIN PAYROLL.HCDEPT   E ON C.DEPTCD = E.DEPTCD  AND E.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)          \n ");
					sql.append( " LEFT JOIN PAYROLL.HLDUTYC07 H ON X.EMPNO  = H.EMPNO  AND X.M_ATTDAY = H.USEDT                                       \n ");
					sql.append( " LEFT JOIN PAYROLL.HCLCODE   G ON H.CODE  = G.MINORCD AND G.MAJORCD ='1124'                                          \n ");
					sql.append( " GROUP BY X.EMPNO                                                                                                    \n ");
					sql.append( " ORDER BY X.EMPNO                                                                                                    \n ");
					
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