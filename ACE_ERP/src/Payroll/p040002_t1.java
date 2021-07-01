package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;


public class p040002_t1 extends HttpServlet{
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

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				//String  str1	= req.getParameter("v_str1");

				String[] strArrCN = new String[]{
				"EMPNO",	   /* 사번 */
				"EMPNMK",       /*한글명*/
				"NOTWRK",       /*휴직정직일수*/
				"APPDT",	       /* 년월 */
				"PAYDIV",	/* 급여구분*/

				"DEPTCD",	/*  부서코드*/
				"DEPTNM",	/*  부서명*/
				"PAYGRDNM",	/* 직위코드*/
				"GRDDIVNM",	/*직급*/
				"PAYSEQNM",	/* 호봉코드 */

				"PAYBNKNM",	/*  은행코드*/
				"PAYNUM",	/*  계좌번호*/
				"PAYDT",  /*  지급일*/
				"DUYNOT",	/*  무계결근일수*/

				"P10000",	/*  기본급여*/

				"P11000",	/* 직책수당 */
				"P12000",	/* 시간외수당 */
				"P21000",	/*  근속수당*/
				"P22000",	/*  자기계발비 */
				"P23000",	/*  부양가족*/

				"P24000",	/*  차량유지비 */
				"P25000",	/*  출납수당*/
				"P26000",	/*  운전수당*/
				"P27000",	/*  연장수당*/
				"P28000",	/*  자격수당*/

				"P29000",	/*  남북경협수당*/
				"P30000",	/*  사장단수당*/
				"P31000",	/*  특수지수당*/
				"P32000",	/*  지역근무수당*/
				"P36000",	/*  학비보조금*/

				"P37000",	/*  개인연금보조금*/
				"P38000",	/*  임원직책수당*/
				"PX0010",	/*  기타지급1*/
				"PX0020",	/*  기타지급2*/
				"PX0030",	/*  기타지급3*/

				"PX0040",	/*  기타지급4*/
				"S91000",	/*  지급합계*/
				"T11000",	/*  소득세 OR 갑근세*/
				"T12000",	/*  주민세*/
				"B11000",	/*  건강보험료*/

				"B12000",	/*  국민연금*/
				"B13000",	/*  고용보험*/
				"B15000",	/*  개인연금*/
				"B14000",	/*  여직원회비*/
				"B16000",	/*  공조회비*/

				"BX0010",	/*  기타공제1*/		
				"BX0020",	/*  기타공제2*/		
				"BX0030",	/*  기타공제3*/		
				"BX0040",	/*  기타공제4*/
				"S93000",	/*  공제합계*/	

				"S94000",	/*  차인지급액*/
				
				"STRTDT",	/*  입사일*/	
				"JOBGRPHNM",	/*  직군*/	
				"ENDDT",	/*  퇴사일*/	
				"RESINO",	/*  주민번호*/	

				"DUYEAR",	/*  근무기간*/	
				"DUYMM",	/*  근무기간*/	
				"DUDAY",	/*  근무기간*/	
				"T21000",	/*  총소득*/	
				"CZIPCD",	/*  우편번호*/	

				"CADDR",	    /*  주소*/	
				"T92000"	/*  퇴직전환금*/	
				};

        int indexRow=0;
				int[] idx = new int[62];
				for (int i=0; i<strArrCN.length; i++) {
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						InsertSql = new StringBuffer();
						InsertSql.append( " " );
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE PAYROLL.PBPAY " );
						UpdateSql.append( " SET " );
							for(int i=14;i<=50;i++)	{
								UpdateSql.append( strArrCN[i] + "= ?, \n");
							}

								UpdateSql.append( strArrCN[61] + "= ?   \n");
								UpdateSql.append( "  WHERE  ");
								UpdateSql.append( "  EMPNO = ?  " );
								UpdateSql.append( "  AND APPDT = ? " );
								UpdateSql.append( "  AND PAYDIV = ? " );
								UpdateSql.append( "  AND PAYDT = ? " );

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						for(int i=14;i<=50;i++)	{
              gsmt.bindColumn(i-13, idx[i]);
							indexRow=i-13;
						}
							indexRow++;
							gsmt.bindColumn(indexRow, idx[61]); //퇴직전환금 추가
							gsmt.bindColumn(++indexRow, idx[0]);
							gsmt.bindColumn(++indexRow, idx[3]);
							gsmt.bindColumn(++indexRow, idx[4]);
							gsmt.bindColumn(++indexRow, idx[12]);
							indexRow=0;
							gsmt.executeUpdate();
							gsmt.close();  
							UpdateSql=null;
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( "	DELETE FROM PAYROLL.PBPAY " );
						DeleteSql.append( " WHERE EMPNO = ? " );
						DeleteSql.append( " AND APPDT = ? " );
						DeleteSql.append( " AND PAYDIV = ? " );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[3]);
						gsmt.bindColumn(3, idx[4]);

						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.dbg.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}