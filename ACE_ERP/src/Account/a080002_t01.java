package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080002_t01 extends HttpServlet{
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
					"ATCODE",  "ATKORNAM", "SATNM",   "BGTMM01", "BGTMM02", 
					"BGTMM03", "BGTMM04",  "BGTMM05", "BGTMM06", "BGTMM07",
					"BGTMM08", "BGTMM09",  "BGTMM10", "BGTMM11", "BGTMM12", 
					"BASMM01", "BASMM02",  "BASMM03", "BASMM04", "BASMM05",
					"BASMM06", "BASMM07",  "BASMM08", "BASMM09", "BASMM10",
					"BASMM11", "BASMM12",	 "CHGMM01", "CHGMM02", "CHGMM03", 
					"CHGMM04", "CHGMM05",	 "CHGMM06", "CHGMM07", "CHGMM08", 
					"CHGMM09", "CHGMM10",	 "CHGMM11", "CHGMM12", "BGTSUM",  
					"BASSUM" , "CHGSUM" ,  "APPROVAL","CHK"    , "FDCODE",
					"BGTYY"  , "BGTMM"  ,  "BGTDIV" , "BGTDPT" , "FSREFCD",
					"SATCODE", "BGTMACT"
				};

				int[] idx = new int[52];
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

		        String strATCODE="";  //0
		        String strFDCODE="";  //44
		        String strBGTYY="";   //45
		        String strBGTMM="";   //46
		        String strBGTDIV="";  //47
		        String strBGTDPT="";  //48
		        String strFSREFCD=""; //49
		        String strSATCODE=""; //50
		        String strBGTMACT=""; //51
		
		        String strMM = "";


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
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						dbltempbgt=0; //월예산의 합계
				             for( int m=0;m<strmm.length;m++){ 
				
				                strATCODE =rows[j].getString(idx[0]).trim(); 
				                strFDCODE =rows[j].getString(idx[44]).trim();
				                strBGTYY  =rows[j].getString(idx[45]).trim();
				                strBGTMM  =rows[j].getString(idx[46]).trim();
				                strBGTDIV =rows[j].getString(idx[47]).trim();
				                strBGTDPT =rows[j].getString(idx[48]).trim();
				                strFSREFCD=rows[j].getString(idx[49]).trim();
				                strSATCODE=rows[j].getString(idx[50]).trim();
				                strBGTMACT=rows[j].getString(idx[51]).trim();


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
								sql.append( " FROM ACCOUNT.BGTDTL A									\n");
								sql.append( " WHERE A.FDCODE IS NOT NULL							\n");
								if(!strATCODE.equals("")) sql.append( " AND A.ATCODE = '"+strATCODE+"'		                      \n");	//계정과목
								if(!strFDCODE.equals("")) sql.append( " AND A.FDCODE =  '"+strFDCODE+"'			                    \n");	//지점코드
								if(!strBGTYY.equals("")) sql.append( " AND A.BGTYY  =  '"+strBGTYY+"'			                    \n");	//예산년도
								if(!strBGTDIV.equals("")) sql.append( " AND A.BGTDIV =  '"+strBGTDIV+"'			                    \n");	//예산본부 
								if(!strBGTDPT.equals("")) sql.append( " AND A.BGTDPT =  '"+strBGTDPT+"'			                    \n");	//예산부서
								if(!strFSREFCD.equals("")) sql.append( " AND A.FSREFCD = '"+strFSREFCD+"'                        \n");
								if(!strSATCODE.equals("")) sql.append( " AND A.SATCODE = '"+strSATCODE+"'                        \n");
								if(!strBGTMACT.equals("")) sql.append( " AND A.BGTMACT = '"+strBGTMACT+"'                        \n");


								sql.append( " ORDER BY ATCODE,FSREFCD,SATCODE     										\n");

								//System.out.println("a080002_t01::"+sql.toString()); 
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
									strMM = rs.getString("BGTMM");
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
											UpdateSql1.append( " BASICBGT="+dblbasicbgt+", 												    \n");
											UpdateSql1.append( " REALBGT="+dblbasicbgt+", 						  						    \n");
											UpdateSql1.append( " APPROVAL='Y'																\n");
											UpdateSql1.append( " WHERE FDCODE IS NOT NULL   												\n");
					                      if(!strATCODE.equals("")) UpdateSql1.append( " AND ATCODE = '"+strATCODE+"'                       \n");
					                      if(!strFDCODE.equals("")) UpdateSql1.append( " AND FDCODE =  '"+strFDCODE+"'                      \n");
					                      if(!strBGTYY.equals("")) UpdateSql1.append( " AND BGTYY  =  '"+strBGTYY+"'                        \n");
					                      if(!strBGTDIV.equals("")) UpdateSql1.append( " AND BGTDIV =  '"+strBGTDIV+"'                      \n");
					                      if(!strBGTDPT.equals("")) UpdateSql1.append( " AND BGTDPT =  '"+strBGTDPT+"'                      \n");
					                      if(!strFSREFCD.equals("")) UpdateSql1.append( " AND FSREFCD = '"+strFSREFCD+"'                     \n");
					                      if(!strSATCODE.equals("")) UpdateSql1.append( " AND SATCODE = '"+strSATCODE+"'                     \n");
					                      if(!strBGTMACT.equals("")) UpdateSql1.append( " AND BGTMACT = '"+strBGTMACT+"'                     \n");
					                      if(!str[4].equals("")) UpdateSql1.append( " AND BGTMM = '"+strMM+"'	\n");	//예산월[당초]
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
												sql2.append( " A.REALBGT REALBGT   /*실행예산*/                   		\n"); 
												sql2.append( " FROM ACCOUNT.BGTMST A									\n");
												sql2.append( " WHERE A.FDCODE IS NOT NULL								\n");
						                        if(!strATCODE.equals("")) sql2.append( " AND A.ATCODE = '"+strATCODE+"'                       \n");
						                        if(!strFDCODE.equals("")) sql2.append( " AND A.FDCODE =  '"+strFDCODE+"'                      \n");
						                        if(!strBGTYY.equals("")) sql2.append( " AND A.BGTYY  =  '"+strBGTYY+"'                       \n");
						                        if(!strBGTDIV.equals("")) sql2.append( " AND A.BGTDIV =  '"+strBGTDIV+"'                      \n");
						                        if(!strBGTDPT.equals("")) sql2.append( " AND A.BGTDPT =  '"+strBGTDPT+"'                      \n");
						                        if(!strFSREFCD.equals("")) sql2.append( " AND A.FSREFCD = '"+strFSREFCD+"'                     \n");
						                        if(!strSATCODE.equals("")) sql2.append( " AND A.SATCODE = '"+strSATCODE+"'                     \n");
						                        if(!strBGTMACT.equals("")) sql2.append( " AND A.BGTMACT = '"+strBGTMACT+"'                     \n");

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
													sql22.append( " FROM ACCOUNT.BGTDTL A							\n");
													sql22.append( " WHERE A.FDCODE IS NOT NULL						\n");
						                          if(!strATCODE.equals("")) sql22.append( " AND A.ATCODE = '"+strATCODE+"'                       \n");
						                          if(!strFDCODE.equals("")) sql22.append( " AND A.FDCODE =  '"+strFDCODE+"'                      \n");
						                          if(!strBGTYY.equals("")) sql22.append( " AND A.BGTYY  =  '"+strBGTYY+"'                       \n");
						                          if(!strBGTDIV.equals("")) sql22.append( " AND A.BGTDIV =  '"+strBGTDIV+"'                      \n");
						                          if(!strBGTDPT.equals("")) sql22.append( " AND A.BGTDPT =  '"+strBGTDPT+"'                      \n");
						                          if(!strFSREFCD.equals("")) sql22.append( " AND A.FSREFCD = '"+strFSREFCD+"'                     \n");
						                          if(!strSATCODE.equals("")) sql22.append( " AND A.SATCODE = '"+strSATCODE+"'                     \n");
						                          if(!strBGTMACT.equals("")) sql22.append( " AND A.BGTMACT = '"+strBGTMACT+"'                     \n");
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
													UpdateSql4.append( " REALBGT="+dblrealbgt+"						  						\n");
													UpdateSql4.append( " WHERE FDCODE IS NOT NULL													\n");
						                          if(!strATCODE.equals("")) UpdateSql4.append( " AND ATCODE = '"+strATCODE+"'                       \n");
						                          if(!strFDCODE.equals("")) UpdateSql4.append( " AND FDCODE =  '"+strFDCODE+"'                      \n");
						                          if(!strBGTYY.equals("")) UpdateSql4.append( " AND BGTYY  =  '"+strBGTYY+"'                       \n");
						                          if(!strBGTDIV.equals("")) UpdateSql4.append( " AND BGTDIV =  '"+strBGTDIV+"'                      \n");
						                          if(!strBGTDPT.equals("")) UpdateSql4.append( " AND BGTDPT =  '"+strBGTDPT+"'                      \n");
						                          if(!strFSREFCD.equals("")) UpdateSql4.append( " AND FSREFCD = '"+strFSREFCD+"'                     \n");
						                          if(!strSATCODE.equals("")) UpdateSql4.append( " AND SATCODE = '"+strSATCODE+"'                     \n");
						                          if(!strBGTMACT.equals("")) UpdateSql4.append( " AND BGTMACT = '"+strBGTMACT+"'                     \n");

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
											UpdateSql2.append( " WHERE FDCODE IS NOT NULL																		\n");
					                      if(!strATCODE.equals("")) UpdateSql2.append( " AND ATCODE = '"+strATCODE+"'                       \n");
					                      if(!strFDCODE.equals("")) UpdateSql2.append( " AND FDCODE =  '"+strFDCODE+"'                      \n");
					                      if(!strBGTYY.equals("")) UpdateSql2.append( " AND BGTYY  =  '"+strBGTYY+"'                       \n");
					                      if(!strBGTDIV.equals("")) UpdateSql2.append( " AND BGTDIV =  '"+strBGTDIV+"'                      \n");
					                      if(!strBGTDPT.equals("")) UpdateSql2.append( " AND BGTDPT =  '"+strBGTDPT+"'                      \n");
					                      if(!strFSREFCD.equals("")) UpdateSql2.append( " AND FSREFCD = '"+strFSREFCD+"'                     \n");
					                      if(!strSATCODE.equals("")) UpdateSql2.append( " AND SATCODE = '"+strSATCODE+"'                     \n");
					                      if(!strBGTMACT.equals("")) UpdateSql2.append( " AND BGTMACT = '"+strBGTMACT+"'                     \n");
											UpdateSql2.append( "												AND APPROVAL='Y'							\n");	//승인건

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
				                if(!strATCODE.equals("")) sql2.append( " AND A.ATCODE = '"+strATCODE+"'                       \n");
				                if(!strFDCODE.equals("")) sql2.append( " AND A.FDCODE =  '"+strFDCODE+"'                      \n");
				                if(!strBGTYY.equals("")) sql2.append( " AND A.BGTYY  =  '"+strBGTYY+"'                       \n");
				                if(!strBGTDIV.equals("")) sql2.append( " AND A.BGTDIV =  '"+strBGTDIV+"'                      \n");
				                if(!strBGTDPT.equals("")) sql2.append( " AND A.BGTDPT =  '"+strBGTDPT+"'                      \n");
				                if(!strFSREFCD.equals("")) sql2.append( " AND A.FSREFCD = '"+strFSREFCD+"'                     \n");
				                if(!strSATCODE.equals("")) sql2.append( " AND A.SATCODE = '"+strSATCODE+"'                     \n");
				                if(!strBGTMACT.equals("")) sql2.append( " AND A.BGTMACT = '"+strBGTMACT+"'                     \n");
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
									sql22.append( " FROM ACCOUNT.BGTDTL A														\n");
									sql22.append( " WHERE A.FDCODE IS NOT NULL													\n");
				                  if(!strATCODE.equals("")) sql22.append( " AND A.ATCODE = '"+strATCODE+"'                       \n");
				                  if(!strFDCODE.equals("")) sql22.append( " AND A.FDCODE =  '"+strFDCODE+"'                      \n");
				                  if(!strBGTYY.equals("")) sql22.append( " AND A.BGTYY  =  '"+strBGTYY+"'                       \n");
				                  if(!strBGTDIV.equals("")) sql22.append( " AND A.BGTDIV =  '"+strBGTDIV+"'                      \n");
				                  if(!strBGTDPT.equals("")) sql22.append( " AND A.BGTDPT =  '"+strBGTDPT+"'                      \n");
				                  if(!strFSREFCD.equals("")) sql22.append( " AND A.FSREFCD = '"+strFSREFCD+"'                     \n");
				                  if(!strSATCODE.equals("")) sql22.append( " AND A.SATCODE = '"+strSATCODE+"'                     \n");
				                  if(!strBGTMACT.equals("")) sql22.append( " AND A.BGTMACT = '"+strBGTMACT+"'                     \n");
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
									UpdateSql3.append( " WHERE FDCODE IS NOT NULL  												\n");
				                  if(!strATCODE.equals("")) UpdateSql3.append( " AND ATCODE = '"+strATCODE+"'                       \n");
				                  if(!strFDCODE.equals("")) UpdateSql3.append( " AND FDCODE =  '"+strFDCODE+"'                      \n");
				                  if(!strBGTYY.equals("")) UpdateSql3.append( " AND BGTYY  =  '"+strBGTYY+"'                       \n");
				                  if(!strBGTDIV.equals("")) UpdateSql3.append( " AND BGTDIV =  '"+strBGTDIV+"'                      \n");
				                  if(!strBGTDPT.equals("")) UpdateSql3.append( " AND BGTDPT =  '"+strBGTDPT+"'                      \n");
				                  if(!strFSREFCD.equals("")) UpdateSql3.append( " AND FSREFCD = '"+strFSREFCD+"'                     \n");
				                  if(!strSATCODE.equals("")) UpdateSql3.append( " AND SATCODE = '"+strSATCODE+"'                     \n");
				                  if(!strBGTMACT.equals("")) UpdateSql3.append( " AND BGTMACT = '"+strBGTMACT+"'                     \n");
									GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql3.toString());
									gsmt3.setGauceDataRow(rows[j]);
									gsmt3.executeUpdate(); 
									gsmt3.close();
									dbltempbgt=0;
								}//while
							}// if
						} // for m
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
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