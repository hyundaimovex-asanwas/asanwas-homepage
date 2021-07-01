package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040010_t3 extends HttpServlet{
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

				//StringBuffer InsertSql  = null;
				//StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql  = null;
				//StringBuffer UpdateSql2 = null;
				StringBuffer UpdateSql3 = null;
				//StringBuffer UpdateSql4 = null;
				StringBuffer UpdateSql5 = null;
				StringBuffer DeleteSql  = null;

				Statement stmt = null;
				ResultSet rs = null;

				Statement stmt2 = null;
				ResultSet rs2 = null;

				Statement stmt4 = null;
				ResultSet rs4 = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								수정분개 - 전표 MST 조회
						********************************************************************/
						String  g_fdcode = "";
						String  g_actdat = "";
						String  g_actymm = "";
						String  g_atcode = "";
						String  g_cocode = "";
						String  g_divcds = "";
						String  g_deptcd = "";
						double  g_chato2 = 0;
						double  g_daeto2 = 0;
						double  g_chatot = 0;
						double  g_daetot = 0;
						String  g_gubun="";
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT X.FDCODE,X.ACTDAT,X.ATCODE,X.COCODE,X.DIVCD,X.DEPTCD,								\n");
						sql.append( "        SUM(X.DETOT) DETOT,SUM(X.CRTOT) CRTOT,X.STATUS										\n");
						sql.append( " FROM  (SELECT A.FDCODE FDCODE,A.ACTDAT ACTDAT,											\n");
						sql.append( "               B.ATCODE ATCODE,A.COCODE COCODE,'Y000' AS DIVCD,A.DEPTCD DEPTCD,	        \n");
						sql.append( "               CASE WHEN B.ATDECR='1' THEN NVL(B.FSAMT,0) ELSE 0 END AS DETOT,             \n");
						sql.append( "               CASE WHEN B.ATDECR='2' THEN NVL(B.FSAMT,0) ELSE 0 END AS CRTOT,             \n");
						sql.append( "               'Y' AS STATUS																\n");
						sql.append( "        FROM ACCOUNT.MFSLIPMST A,ACCOUNT.MFSLIPDTL B										\n");
						sql.append( "        WHERE A.FDCODE=B.FDCODE AND A.FSDAT=B.FSDAT AND A.FSNBR=B.FSNBR					\n");
						sql.append( "        AND A.FDCODE IS NOT NULL AND B.ATCODE IS NOT NULL /*AND A.FSSTAT='N'*/				\n");
						sql.append( "        AND A.FDCODE ='"+rows[j].getString(idx[0])+"' \n");
						sql.append( "        AND A.FSDAT  ='"+rows[j].getString(idx[1])+"' \n");
						sql.append( "        AND A.FSNBR  ='"+rows[j].getString(idx[2])+"' \n");
						sql.append( "        GROUP BY A.FDCODE,A.ACTDAT,B.ATCODE,												\n");
						sql.append( "									A.COCODE,A.DEPTCD,B.ATDECR,B.FSAMT						\n");
						sql.append( " ) X																						\n");
						sql.append( " GROUP BY X.FDCODE,X.ACTDAT,X.ATCODE,X.COCODE,X.DIVCD,X.DEPTCD,X.STATUS					\n");
						sql.append( " ORDER BY FDCODE,ACTDAT,ATCODE																\n");

						
						//System.out.println("a040010_t3::"+sql.toString());
						
						stmt = conn.createStatement();
						rs   = stmt.executeQuery(sql.toString());
						
						while(rs.next()){
							g_fdcode = rs.getString(1) + "";
							g_actdat = rs.getString(2) + "";
							g_actymm = g_actdat.substring(0,6);
							g_atcode = rs.getString(3) + "";
							g_cocode = rs.getString(4) + "";
							g_divcds = rs.getString(5) + "";
							g_deptcd = rs.getString(6) + "";
							g_chato2 = rs.getDouble(7);
							g_daeto2 = rs.getDouble(8);

							/*******************************************************************
									수정분개 - 분개 차/대변 금액 누적여부 체크
							********************************************************************/
              
							g_chatot = 0;
							g_daetot = 0;
							g_gubun ="0";
							
							StringBuffer sql2 = new StringBuffer();
							sql2.append( " SELECT A.DETOT, A.CRTOT	\n");
							sql2.append( " FROM ACCOUNT.MDMTOTAL A												\n");
							sql2.append( " WHERE A.FDCODE='"+g_fdcode+"' AND A.ACTYYMM='"+g_actdat.substring(0,6)+"' \n");
							sql2.append( " AND A.ATCODE='"+g_atcode+"'   AND A.COCODE='"+g_cocode+"'	\n");
							sql2.append( " AND A.DIVCD='"+g_divcds+"'    AND A.DEPTCD='"+g_deptcd+"'	\n");

							stmt2 = conn.createStatement();
							rs2   = stmt2.executeQuery(sql2.toString());

							while(rs2.next())	{
								g_chatot = rs2.getDouble(1);
								g_daetot = rs2.getDouble(2);
								g_gubun="1";
							}
								rs2.close();
							if(g_gubun.equals("0")) {
								/*******************************************************************
										수정분개 - 결재 MST
								********************************************************************/

								StringBuffer InsertSql = null;
								InsertSql = new StringBuffer();
								InsertSql.append( " INSERT INTO ACCOUNT.MDMTOTAL(FDCODE,ACTYYMM,ATCODE,COCODE,DIVCD,DEPTCD,DETOT,CRTOT,STATUS)	\n");
								InsertSql.append( " VALUES ( '"+g_fdcode+"','"+g_actymm+"','"+g_atcode+"','"+g_cocode+"','"+g_divcds+"', \n");
								InsertSql.append( "          '"+g_deptcd+"',"+g_chato2+","+g_daeto2+",'Y') \n");
								
								GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
								gsmt.setGauceDataRow(rows[j]);
								gsmt.executeUpdate(); 
								gsmt.close();
							}else{/*금액 누적*/
								/*******************************************************************
										수정분개 - 분개 MST 금액 누적(결재완료)
								********************************************************************/
								StringBuffer UpdateSql4 = null;
								UpdateSql4 = new StringBuffer();
								UpdateSql4.append( " UPDATE ACCOUNT.MDMTOTAL SET	\n");
								UpdateSql4.append( " DETOT=DETOT+"+g_chato2+",		\n");
								UpdateSql4.append( " CRTOT=CRTOT+"+g_daeto2+",		\n");
								UpdateSql4.append( " STATUS='Y' ");
								UpdateSql4.append( " WHERE FDCODE  ='"+g_fdcode+"' \n");
								UpdateSql4.append( "   AND ACTYYMM ='"+g_actymm+"' \n");
								UpdateSql4.append( "   AND ATCODE  ='"+g_atcode+"' \n");
								UpdateSql4.append( "   AND COCODE  ='"+g_cocode+"' \n");
								UpdateSql4.append( "   AND DIVCD   ='"+g_divcds+"' \n");
								UpdateSql4.append( "   AND DEPTCD  ='"+g_deptcd+"' \n");

								GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql4.toString());
								gsmt4.setGauceDataRow(rows[j]);
								gsmt4.executeUpdate();
								gsmt4.close();
							}

							/***************************************************************************
               				일집계
							****************************************************************************/
							g_chatot = 0;
							g_daetot = 0;
							g_gubun ="0";
							
							StringBuffer sql4 = new StringBuffer();
							sql4.append( " SELECT A.DETOT, A.CRTOT	\n");
							sql4.append( " FROM ACCOUNT.MDTOTAL A												\n");
							sql4.append( " WHERE A.FDCODE='"+g_fdcode+"' AND A.ACTDAT='"+g_actdat+"' \n");
							sql4.append( " AND A.ATCODE='"+g_atcode+"'   AND A.COCODE='"+g_cocode+"'	\n");
							sql4.append( " AND A.DIVCD='"+g_divcds+"'    AND A.DEPTCD='"+g_deptcd+"'	\n");

							stmt4 = conn.createStatement();
							rs4   = stmt4.executeQuery(sql4.toString());

							while(rs4.next())	{
								g_chatot = rs4.getDouble(1);
								g_daetot = rs4.getDouble(2);
								g_gubun="1";
							}

							if(g_gubun.equals("0")) {
								/*******************************************************************
										수정분개 - 결재 DTL
								********************************************************************/
								StringBuffer InsertSql2 = null;
								InsertSql2 = new StringBuffer();
								InsertSql2.append( " INSERT INTO ACCOUNT.MDTOTAL(FDCODE,ACTDAT,ATCODE,COCODE,DIVCD,DEPTCD,DETOT,CRTOT,STATUS)	\n");
								InsertSql2.append( " VALUES ( '"+g_fdcode+"','"+g_actdat+"','"+g_atcode+"','"+g_cocode+"','"+g_divcds+"', \n");
								InsertSql2.append( "          '"+g_deptcd+"',"+g_chato2+","+g_daeto2+",'Y') \n");

								GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
								gsmt2.setGauceDataRow(rows[j]);
								gsmt2.executeUpdate(); 
								gsmt2.close();
							}else{/*금액 누적*/
								/*******************************************************************
										수정분개 - 분개 DTL 금액 누적(결재완료)
								********************************************************************/
								UpdateSql5 = new StringBuffer();
								UpdateSql5.append( " UPDATE ACCOUNT.MDTOTAL SET	\n");
								UpdateSql5.append( " DETOT=DETOT+"+g_chato2+",	\n");
								UpdateSql5.append( " CRTOT=CRTOT+"+g_daeto2+",	\n");
								UpdateSql5.append( " STATUS='Y' ");
								UpdateSql5.append( " WHERE FDCODE  ='"+g_fdcode+"' \n");
								UpdateSql5.append( "   AND ACTDAT  ='"+g_actdat+"' \n");
								UpdateSql5.append( "   AND ATCODE  ='"+g_atcode+"' \n");
								UpdateSql5.append( "   AND COCODE  ='"+g_cocode+"' \n");
								UpdateSql5.append( "   AND DIVCD   ='"+g_divcds+"' \n");
								UpdateSql5.append( "   AND DEPTCD  ='"+g_deptcd+"' \n");

								GauceStatement gsmt5 = conn.getGauceStatement(UpdateSql5.toString());
								gsmt5.setGauceDataRow(rows[j]);
								gsmt5.executeUpdate();
								gsmt5.close();
							}


							/*******************************************************************
									수정분개 - 전표 MST 상태변경(결재완료)
							********************************************************************/
							UpdateSql3 = new StringBuffer();
							UpdateSql3.append( " UPDATE ACCOUNT.MFSLIPMST SET	");
							UpdateSql3.append( " FSSTAT='Y' ");
							UpdateSql3.append( " WHERE FDCODE ='"+rows[j].getString(idx[0])+"' ");
							UpdateSql3.append( "   AND FSDAT  ='"+rows[j].getString(idx[1])+"' ");
							UpdateSql3.append( "   AND FSNBR  ='"+rows[j].getString(idx[2])+"' ");

							GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
							gsmt3.setGauceDataRow(rows[j]);
							gsmt3.executeUpdate();
							gsmt3.close();
						}//while


						/*******************************************************************
						    2010.08.31 JYS 
								수정분개 - 결재시 상위집계상태에 UPDATE함   
								UPSTS - 3 : 완료수정 ( 결재하면서 수정됨 )
						********************************************************************/
						if(j==0){
							StringBuffer UpdateSql_999  = null;
							UpdateSql_999 = new StringBuffer();
							UpdateSql_999.append( " UPDATE ACCOUNT.UPSUMSTS SET " );
							UpdateSql_999.append( "        UPSTS = '3'," );
							UpdateSql_999.append( "        UPID ='"+str2+"'," );
							UpdateSql_999.append( "        UPDT = sysdate" );
							UpdateSql_999.append( "  WHERE GUBUN='9'       " );
							UpdateSql_999.append( "    AND FDCODE = '"+rows[j].getString(idx[0])+"' " );
							UpdateSql_999.append( "    AND ACTYYMM ='"+g_actymm+"' " );

							GauceStatement gsmt999 = conn.getGauceStatement(UpdateSql_999.toString());
							gsmt999.executeUpdate();
							gsmt999.close();
						}

          
					}//if TB_JOB_INSERT

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {
						
					}

        //j=0 일때만 처리함.

				}//for (int j = 0; j < rows.length; j++){
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