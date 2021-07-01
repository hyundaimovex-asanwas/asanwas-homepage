package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import java.util.*;

public class p031004_t1 extends HttpServlet{

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

        int intEDUPAY=0;                //본인
				//배열중 [0]은 인원수 저장
        int[] intEDUPAYN = new int[6];  //취학전
				int[] intEDUPAYP = new int[6];  //초중고
				int[] intEDUPAYU = new int[6];  //대학교
				int[] intEDUPAYH = new int[6];  //장애인

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				GauceStatement gsmt = null;
        /****************************************************
         귀속년도	2010년 연말정산 세액계산 
         step1 : YCENTRY10==> YCPAY10 으로 기본데이터 INSERT
				 유의사항; 건별로 처리함.

				 YCPRSNK(교육비) 상세==>YCEMNTRY10(소득공제신고서)으로 적용함.
				 ==> 교육비는 1인당 한도 적용함.
				*****************************************************/
        int idxAPPYY = userSet.indexOfColumn("APPYY");   //귀속년도
				int idxEMPNO = userSet.indexOfColumn("EMPNO");   //사번
				
					       
				GauceDataRow[] rows = userSet.getDataRows();

       	StringBuffer InsertSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql = null;
        StringBuffer SelectSql = null;

				Statement stmt = null;
				ResultSet rs = null;
				
				logger.dbg.println(this,"step1");

        DeleteSql = new StringBuffer();
				DeleteSql.append( "	DELETE FROM PAYROLL.YCPAY10   \n  " );
				DeleteSql.append( "	 WHERE APPYY=?                \n  " );
				DeleteSql.append( "	   AND EMPNO=?                \n  " );
				
				InsertSql = new StringBuffer();
				InsertSql.append( "	INSERT INTO PAYROLL.YCPAY10 (																											\n  " );
				InsertSql.append( "	 APPYY,    EMPNO,    EMPNMK,   MGENO,    DEPTCD,																	\n  " );
				InsertSql.append( "	 PAYGRD,   PAYSEQ,   ADDR1,    ADDR2,    RESINO,																	\n  " );
				InsertSql.append( "	 SEX,      RESIGB,   RESINA,   RESINACD, COTRYGB,																	\n  " );
				InsertSql.append( "	 FSINGLE,  NATION,   NATIONCD, HOUSEYN,  YETAGB,																	\n  " );
				InsertSql.append( "	 CWORKNM,  CWORKNO,  CWORKFR,  CWORKTO,  CREDUFR,																	\n  " );
				InsertSql.append( "	 CREDUTO,  CP11000,  CP12000,  CP13000,  CP10000,																	\n  " );
				InsertSql.append( "	 NTAXCD01, NTAXCD02, NTAXCD03, NTAXCD04, NTAXCD05,																\n  " );
				InsertSql.append( "	 CNTAX01,  CNTAX02,  CNTAX03,  CNTAX04,  CNTAX05,																	\n  " );
				InsertSql.append( "	 CNTAXSUM, TOTPAY,   																															\n  " );
				InsertSql.append( "	 CP41000,  CP42000,  CP43000,  CP40000,  																					\n  " );
				InsertSql.append( "	 CBP1000,  CBP2000,  CBP3000,  CBPSUM,  																					\n  " );
				InsertSql.append( "	 CCP41000, CCP42000, CCP43000, CCP40000, 																					\n  " );
				InsertSql.append( "	 PENAMT01, PENAMT03, INSAMT01, INSAMT02, DEDAMT04 																\n  " );
				InsertSql.append( "	)																																									\n  " );
				InsertSql.append( "	SELECT A.APPYY,   A.EMPNO,  B.EMPNMK,   A.MGENO,    A.DEPTCD,											\n  " );
				InsertSql.append( "	       A.PAYGRD,  A.PAYSEQ, A.ADDR1,    A.ADDR2,    A.RESINO,											\n  " );
				InsertSql.append( "	       A.SEX,     A.RESIGB, A.RESINA,   A.RESINACD, A.COTRYGB,										\n  " );
				InsertSql.append( "	       A.FSINGLE, A.NATION, A.NATIONCD, A.HOUSEYN,  A.YETAGB,											\n  " );
				InsertSql.append( "	       '현대아산 주식회사','2218113834',																					\n  " );
				InsertSql.append( "	       A.WORKFR,  A.WORKTO, A.REDUFR,																							\n  " );
				InsertSql.append( "	       A.REDUTO,  A.CP11000,A.CP12000,  A.CP13000,  A.CP10000,										\n  " );
				//InsertSql.append( "	       CASE WHEN A.SFRE005>0 THEN 'H03' ELSE '' END AS NTXCD01, --차량비과세			\n  " );
				//InsertSql.append( "	       CASE WHEN A.SFRE006>0 THEN 'P01' ELSE '' END AS NTXCD02, --식대비과세			\n  " );
				//InsertSql.append( "	       CASE WHEN A.SFRE002>0 THEN 'M01' ELSE '' END AS NTXCD03, --국외근로 100		\n  " );
        InsertSql.append( "	       CASE WHEN A.SFRE002>0 THEN 'M01' ELSE '' END AS NTXCD01, --국외근로 100		\n  " );
				InsertSql.append( "	       '' AS NTXCD02, '' AS NTXCD03, '' AS NTXCD04, '' AS NTXCD05,    						\n  " );
				//InsertSql.append( "	       A.SFRE005 AS CNTAX01,																											\n  " );
				//InsertSql.append( "	       A.SFRE006 AS CNTAX02,																											\n  " );
				//InsertSql.append( "	       A.SFRE002 AS CNTAX03,																											\n  " );
        InsertSql.append( "	       A.SFRE002 AS CNTAX01,																											\n  " );
				InsertSql.append( "	       0 AS CNTAX02,																															\n  " );
				InsertSql.append( "	       0 AS CNTAX03,																															\n  " );
				InsertSql.append( "	       0 AS CNTAX04,																															\n  " );
				InsertSql.append( "	       0 AS CNTAX05,																															\n  " );
				InsertSql.append( "	       A.SFRE002 AS CNTAXSUM , A.CP10000+COALESCE(X.BP10SUM,0) AS TOTPAY,         \n  " );
        InsertSql.append( "	       A.CP41000, A.CP42000, 0 AS CP43000, CP41000+CP42000 AS CP40000,            \n  " );
        InsertSql.append( "	       A.CP11000+COALESCE(X.BP11000,0) AS CBP1000,                                \n  " );
	      InsertSql.append( "	       A.CP12000+COALESCE(X.BP12000,0) AS CBP2000,                                \n  " );
				InsertSql.append( "	       A.CP13000+COALESCE(X.BP13000,0) AS CBP3000,                                \n  " );
				InsertSql.append( "	       A.CP10000+COALESCE(X.BP10SUM,0) AS CBPSUM,                                 \n  " );
        InsertSql.append( "	       0 AS CCP41000, 0 AS CCP42000,                  \n  " );
				InsertSql.append( "	       0 AS CCP43000, 0 AS CCP40000,                  \n  " );

				//InsertSql.append( "	       A.CP41000+X.BP41000 AS CCP41000, A.CP42000+X.BP42000 AS CCP42000,          \n  " );
				//InsertSql.append( "	       0 AS CCP43000, A.CP41000+A.CP42000+X.BP40SUM AS CCP40000,                  \n  " );
				InsertSql.append( "	       A.CPENAMT01+A.BPENAMT01 AS PENAMT01, A.CPENAMT03+A.BPENAMT03 AS PENAMT03,  \n  " );
				InsertSql.append( "	       A.CINSAMT01+A.BINSAMT01 AS INSAMT01, A.CINSAMT02+A.BINSAMT02 AS INSAMT02,   \n  " );

				InsertSql.append( "	       A.CONAMT99   \n  " );

				//InsertSql.append( "	  FROM PAYROLL.YCENTRY10_2 A																												\n  " );
				InsertSql.append( "	  FROM PAYROLL.YCENTRY10 A																												\n  " );
				InsertSql.append( "	  LEFT JOIN PAYROLL.YIPERSON B ON A.EMPNO = B.EMPNO AND B.USESTS IN ('1','2','3')	\n  " );
				InsertSql.append( "	  LEFT JOIN ( SELECT YYYY,EMPNO,                                                                          \n  " );
				InsertSql.append( "	  				           COALESCE(SUM(BP11000),0)BP11000, COALESCE(SUM(BP12000),0)BP12000,  \n  " );
				InsertSql.append( "	  				           COALESCE(SUM(BP13000),0)BP13000, COALESCE(SUM(BP10SUM),0)BP10SUM,  \n  " );
				InsertSql.append( "	  				           COALESCE(SUM(BP41000),0)BP41000, COALESCE(SUM(BP42000),0)BP42000,  \n  " );
				InsertSql.append( "	  				           COALESCE(SUM(BP43000),0)BP43000, COALESCE(SUM(BP40SUM),0)BP40SUM   \n  " );
				InsertSql.append( "	  			        FROM PAYROLL.YCBEFOFF                                                                     \n  " );
				InsertSql.append( "	  		         WHERE YYYY=?                                                                               \n  " );
				InsertSql.append( "	  			         AND EMPNO=?                                                                              \n  " );
				InsertSql.append( "	  		         GROUP BY YYYY,EMPNO                                                                        \n  " );
				InsertSql.append( "	  		    	 ) X ON A.APPYY=X.YYYY AND A.EMPNO = X.EMPNO                                                  \n  " );

				InsertSql.append( "	 WHERE A.APPYY=?																													    		\n  " );
				InsertSql.append( "	   AND A.EMPNO=?																													    		\n  " );

				logger.dbg.println(this,"step2");


        for (int j = 0; j < rows.length; j++){ 
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						//건별 삭제 

						//logger.dbg.println(this,"step000"+rows[j].getString(idxAPPYY));
						//logger.dbg.println(this,"step000"+rows[j].getString(idxEMPNO));

						gsmt = conn.getGauceStatement(DeleteSql.toString());
						//logger.dbg.println(this,"step001");

						gsmt.setGauceDataRow(rows[j]);  
						//logger.dbg.println(this,"step002");

						gsmt.bindColumn(1, idxAPPYY);
						//logger.dbg.println(this,"step003");
						gsmt.bindColumn(2, idxEMPNO);
						//logger.dbg.println(this,"step004");
						gsmt.executeUpdate();
						//logger.dbg.println(this,"step005");
						gsmt.close();
						//logger.dbg.println(this,"step006");
						//gsmt=null;      
						//logger.dbg.println(this,"step007");
						//DeleteSql=null;
						//logger.dbg.println(this,"step008");

            //건별 INSERT
						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);  
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxAPPYY);
						gsmt.bindColumn(4, idxEMPNO);

						gsmt.executeUpdate();
						gsmt.close();
						//gsmt=null;      
						//InsertSql=null;


            //교육비 적용//////////////////////////////////////////////////////////////////
						//국세청											국세청외
						//EDUPAYNK-취학전교육비       EDUPAYNE-취학전교육비
						//EDUPAYPK-초중고교육비				EDUPAYPE-초중고교육비
            //EDUPAYUK-대학교교육비				EDUPAYUE-대학교교육비
						//EDUPAYHK-장애인교육비				EDUPAYHE-장애인교육비

						//초기화
            intEDUPAY=0;      //본인
						for(int i=0;i<6;i++){
							intEDUPAYN[i]=0; 
							intEDUPAYP[i]=0;
							intEDUPAYU[i]=0;
							intEDUPAYH[i]=0;
						}						
						
            SelectSql = new StringBuffer();
						SelectSql.append( " SELECT COALESCE(RESINO1,'')RESINO1,RELAT1,FAMNM1,   \n" ); 
						SelectSql.append( "        EDUPAYNK,EDUPAYPK,EDUPAYUK,EDUPAYHK,         \n" ); 
						SelectSql.append( "        EDUPAYNE,EDUPAYPE,EDUPAYUE,EDUPAYHE          \n" ); 
						SelectSql.append( "   FROM PAYROLL.YCPRSNK                              \n" ); 
						SelectSql.append( "  WHERE APPDT='"+rows[j].getString(idxAPPYY)+"12'    \n" ); 
						SelectSql.append( "    AND EMPNO='"+rows[j].getString(idxEMPNO)+"'	    \n" ); 

						//logger.dbg.println(this,"SelectSql::"+SelectSql.toString());
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  

							//본인 대학교와 장애인만 넣었음.
							if(rs.getInt("RELAT1")==0){
								intEDUPAY = rs.getInt("EDUPAYUK")+rs.getInt("EDUPAYUE")+rs.getInt("EDUPAYHK")+rs.getInt("EDUPAYHE");
							}else{//본인이 아닌경우

								//취학전교육비
								if(rs.getInt("EDUPAYNK")!=0||rs.getInt("EDUPAYNE")!=0){
									intEDUPAYN[0]+=1;
									intEDUPAYN[intEDUPAYN[0]]=rs.getInt("EDUPAYNK")+rs.getInt("EDUPAYNE");									
								}

								//초중고교육비
								if(rs.getInt("EDUPAYPK")!=0||rs.getInt("EDUPAYPE")!=0){
									intEDUPAYP[0]+=1;
									intEDUPAYP[intEDUPAYP[0]]=rs.getInt("EDUPAYPK")+rs.getInt("EDUPAYPE");									
								}

								//대학교교육비
								if(rs.getInt("EDUPAYUK")!=0||rs.getInt("EDUPAYUE")!=0){
									intEDUPAYU[0]+=1;
									intEDUPAYU[intEDUPAYU[0]]=rs.getInt("EDUPAYUK")+rs.getInt("EDUPAYUE");									
								}

                //장애인교육비
								if(rs.getInt("EDUPAYHK")!=0||rs.getInt("EDUPAYHE")!=0){
									intEDUPAYH[0]+=1;
									intEDUPAYH[intEDUPAYH[0]]=rs.getInt("EDUPAYHK")+rs.getInt("EDUPAYHE");				
								}
							}
 					  }//while			

					  stmt.close();
						rs.close();

           
					  UpdateSql = new StringBuffer();
						UpdateSql.append( "  UPDATE PAYROLL.YCENTRY10 SET   \n" );
						//UpdateSql.append( "  UPDATE PAYROLL.YCENTRY10_2 SET   \n" );
						UpdateSql.append( "   EDUAMT01= "+intEDUPAY+"       \n" );
						UpdateSql.append( "  ,EDUCNT02= "+intEDUPAYN[0]+"   \n" );
						UpdateSql.append( "  ,EDUAMT021="+intEDUPAYN[1]+"   \n" );
						UpdateSql.append( "  ,EDUAMT022="+intEDUPAYN[2]+"   \n" );
						UpdateSql.append( "  ,EDUAMT023="+intEDUPAYN[3]+"   \n" );
						UpdateSql.append( "  ,EDUAMT024="+intEDUPAYN[4]+"   \n" );
						UpdateSql.append( "  ,EDUAMT025="+intEDUPAYN[5]+"   \n" );
						UpdateSql.append( "  ,EDUCNT03= "+intEDUPAYP[0]+"   \n" );
						UpdateSql.append( "  ,EDUAMT031="+intEDUPAYP[1]+"   \n" );
						UpdateSql.append( "  ,EDUAMT032="+intEDUPAYP[2]+"   \n" );
						UpdateSql.append( "  ,EDUAMT033="+intEDUPAYP[3]+"   \n" );
						UpdateSql.append( "  ,EDUAMT034="+intEDUPAYP[4]+"   \n" );
						UpdateSql.append( "  ,EDUAMT035="+intEDUPAYP[5]+"   \n" );
						UpdateSql.append( "  ,EDUCNT04= "+intEDUPAYU[0]+"   \n" );
						UpdateSql.append( "  ,EDUAMT041="+intEDUPAYU[1]+"   \n" );
						UpdateSql.append( "  ,EDUAMT042="+intEDUPAYU[2]+"   \n" );
						UpdateSql.append( "  ,EDUAMT043="+intEDUPAYU[3]+"   \n" );
						UpdateSql.append( "  ,EDUAMT044="+intEDUPAYU[4]+"   \n" );
						UpdateSql.append( "  ,EDUAMT045="+intEDUPAYU[5]+"   \n" );
						UpdateSql.append( "  ,EDUCNT05= "+intEDUPAYH[0]+"   \n" );
						UpdateSql.append( "  ,EDUAMT051="+intEDUPAYH[1]+"   \n" );
						UpdateSql.append( "  ,EDUAMT052="+intEDUPAYH[2]+"   \n" );
						UpdateSql.append( "  ,EDUAMT053="+intEDUPAYH[3]+"   \n" );
						UpdateSql.append( "  ,EDUAMT054="+intEDUPAYH[4]+"   \n" );
            UpdateSql.append( "  ,EDUAMT055="+intEDUPAYH[5]+"   \n" );
						UpdateSql.append( "  WHERE APPYY = '"+rows[j].getString(idxAPPYY)+"' \n" );
						UpdateSql.append( "    AND EMPNO = '"+rows[j].getString(idxEMPNO)+"' \n" );

						logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
						gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.executeUpdate();
						gsmt.close();

						//교육비 공제신고서 적용 끝///////

					}//if
				}//for  

			} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
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
  /**
  public void Step(String strempno){

     ServiceLoader loader = null;
		 GauceService service = null;
		 GauceContext context = null;
		 Logger logger = null; 

		 loader = new ServiceLoader(req, res);
	 	 service = loader.newService();
	 	 context = service.getContext();
	 	 logger = context.getLogger();

		 logger.dbg.println(this,"strempno"+strempno);

     //System.out.println("strempno"+strempno); 
	}
	**/
}



/**
class Step{
  public Step(String strempno){
		System.out.println("strempno"+strempno); 
  }
};

**/