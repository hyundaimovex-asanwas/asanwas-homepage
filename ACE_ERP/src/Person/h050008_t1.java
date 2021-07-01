package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class h050008_t1 extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;

		try{
			loader = new ServiceLoader(req, res);
	 		service = loader.newService();
	 		context = service.getContext();
	 		logger = context.getLogger();
	 		GauceRequest reqGauce = null;
	 		GauceResponse resGauce = null;

			try {
				
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxFRDT    = userSet.indexOfColumn("FRDT");	    //from 일자
				int idxTODT    = userSet.indexOfColumn("TODT");	    //to   일자
				int idxLAZCD   = userSet.indexOfColumn("LAZCD");	  //근태구분
				int idxINTRDAY = userSet.indexOfColumn("INTRDAY");	//일수
				
				GauceDataRow[] rows = userSet.getDataRows();


				StringBuffer InsertSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

						String strFrdt = rows[j].getString(idxFRDT); //FROM 일자
						String strTodt = rows[j].getString(idxTODT); //TO이랒
						String strOtdt =""; //근태일자
						
						int yyyy = Integer.parseInt(strFrdt.substring(0,4));
						int mm = Integer.parseInt(strFrdt.substring(4,6))-1; //month의 경우 해당월수-1을 해줍니다. 
						int dd = Integer.parseInt(strFrdt.substring(6,8));

						String stryyyy="";
						String strmm="";
						String strdd="";

						Calendar cal2 = Calendar.getInstance ( ); 
						cal2.set ( yyyy, mm, dd ); // 기준일로 설정. 
						for ( int i =1;i<=rows[j].getInt(idxINTRDAY);i++){
					  	if(i==1){ //from일자
								strOtdt=strFrdt;
							}else if(i==rows[j].getDouble(idxINTRDAY)){//to일자
								strOtdt=strTodt;
							}else{ //from일자와 to일자 사이
								cal2.add ( Calendar.DATE, 1 ); // 다음날로 바뀜
								yyyy = cal2.get ( Calendar.YEAR );
								mm = cal2.get ( Calendar.MONTH ) + 1;
								dd = cal2.get ( Calendar.DATE );

								stryyyy = String.valueOf(yyyy);
								if(mm<10) strmm = "0"+ String.valueOf(mm);
								else strmm = String.valueOf(mm);
								if(dd<10) strdd = "0"+ String.valueOf(dd);
								else strdd = String.valueOf(dd);
								strOtdt=stryyyy+strmm+strdd;
							}

							//현재일자가 휴일이면 근태Table에 자동생성함.///////////////////////////////////////////////////	
							StringBuffer sql = new StringBuffer();
							Statement stmt= null;
							ResultSet rs = null;
							String strGubun="";
							int cnt=0;
							long lngamt=0;
							sql.append( " SELECT COUNT(*) CNT      ");
							sql.append( "   FROM PAYROLL.HCHOLDAY A                ");
							sql.append( "   LEFT JOIN ( SELECT B.LAZCD, B.AMT      ");
							sql.append( " 							  FROM PAYROLL.HCHOLFEE B  ");
							sql.append( " 						   WHERE LAZCD='S01'         ");
							sql.append( " 					  ) C ON 1=1                   ");
							sql.append( "  WHERE A.HOLDT = '"+strOtdt+"'           ");
							sql.append( "  GROUP BY C.LAZCD, C.AMT                 ");

							stmt = conn.createStatement();
							rs = stmt.executeQuery(sql.toString());
							while(rs.next())	{
								strGubun="1";
							}//while
							rs.close();
							stmt.close();
							
							//동시에 휴일근무
							if(strGubun.equals("")){
								
								//기존데이타 삭제
								DeleteSql = new StringBuffer();
								DeleteSql.append( " DELETE FROM PAYROLL.HLDUTY  ");
								DeleteSql.append( "  WHERE APPDT= '"+strOtdt+"'");
								DeleteSql.append( "    AND LAZCD='S01'");
								DeleteSql.append( "    AND FRDT ='"+strOtdt+"'");

								GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
								gsmt.executeUpdate();
								gsmt.close();

								//신규데이타 입력
								InsertSql = new StringBuffer();
								InsertSql.append( " INSERT INTO PAYROLL.HLDUTY(     ");
								InsertSql.append( " APPDT,  EMPNO,   LAZCD,   DEPTCD,  PAYSEQ,     \n");
								InsertSql.append( " FRDT,   TODT,    FRTIME,  TOTIME,  DTYREM,     \n");
								InsertSql.append( " CLOSYN, SGDT,    SGNID,   AGRDT,   AGRID,      \n");
								InsertSql.append( " PAYDT,   AMT,    OTLAZCD                       \n");
								InsertSql.append( " )    \n");
								InsertSql.append( " SELECT A.ATTDAY APPDT, A.EMPNO,    --정규직                                                      \n");
								//InsertSql.append( "        CASE WHEN RTRIM(B.EMPNMK)='' OR B.EMPNMK IS NULL THEN D.EMPNMK ELSE B.EMPNMK END EMPNMK,  \n");
								InsertSql.append( "        'S01' LAZCD,  B.DEPTCD,   B.PAYGRD,                                                       \n");
								InsertSql.append( "	       A.ATTDAY FRDT,  A.CLODAY TODT, A.ATTTIME, A.CLOTIME, '야근' DTYREM,                       \n");
								InsertSql.append( "	       'Y' CLOSYN, '' SGDT,    ''SGNID,   ''AGRDT,   ''AGRID,                                    \n");
								InsertSql.append( "	       ''PAYDT,                                                                                  \n");
								InsertSql.append( "	       CASE WHEN A.CLOTIME>='210000' AND A.CLOTIME<'240000' THEN 7000                            \n");
								InsertSql.append( "	            WHEN (A.CLOTIME>='000000' AND A.CLOTIME<='040000') OR A.CLOTIME='240000' THEN 10000  \n");
								InsertSql.append( "	            ELSE 0                                                                               \n");
								InsertSql.append( "	       END AMT,                                                                                  \n");
								InsertSql.append( "	       ''OTLAZCD                                                                                 \n");
								InsertSql.append( "	  FROM PAYROLL.HLATTEND A                                                                        \n");
								InsertSql.append( "	  LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO                                              \n");
								InsertSql.append( "	  LEFT JOIN PAYROLL.HCLCODE C ON B.PAYGRD = C.MINORCD AND C.MAJORCD='2002'                       \n");
								//InsertSql.append( "	  LEFT JOIN PAYROLL.T_HIPERSON D ON A.EMPNO =D.EMPNO                                             \n");
								InsertSql.append( "	 WHERE A.ATTDAY ='"+strOtdt+"'    \n");
								InsertSql.append( "	   AND C.MEMO<>'0' --임원이 아닌 경우                                                            \n");
								InsertSql.append( "	   AND B.PAYGRD<>'300' --운전직 아닌 경우(운전직은 수동입력)                                     \n");
								InsertSql.append( "	   AND SUBSTR(A.EMPNO,1,1) IN ('1','2')                                                         \n");
								InsertSql.append( "	   AND (A.CLOTIME>='210000' OR (A.CLOTIME<='040000' AND SUBSTR(A.CLOTIME,1,4) <> '0000'))        \n");
								InsertSql.append( "	 UNION ALL                                                                                       \n");
								InsertSql.append( "	SELECT A.ATTDAY APPDT, A.EMPNO,         --계약직                                                 \n");
								//InsertSql.append( "        CASE WHEN RTRIM(B.EMPNMK)='' OR B.EMPNMK IS NULL THEN D.EMPNMK ELSE B.EMPNMK END EMPNMK,  \n");
								InsertSql.append( "        'S01' LAZCD,  D.DEPTCD,  D.PAYGRD,                                                        \n");
								InsertSql.append( "        A.ATTDAY FRDT,  A.CLODAY TODT, A.ATTTIME, A.CLOTIME, '야근' DTYREM,                       \n");
								InsertSql.append( "	       'Y' CLOSYN, '' SGDT,    ''SGNID,   ''AGRDT,   ''AGRID,                                    \n");
								InsertSql.append( "	       ''PAYDT,                                                                                  \n");
								InsertSql.append( "	       CASE WHEN D.PAYGRD = '700' THEN  CASE WHEN A.CLOTIME>='200000' THEN 5000                                                 \n");
								InsertSql.append( "	                                             WHEN (A.CLOTIME>='000000' AND A.CLOTIME<='040000') OR A.CLOTIME='240000' THEN 5000 \n");
								InsertSql.append( "	                                             ELSE 0 END                                                                         \n");
								InsertSql.append( "	            ELSE  CASE WHEN A.CLOTIME>='210000' AND A.CLOTIME<'240000' THEN 7000                                                \n");
								InsertSql.append( "	                       WHEN (A.CLOTIME>='000000' AND A.CLOTIME<='040000') OR A.CLOTIME='240000' THEN 10000                      \n");
								InsertSql.append( "	                       ELSE 0  END                                                                                              \n");
								InsertSql.append( "	        END AMT,                                                                                                                \n");
								InsertSql.append( "	        \n");
								InsertSql.append( "	       ''OTLAZCD                                                                                 \n");
								InsertSql.append( "	  FROM PAYROLL.HLATTEND A                                                                        \n");
								//InsertSql.append( "	  LEFT JOIN PAYROLL.HIPERSON B ON A.EMPNO = B.EMPNO                                              \n");
								InsertSql.append( "	  LEFT JOIN PAYROLL.T_HIPERSON D ON A.EMPNO =D.EMPNO                                             \n");
								InsertSql.append( "	  LEFT JOIN PAYROLL.HCLCODE C ON D.PAYGRD = C.MINORCD AND C.MAJORCD='2002'                       \n");
								InsertSql.append( "	 WHERE A.ATTDAY = '"+strOtdt+"'    \n");
								InsertSql.append( "	   AND D.PAYGRD<>'300' --운전직 아닌 경우(운전직은 수동입력)                                     \n");
								InsertSql.append( "	   AND SUBSTR(A.EMPNO,1,1) NOT IN ('1','2')                                                  \n");
								InsertSql.append( "	   AND (A.CLOTIME>='210000' OR (A.CLOTIME<='040000' AND SUBSTR(A.CLOTIME,1,4) <> '0000'))        \n");
								InsertSql.append( "	 ORDER BY CLOTIME                                                                                \n");

                //logger.dbg.println(this,InsertSql.toString());
		
								GauceStatement gsmt2 = conn.getGauceStatement(InsertSql.toString());
								
								gsmt2.executeUpdate();
								gsmt2.close();  
							}
						}
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
					}
				}
			}
			catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

      conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}