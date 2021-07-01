package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.//년간월별소득현황
public class a160004_s2 extends HttpServlet {
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
	실제 업무에서 적용하실 부분 - 급여지급현황 조회
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				String [] str = new String [9];
				str[0]	= req.getParameter("v_str3");		//지급년월
				str[1]	= req.getParameter("v_str4");		//지급구분


				for (int s=0;s<1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{
				"EMPNO",	   /* 사번 */
				"EMPNMK",       /*한글명*/
				"PAYDIVNM",	/* 지급구분*/
				"DEPTCD",	/*  부서코드*/
				"DEPTNM",	/*  부서명*/
				"PAYDT",  /*  지급일*/
                "MINORNM",	/*직위*/
				"TMINORNM",  /*근무지*/
				

			    "PAYSUM", //급여총액
				"GP35000", //과세식대
				"BP35000", //비과세식대
                "S91000",//식대차량합계
				"T11000",	/*  소득세 OR 갑근세*/
				"T12000",	/*  주민세*/
				"BXTOTAL", //기타공제계*/
				"S93000",	/*  공제합계*/	
				"S94000",	/*  실지금액*/	
				"MINORCD"       /*지급코드*/
				};

				int[] intArrCN = new int[]{  
					7, 	
					20,
					30,	
					4,	
					50,	
					8,/*지급일*/	

                    30,
                    30,
					9,
					9,
					9,


					9,
					9,
					9,
					9,
					9,
					9,
					4
          }; 

				int[] intArrCN2 = new int[]{
					-1,   
					-1,
					-1,
					-1,
					-1,
					-1,
                    -1,
					-1,	 
					0,
					0,
					0,


					0,
					0,
					0,
					0,
					0,
					0,
					-1   
					}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT  ");
					sql.append( "  A.EMPNO, ");								/* 사번 */
					sql.append( "  A.EMPNMK, ");							/*한글명*/
					sql.append( "  D.MINORNM AS PAYDIVNM, "); /*지급구분*/
					sql.append( "  B.DEPTCD, ");							/* 부서코드 */
					sql.append( "  C.DEPTNM AS DEPTNM, ");		/* 부서명*/
					sql.append( "  E.MINORNM AS MINORNM, ");		/* 직위명*/
					sql.append( "  F.MINORNM AS TMINORNM, ");		/* 근무지*/
					sql.append( "  B.PAYDT, ");		/*  지급일*/
					sql.append( "  H.GP35000, H.BP35000,");		/*  과세 비과세 식대비*/
					sql.append( "COALESCE((B.P10000+B.P11000+B.P12000+B.P21000+B.P22000+B.P23000+P24000+B.P25000+B.P26000+B.P27000+B.P28000+B.P29000+B.P30000+B.P31000+B.P32000+B.P33000+B.P34000+H.GP35000+B.P36000+B.P37000+B.P38000+B.P39000+B.PX0010+B.PX0020+B.PX0030+B.PX0040),0) AS PAYSUM, ");
					sql.append( "COALESCE(B.S91000,0)AS S91000,\n");
					sql.append( "  B.T11000, ");	/*  소득세 OR 갑근세*/
					sql.append( "  B.T12000, ");	/*  주민세*/
					sql.append( "COALESCE((B.P41000+B.P42000+B.T21000+B.T22000+B.T23000+B.B11000+B.B12000+B.B13000+B.B14000+B.B15000+B.B16000+B.BX0010+B.BX0020+B.BX0030+B.BX0040+B.APLAMT+B.APLRAT),0)AS BXTOTAL ,\n");
					sql.append( "  B.S93000,  ");	/*  공제합계*/	
					sql.append( "  B.S94000,  ");	/*  실지급액*/	
					sql.append( "  D.MINORCD ");       /*지급코드*/
					sql.append( " from PAYROLL.T_HIPERSON A, PAYROLL.PBPAY B  ");
					sql.append( " LEFT JOIN (  SELECT   G.EMPNO, G.APPDT, G.PAYDIV, \n");
					sql.append( "					    CASE WHEN G.P35000 > 100000 THEN  (G.P35000 - 100000) ELSE 0 END GP35000 , \n"); //과세식대 , 10만원보다 크면 -10만원한 것이 과세 , 작으면 0이 과세
					sql.append( "					    CASE WHEN G.P35000 >= 100000 THEN  100000 ELSE G.P35000 END BP35000  \n"); //비과세식대 10만원>= 10= 비과세, 더 작으면 식대가 비과세
					sql.append( "        FROM PAYROLL.PBPAY G)H ON A.EMPNO = H.EMPNO AND H.APPDT ='"  + str[0] + "' AND H.PAYDIV ='"+str[1]+"' \n");
                    sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON  B.DEPTCD=C.DEPTCD ");
				    sql.append( " LEFT JOIN PAYROLL.HCLCODE D ON  B.PAYDIV=D.MINORCD AND D.MAJORCD='1120' "); /*지급구분*/
					sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON  B.PAYGRD=E.MINORCD AND E.MAJORCD='2002' "); /*직위*/
                    sql.append( " LEFT JOIN PAYROLL.HCLCODE F ON  C.DEPTGB=F.MINORCD AND F.MAJORCD='2050' "); /*근무지*/
					sql.append( " WHERE A.EMPNO=B.EMPNO ");			
					if (!str[0].equals("")) sql.append( " AND B.APPDT= '"  + str[0] + "' ");  //지급년월
					if (str[1].equals("T")) 
					sql.append( " AND B.PAYDIV IN('T') ");   //지급구분
					sql.append( "  ORDER BY C.TREECD, E.SEQ "); /*지급구분*/
					
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