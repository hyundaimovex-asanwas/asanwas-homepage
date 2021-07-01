package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.//년간월별소득현황
public class h100009_s9 extends HttpServlet {

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
	실제 업무에서 적용하실 부분 - 급여지급현황 조회
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [7];
				str[0]	= req.getParameter("v_str1");		//지급년월
				str[1]	= req.getParameter("v_str2");		//지급년월까지
				str[2]	= req.getParameter("v_str3");		//지급구분
				str[3]	= req.getParameter("v_str4");		//재직구분
				str[4]	= req.getParameter("v_str5");		//level 
				str[5]	= req.getParameter("v_str6");		//treecd
				str[6]	= req.getParameter("v_str7");		//직위

				for (int s=0;s<=6;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
						"DEPTNM","PAYGNM","EMPNO","EMPNMK","RESINO",
						"STRTDT","PAYDIVNM","PAYDT","P10000","P11000",
						"P12000","P21000","P22000","P23000","P24000",
						"P25000","P26000","P27000","P28000","P29000",
						"P30000","P31000","P32000","P36000","P37000",
						"P38000","P34000","P35000","P39000","PX0010",
						"PX0020","PX0030","PX0040","S91000","T11000",
						"T12000","B11000","B12000","B13000","B15000",
						"B14000","B16000","B17000","BX0010","BX0020",
						"BX0030","BX0040","P41000","P42000","T21000",
						"T22000","S93000","S94000","SEQ"   ,"TREECD" 
				};

				int[] intArrCN = new int[]{  
					 30, 30,  7, 20, 13,
						8, 30,  8,  9,  9,
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9,
						9,  9,  9,  9,  9,
						9,  9,  9,  4,  8      
          }; 

				int[] intArrCN2 = new int[]{
					 -1, -1, -1, -1, -1,
					 -1, -1, -1,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0,  0,
					  0,  0,  0,  0, -1	      
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT DISTINCT		                              							\n");
					sql.append( " RTRIM(C.DEPTNM) DEPTNM,						--부서명										\n");
					sql.append( " RTRIM(E.MINORNM) PAYGNM,					--직위명										\n");
					sql.append( " A.EMPNO,													--사번											\n");
					sql.append( " RTRIM(A.EMPNMK) EMPNMK,						--성명											\n");
					sql.append( " A.RESINO,													--주민번호									\n");
					sql.append( " A.STRTDT,													--입사일										\n");
					sql.append( " RTRIM(D.MINORNM) PAYDIVNM,				--지급구분[1:정기,5:상여]   \n");
					sql.append( " B.PAYDT,													--지급일										\n");
					sql.append( " SUM(B.P10000) P10000,							--기본급										\n");
					sql.append( " SUM(B.P11000) P11000,             --직책수당									\n");
					sql.append( " SUM(B.P12000) P12000,             --시간외수당		            \n");
					sql.append( " SUM(B.P21000) P21000,             --근속수당									\n");
					sql.append( " SUM(B.P22000) P22000,             --자기계발비		            \n");
					sql.append( " SUM(B.P23000) P23000,             --부양가족수당	            \n");
					sql.append( " SUM(B.P24000) P24000,             --차량유지비		            \n");
					sql.append( " SUM(B.P25000) P25000,             --출납수당									\n");
					sql.append( " SUM(B.P26000) P26000,             --운전수당									\n");
					sql.append( " SUM(B.P27000) P27000,             --연장수당									\n");
					sql.append( " SUM(B.P28000) P28000,             --자격수당									\n");
					sql.append( " SUM(B.P29000) P29000,             --남북경협수당	            \n");
					sql.append( " SUM(B.P30000) P30000,             --사장단수당		            \n");
					sql.append( " SUM(B.P31000) P31000,             --특수지수당		            \n");
					sql.append( " SUM(B.P32000) P32000,             --지역근무수당	            \n");
					sql.append( " SUM(B.P36000) P36000,             --학비보조금		            \n");
					sql.append( " SUM(B.P37000) P37000,             --개인연금보조금	          \n");
					sql.append( " SUM(B.P38000) P38000,             --임원직책수당	            \n");
					sql.append( " SUM(B.P34000) P34000,             --년차수당		              \n");
					sql.append( " SUM(B.P35000) P35000,             --식대보조		              \n");
					sql.append( " SUM(B.P39000) P39000,             --전월소급		              \n");
					sql.append( " SUM(B.PX0010) PX0010,             --휴일수당		              \n");
					sql.append( " SUM(B.PX0020) PX0020,             --기타지급1		              \n");
					sql.append( " SUM(B.PX0030) PX0030,             --기타지급2		              \n");
					sql.append( " SUM(B.PX0040) PX0040,             --기타지급3		              \n");
					sql.append( " SUM(B.S91000) S91000,             --지급합계		              \n");
					sql.append( " SUM(B.T11000) T11000,             --소득세		                \n");
					sql.append( " SUM(B.T12000) T12000,             --주민세		                \n");
					sql.append( " SUM(B.B11000) B11000,             --건강보험료		            \n");
					sql.append( " SUM(B.B12000) B12000,             --국민연금		              \n");
					sql.append( " SUM(B.B13000) B13000,             --고용보험		              \n");
					sql.append( " SUM(B.B15000) B15000,             --개인연금		              \n");
					sql.append( " SUM(B.B14000) B14000,             --여직원회비		            \n");
					sql.append( " SUM(B.B16000) B16000,             --공조회비		              \n");
					sql.append( " SUM(B.B17000) B17000,             --산재보험		              \n");
					sql.append( " SUM(B.BX0010) BX0010,             --보증보험		              \n");
					sql.append( " SUM(B.BX0020) BX0020,             --기타공제1		              \n");
					sql.append( " SUM(B.BX0030) BX0030,             --기타공제2		              \n");
					sql.append( " SUM(B.BX0040) BX0040,             --기타공제3		              \n");
					sql.append( " SUM(B.P41000) P41000,             --정산건강		              \n");
					sql.append( " SUM(B.P42000) P42000,             --정산고용		              \n");
					sql.append( " SUM(B.T21000) T21000,             --정산소득		              \n");
					sql.append( " SUM(B.T22000) T22000,             --정산주민		              \n");
					sql.append( " SUM(B.S93000) S93000,             --공제합계		              \n");
					sql.append( " SUM(B.S94000) S94000,             --실지급액		              \n");
					sql.append( " E.SEQ,C.TREECD										--직위순서,조직도						\n");
					sql.append( " from PAYROLL.T_HIPERSON A,				--기본정보		              \n");
					sql.append( " PAYROLL.PBPAY B,									--급여지급내역	            \n");
					sql.append( " PAYROLL.HCDEPT C,									--부서정보		              \n");
					sql.append( " PAYROLL.HCLCODE D,								--하위코드정보[지급구분]    \n");
					sql.append( " PAYROLL.HCLCODE E									--하위코드정보[재직구분]    \n");
					sql.append( " WHERE A.EMPNO=B.EMPNO																					\n");
					sql.append( " AND B.DEPTCD=C.DEPTCD																					\n");
					sql.append( " AND B.PAYDIV = D.MINORCD																			\n");
					sql.append( " AND B.PAYGRD = E.MINORCD																			\n");
					sql.append( " AND D.MAJORCD = '1120'						--지급구분									\n");
					sql.append( " AND E.MAJORCD = '2002'						--직위코드									\n");

					if (!str[2].equals("")&&!str[2].equals("0")) sql.append( " AND B.PAYDIV= '"  + str[2] + "' \n");		  //지급구분
					if (!str[2].equals("")&&!str[2].equals("T")) sql.append( " AND B.PAYDIV= 'T' \n");		  //지급구분

					if (!str[3].equals("")&&!str[3].equals("0")) sql.append( " AND A.USESTS = '" + str[3]+ "'  \n");			//재직구분

					if (str[4].equals("1")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[5] + "'");		//소속
					if (str[4].equals("2")) sql.append( " AND SUBSTR(C.TREECD,1,4)= '" + str[5] + "'");
					if (str[4].equals("3")) sql.append( " AND SUBSTR(C.TREECD,1,6)= '" + str[5] +"'");
					if (str[4].equals("4")) sql.append( " AND RTRIM(C.TREECD)= '" + str[5] + "'");
					
					if (!str[6].equals("")&&!str[6].equals("0")) sql.append( " AND B.PAYGRD = '" + str[6]+ "'  \n");			//직위

					sql.append( " GROUP BY C.DEPTNM,E.MINORNM,A.EMPNO,A.EMPNMK,A.RESINO,A.STRTDT,D.MINORNM,B.PAYDT,E.SEQ,C.TREECD  \n");
					
					if (!str[0].equals("")&&!str[0].equals("0") && (!str[1].equals("")&&!str[1].equals("0")) )
					sql.append( " HAVING SUBSTR(B.PAYDT,1,6) BETWEEN '"  + str[0] + "' AND '"  + str[1] + "' \n");			//지급일자[FR~TO]
					
					sql.append( " ORDER BY TREECD, SEQ, PAYDIVNM, PAYDT \n"); 
					
					logger.dbg.println(this,sql.toString());

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