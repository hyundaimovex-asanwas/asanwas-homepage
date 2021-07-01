package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080005_t3 extends HttpServlet{
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
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1  = reqGauce.getParameter("v_str1");		//지점구분
				String str2  = reqGauce.getParameter("v_str2");		//신청서번호

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"CHK",   "BGTRQNO","FDCODE", "BGTYY",	 "BGTMM",	 
					"BGTDIV","BGTDPT", "ATCODE", "FSREFCD","SATCODE",
					"BGTRQDIV","BGTRQAMT","CNT"
				};

				int[] idx = new int[13];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				StringBuffer InsertSql2 = null;	//예산신청 MST

				Statement stmt = null;
				ResultSet rs = null;

				Statement stmt2 = null;
				ResultSet rs2 = null;

				Statement stmt3 = null;
				ResultSet rs3 = null;

				Statement stmt5 = null;
				ResultSet rs5 = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						int addbgt2	 = 0;	/*추가예산*/   
						int chgabgt2 = 0;	/*항목전용*/     
						int chgtbgt2 = 0;	/*기간전용*/   
						int realbgt2 = 0;	/*실행예산*/ 
							
						if(j==0){	//데이터 조회를 위해 한번만 실행
							/*******************************************************************
									예산편성 Detail 조회(기존 값 조회)
							********************************************************************/
							StringBuffer sql2 = new StringBuffer();
							int addbgt	= 0;	/*추가예산*/   
							int chgabgt = 0;	/*항목전용*/     
							int chgtbgt = 0;	/*기간전용*/   
							int realbgt = 0;	/*실행예산*/   

							sql2.append( " SELECT																		\n"); 
							sql2.append( " COALESCE(A.ADDBGT,0)  ADDBGT,	/*추가예산*/			\n"); 
							sql2.append( " COALESCE(A.CHGABGT,0) CHGABGT,	/*항목전용*/		\n"); 
							sql2.append( " COALESCE(A.CHGTBGT,0) CHGTBGT,	/*기간전용*/		\n"); 
							sql2.append( " COALESCE(A.REALBGT,0) REALBGT	/*실행예산*/			\n"); 
							sql2.append( " FROM ACCOUNT.BGTDTL A											\n"); 
							sql2.append( " WHERE A.FDCODE='"+rows[j].getString(idx[2])+"'	\n");
							sql2.append( " AND A.BGTYY   ='"+rows[j].getString(idx[3])+"'		\n");
							sql2.append( " AND A.BGTMM   ='"+rows[j].getString(idx[4])+"'	\n");
							sql2.append( " AND A.BGTDIV  ='"+rows[j].getString(idx[5])+"'		\n");
							sql2.append( " AND A.BGTDPT  ='"+rows[j].getString(idx[6])+"'	\n");
							sql2.append( " AND A.ATCODE  ='"+rows[j].getString(idx[7])+"'	\n");
							sql2.append( " AND A.FSREFCD ='"+rows[j].getString(idx[8])+"'	\n");
							sql2.append( " AND A.SATCODE ='"+rows[j].getString(idx[9])+"'	\n");


							stmt2 = conn.createStatement();
							rs2 = stmt2.executeQuery(sql2.toString());

							while(rs2.next())	{
								addbgt	= rs2.getInt(1);
								chgabgt = rs2.getInt(2);
								chgtbgt = rs2.getInt(3);
								realbgt = rs2.getInt(4);
							}
							addbgt2	 = addbgt;	
							chgabgt2 = chgabgt;  
							chgtbgt2 = chgtbgt;
							realbgt2 = realbgt;
						}

						/*******************************************************************
							예산신청 Detail3 - 예산월,금액확인 후
																 예산편성관리 Detail에 적용(+,-),상태-R(완료)
						********************************************************************/
						StringBuffer sql5 = new StringBuffer();
						String p_mon	= "";	/*추가예산*/   
						String p_ope	= "";	/*연산자*/   
						int p_amt1 = 0;	/*추가예산*/   
						int p_amt2 = 0;	/*항목전용*/     
						int p_amt3 = 0;	/*기간전용*/   
						int p_amt4 = 0;	/*실행예산*/ 
						int p_temp = 0;

						sql5.append( " SELECT																			\n");
						sql5.append( " RTRIM(A.BGTRQMON) BGTRQMON,         /*예산월*/			\n"); 
						sql5.append( " COALESCE(A.AMTFROMB,0)  AMTFROMB,   /*전기이월*/		\n"); 
						sql5.append( " COALESCE(A.AMTGIVETO,0) AMTGIVETO,  /*차기이월*/		\n"); 
						sql5.append( " COALESCE(A.AMTFROMA,0)  AMTFROMA,   /*조기집행*/		\n"); 
						sql5.append( " COALESCE(A.AMTGVTOB,0)  AMTGVTOB    /*피조기집행*/	\n"); 
						sql5.append( " FROM ACCOUNT.BGTRQDTL3 A										\n"); 
						sql5.append( " WHERE A.FDCODE='"+rows[j].getString(idx[2])+"'					\n"); 
						sql5.append( "   AND A.BGTRQNO='"+rows[j].getString(idx[1])+"'					\n"); 


						stmt5 = conn.createStatement();
						rs5 = stmt5.executeQuery(sql5.toString());

						while(rs5.next())	{
							p_mon	 = rs5.getString(1);
							p_amt1 = rs5.getInt(2);
							p_amt2 = rs5.getInt(3);
							p_amt3 = rs5.getInt(4);
							p_amt4 = rs5.getInt(5);
						}

						if (p_amt1>0){	
							p_ope = "+";	//전기이월
							p_temp = p_amt1;
						}else if (p_amt2>0){
							p_ope = "-";	//차기이월
							p_temp = p_amt1;
						}else if (p_amt3>0){
							p_ope = "+";	//조기집행
							p_temp = p_amt1;
						}else if (p_amt4>0){
							p_ope = "-";	//피조기집행
							p_temp = p_amt1;
						}

						if (rows[j].getString(idx[10]).equals("01")) { 
							/*******************************************************************
								예산편성 Detail Update - 추가예산,실행예산 적용
							********************************************************************/
							InsertSql = new StringBuffer();
							InsertSql.append( " UPDATE ACCOUNT.BGTDTL SET						\n");
							InsertSql.append( "	ADDBGT  = "+addbgt2+p_ope+p_temp+",			\n");
							InsertSql.append( "	REALBGT = "+realbgt2+p_ope+p_temp+"			\n");
							InsertSql.append( " WHERE FDCODE  = ?										\n");
							InsertSql.append( " AND BGTYY    = ?											\n");
							InsertSql.append( " AND BGTMM    = ?											\n");
							InsertSql.append( " AND BGTDIV   = ?											\n");
							InsertSql.append( " AND BGTDPT   = ?											\n");
							InsertSql.append( " AND ATCODE   = ?											\n");
							InsertSql.append( " AND FSREFCD  = ?											\n");
							InsertSql.append( " AND SATCODE  = ?										\n");


							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							for(int s=1;s<=8;s++){
								gsmt.bindColumn(s, idx[s+1]);
							}

							gsmt.executeUpdate();
							gsmt.close();
							InsertSql = null;

						}else if (rows[j].getString(idx[10]).equals("02")) { 
							/*******************************************************************
								예산편성 Detail Update - 기간전용
							********************************************************************/
							InsertSql = new StringBuffer();
							InsertSql.append( " UPDATE ACCOUNT.BGTDTL SET								\n");
							InsertSql.append( "		CHGABGT = "+chgabgt2+p_ope+p_temp+",			\n");
							InsertSql.append( "		REALBGT = "+realbgt2+p_ope+p_temp+"				\n");
							InsertSql.append( " WHERE FDCODE  = ?												\n");
							InsertSql.append( " AND  BGTYY    = ?													\n");
							InsertSql.append( " AND  BGTMM    = ?												\n");
							InsertSql.append( " AND  BGTDIV   = ?													\n");
							InsertSql.append( " AND  BGTDPT   = ?												\n");
							InsertSql.append( " AND  ATCODE   = ?												\n");
							InsertSql.append( " AND  FSREFCD  = ?												\n");
							InsertSql.append( " AND  SATCODE  = ?												\n");


							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							for(int s=1;s<=8;s++){
								gsmt.bindColumn(s, idx[s+1]);
							}

							gsmt.executeUpdate();
							gsmt.close();
							InsertSql = null;

						}else if (rows[j].getString(idx[10]).equals("03")) { 
							/*******************************************************************
								예산편성 Detail Update - 항목전용
							********************************************************************/
							InsertSql = new StringBuffer();
							InsertSql.append( " UPDATE ACCOUNT.BGTDTL SET									\n");
							InsertSql.append( "		CHGTBGT = "+chgtbgt2+p_ope+p_temp+",					\n");
							InsertSql.append( "		REALBGT = "+realbgt2+p_ope+p_temp+"					\n");
							InsertSql.append( " WHERE FDCODE  = ?													\n");
							InsertSql.append( " AND BGTYY			= ?												\n");
							InsertSql.append( " AND BGTMM			= ?												\n");
							InsertSql.append( " AND BGTDIV		= ?													\n");
							InsertSql.append( " AND BGTDPT		= ?												\n");
							InsertSql.append( " AND ATCODE		= ?												\n");
							InsertSql.append( " AND FSREFCD		= ?												\n");
							InsertSql.append( " AND SATCODE		= ?												\n");


							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);

							for(int s=1;s<=8;s++){
								gsmt.bindColumn(s, idx[s+1]);
							}

							gsmt.executeUpdate();
							gsmt.close();
							InsertSql = null;
						}


						/*******************************************************************
								예산편성 Detail 조회 - 적용된 값을 재조회 후 MST에 적용시킴
						********************************************************************/
						StringBuffer sql3 = new StringBuffer();
						int addbgt3	 = 0;	/*추가예산*/   
						int chgabgt3 = 0;	/*항목전용*/     
						int chgtbgt3 = 0;	/*기간전용*/   
						int realbgt3 = 0;	/*실행예산*/   

						sql3.append( " SELECT																		\n"); 
						sql3.append( " COALESCE(A.ADDBGT,0)  ADDBGT,	/*추가예산*/			\n"); 
						sql3.append( " COALESCE(A.CHGABGT,0) CHGABGT,	/*항목전용*/		\n"); 
						sql3.append( " COALESCE(A.CHGTBGT,0) CHGTBGT,	/*기간전용*/		\n"); 
						sql3.append( " COALESCE(A.REALBGT,0) REALBGT	/*실행예산*/			\n"); 
						sql3.append( " FROM ACCOUNT.BGTDTL A											\n"); 
						sql3.append( " WHERE A.FDCODE='"+rows[j].getString(idx[2])+"'	\n");
						sql3.append( " AND A.BGTYY   ='"+rows[j].getString(idx[3])+"'		\n");
						sql3.append( " AND A.BGTMM   ='"+rows[j].getString(idx[4])+"'	\n");
						sql3.append( " AND A.BGTDIV  ='"+rows[j].getString(idx[5])+"'		\n");
						sql3.append( " AND A.BGTDPT  ='"+rows[j].getString(idx[6])+"'	\n");
						sql3.append( " AND A.ATCODE  ='"+rows[j].getString(idx[7])+"'	\n");
						sql3.append( " AND A.FSREFCD ='"+rows[j].getString(idx[8])+"'	\n");
						sql3.append( " AND A.SATCODE ='"+rows[j].getString(idx[9])+"'	\n");


						stmt3 = conn.createStatement();
						rs3 = stmt3.executeQuery(sql3.toString());

						while(rs3.next())	{
							addbgt3	 = rs3.getInt(1);
							chgabgt3 = rs3.getInt(2);
							chgtbgt3 = rs3.getInt(3);
							realbgt3 = rs3.getInt(4);
						}

						/*******************************************************************
								예산편성 Master Update - 기간은 제외
						********************************************************************/
						InsertSql = new StringBuffer();
						InsertSql.append( " UPDATE ACCOUNT.BGTMST SET						\n");
						InsertSql.append( "		ADDBGT      =  "+addbgt3 +",						\n");
						InsertSql.append( "		CHGABGT     =  "+chgabgt3+",					\n");
						InsertSql.append( "		REALBGT     =  "+realbgt3+"						\n");
						InsertSql.append( " WHERE FDCODE='"+rows[j].getString(idx[2])+"'	\n");
						InsertSql.append( " AND BGTYY   ='"+rows[j].getString(idx[3])+"'		\n");
						InsertSql.append( " AND BGTDIV  ='"+rows[j].getString(idx[5])+"'		\n");
						InsertSql.append( " AND BGTDPT  ='"+rows[j].getString(idx[6])+"'		\n");
						InsertSql.append( " AND ATCODE  ='"+rows[j].getString(idx[7])+"'		\n");
						InsertSql.append( " AND FSREFCD ='"+rows[j].getString(idx[8])+"'	\n");
						InsertSql.append( " AND SATCODE ='"+rows[j].getString(idx[9])+"'	\n");


						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
						InsertSql = null;

						/*******************************************************************
								예산 신청 Master Update - 승인상태 변경
						********************************************************************/
						InsertSql2 = new StringBuffer();
						InsertSql2.append( " UPDATE ACCOUNT.BGTRQMST SET						\n");
						InsertSql2.append( "		BGTRQST = 'Y' 												\n");
						InsertSql2.append( " WHERE FDCODE='"+rows[j].getString(idx[2])+"'		\n");
						InsertSql2.append( " AND BGTRQNO ='"+rows[j].getString(idx[1])+"'			\n");


						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.executeUpdate();
						gsmt2.close();
						InsertSql2 = null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					}
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
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
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}