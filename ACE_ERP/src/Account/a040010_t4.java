package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040010_t4 extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
				
				String str1 = reqGauce.getParameter("v_str1");	//년월
				String str2 = reqGauce.getParameter("v_str2");	//사번 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {"FDCODE","FSDAT","FSNBR","ACTDAT","ACTYYMM"};

				int[] idx = new int[5];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				Statement stmt = null;
				ResultSet rs = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								수정분개 - 전표 MST 조회
						********************************************************************/
						String  g_fdcode = "";
						String  g_actdat = "";
						String  g_atcode = "";
						String  g_cocode = "";
						String  g_divcds = "";
						String  g_deptcd = "";
						double  dbldetot_new=0;
						double  dblcrtot_new=0;
						double  dbldetot=0;
						double  dblcrtot=0;
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT X.FDCODE,X.ACTDAT,X.ATCODE,X.COCODE,X.DIVCD,X.DEPTCD,										\n");
						sql.append( "        SUM(X.DETOT) DETOT,SUM(X.CRTOT) CRTOT,X.STATUS														\n");
						sql.append( " FROM  (SELECT A.FDCODE FDCODE,A.ACTDAT ACTDAT,																	\n");
						sql.append( "               B.ATCODE ATCODE,A.COCODE COCODE,'Y000' AS DIVCD,A.DEPTCD DEPTCD,	\n");
						sql.append( "               SUM(CASE WHEN B.ATDECR = '1' THEN -B.FSAMT ELSE 0 END) DETOT,\n");
						sql.append( "               SUM(CASE WHEN B.ATDECR = '2' THEN -B.FSAMT ELSE 0 END) CRTOT,\n");
						sql.append( "               'Y' AS STATUS		\n");
						sql.append( "        FROM ACCOUNT.MFSLIPMST A,ACCOUNT.MFSLIPDTL B															\n");
						sql.append( "        WHERE A.FDCODE=B.FDCODE AND A.FSDAT=B.FSDAT AND A.FSNBR=B.FSNBR					\n");
						sql.append( "        AND A.FDCODE IS NOT NULL AND B.ATCODE IS NOT NULL AND A.FSSTAT='Y'												\n");
						sql.append( "        AND A.FDCODE ='"+rows[j].getString(idx[0])+"' \n");
						sql.append( "        AND A.FSDAT  ='"+rows[j].getString(idx[1])+"' \n");
						sql.append( "        AND A.FSNBR  ='"+rows[j].getString(idx[2])+"' \n");
						sql.append( "        GROUP BY A.FDCODE,A.ACTDAT,B.ATCODE,																			\n");
						sql.append( "									A.COCODE,A.DEPTCD,B.ATDECR      								\n");
						sql.append( " ) X																																							\n");
						sql.append( " GROUP BY X.FDCODE,X.ACTDAT,X.ATCODE,X.COCODE,X.DIVCD,X.DEPTCD,X.STATUS					\n");
						sql.append( " ORDER BY FDCODE,ACTDAT,ATCODE																										\n");

						stmt = conn.createStatement();
						rs   = stmt.executeQuery(sql.toString());

						while(rs.next())	{
							g_fdcode = rs.getString(1) + "";
							g_actdat = rs.getString(2) + "";
							g_atcode = rs.getString(3) + "";
							g_cocode = rs.getString(4) + "";
							g_divcds = rs.getString(5) + "";
							g_deptcd = rs.getString(6) + "";

							dbldetot_new = rs.getDouble(7);
							dblcrtot_new = rs.getDouble(8);


							//수정분개 금액 조회
							StringBuffer sql_u1 = new StringBuffer();
							Statement stmt_u1 = null;
							ResultSet rs_u1 = null;
							//icnt+=1;
							
							sql_u1.append( " SELECT DETOT,  CRTOT \n");
							sql_u1.append( "   FROM ACCOUNT.MDMTOTAL  \n");
							sql_u1.append( "  WHERE FDCODE  ='"+g_fdcode+"' \n");
							sql_u1.append( "    AND ACTYYMM ='"+g_actdat.substring(0,6)+"' \n");
							sql_u1.append( "    AND ATCODE  ='"+g_atcode+"' \n");
							sql_u1.append( "    AND COCODE  ='"+g_cocode+"' \n");
							sql_u1.append( "    AND DIVCD   ='"+g_divcds+"' \n");
							sql_u1.append( "    AND DEPTCD  ='"+g_deptcd+"' \n");

							stmt_u1 = conn.createStatement();
							rs_u1 = stmt_u1.executeQuery(sql_u1.toString());
							
							dbldetot = 0;
							dblcrtot = 0;
							while(rs_u1.next())	{
 
								dbldetot=rs_u1.getDouble(1);
								dblcrtot=rs_u1.getDouble(2);

								dbldetot = dbldetot +dbldetot_new;
								dblcrtot = dblcrtot +dblcrtot_new;


								/*******************************************************************
										수정분개 - 분개 MST 상태변경(결재취소)
								********************************************************************/
								StringBuffer InsertSql = null;
								InsertSql = new StringBuffer();
								InsertSql.append( " UPDATE ACCOUNT.MDMTOTAL SET	\n");
								InsertSql.append( " DETOT="+dbldetot+",\n");
								InsertSql.append( " CRTOT="+dblcrtot+",\n");
								InsertSql.append( " STATUS='C' \n");
								InsertSql.append( " WHERE FDCODE  ='"+g_fdcode+"' \n");
								InsertSql.append( "   AND ACTYYMM ='"+g_actdat.substring(0,6)+"' \n");
								InsertSql.append( "   AND ATCODE  ='"+g_atcode+"' \n");
								InsertSql.append( "   AND COCODE  ='"+g_cocode+"' \n");
								InsertSql.append( "   AND DIVCD   ='"+g_divcds+"' \n");
								InsertSql.append( "   AND DEPTCD  ='"+g_deptcd+"' \n");

								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
								gsmt.executeUpdate(); 
								gsmt.close();
							}
							rs_u1.close();

							//수정분개 금액 조회
							StringBuffer sql_u2 = new StringBuffer();
							Statement stmt_u2 = null;
							ResultSet rs_u2 = null;
							//icnt+=1;

							sql_u2.append( " SELECT DETOT,  CRTOT \n");
							sql_u2.append( "   FROM ACCOUNT.MDTOTAL  \n");
							sql_u2.append( "  WHERE FDCODE  ='"+g_fdcode+"' \n");
							sql_u2.append( "    AND ACTDAT  ='"+g_actdat+"' \n");
							sql_u2.append( "    AND ATCODE  ='"+g_atcode+"' \n");
							sql_u2.append( "    AND COCODE  ='"+g_cocode+"' \n");
							sql_u2.append( "    AND DIVCD   ='"+g_divcds+"' \n");
							sql_u2.append( "    AND DEPTCD  ='"+g_deptcd+"' \n");

							stmt_u2 = conn.createStatement();
							rs_u2 = stmt_u2.executeQuery(sql_u2.toString());
							
							dbldetot = 0;
							dblcrtot = 0;
							while(rs_u2.next())	{

								dbldetot=rs_u2.getDouble(1);
								dblcrtot=rs_u2.getDouble(2);

								dbldetot = dbldetot +dbldetot_new;
								dblcrtot = dblcrtot +dblcrtot_new;

								/*******************************************************************
										수정분개 - 분개 DTL 상태변경(결재취소)
								********************************************************************/
								StringBuffer InsertSql2 = null;
								InsertSql2 = new StringBuffer();
								InsertSql2.append( " UPDATE ACCOUNT.MDTOTAL SET	\n");
								InsertSql2.append( " DETOT="+dbldetot+",\n");
								InsertSql2.append( " CRTOT="+dblcrtot+",\n");
								InsertSql2.append( " STATUS='C' \n");
								InsertSql2.append( " WHERE FDCODE  ='"+g_fdcode+"' \n");
								InsertSql2.append( "   AND ACTDAT  ='"+g_actdat+"' \n");
								InsertSql2.append( "   AND ATCODE  ='"+g_atcode+"' \n");
								InsertSql2.append( "   AND COCODE  ='"+g_cocode+"' \n");
								InsertSql2.append( "   AND DIVCD   ='"+g_divcds+"' \n");
								InsertSql2.append( "   AND DEPTCD  ='"+g_deptcd+"' \n");

								GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
								gsmt2.executeUpdate(); 
								gsmt2.close();
							}
							rs_u2.close();
						}
						rs.close();
						/*******************************************************************
								수정분개 - 전표 MST 상태변경(결재완료)
						********************************************************************/
						StringBuffer InsertSql3 = null;
						InsertSql3 = new StringBuffer();
						InsertSql3.append( " UPDATE ACCOUNT.MFSLIPMST SET	\n");
						InsertSql3.append( " FSSTAT='C' \n");
						InsertSql3.append( " WHERE FDCODE ='"+rows[j].getString(idx[0])+"' \n");
						InsertSql3.append( "   AND FSDAT  ='"+rows[j].getString(idx[1])+"' \n");
						InsertSql3.append( "   AND FSNBR  ='"+rows[j].getString(idx[2])+"' \n");

						GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
						gsmt3.executeUpdate();
						gsmt3.close();


           /*******************************************************************
						    2010.08.31 JYS 
								수정분개 - 결재취소시 상위집계상태에 UPDATE함   
								UPSTS - 2 : 취소수정 ( 결재취소하면서 수정됨 )
						********************************************************************/
						if(j==0){
							StringBuffer UpdateSql_999  = null;
							UpdateSql_999 = new StringBuffer();
							UpdateSql_999.append( " UPDATE ACCOUNT.UPSUMSTS SET " );
							UpdateSql_999.append( "        UPSTS = '2'," );
							UpdateSql_999.append( "        UPID ='"+str2+"'," );
							UpdateSql_999.append( "        UPDT = sysdate " );
							UpdateSql_999.append( "  WHERE GUBUN='9'       " );
							UpdateSql_999.append( "    AND FDCODE = '"+rows[j].getString(idx[0])+"' " );
							UpdateSql_999.append( "    AND ACTYYMM ='"+g_actdat.substring(0,6)+"' " );

							GauceStatement gsmt999 = conn.getGauceStatement(UpdateSql_999.toString());
							gsmt999.executeUpdate();
							gsmt999.close();
						}
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
					}
				}
			}	catch(Exception e){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}	catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}	finally {
			if (conn != null) try {conn.close(true);} catch (Exception e) {}
			loader.restoreService(service);
	 	}
	}
}