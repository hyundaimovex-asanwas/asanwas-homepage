package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class p030006_s1 extends HttpServlet {

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
				String [] str = new String [10];
				str[0]	= req.getParameter("v_str1");		//적용년
				str[1]	= req.getParameter("v_str2");		//사번


	/*	gcds_data.DataID = "/services/servlet/Payroll.p030006_s3";
		gcds_data.Reset();

		var str1 = gcem_curdt.text;		//정산년월
		var str2 = txt_empnno1.value;	//사번
		
		gcds_data02.DataID = "/services/servlet/Payroll.p030006_s1?v_str1="+gs_date+"&v_str2="+str2;
		gcds_data02.Reset();

*/

				for (int s=0;s<=1;s++) {
					if (str[s]==null) str[s] = "";
				}

				GauceRes.enableFirstRow(dSet);
				String[] strArrCN = new String[]{
					"EMPNO","EMPNMK","RESINO","DEPTNM",//"PAYGNM",
					"PC11000","PC12000",
					"PBC1000","TWKSUM","PC21000","PC22000","PB20000",
					"PB30000","BAAMT01","BAAMT02","CNT01","BAAMT03",
					"CNT02","ADAMT01","AD0103CNT","ADAMT02","ADAMT03",
					"AD0105CNT","ADAMT04","ADAMT05","PENSUM","INSSUM",
					"EDUSUM","HOUSUM","CONSUM","MARSUM","STDSUM",
					"OFFSUM","ETCAMT011","ETCAMT01","ETCAMT02","ETCAMT03",
					"ETCAMT04","TSTDSUM","STDTAX","DEDAMT01","DEDAMT02",
					"DEDAMT03","DEDAMT05","DEDSUM","PB41000","PB42000",
					"PB43000","APPDT"		//46
				};

				int[] intArrCN = new int[]{  
						7,	//사번
					 20,	//성명
					 13,	//주민번호
					 30,	//부서명
					 //30,	//직위
						9,	//현근무급여		
						9,	//현근무상여		
						9,	//급여총계		
						9,	//합계(현+종)		
						9,	//야근근로소득		
						9,	//기타비과세		
						9,	//근로소득공제		
						9,	//근로소득금액		
						9,	//본인공제		
						9,	//배우자공제		
						9,	//부양가족인원	        
						9,	//부양가족공제		
						9,	//경로우대인원		
						9,	//경로우대공제		
						9,	//장애인인원		
						9,	//장애인우대공제	
						9,	//부녀자공제		
						9,	//자녀양육비인원	
						9,	//자녀양육비공제	
						9,	//소수공제자추가공제	
						9,	//연금보험료공제	
						9,	//보험료공제		
						9,	//교육비공제		
						9,	//주택자금공제		
						9,	//기부금공제		
						9,	//혼인이사장례비	
						9,	//표준공제		
						9,	//차감소득		
						9,	//개인연금저축소득공제	
						9,	//연금저축공제		
						9,	//투자조합공제		
						9,	//신용카드공제		
						9,	//우리사주공제		
						9,	//종합소득과세표준	
						9,	//산출세액		
						9,	//근로소득세액공제	
						9,	//납세조합공제		
						9,	//주택차입금		
						9,	//외국납부		
						9,	//세액공제계		
						9,	//결정소득세		
						9,	//결정주민세		
						9,		//결정농특세
						6
         }; 
				
				int[] intArrCN2 = new int[]{ 
					 -1,	//사번
				 	 -1,	//성명
					 -1,	//주민번호
					 -1,	//부서명
					 //-1,  //직위
						0,	//현근무급여		
						0,	//현근무상여		
						0,	//급여총계		
						0,	//합계(현+종)		
						0,	//야근근로소득		
						0,	//기타비과세		
						0,	//근로소득공제		
						0,	//근로소득금액		
						0,	//본인공제		
						0,	//배우자공제		
						0,	//부양가족인원	        
						0,	//부양가족공제		
						0,	//경로우대인원		
						0,	//경로우대공제		
						0,	//장애인인원		
						0,	//장애인우대공제	
						0,	//부녀자공제		
						0,	//자녀양육비인원	
						0,	//자녀양육비공제	
						0,	//소수공제자추가공제	
						0,	//연금보험료공제	
						0,	//보험료공제		
						0,	//교육비공제		
						0,	//주택자금공제		
						0,	//기부금공제		
						0,	//혼인이사장례비	
						0,	//표준공제		
						0,	//차감소득		
						0,	//개인연금저축소득공제	
						0,	//연금저축공제		
						0,	//투자조합공제		
						0,	//신용카드공제		
						0,	//우리사주공제		
						0,	//종합소득과세표준	
						0,	//산출세액		
						0,	//근로소득세액공제	
						0,	//납세조합공제		
						0,	//주택차입금		
						0,	//외국납부		
						0,	//세액공제계		
						0,	//결정소득세		
						0,	//결정주민세		
						0,	//결정농특세
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
						sql.append(" SELECT																\n");
						sql.append(" B.EMPNO,															\n");
						sql.append(" A.EMPNMK,														\n");
						sql.append(" B.RESINO,														\n");
						sql.append(" RTRIM(C.DEPTNM) DEPTNM,		--부서명	\n");
						//sql.append(" RTRIM(D.MINORNM) PAYGNM,		--직위		\n");
						sql.append(" B.PC11000,   --현근무급여						\n");
						sql.append(" B.PC12000,   --현근무상여						\n");
						sql.append(" B.PBC1000,   --급여총계							\n");
						sql.append(" B.TWKSUM,    --합계(현+종)						\n");
						sql.append(" B.PC21000,   --야근근로소득					\n");
						sql.append(" B.PC22000,   --기타비과세						\n");
						sql.append(" B.PB20000,   --근로소득공제					\n");
						sql.append(" B.PB30000,   --근로소득금액					\n");
						sql.append(" B.BAAMT01,   --본인공제							\n");
						sql.append(" B.BAAMT02,   --배우자공제						\n");
						sql.append(" B.BA0102CNT+B.BA0103CNT+B.BA0104CNT+B.BA0105CNT AS CNT01, --부양가족인원	\n");
						sql.append(" B.BAAMT03,   --부양가족공제					\n");
						sql.append(" B.AD0101CNT+B.AD0102CNT AS CNT02,  --경로우대인원	\n");
						sql.append(" B.ADAMT01,   --경로우대공제					\n");
						sql.append(" B.AD0103CNT, --장애인인원						\n");
						sql.append(" B.ADAMT02,   --장애인우대공제				\n");
						sql.append(" B.ADAMT03,   --부녀자공제						\n");
						sql.append(" B.AD0105CNT, --자녀양육비인원				\n");
						sql.append(" B.ADAMT04,   --자녀양육비공제				\n");
						sql.append(" B.ADAMT05,   --소수공제자추가공제		\n");
						sql.append(" B.PENSUM,    --연금보험료공제				\n");
						sql.append(" B.INSSUM,    --보험료계(보험료공제)	\n");
						sql.append(" B.EDUSUM,    --교육비계(교육비공제)	\n");
						sql.append(" B.HOUSUM,    --주택자금계(주택자금공제)	\n");
						sql.append(" B.CONSUM,    --기부금계(기부금공제)			\n");
						sql.append(" B.MARSUM,    --혼인장례이사계(혼인이사장례비)	\n");
						sql.append(" B.STDSUM,    --표준공제						\n");
						sql.append(" B.OFFSUM,    --차감소득						\n");
						sql.append(" B.ETCAMT011, --개인연금저축소득공제	\n");
						sql.append(" B.ETCAMT01,  --연금저축공제					\n");
						sql.append(" B.ETCAMT02,  --투자조합공제					\n");
						sql.append(" B.ETCAMT03,  --신용카드공제					\n");
						sql.append(" B.ETCAMT04,  --우리사주공제					\n");
						sql.append(" B.TSTDSUM,   --종합소득과세표준			\n");
						sql.append(" B.STDTAX,    --산출세액							\n");
						sql.append(" B.DEDAMT01,  --근로소득세액공제			\n");
						sql.append(" B.DEDAMT02,  --납세조합공제					\n");
						sql.append(" B.DEDAMT03,  --주택차입금						\n");
						sql.append(" B.DEDAMT05,  --외국납부							\n");
						sql.append(" B.DEDSUM,    --세액공제계						\n");
						sql.append(" B.PB41000,   --결정소득세						\n");
						sql.append(" B.PB42000,   --결정주민세						\n");
						sql.append(" B.PB43000,   --결정농특세						\n");
						sql.append(" B.APPDT				--귀속년도							\n");
						sql.append(" FROM PAYROLL.YCPAYCOL B							\n");
						sql.append(" LEFT JOIN PAYROLL.HIPERSON A ON A.EMPNO = B.EMPNO	\n");
						sql.append(" LEFT JOIN PAYROLL.HCDEPT C ON C.DEPTCD = B.DEPTCD \n");
						sql.append(" LEFT JOIN PAYROLL.HCLCODE D ON D.MINORCD =  A.PAYGRD AND D.MAJORCD='2002' ");
						sql.append(" WHERE ");

						if (!str[0].equals("")) {	sql.append(" B.APPDT = '"+str[0]+"' "); }
						if (!str[1].equals("")) { sql.append(" AND B.EMPNO = '"+str[1]+"' "); }

						sql.append( " ORDER BY C.TREECD, D.SEQ ");	

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