package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080002_t1 extends HttpServlet{
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
				conn.setAutoCommit(false);


				String []  str	= new String [10];
				str[0] = reqGauce.getParameter("v_str1");		//지점코드    
				str[1] = reqGauce.getParameter("v_str2");		//예산년도              
				str[2] = reqGauce.getParameter("v_str3");		//예산본부              
				str[3] = reqGauce.getParameter("v_str4");		//예산부서              
				str[4] = reqGauce.getParameter("v_str5");		//예산월[당초월]
				str[5] = reqGauce.getParameter("v_str6");		//당초예산승인구분
				str[6] = reqGauce.getParameter("v_str7");		//총괄

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				for(int i=0;i<=8;i++) {
					if (str[i]==null) str[i] = "";
				}

				String [] strmm = new String[12];
				strmm = str[4].split(";");
				
				String[] StrArrCN = new String[] {
					"param0", "param1", "param2", "param3","param4",
					"param5", "param6", "param7", "param8","param9",
					"param10","param11","param12","param13","param14",
					"param15","param16","param17","param18","param19",
					"param20","param21","param22","param23","param24",
					"param25","param26","param27","param28","param29",
					"param30","param31","param32","param33","param34",
					"param35","param36","param37","param38","param39"
				};

				int[] idx = new int[40];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;	
				StringBuffer UpdateSql1 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer UpdateSql3 = null;
				StringBuffer UpdateSql4 = null;
				StringBuffer DeleteSql  = null;

				Statement stmt = null;
				ResultSet rs = null;
				Statement stmt2 = null;
				ResultSet rs2 = null;
				Statement stmt22 = null;
				ResultSet rs22 = null;
				double dblbasicbgt=0;
				double dblrealbgt=0;
				String stratcode="";  //계정
				String strfsrefcd=""; //관리항목
				String strsatcode=""; //세목
				String stratcode2="";  //계정
				String strfsrefcd2=""; //관리항목
				String strsatcode2=""; //세목

				double dblinitbgt_yy=0; //예산mst 의 초기예산
				double dblrealbgt_yy=0; //예산mst 의 실행예산
				double dbltempbgt=0; //월예산의 합계

				String strGubun="";

				int inum1=0;
				int inum2=0;
				if(str[5].equals("T")){
					inum1=0;
					inum2=1;
				}else if(str[5].equals("C")){
					inum1=1;
					inum2=2;
				}
				
				for (int j=inum1;j<inum2;j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

							dbltempbgt=0; //월예산의 합계
							
							for( int m=0;m<strmm.length;m++){ 
								/*******************************************************************
									예산 Detail Data 조회
								********************************************************************/
								StringBuffer sql = new StringBuffer();
								String check = "";
								sql.append( " SELECT																			        		\n"); 
								sql.append( " RTRIM(A.FDCODE)  FDCODE,        /*지점코드*/        		\n"); 
								sql.append( " RTRIM(A.BGTYY)   BGTYY,         /*예산년도*/        		\n"); 
								sql.append( " RTRIM(A.BGTMM)   BGTMM,         /*예산월*/          		\n"); 
								sql.append( " RTRIM(A.BGTDIV)  BGTDIV,        /*예산본부*/        		\n"); 
								sql.append( " RTRIM(A.BGTDPT)  BGTDPT,        /*예산부서*/        		\n"); 
								sql.append( " RTRIM(A.ATCODE)  ATCODE,        /*계정코드*/        		\n"); 
								sql.append( " RTRIM(A.FSREFCD) FSREFCD,       /*관리항목코드*/    		\n"); 
								sql.append( " RTRIM(A.SATCODE) SATCODE,       /*세    목*/        		\n"); 
								sql.append( " CASE WHEN COALESCE(A.CHGBGT,0)=0 THEN COALESCE(A.INITBGT,0)              \n");
								sql.append( "      WHEN COALESCE(A.CHGBGT,0)>0 THEN COALESCE(A.CHGBGT,0) END BASICBGT2,\n");
								sql.append( " COALESCE(A.INITBGT,0) INITBGT,  /*신청액*/        		  \n"); 
								sql.append( " COALESCE(A.ADDBGT,0)  ADDBGT,   /*추가예산*/        		\n"); 
								sql.append( " COALESCE(A.CHGABGT,0) CHGABGT,  /*조정액*/        		  \n"); 
								sql.append( " COALESCE(A.BASICBGT,0) BASICBGT,/*배정액*/        		  \n"); 
								sql.append( " COALESCE(A.REALBGT,0) REALBGT,  /*실행예산*/        		\n"); 
								sql.append( " COALESCE(A.RESULTS,0) RESULTS,  /*실    적*/        		\n"); 
								sql.append( " RTRIM(A.APPROVAL) APPROVAL,     /*당초예산승인구분*/		\n"); 
								sql.append( " RTRIM(A.CHGAPPROV) CHGAPPROV    /*변동예산승인구분*/		\n"); 
								sql.append( " FROM ACCOUNT.BGTDTL A																		\n");
								sql.append( " WHERE A.FDCODE IS NOT NULL																	\n");
								if(!str[0].equals("")) sql.append( " AND A.FDCODE =  '"+str[0]+"'			\n");	//지점코드
								if(!str[1].equals("")) sql.append( " AND A.BGTYY  =  '"+str[1]+"'			\n");	//예산년도
								if(!str[2].equals("")) sql.append( " AND A.BGTDIV =  '"+str[2]+"'			\n");	//예산본부 
								if(!str[3].equals("")) sql.append( " AND A.BGTDPT =  '"+str[3]+"'			\n");	//예산부서
								if(!str[4].equals("")) sql.append( " AND A.BGTMM = '"+strmm[m]+"'			\n");	//예산월
								sql.append( " ORDER BY ATCODE,FSREFCD,SATCODE     										\n");

								stmt = conn.createStatement();
								rs = stmt.executeQuery(sql.toString());
                
								stratcode="";
								strfsrefcd="";
								strsatcode="";
								dblbasicbgt=0;
								dblrealbgt=0;
								dblinitbgt_yy=0; //예산mst 의 초기예산
								dblrealbgt_yy=0; //예산mst 의 실행예산
				        
								while(rs.next())	{
									dblrealbgt=0;
									dblbasicbgt=0;
									check = rs.getString(1);
									dblbasicbgt = rs.getDouble(9);  //신청액 또는 조정액 ==> 배정액
									dblrealbgt = rs.getDouble(14);  //실행예산

							    stratcode=rs.getString(6);  //계정
							    strfsrefcd=rs.getString(7); //관리항목
							    strsatcode=rs.getString(8); //세목

									if (!check.equals("")) {
										/*******************************************************************
											예산 Detail Update : 당초예산승인구분
										********************************************************************/
										if(str[5].equals("T")) {	//승인
											dblrealbgt += dblbasicbgt; //실행예산 = 실행예산 + 배정예산
											UpdateSql1 = new StringBuffer();
											UpdateSql1.append( " UPDATE ACCOUNT.BGTDTL SET													\n");
											UpdateSql1.append( " BASICBGT="+dblbasicbgt+", 												  \n");
											UpdateSql1.append( " REALBGT="+dblbasicbgt+", 						  						  \n");
											UpdateSql1.append( " APPROVAL='Y'																				\n");
											UpdateSql1.append( " WHERE FDCODE IS NOT NULL																\n");
											if(!str[0].equals("")) UpdateSql1.append( " AND FDCODE =  '"+str[0]+"'	\n");	//지점코드
											if(!str[1].equals("")) UpdateSql1.append( " AND BGTYY  =  '"+str[1]+"'	\n");	//예산년도
											if(!str[2].equals("")) UpdateSql1.append( " AND BGTDIV =  '"+str[2]+"'	\n");	//예산본부 
											if(!str[3].equals("")) UpdateSql1.append( " AND BGTDPT =  '"+str[3]+"'	\n");	//예산부서
											if(!str[4].equals("")) UpdateSql1.append( " AND BGTMM = '"+strmm[m]+"'	\n");	//예산월[당초]
											UpdateSql1.append( " AND ATCODE= '"+stratcode+"'		  \n");
											UpdateSql1.append( " AND FSREFCD= '"+strfsrefcd+"'		\n");
											UpdateSql1.append( " AND SATCODE= '"+strsatcode+"'		\n");

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql1.toString());
											gsmt.setGauceDataRow(rows[j]);
											gsmt.executeUpdate(); 
											gsmt.close();

										}else if(str[5].equals("C")) {	//취소
											if(m==0 && strGubun.equals("")){
												 strGubun="Y";
												//예산Mst에 금액 Update
												StringBuffer sql2 = new StringBuffer();
												sql2.append( " SELECT																			        		\n"); 
												sql2.append( " RTRIM(A.FDCODE)  FDCODE,        /*지점코드*/        		\n"); 
												sql2.append( " RTRIM(A.BGTYY)   BGTYY,         /*예산년도*/        		\n"); 
												sql2.append( " RTRIM(A.BGTDIV)  BGTDIV,        /*예산본부*/        		\n"); 
												sql2.append( " RTRIM(A.BGTDPT)  BGTDPT,        /*예산부서*/        		\n"); 
												sql2.append( " RTRIM(A.ATCODE)  ATCODE,        /*계정코드*/        		\n"); 
												sql2.append( " RTRIM(A.FSREFCD) FSREFCD,       /*관리항목코드*/    		\n"); 
												sql2.append( " RTRIM(A.SATCODE) SATCODE,       /*세    목*/        		\n"); 
												sql2.append( " A.REALBGT REALBGT   /*실행예산*/        		\n"); 
												sql2.append( " FROM ACCOUNT.BGTMST A																	\n");
												sql2.append( " WHERE A.FDCODE IS NOT NULL																	\n");
												if(!str[0].equals("")) sql2.append( " AND A.FDCODE =  '"+str[0]+"'		\n");	//지점코드
												if(!str[1].equals("")) sql2.append( " AND A.BGTYY  =  '"+str[1]+"'		\n");	//예산년도
												if(!str[2].equals("")) sql2.append( " AND A.BGTDIV =  '"+str[2]+"'		\n");	//예산본부 
												if(!str[3].equals("")) sql2.append( " AND A.BGTDPT =  '"+str[3]+"'		\n");	//예산부서

												stmt2 = conn.createStatement();
												rs2 = stmt2.executeQuery(sql2.toString());

												stratcode2="";  //계정
												strfsrefcd2=""; //관리항목
												strsatcode2=""; //세목
												dblrealbgt_yy=0; //예산mst 의 실행예산
												
												while(rs2.next())	{
													dblrealbgt_yy=0;
													dblrealbgt_yy = rs2.getDouble(8);   //실행예산
													stratcode2=rs2.getString(5);         //계정
													strfsrefcd2=rs2.getString(6);        //관리항목
													strsatcode2=rs2.getString(7);        //세목

													StringBuffer sql22 = new StringBuffer();
													sql22.append( " SELECT																			        		\n"); 
													sql22.append( " RTRIM(A.FDCODE)  FDCODE,        /*지점코드*/        		\n"); 
													sql22.append( " RTRIM(A.BGTYY)   BGTYY,         /*예산년도*/        		\n"); 
													sql22.append( " RTRIM(A.BGTDIV)  BGTDIV,        /*예산본부*/        		\n"); 
													sql22.append( " RTRIM(A.BGTDPT)  BGTDPT,        /*예산부서*/        		\n"); 
													sql22.append( " RTRIM(A.ATCODE)  ATCODE,        /*계정코드*/        		\n"); 
													sql22.append( " RTRIM(A.FSREFCD) FSREFCD,       /*관리항목코드*/    		\n"); 
													sql22.append( " RTRIM(A.SATCODE) SATCODE,       /*세    목*/        		\n"); 
													sql22.append( " SUM(A.REALBGT) REALBGT  /*실행예산*/        		\n"); 
													sql22.append( " FROM ACCOUNT.BGTDTL A																		\n");
													sql22.append( " WHERE A.FDCODE IS NOT NULL																	\n");
													if(!str[0].equals("")) sql22.append( " AND A.FDCODE =  '"+str[0]+"'			\n");	//지점코드
													if(!str[1].equals("")) sql22.append( " AND A.BGTYY  =  '"+str[1]+"'			\n");	//예산년도
													if(!str[2].equals("")) sql22.append( " AND A.BGTDIV =  '"+str[2]+"'			\n");	//예산본부 
													if(!str[3].equals("")) sql22.append( " AND A.BGTDPT =  '"+str[3]+"'			\n");	//예산부서
													sql22.append( "   AND A.ATCODE =  '"+stratcode2+"'			\n");
													sql22.append( "   AND A.FSREFCD =  '"+strfsrefcd2+"'			\n");
													sql22.append( "   AND A.SATCODE =  '"+strsatcode2+"'			\n");
													sql22.append( " GROUP BY A.FDCODE,A.BGTYY,A.BGTDIV,A.BGTDPT,A.ATCODE,A.FSREFCD, A.SATCODE \n");
													sql22.append( " ORDER BY A.ATCODE,A.FSREFCD,A.SATCODE     										\n");

													stmt22 = conn.createStatement();
													rs22 = stmt22.executeQuery(sql22.toString());
													
													while(rs22.next())	{
														dbltempbgt = rs22.getDouble(8); 
													}

													dblrealbgt_yy -= dbltempbgt; //실행예산 = 실행예산 - 배정예산
													UpdateSql4 = new StringBuffer();
													UpdateSql4.append( " UPDATE ACCOUNT.BGTMST SET													\n");
													UpdateSql4.append( " REALBGT="+dblrealbgt_yy+"						  						\n");
													UpdateSql4.append( " WHERE FDCODE IS NOT NULL																\n");
													if(!str[0].equals("")) UpdateSql4.append( " AND FDCODE =  '"+str[0]+"'	\n");	//지점코드
													if(!str[1].equals("")) UpdateSql4.append( " AND BGTYY  =  '"+str[1]+"'	\n");	//예산년도
													if(!str[2].equals("")) UpdateSql4.append( " AND BGTDIV =  '"+str[2]+"'	\n");	//예산본부 
													if(!str[3].equals("")) UpdateSql4.append( " AND BGTDPT =  '"+str[3]+"'	\n");	//예산부서
													UpdateSql4.append( " AND ATCODE= '"+stratcode2+"'		  \n");
													UpdateSql4.append( " AND FSREFCD= '"+strfsrefcd2+"'		\n");
													UpdateSql4.append( " AND SATCODE= '"+strsatcode2+"'		\n");

													GauceStatement gsmt4 = conn.getGauceStatement(UpdateSql4.toString());
													gsmt4.setGauceDataRow(rows[j]);
													gsmt4.executeUpdate(); 
													gsmt4.close();
													dbltempbgt=0;
												}//while
									  	}// if

											dblrealbgt -= dblbasicbgt; //실행예산 = 실행예산 - 배정예산 
											UpdateSql2 = new StringBuffer();
											UpdateSql2.append( " UPDATE ACCOUNT.BGTDTL SET														\n");
											UpdateSql2.append( " BASICBGT=0,																					\n");
											UpdateSql2.append( " REALBGT="+dblrealbgt+", 						  								\n");
											UpdateSql2.append( " APPROVAL='N'																					\n");
											UpdateSql2.append( " WHERE FDCODE IS NOT NULL																	\n");
											if(!str[0].equals("")) UpdateSql2.append( " AND FDCODE =  '"+str[0]+"'		\n");	//지점코드
											if(!str[1].equals("")) UpdateSql2.append( " AND BGTYY  =  '"+str[1]+"'		\n");	//예산년도
											if(!str[2].equals("")) UpdateSql2.append( " AND BGTDIV =  '"+str[2]+"'		\n");	//예산본부 
											if(!str[3].equals("")) UpdateSql2.append( " AND BGTDPT =  '"+str[3]+"'		\n");	//예산부서
											if(!str[4].equals("")) UpdateSql2.append( " AND BGTMM =   '"+strmm[m]+"'	\n");	//예산월[당초]
											UpdateSql2.append( "												AND APPROVAL='Y'							\n");	//승인건
											UpdateSql2.append( " AND ATCODE= '"+stratcode+"'		  \n");
											UpdateSql2.append( " AND FSREFCD= '"+strfsrefcd+"'		\n");
											UpdateSql2.append( " AND SATCODE= '"+strsatcode+"'		\n");

											GauceStatement gsmt = conn.getGauceStatement(UpdateSql2.toString());
											gsmt.setGauceDataRow(rows[j]);
											gsmt.executeUpdate(); 
											gsmt.close();
										}
									}
							} //while

							if(m==strmm.length-1&&str[5].equals("T")){
								/*예산Mst에 금액 Update*/
								StringBuffer sql2 = new StringBuffer();
								sql2.append( " SELECT																			        		\n"); 
								sql2.append( " RTRIM(A.FDCODE)  FDCODE,        /*지점코드*/        		\n"); 
								sql2.append( " RTRIM(A.BGTYY)   BGTYY,         /*예산년도*/        		\n"); 
								sql2.append( " RTRIM(A.BGTDIV)  BGTDIV,        /*예산본부*/        		\n"); 
								sql2.append( " RTRIM(A.BGTDPT)  BGTDPT,        /*예산부서*/        		\n"); 
								sql2.append( " RTRIM(A.ATCODE)  ATCODE,        /*계정코드*/        		\n"); 
								sql2.append( " RTRIM(A.FSREFCD) FSREFCD,       /*관리항목코드*/    		\n"); 
								sql2.append( " RTRIM(A.SATCODE) SATCODE,       /*세    목*/        		\n"); 
								sql2.append( " A.REALBGT REALBGT   /*실행예산*/        		\n"); 
								sql2.append( " FROM ACCOUNT.BGTMST A																	\n");
								sql2.append( " WHERE A.FDCODE IS NOT NULL																	\n");
								if(!str[0].equals("")) sql2.append( " AND A.FDCODE =  '"+str[0]+"'		\n");	//지점코드
								if(!str[1].equals("")) sql2.append( " AND A.BGTYY  =  '"+str[1]+"'		\n");	//예산년도
								if(!str[2].equals("")) sql2.append( " AND A.BGTDIV =  '"+str[2]+"'		\n");	//예산본부 
								if(!str[3].equals("")) sql2.append( " AND A.BGTDPT =  '"+str[3]+"'		\n");	//예산부서

								stmt2 = conn.createStatement();
								rs2 = stmt2.executeQuery(sql2.toString());

								stratcode="";  //계정
								strfsrefcd=""; //관리항목
								strsatcode=""; //세목
								dblrealbgt_yy=0; //예산mst 의 실행예산
								
								while(rs2.next())	{
									dblrealbgt_yy=0;
									dblrealbgt_yy = rs2.getDouble(8);   //실행예산
									stratcode=rs2.getString(5);         //계정
									strfsrefcd=rs2.getString(6);        //관리항목
									strsatcode=rs2.getString(7);        //세목

									StringBuffer sql22 = new StringBuffer();
									sql22.append( " SELECT																			        		\n"); 
									sql22.append( " RTRIM(A.FDCODE)  FDCODE,        /*지점코드*/        		\n"); 
									sql22.append( " RTRIM(A.BGTYY)   BGTYY,         /*예산년도*/        		\n"); 
									sql22.append( " RTRIM(A.BGTDIV)  BGTDIV,        /*예산본부*/        		\n"); 
									sql22.append( " RTRIM(A.BGTDPT)  BGTDPT,        /*예산부서*/        		\n"); 
									sql22.append( " RTRIM(A.ATCODE)  ATCODE,        /*계정코드*/        		\n"); 
									sql22.append( " RTRIM(A.FSREFCD) FSREFCD,       /*관리항목코드*/    		\n"); 
									sql22.append( " RTRIM(A.SATCODE) SATCODE,       /*세    목*/        		\n"); 
									sql22.append( " SUM(A.REALBGT) REALBGT  /*실행예산*/        		\n"); 
									sql22.append( " FROM ACCOUNT.BGTDTL A																		\n");
									sql22.append( " WHERE A.FDCODE IS NOT NULL																	\n");
									if(!str[0].equals("")) sql22.append( " AND A.FDCODE =  '"+str[0]+"'			\n");	//지점코드
									if(!str[1].equals("")) sql22.append( " AND A.BGTYY  =  '"+str[1]+"'			\n");	//예산년도
									if(!str[2].equals("")) sql22.append( " AND A.BGTDIV =  '"+str[2]+"'			\n");	//예산본부 
									if(!str[3].equals("")) sql22.append( " AND A.BGTDPT =  '"+str[3]+"'			\n");	//예산부서
									sql22.append( "   AND A.ATCODE =  '"+stratcode+"'			\n");
									sql22.append( "   AND A.FSREFCD =  '"+strfsrefcd+"'			\n");
									sql22.append( "   AND A.SATCODE =  '"+strsatcode+"'			\n");
									sql22.append( " GROUP BY A.FDCODE,A.BGTYY,A.BGTDIV,A.BGTDPT,A.ATCODE,A.FSREFCD, A.SATCODE \n");
									sql22.append( " ORDER BY A.ATCODE,A.FSREFCD,A.SATCODE     										\n");

									stmt22 = conn.createStatement();
									rs22 = stmt22.executeQuery(sql22.toString());
									dbltempbgt=0;
									
									while(rs22.next())	{
										dbltempbgt = rs22.getDouble(8); 
									}

									dblrealbgt_yy += dbltempbgt; //실행예산 = 실행예산 + 배정예산(합계)
									UpdateSql3 = new StringBuffer();
									UpdateSql3.append( " UPDATE ACCOUNT.BGTMST SET													\n");
									UpdateSql3.append( " REALBGT="+dblrealbgt_yy+"  				  						  \n");
									UpdateSql3.append( " WHERE FDCODE IS NOT NULL																\n");
									if(!str[0].equals("")) UpdateSql3.append( " AND FDCODE =  '"+str[0]+"'	\n");	//지점코드
									if(!str[1].equals("")) UpdateSql3.append( " AND BGTYY  =  '"+str[1]+"'	\n");	//예산년도
									if(!str[2].equals("")) UpdateSql3.append( " AND BGTDIV =  '"+str[2]+"'	\n");	//예산본부 
									if(!str[3].equals("")) UpdateSql3.append( " AND BGTDPT =  '"+str[3]+"'	\n");	//예산부서
									UpdateSql3.append( " AND ATCODE= '"+stratcode+"'		  \n");
									UpdateSql3.append( " AND FSREFCD= '"+strfsrefcd+"'		\n");
									UpdateSql3.append( " AND SATCODE= '"+strsatcode+"'		\n");


									GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
									gsmt3.setGauceDataRow(rows[j]);
									gsmt3.executeUpdate(); 
									gsmt3.close();
									dbltempbgt=0;
								}//while
							}// if
						} // for m
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {

					}
				}//for j
			}catch(Exception e){
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