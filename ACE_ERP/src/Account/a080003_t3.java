package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080003_t3 extends HttpServlet{
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

				String str1  = reqGauce.getParameter("v_str1");		//신청서번호(생성-I)
				String str2  = reqGauce.getParameter("v_str2");		//저장구분[mst(A)-I,U] OR [dtl_1(B)-I,U]
				String str3  = reqGauce.getParameter("v_str3");		//신청서번호(기존-U)
				String str4  = reqGauce.getParameter("v_str4");		//작성월

				String str5  = reqGauce.getParameter("v_str5");		//예산년도
				String str6  = reqGauce.getParameter("v_str6");		//예산부서
				String str7  = reqGauce.getParameter("v_str7");		//관리항목코드
				String str8  = reqGauce.getParameter("v_str8");		//예산타입
				String str9  = reqGauce.getParameter("v_str9");		//예산계정
				String str10 = reqGauce.getParameter("v_str10");	//세세목

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"FDCODE","BGTRQNO","BGTRQSEQ","BGTRQDIV","BGTRQAMT",
					"BGTTOMON","BGTFRMON","DVTFRACT","DVTFRSATCD","WHYRQNOTE",
					"BGTFRDEPT"
				};

				int[] idx = new int[11];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer Insertsql2_2_2 = null;	//예산Detail
				StringBuffer Updatesql2_2_2 = null;
				StringBuffer Updatesql3_2_2 = null;
				StringBuffer DeleteSql_2    = null;

				StringBuffer Insertsql3_2_2 = null;	//예산Detail(2)

				StringBuffer Updatesql4_2_2 = null;	//예산Detail(3)
				StringBuffer Insertsql4_2_2 = null;	//예산Detail(3)

				Statement stmt3_2 = null;
				ResultSet rs3_2 = null;

				Statement stmt2_2 = null;
				ResultSet rs2_2 = null;

				Statement stmt4_2 = null;
				ResultSet rs4_2 = null;

				Statement stmt5_2 = null;
				ResultSet rs5_2 = null;

				Statement stmt6_2 = null;
				ResultSet rs6_2 = null;

				Statement stmt7_2 = null;
				ResultSet rs7_2 = null;

				Statement stmt8_2 = null;
				ResultSet rs8_2 = null;

				Statement stmt9_2 = null;
				ResultSet rs9_2 = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						if(str2.equals("BI")) {	//only dtl_1(I) save
							/*******************************************************************
									1. 예산 신청 Master 신청서번호  
							********************************************************************/
							String Sbgtrqno2 = rows[j].getString(idx[1]);
							StringBuffer sql3_2 = new StringBuffer();

							sql3_2.append( " SELECT																			\n"); 
							sql3_2.append( " MAX(BGTRQNO) AS CNT				/*신청서번호*/				\n"); 
							sql3_2.append( " FROM ACCOUNT.BGTRQMST												\n"); 
							sql3_2.append( " WHERE FDCODE='"+rows[j].getString(idx[0])+"'					\n");

							stmt3_2 = conn.createStatement();
							rs3_2 = stmt3_2.executeQuery(sql3_2.toString());

							while(rs3_2.next())	{
								Sbgtrqno2 = rs3_2.getString(1) + "";
							}

							if (Sbgtrqno2.equals("0")) { 
								Sbgtrqno2 = "BR" + str1 + "0001";			//최초생성
							}else{
								Sbgtrqno2 = Sbgtrqno2 + "";						//추가생성
							}

							/*******************************************************************
										예산 신청 Detail(1) InSert 
							********************************************************************/
							String Seq  = rows[j].getString(idx[2]);
							String fdcd = rows[j].getString(idx[0]);
							String Chk02 = "";
							StringBuffer sql2_2 = new StringBuffer();

							sql2_2.append( " SELECT												 						\n"); 
							sql2_2.append( " CAST(MAX(BGTRQSEQ) AS INTEGER)+1 CNT	/*순번*/		\n"); 
							sql2_2.append( " FROM ACCOUNT.BGTRQDTL1										\n"); 
							sql2_2.append( " WHERE FDCODE='"+rows[j].getString(idx[0])+"'				\n");
							sql2_2.append( " AND BGTRQNO='"+Sbgtrqno2+"'										\n");

							stmt2_2 = conn.createStatement();
							rs2_2 = stmt2_2.executeQuery(sql2_2.toString());

							while(rs2_2.next())	{
								Seq = rs2_2.getInt(1) + "";
							}

							if (Seq.equals(null)) {
								Seq = "01";				Chk02 = "N";		//최초생성
							}else{	
								if(Seq.length()<2){
									if (Seq.equals("0")) {	
										Seq = "01";							Chk02 = "N";		//최초생성
									}else	{
										Seq = "0" + Seq + "";		Chk02 = "N";		//추가생성
									}
								}else{
										Seq = Seq + "";					Chk02 = "N";		//추가생성
								}
							}

							if (Chk02.equals("N"))	{	//New Insert
								Insertsql2_2_2 = new StringBuffer();
								Insertsql2_2_2.append( " INSERT INTO ACCOUNT.BGTRQDTL1 (									\n");
								Insertsql2_2_2.append( " FDCODE,  BGTRQNO, BGTRQSEQ,BGTRQDIV,  BGTRQAMT, 	\n");
								Insertsql2_2_2.append( " BGTTOMON,BGTFRMON,DVTFRACT,DVTFRSATCD,WHYRQNOTE,	\n");
								Insertsql2_2_2.append( " BGTFRDEPT,BGTRQST																\n");
								Insertsql2_2_2.append( " ) VALUES(																				\n");
								Insertsql2_2_2.append( " '"+fdcd+"','"+Sbgtrqno2+"','"+Seq+"',?,?, 				\n");
								Insertsql2_2_2.append( " ?, ?, ?, ?, ?, ?, 'R'														\n");
								Insertsql2_2_2.append( " )																								\n");

								GauceStatement gsmt = conn.getGauceStatement(Insertsql2_2_2.toString());
								gsmt.setGauceDataRow(rows[j]);

								for(int s=1;s<=8;s++) {
									gsmt.bindColumn(s, idx[s+2]);
								}

								gsmt.executeUpdate();
								gsmt.close();
								Insertsql2_2_2 = null;

								/*******************************************************************
									예산 Detail(2) Insert
								*******************************************************************/
								StringBuffer sql4_2 = new StringBuffer();
								int amt01 = 0;	/*요청액*/
								sql4_2.append( " SELECT              								\n");	
								sql4_2.append( "	COALESCE(A.BGTRQAMT,0) BGTRQAMT	  \n");
								sql4_2.append( " FROM ACCOUNT.BGTRQDTL2 A						\n");
								sql4_2.append( " WHERE A.FDCODE IS NOT NULL								\n");
								sql4_2.append( " AND A.FDCODE  = '"+fdcd+"'					\n");
								sql4_2.append( " AND A.BGTRQNO = '"+Sbgtrqno2+"'		\n");

								stmt4_2 = conn.createStatement();
								rs4_2 = stmt4_2.executeQuery(sql4_2.toString());

								while(rs4_2.next())	{
									amt01 = rs4_2.getInt(1);
								}

								if(amt01 != 0) {
									Insertsql3_2_2 = new StringBuffer();
									Insertsql3_2_2.append( " UPDATE ACCOUNT.BGTRQDTL2 SET   							\n");  
									Insertsql3_2_2.append( " BGTRQAMT="+amt01+"+"+rows[j].getInt(idx[4])+"\n");  
									Insertsql3_2_2.append( " WHERE FDCODE='"+fdcd+"'											\n");
									Insertsql3_2_2.append( " AND BGTRQNO='"+Sbgtrqno2+"'									\n");  

									GauceStatement gsmt4 = conn.getGauceStatement(Insertsql3_2_2.toString());
									gsmt4.setGauceDataRow(rows[j]);
									gsmt4.executeUpdate();
									gsmt4.close();
									Insertsql3_2_2 = null;
								}

								/*******************************************************************
									예산 Detail 조회 - Insert 체크(기존/생성)구분
										+ Detail(3) Update
								********************************************************************/
								StringBuffer sql7_2 = new StringBuffer();
								String bgttomon = "";
								String Smon = "";
								sql7_2.append( " SELECT A.BGTRQMON	/*예산월*/									\n");	
								sql7_2.append( " FROM ACCOUNT.BGTRQDTL3 A												\n");
								sql7_2.append( " WHERE A.FDCODE='"+rows[j].getString(idx[0])+"'	\n");
								sql7_2.append( " AND A.BGTRQNO='"+Sbgtrqno2+"'									\n");
								sql7_2.append( " AND A.BGTRQMON='"+str4+"'											\n");

								stmt7_2 = conn.createStatement();
								rs7_2   = stmt7_2.executeQuery(sql7_2.toString());

								while(rs7_2.next())	{
									bgttomon = rs7_2.getString(1);
								}

								Smon = bgttomon;

								/*******************************************************************
									예산 Detail(3) 조회 - 전용계산(배정월의 계정,세목에 대한 금액SUM)
										+ Detail(3) Insert or Update에 필요
								********************************************************************/
								StringBuffer sql9_2 = new StringBuffer();
								String chk01 = "";
								sql9_2.append( " SELECT 																									\n");	
								sql9_2.append( " RTRIM(A.ATCODE)  ATCODE,		/*계정*/											\n");	
								sql9_2.append( " RTRIM(A.SATCODE) SATCODE 	/*세목*/											\n");	
								sql9_2.append( " FROM ACCOUNT.BGTRQMST A																	\n");
								sql9_2.append( " LEFT JOIN ACCOUNT.BGTRQDTL1 B ON A.FDCODE=B.FDCODE AND A.BGTRQNO=B.BGTRQNO	\n");
								sql9_2.append( " WHERE A.FDCODE   = '"+rows[j].getString(idx[0])+"'				\n");
								sql9_2.append( "   AND A.BGTRQNO  = '"+Sbgtrqno2+"'												\n");
								sql9_2.append( "   AND B.BGTTOMON = '"+rows[j].getString(idx[5])+"'				\n");//배정월

								stmt8_2 = conn.createStatement();
								rs8_2   = stmt8_2.executeQuery(sql9_2.toString());

								while(rs8_2.next())	{
									chk01 = rs8_2.getString(1);
								}

								/*******************************************************************
									예산 Detail 조회 - 신청상태,실행예산
										+ Detail(3) Update
								********************************************************************/
								StringBuffer sql6_2 = new StringBuffer();
								int sbasbgt = 0;	/*배정액*/
								int saddbgt = 0;	/*추가예산*/
								sql6_2.append( " SELECT COALESCE(A.BASICBGT,0) BASICBGT,	/*기본예산*/	\n");	
								sql6_2.append( "				COALESCE(A.ADDBGT,0) ADDBGT				/*추가예산*/	\n");	
								sql6_2.append( " FROM ACCOUNT.BGTDTL A																	\n");
								sql6_2.append( " LEFT JOIN ACCOUNT.BGTRQMST B ON A.FDCODE=B.FDCODE      \n");
								sql6_2.append( " AND A.BGTYY=B.BGTYY AND A.BGTMM=SUBSTR(B.WRDT,5,2) AND A.BGTDIV=B.BGTDIV	\n");
								sql6_2.append( " AND A.BGTDPT=B.BGTDPT AND A.ATCODE=B.ATCODE AND A.FSREFCD=B.FSREFCD     	\n");
								sql6_2.append( " AND A.SATCODE=B.SATCODE                                                 	\n");
								sql6_2.append( " WHERE A.FDCODE IS NOT NULL																\n");
								sql6_2.append( "   AND A.FDCODE  = '"+rows[j].getString(idx[0])+"'	\n");	//지점코드
								sql6_2.append( "   AND A.BGTYY   = '"+str5+"'												\n");	//예산년도
								sql6_2.append( "   AND A.BGTDPT  = '"+str6+"'												\n");	//예산부서
								sql6_2.append( "   AND A.FSREFCD = '"+str7+"'												\n");	//관리항목코드
								sql6_2.append( "   AND A.BGTMACT = '"+str8+"'												\n");	//예산타입
								sql6_2.append( "   AND A.ATCODE  = '"+str9+"'												\n");	//예산계정
								sql6_2.append( "   AND A.SATCODE = '"+str10+"'											\n");	//세세목
								sql6_2.append( "   AND B.BGTRQST = 'Y' 															\n");	//신청서상태[완료]
								
								stmt5_2 = conn.createStatement();
								rs5_2   = stmt5_2.executeQuery(sql6_2.toString());
								while(rs5_2.next())	{
									sbasbgt = rs5_2.getInt(1);
									saddbgt = rs5_2.getInt(2);
								}

								/*******************************************************************
									예산 Master 조회 - 신청상태,실행예산,실적+결재전실적
									 + 예산 Detail(3) Update
								********************************************************************/
								StringBuffer sql5_2 = new StringBuffer();
								String token = "";/*신청상태*/
								int stotbgt = 0;	/*총예산*/
								int sresult = 0;	/*실  적*/
								sql5_2.append( " SELECT B.BGTRQST,												/*신청상태*/									\n");
								sql5_2.append( "				COALESCE(A.REALBGT,0) REALBGT,		/*실행예산*/									\n");	
								sql5_2.append( "				COALESCE(A.RESULTS+A.BRESULTS,0) RESULT	/*실적+결재전실적*/			\n");	
								sql5_2.append( " FROM ACCOUNT.BGTMST A																									\n");
								sql5_2.append( " LEFT JOIN ACCOUNT.BGTRQMST B ON A.FDCODE=B.FDCODE											\n");
								sql5_2.append( " AND A.BGTYY=B.BGTYY AND A.BGTDIV=B.BGTDIV AND A.BGTDPT=B.BGTDPT				\n");
								sql5_2.append( " AND A.ATCODE=B.ATCODE AND A.FSREFCD=B.FSREFCD AND A.SATCODE=B.SATCODE	\n");
								sql5_2.append( " WHERE A.FDCODE IS NOT NULL																										\n");
								sql5_2.append( " AND A.FDCODE  = '"+rows[j].getString(idx[0])+"'							\n");	//지점코드
								sql5_2.append( " AND A.BGTYY   = '"+str5+"'															\n");	//예산년도
								sql5_2.append( " AND A.BGTDPT  = '"+str6+"'														\n");	//예산부서
								sql5_2.append( " AND A.FSREFCD = '"+str7+"'														\n");	//관리항목코드
								sql5_2.append( " AND A.BGTMACT = '"+str8+"'														\n");	//예산타입
								sql5_2.append( " AND A.ATCODE  = '"+str9+"'														\n");	//예산계정
								sql5_2.append( " AND A.SATCODE = '"+str10+"'														\n");	//세세목
								sql5_2.append( " AND B.BGTRQST = 'Y' 																\n");	//신청서상태[완료]

								stmt9_2 = conn.createStatement();
								rs9_2   = stmt9_2.executeQuery(sql5_2.toString());

								while(rs9_2.next())	{
									token   = rs9_2.getString(1);
									stotbgt = rs9_2.getInt(2);
									sresult = rs9_2.getInt(3);
								}

								//logger.dbg.println(this, "DTL[5]");

								/*******************************************************************
									예산 Detail(1) 조회  - 신청금액(BGTRQAMT)
									 + 예산 Detail(3) Update
								********************************************************************/
								StringBuffer sql8_2 = new StringBuffer();
								int gbgtrqamt = 0;	/*신청금액*/
								sql8_2.append( " SELECT																								\n");
								sql8_2.append( " A.FDCODE,A.BGTRQNO,A.BGTTOMON,B.ATCODE,B.SATCODE,					\n");
								sql8_2.append( " B.BGTRQST,A.BGTRQAMT																	\n");
								sql8_2.append( " FROM ACCOUNT.BGTRQDTL1 A																\n");
								sql8_2.append( " LEFT JOIN ACCOUNT.BGTRQMST B ON A.FDCODE=B.FDCODE					\n");
								sql8_2.append( "												AND A.BGTRQNO=B.BGTRQNO					\n");
								sql8_2.append( " WHERE A.FDCODE IS NOT NULL																\n");
								sql8_2.append( " AND A.FDCODE  = '"+rows[j].getString(idx[0])+"'								\n");
								sql8_2.append( " AND A.BGTTOMON= '"+str4+"'															\n");
								sql8_2.append( " AND B.ATCODE  = '"+str9+"'															\n");
								sql8_2.append( " AND B.SATCODE = '"+str10+"'															\n");
								sql8_2.append( " AND B.BGTRQST = 'Y'																		\n");

								stmt6_2 = conn.createStatement();
								rs6_2   = stmt6_2.executeQuery(sql8_2.toString());

								while(rs6_2.next())	{
									gbgtrqamt = rs6_2.getInt(7);
								}

								int gubun1 = Integer.parseInt(rows[j].getString(idx[5]));
								int gubun2 = Integer.parseInt(rows[j].getString(idx[6]));
								
								if(token.equals("Y")) {	//신청상태[결재완료]일때
									if(!Smon.equals("")) {	//기존
										
										Updatesql4_2_2 = new StringBuffer();
										Updatesql4_2_2.append( " UPDATE ACCOUNT.BGTRQDTL3 SET	\n");
										
										if(rows[j].getString(idx[3]).equals("02")) {	//신청구분[기간전용]

											if(Integer.parseInt(str4)==gubun1 && Integer.parseInt(str4)<gubun2) {
												//기준월(wrdt)이 배정월과 같고 피배정월보다 작을 때 
												Updatesql4_2_2.append( " AMTFROMB  = "+gbgtrqamt+" \n");	//전기이월

											}else if(gubun1>Integer.parseInt(str4) && Integer.parseInt(str4)==gubun2) {	
												//기준월(wrdt)이 배정월보다 크고 피배정월과 같을때
												Updatesql4_2_2.append( " AMTGIVETO = "+gbgtrqamt+" \n");	//차기이월

											}else if(Integer.parseInt(str4)==gubun1 && Integer.parseInt(str4)>gubun2) {
												//기준월(wrdt)이 배정월과 같고 피배정월이 배정월보다 클때
												Updatesql4_2_2.append( " AMTFROMA  = "+gbgtrqamt+" \n");	//조기집행

											}else if(Integer.parseInt(str4)<gubun1 && Integer.parseInt(str4)==gubun2) {	
												//기준월(wrdt)이 배정월보다 작고 피배정월과 같을때
												Updatesql4_2_2.append( " AMTGVTOB  = "+gbgtrqamt+" \n");	//피조기집행

											}											

											Updatesql4_2_2.append( " WHERE FDCODE=	'"+fdcd+"'											\n");
											Updatesql4_2_2.append( "	 AND BGTRQNO=	'"+Sbgtrqno2+"'									\n");
											Updatesql4_2_2.append( "	 AND BGTRQMON='"+rows[j].getString(idx[5])+"'	\n");

											
											GauceStatement gsmt8 = conn.getGauceStatement(Updatesql4_2_2.toString());
											gsmt8.setGauceDataRow(rows[j]);
											gsmt8.executeUpdate(); 
											gsmt8.close();
										
										}else if(Smon.equals("")) {	//생성

											/*******************************************************************
												예산 Master 조회 - 예산 신청 Detail(3) Insert
											*******************************************************************/
											Insertsql4_2_2 = new StringBuffer();

											Insertsql4_2_2.append( " INSERT INTO ACCOUNT.BGTRQDTL3 (							\n");
											Insertsql4_2_2.append( " FDCODE,BGTRQNO,BGTRQMON,BGTAMT,BGTADAMT,			\n");
											Insertsql4_2_2.append( " TOTBGTAMT,RESULTAMT													\n");
											Insertsql4_2_2.append( " ) VALUES(																		\n");
  
											Insertsql4_2_2.append( " '"+rows[j].getString(idx[0])+"',							\n");//지점구분
											Insertsql4_2_2.append( " '"+Sbgtrqno2+"',															\n");//신청서번호
											
											if(rows[j].getString(idx[3]).equals("03")&&chk01.equals("B")) {	//항목전용이면서 배정월 기준
												Insertsql4_2_2.append( " '"+rows[j].getString(idx[5])+"',	\n");//DTL1의 배정월
											}else if(rows[j].getString(idx[3]).equals("03")&&chk01.equals("P")) {	//항목전용이면서 피전용월 기준
												Insertsql4_2_2.append( " '"+rows[j].getString(idx[6])+"',	\n");//DTL1의 피전용월
											}else{
												Insertsql4_2_2.append( " '"+str4+"',											\n");//회계월
											}
											
											Insertsql4_2_2.append( "  "+sbasbgt+",																\n");//배정액
											Insertsql4_2_2.append( "  "+saddbgt+",																\n");//추가예산
											Insertsql4_2_2.append( "  "+stotbgt+",																\n");//총예산
											Insertsql4_2_2.append( "  "+sresult+"																	\n");//실적
											Insertsql4_2_2.append( " )																						\n");

											GauceStatement gsmt6 = conn.getGauceStatement(Insertsql4_2_2.toString());
											gsmt6.setGauceDataRow(rows[j]);
											gsmt6.executeUpdate();
											gsmt6.close();
										}
									}
								}
							}
						}
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						/*******************************************************************
								예산 Detail(1) Update
						********************************************************************/
						if(str2.equals("BI")) {	
							Updatesql2_2_2 = new StringBuffer();
							Updatesql2_2_2.append( " UPDATE ACCOUNT.BGTRQDTL1 SET										\n");
							Updatesql2_2_2.append( " BGTRQDIV = ?,  BGTRQAMT = ?,  BGTTOMON = ?,		\n");
							Updatesql2_2_2.append( " BGTFRMON = ?,  DVTFRACT = ?,  DVTFRSATCD = ?,	\n");
							Updatesql2_2_2.append( " WHYRQNOTE = ?, BGTFRDEPT =?,	 BGTRQST = 'R'		\n");
							Updatesql2_2_2.append( " WHERE FDCODE=? AND BGTRQNO=?	 AND BGTRQSEQ=?		\n");

							GauceStatement gsmt = conn.getGauceStatement(Updatesql2_2_2.toString());
							gsmt.setGauceDataRow(rows[j]);

							for(int t=1;t<=8;t++) {
								gsmt.bindColumn(t, idx[t+2]);
							}

							gsmt.bindColumn(9,  idx[0]);
							gsmt.bindColumn(10, idx[1]);
							gsmt.bindColumn(11, idx[2]);

							gsmt.executeUpdate(); 
							gsmt.close();
						}
					}
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						/*******************************************************************
								예산 Detail Delete
						********************************************************************/
						DeleteSql_2 = new StringBuffer();
						DeleteSql_2.append( " DELETE FROM ACCOUNT.BGTRQDTL1											");
						DeleteSql_2.append( " WHERE FDCODE = ? AND BGTRQNO = ? AND BGTRQSEQ = ? ");
			
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql_2.toString());
						gsmt.setGauceDataRow(rows[j]);

						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
						gsmt.executeUpdate(); 
						gsmt.close();
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