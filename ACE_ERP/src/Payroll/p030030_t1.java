package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p030030_t1 extends HttpServlet{

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

				int intSeq = 0; 
				int intCnt = 0;

				String strAPPYY ="";
				String strWRKGB ="";
				String strEMPNO ="";

        String strC004 ="";
				String strC012 ="";
        

        String[] strE007 = new String[5]; //관계
				String[] strE008 = new String[5]; //내외국인구분
				String[] strE009 = new String[5]; //성명
				String[] strE010 = new String[5]; //주민번호
				String[] strE011 = new String[5]; //기본공제
				String[] strE012 = new String[5]; //장애인공제
				String[] strE013 = new String[5]; //6세이하
				String[] strE014 = new String[5]; //부녀자공제
				String[] strE015 = new String[5]; //경로우대공제
				String[] strE016 = new String[5]; //출산입양자공제
				
				int[] intE017 = new int[5];				 //국세청 보험료
				int[] intE018 = new int[5];				 //국세청 의료비
				int[] intE019 = new int[5];				 //국세청 교육비
				int[] intE020 = new int[5];				 //국세청 신용카드
				int[] intE021 = new int[5];				 //국세청 직불카드
				int[] intE022 = new int[5];				 //국세청 현금영수증
				int[] intE023 = new int[5];				 //국세청 기부금
																
				int[] intE024 = new int[5];				 //국세청 외 보험료    
				int[] intE025 = new int[5];				 //국세청 외 의료비    
				int[] intE026 = new int[5];				 //국세청 외 교육비    
				int[] intE027 = new int[5];				 //국세청 외 신용카드  
				int[] intE028 = new int[5];				 //국세청 외 직불카드  
				int[] intE029 = new int[5];				 //국세청 외 기부금 
																						       
						   
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //귀속년도       
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");   //귀속년도       

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer SelectSql = null;

				GauceStatement gsmt = null;
				Statement stmt = null;
				ResultSet rs = null;
	       
        //===================================================================================
        /************************************************************************************
         전산제출_근로소득공제명세서 ( E레코드 ) 
				*************************************************************************************/
				//logger.dbg.println(this,"STEP2::");

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //삭제로직추가
            //기존데이터 초기화 
						DeleteSql = new StringBuffer();
						DeleteSql.append( "  DELETE FROM PAYROLL.YCW_E10  \n  " );
						DeleteSql.append( "   WHERE APPYY = ? \n  " );
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPYY);
						gsmt.executeUpdate();
						gsmt.close();
						gsmt=null;
						DeleteSql =null;
						
						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT SUBSTR(A.APPDT,1,4) APPYY, A.APPDT, A.EMPNO,   \n" ); 
						SelectSql.append( " 	   A.RELAT1,                                        \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF1='T' THEN '9' ELSE '1' END REF1, \n" ); 
						SelectSql.append( " 	   A.FAMNM1, A.RESINO1,                             \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF2='T' THEN '1' ELSE '' END REF2,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF3='T' THEN '1' ELSE '' END REF3,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF4='T' THEN '1' ELSE '' END REF4,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF6='T' THEN '1' ELSE '' END REF6,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF5='T' THEN '1' ELSE '' END REF5,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF8='T' THEN '1' ELSE '' END REF8,  \n" ); 
						SelectSql.append( " 	   (CASE WHEN A.RELAT1='0' THEN COALESCE(A.REF11,0)+COALESCE(Z.INS12,0) ELSE COALESCE(A.REF11,0) END) REF11, \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF12,0)REF12, COALESCE(A.REF13,0)REF13,                                                       \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF14,0)REF14, COALESCE(A.REF17,0)REF17, COALESCE(A.REF15,0)REF15, COALESCE(A.REF16,0)REF16,   \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF21,0)REF21, COALESCE(A.REF22,0)REF22, COALESCE(A.REF23,0)REF23,                             \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF24,0)REF24, COALESCE(A.REF27,0)REF27,                         COALESCE(A.REF26,0)REF26,     \n" ); 
						SelectSql.append( " 	   (RANK() OVER( PARTITION BY SUBSTR(A.APPDT,1,4),A.EMPNO  ORDER BY A.RELAT1 ASC, A.RESINO1)) SEQ,           \n" ); 
						SelectSql.append( " 	   Y.MAX_CNT, X.C004, X.C012, '1' WRKGB                                                                      \n" );
						SelectSql.append( "   FROM PAYROLL.YCPRSN A                                                                              \n" ); 
            SelectSql.append( "   LEFT JOIN ( SELECT B.APPDT, B.EMPNO, COUNT(*) MAX_CNT                                              \n" ); 
						SelectSql.append( "     		        FROM PAYROLL.YCPRSN B                                                                \n" ); 
						SelectSql.append( " 			         WHERE B.APPDT ='"+rows[j].getString(idxAPPYY)+"12'                                    \n" ); 
						SelectSql.append( " 			         GROUP BY B.APPDT, B.EMPNO                                                             \n" ); 
						SelectSql.append( " 		         ) Y ON A.APPDT = Y.APPDT AND A.EMPNO = Y.EMPNO                                          \n" ); 
						SelectSql.append( "   LEFT JOIN ( SELECT B.APPYY, B.EMPNO, B.C004, B.C012                                                \n" ); 
						SelectSql.append( " 			          FROM PAYROLL.YCW_C10 B                                                               \n" ); 
						SelectSql.append( " 			         WHERE APPYY='"+rows[j].getString(idxAPPYY)+"'                                         \n" );
						SelectSql.append( " 		         ) X ON X.APPYY = SUBSTR(A.APPDT,1,4)                                                    \n" ); 
						SelectSql.append( " 			          AND X.EMPNO = A.EMPNO                                                                \n" ); 
						SelectSql.append( " 			          AND X.APPYY='"+rows[j].getString(idxAPPYY)+"'                                        \n" ); 
						//보험료에 건강보험료 포함시킴.(현근무+전근무 건강보험료)
						SelectSql.append( "   LEFT JOIN ( SELECT C.APPYY, C.EMPNO, (C.CINSAMT01+C.CINSAMT02+C.BINSAMT01+C.BINSAMT02) AS INS12    \n" ); 
						SelectSql.append( "                 FROM PAYROLL.YCENTRY10 C                                                             \n" ); 
						SelectSql.append( "                WHERE APPYY='"+rows[j].getString(idxAPPYY)+"'                                         \n" ); 
						SelectSql.append( "               ) Z ON Z.APPYY = SUBSTR(A.APPDT,1,4)                                                   \n" ); 
						SelectSql.append( "                  AND Z.EMPNO = A.EMPNO                                                               \n" ); 
						SelectSql.append( "                  AND Z.APPYY='"+rows[j].getString(idxAPPYY)+"'                                       \n" ); 
            SelectSql.append( "                  AND A.RELAT1='0'                                                                    \n" ); 
						SelectSql.append( "  WHERE A.APPDT='"+rows[j].getString(idxAPPYY)+"12'                                                   \n" ); 
						//SelectSql.append( "    AND A.EMPNO IN ('2070037','2010017' )                                                             \n" ); 
						SelectSql.append( "  UNION ALL                                                                                           \n" ); 
						SelectSql.append( " SELECT SUBSTR(A.APPDT,1,4) APPYY, A.APPDT, A.EMPNO,   \n" ); 
						SelectSql.append( " 	   A.RELAT1,                                        \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF1='T' THEN '9' ELSE '1' END REF1, \n" ); 
						SelectSql.append( " 	   A.FAMNM1, A.RESINO1,                             \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF2='T' THEN '1' ELSE '' END REF2,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF3='T' THEN '1' ELSE '' END REF3,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF4='T' THEN '1' ELSE '' END REF4,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF6='T' THEN '1' ELSE '' END REF6,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF5='T' THEN '1' ELSE '' END REF5,  \n" ); 
						SelectSql.append( " 	   CASE WHEN A.REF8='T' THEN '1' ELSE '' END REF8,  \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF11,0)REF11,                        \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF12,0)REF12, COALESCE(A.REF13,0)REF13,                                                       \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF14,0)REF14, COALESCE(A.REF17,0)REF17, COALESCE(A.REF15,0)REF15, COALESCE(A.REF16,0)REF16,   \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF21,0)REF21, COALESCE(A.REF22,0)REF22, COALESCE(A.REF23,0)REF23,                             \n" ); 
						SelectSql.append( " 	   COALESCE(A.REF24,0)REF24, COALESCE(A.REF27,0)REF27,                         COALESCE(A.REF26,0)REF26,     \n" ); 
						SelectSql.append( " 	   (RANK() OVER( PARTITION BY SUBSTR(A.APPDT,1,4),A.EMPNO  ORDER BY A.RELAT1 ASC, A.RESINO1)) SEQ,           \n" ); 
						SelectSql.append( " 	   Y.MAX_CNT, X.C004, X.C012,  '2' WRKGB                                                                     \n" );
						SelectSql.append( "   FROM PAYROLL.YCMIDPRSN A                                                                           \n" ); 
            SelectSql.append( "   LEFT JOIN ( SELECT B.APPDT, B.EMPNO, COUNT(*) MAX_CNT                                              \n" ); 
						SelectSql.append( "     		        FROM PAYROLL.YCMIDPRSN B                                                                \n" ); 
						SelectSql.append( " 			         WHERE B.APPDT ='"+rows[j].getString(idxAPPYY)+"12'                                    \n" ); 
						SelectSql.append( " 			         GROUP BY B.APPDT, B.EMPNO                                                             \n" ); 
						SelectSql.append( " 		         ) Y ON A.APPDT = Y.APPDT AND A.EMPNO = Y.EMPNO                                          \n" ); 
						SelectSql.append( "   LEFT JOIN ( SELECT B.APPYY, B.EMPNO, B.C004, B.C012                                                \n" ); 
						SelectSql.append( " 			          FROM PAYROLL.YCW_C10 B                                                               \n" ); 
						SelectSql.append( " 			         WHERE APPYY='"+rows[j].getString(idxAPPYY)+"'                                         \n" );
						SelectSql.append( " 		         ) X ON X.APPYY = SUBSTR(A.APPDT,1,4)                                                    \n" ); 
						SelectSql.append( " 			          AND X.EMPNO = A.EMPNO                                                                \n" ); 
						SelectSql.append( " 			          AND X.APPYY='"+rows[j].getString(idxAPPYY)+"'                                        \n" ); 
						//퇴직자는 보험료에 건강보험료 포함시켰음.
						SelectSql.append( "  WHERE A.APPDT='"+rows[j].getString(idxAPPYY)+"12'                                                   \n" ); 
						SelectSql.append( "  ORDER BY C004, EMPNO, RELAT1 ASC, RESINO1                                                           \n" ); 

						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  
							//초기화 
							if(rs.getInt("SEQ")==1 || rs.getInt("SEQ")==6 ){
								for(int i=0;i<5;i++){
									
								   strE007[i] =	"";
									 strE008[i] = "";
                 	 strE009[i] = "";
									 strE010[i] = "";
									 strE011[i] = "";
									 strE012[i] = "";
									 strE013[i] = "";
									 strE014[i] = "";
									 strE015[i] = "";
									 strE016[i] = "";
									 						
									 intE017[i] = 0;
									 intE018[i] = 0;
									 intE019[i] = 0;
									 intE020[i] = 0;
									 intE021[i] = 0;
									 intE022[i] = 0;
									 intE023[i] = 0;
									 						
									 intE024[i] = 0;
									 intE025[i] = 0;
									 intE026[i] = 0;
									 intE027[i] = 0;
									 intE028[i] = 0;
									 intE029[i] = 0;

									 intCnt = 0;
								}
                strAPPYY="";
                strWRKGB="";
								strEMPNO="";
							}   
						
							if(rs.getInt("MAX_CNT")<=5){  // 가족 5명 이하(본인포함) 

                intSeq = rs.getInt("SEQ");

                //데이터 저장 
                if(rs.getInt("SEQ")==1){
									strC004 = rs.getString("C004"); //일련번호
									strC012 = rs.getString("C012"); //소득자주민번호
									intCnt = 1;
									strAPPYY = rs.getString("APPYY"); //귀속년도                      
                  strWRKGB = rs.getString("WRKGB");	//구분 1- 계속근무, 2-중도퇴사  
                  strEMPNO = rs.getString("EMPNO"); //사번                          
								}

                strE007[intSeq-1] = rs.getString("RELAT1");   //관계               
								strE008[intSeq-1] = rs.getString("REF1");  		//내외국인구분       
								strE009[intSeq-1] = rs.getString("FAMNM1");		//성명               
								strE010[intSeq-1] = rs.getString("RESINO1");	//주민번호           
								strE011[intSeq-1] = rs.getString("REF2");  		//기본공제           
								strE012[intSeq-1] = rs.getString("REF3");  		//장애인공제         
								strE013[intSeq-1] = rs.getString("REF4");  		//6세이하            
								strE014[intSeq-1] = rs.getString("REF6");  		//부녀자공제         
								strE015[intSeq-1] = rs.getString("REF5");  		//경로우대공제       
								strE016[intSeq-1] = rs.getString("REF8");  		//출산입양자공제     
																															                     
                intE017[intSeq-1] = rs.getInt("REF11"); 			//국세청 보험료     
								intE018[intSeq-1] = rs.getInt("REF12"); 			//국세청 의료비     
								intE019[intSeq-1] = rs.getInt("REF13"); 			//국세청 교육비     
								intE020[intSeq-1] = rs.getInt("REF14"); 			//국세청 신용카드   
								intE021[intSeq-1] = rs.getInt("REF17"); 			//국세청 직불카드   
								intE022[intSeq-1] = rs.getInt("REF15"); 			//국세청 현금영수증 
								intE023[intSeq-1] = rs.getInt("REF16"); 			//국세청 기부금     
																															                     
								intE024[intSeq-1] = rs.getInt("REF21"); 			//국세청 외 보험료  
								intE025[intSeq-1] = rs.getInt("REF22"); 			//국세청 외 의료비  
								intE026[intSeq-1] = rs.getInt("REF23"); 			//국세청 외 교육비  
								intE027[intSeq-1] = rs.getInt("REF24"); 			//국세청 외 신용카드
								intE028[intSeq-1] = rs.getInt("REF27"); 			//국세청 외 직불카드
								intE029[intSeq-1] = rs.getInt("REF26"); 			//국세청 외 기부금  
							  
								if(rs.getInt("MAX_CNT")==rs.getInt("SEQ")){   //최종건  INSERT
                
									  InsertSql = new StringBuffer();
										InsertSql.append( " INSERT INTO PAYROLL.YCW_E10 (  \n " );
										InsertSql.append( " APPYY,  WRKGB,  EMPNO,                          \n " );
										InsertSql.append( " E001,   E002,   E003,   E004,   E005,   E006,   \n " );
										InsertSql.append( " E007,   E008,   E009,   E010,   E011,   E012,   E013,   E014,   E015,   E016, \n " );
										InsertSql.append( " E017,   E018,   E019,   E020,   E021,   E022,   E023,   E024,   E025,   E026, \n " );
										InsertSql.append( " E027,   E028,   E029,   \n " );
										InsertSql.append( " E030,   E031,   E032,   E033,   E034,   E035,   E036,   E037,   E038,   E039, \n " );
										InsertSql.append( " E040,   E041,   E042,   E043,   E044,   E045,   E046,   E047,   E048,   E049, \n " );
										InsertSql.append( " E050,   E051,   E052,   \n " );
										InsertSql.append( " E053,   E054,   E055,   E056,   E057,   E058,   E059,   E060,   E061,   E062, \n " );
										InsertSql.append( " E063,   E064,   E065,   E066,   E067,   E068,   E069,   E070,   E071,   E072, \n " );	
										InsertSql.append( " E073,   E074,   E075,   \n " );
										InsertSql.append( " E076,   E077,   E078,   E079,   E080,   E081,   E082,   E083,   E084,   E085, \n " );
										InsertSql.append( " E086,   E087,   E088,   E089,   E090,   E091,   E092,   E093,   E094,   E095, \n " );
										InsertSql.append( " E096,   E097,   E098,   \n " );
										InsertSql.append( " E099,   E100,   E101,   E102,   E103,   E104,   E105,   E106,   E107,   E108, \n " );
										InsertSql.append( " E109,   E110,   E111,   E112,   E113,   E114,   E115,   E116,   E117,   E118, \n " );
										InsertSql.append( " E119,   E120,   E121,   \n " );
										InsertSql.append( " E122,   E123                                                           \n " );
										InsertSql.append( " ) VALUES (  \n " );
										InsertSql.append( " '"+strAPPYY+"', '"+strWRKGB+"', '"+strEMPNO+"',  \n " );	
										InsertSql.append( " 'E', '20', '227', '"+strC004+"', '2218113834', '"+strC012+"',  \n " );	 //~E006
										InsertSql.append( " '"+strE007[0]+"','"+strE008[0]+"','"+strE009[0]+"','"+strE010[0]+"','"+strE011[0]+"',  \n " );	
										InsertSql.append( " '"+strE012[0]+"','"+strE013[0]+"','"+strE014[0]+"','"+strE015[0]+"','"+strE016[0]+"',  \n " );	
										InsertSql.append( "  "+intE017[0]+",  "+intE018[0]+",  "+intE019[0]+",  "+intE020[0]+",  "+intE021[0]+",   \n " );	
										InsertSql.append( "  "+intE022[0]+",  "+intE023[0]+",  "+intE024[0]+",  "+intE025[0]+",  "+intE026[0]+",   \n " );
										InsertSql.append( "  "+intE027[0]+",  "+intE028[0]+",  "+intE029[0]+",  \n " );
										InsertSql.append( " '"+strE007[1]+"','"+strE008[1]+"','"+strE009[1]+"','"+strE010[1]+"','"+strE011[1]+"',  \n " );	
										InsertSql.append( " '"+strE012[1]+"','"+strE013[1]+"','"+strE014[1]+"','"+strE015[1]+"','"+strE016[1]+"',  \n " );	
										InsertSql.append( "  "+intE017[1]+",  "+intE018[1]+",  "+intE019[1]+",  "+intE020[1]+",  "+intE021[1]+",   \n " );	
										InsertSql.append( "  "+intE022[1]+",  "+intE023[1]+",  "+intE024[1]+",  "+intE025[1]+",  "+intE026[1]+",   \n " );
										InsertSql.append( "  "+intE027[1]+",  "+intE028[1]+",  "+intE029[1]+",  \n " );
										InsertSql.append( " '"+strE007[2]+"','"+strE008[2]+"','"+strE009[2]+"','"+strE010[2]+"','"+strE011[2]+"',  \n " );	
										InsertSql.append( " '"+strE012[2]+"','"+strE013[2]+"','"+strE014[2]+"','"+strE015[2]+"','"+strE016[2]+"',  \n " );	
										InsertSql.append( "  "+intE017[2]+",  "+intE018[2]+",  "+intE019[2]+",  "+intE020[2]+",  "+intE021[2]+",   \n " );	
										InsertSql.append( "  "+intE022[2]+",  "+intE023[2]+",  "+intE024[2]+",  "+intE025[2]+",  "+intE026[2]+",   \n " );
										InsertSql.append( "  "+intE027[2]+",  "+intE028[2]+",  "+intE029[2]+",  \n " );										  
										InsertSql.append( " '"+strE007[3]+"','"+strE008[3]+"','"+strE009[3]+"','"+strE010[3]+"','"+strE011[3]+"',  \n " );	
										InsertSql.append( " '"+strE012[3]+"','"+strE013[3]+"','"+strE014[3]+"','"+strE015[3]+"','"+strE016[3]+"',  \n " );	
										InsertSql.append( "  "+intE017[3]+",  "+intE018[3]+",  "+intE019[3]+",  "+intE020[3]+",  "+intE021[3]+",   \n " );	
										InsertSql.append( "  "+intE022[3]+",  "+intE023[3]+",  "+intE024[3]+",  "+intE025[3]+",  "+intE026[3]+",   \n " );
										InsertSql.append( "  "+intE027[3]+",  "+intE028[3]+",  "+intE029[3]+",  \n " );;									  
										InsertSql.append( " '"+strE007[4]+"','"+strE008[4]+"','"+strE009[4]+"','"+strE010[4]+"','"+strE011[4]+"',  \n " );	
										InsertSql.append( " '"+strE012[4]+"','"+strE013[4]+"','"+strE014[4]+"','"+strE015[4]+"','"+strE016[4]+"',  \n " );	
										InsertSql.append( "  "+intE017[4]+",  "+intE018[4]+",  "+intE019[4]+",  "+intE020[4]+",  "+intE021[4]+",   \n " );	
										InsertSql.append( "  "+intE022[4]+",  "+intE023[4]+",  "+intE024[4]+",  "+intE025[4]+",  "+intE026[4]+",   \n " );
										InsertSql.append( "  "+intE027[4]+",  "+intE028[4]+",  "+intE029[4]+",  \n " );	
										InsertSql.append( "  "+intCnt+", '' \n " );	
										InsertSql.append( " ) \n " );	

										gsmt = conn.getGauceStatement(InsertSql.toString());
										gsmt.executeUpdate();
	    							gsmt.close();
								}

							}else{  //6건이상
               
                intSeq= rs.getInt("SEQ");

								if(intSeq ==1){
                  intCnt =1;
								}else if(intSeq==6){
									intCnt =2;
								}

								if(intSeq >5){
									intSeq -=5;
								}

                //데이터 저장 
                if(rs.getInt("SEQ")==1||rs.getInt("SEQ")==6){
									strC004 = rs.getString("C004"); //일련번호
									strC012 = rs.getString("C012"); //소득자주민번호
									strAPPYY = rs.getString("APPYY"); //귀속년도
                  strWRKGB = rs.getString("WRKGB"); //구분 1- 계속근무, 2-중도퇴사
                  strEMPNO = rs.getString("EMPNO"); //사번
								}														

                strE007[intSeq-1] = rs.getString("RELAT1");   //관계               
								strE008[intSeq-1] = rs.getString("REF1");  		//내외국인구분       
								strE009[intSeq-1] = rs.getString("FAMNM1");		//성명               
								strE010[intSeq-1] = rs.getString("RESINO1");	//주민번호           
								strE011[intSeq-1] = rs.getString("REF2");  		//기본공제           
								strE012[intSeq-1] = rs.getString("REF3");  		//장애인공제         
								strE013[intSeq-1] = rs.getString("REF4");  		//6세이하            
								strE014[intSeq-1] = rs.getString("REF6");  		//부녀자공제         
								strE015[intSeq-1] = rs.getString("REF5");  		//경로우대공제       
								strE016[intSeq-1] = rs.getString("REF8");  		//출산입양자공제     
																															                     
                intE017[intSeq-1] = rs.getInt("REF11"); 			 //국세청 보험료     
								intE018[intSeq-1] = rs.getInt("REF12"); 			 //국세청 의료비     
								intE019[intSeq-1] = rs.getInt("REF13"); 			 //국세청 교육비     
								intE020[intSeq-1] = rs.getInt("REF14"); 			 //국세청 신용카드   
								intE021[intSeq-1] = rs.getInt("REF17"); 			 //국세청 직불카드   
								intE022[intSeq-1] = rs.getInt("REF15"); 			 //국세청 현금영수증 
								intE023[intSeq-1] = rs.getInt("REF16"); 			 //국세청 기부금     
																															                     
								intE024[intSeq-1] = rs.getInt("REF21"); 			 //국세청 외 보험료  
								intE025[intSeq-1] = rs.getInt("REF22"); 			 //국세청 외 의료비  
								intE026[intSeq-1] = rs.getInt("REF23"); 			 //국세청 외 교육비  
								intE027[intSeq-1] = rs.getInt("REF24"); 			 //국세청 외 신용카드
								intE028[intSeq-1] = rs.getInt("REF27"); 			 //국세청 외 직불카드
								intE029[intSeq-1] = rs.getInt("REF26"); 			 //국세청 외 기부금  

								//logger.dbg.println(this,"MAX_CNT::"+rs.getInt("MAX_CNT"));
								//logger.dbg.println(this,"SEQ::"+rs.getInt("SEQ"));

								if(rs.getInt("SEQ")==5 || rs.getInt("MAX_CNT")==rs.getInt("SEQ") ){ // 첫번째 두번째 ROW INSERT
								  //logger.dbg.println(this,"99::");

									InsertSql = new StringBuffer();

									 logger.dbg.println(this,"999::");
									InsertSql.append( " INSERT INTO PAYROLL.YCW_E10 (  \n " );
									InsertSql.append( " APPYY,  WRKGB,  EMPNO,                          \n " );
									InsertSql.append( " E001,   E002,   E003,   E004,   E005,   E006,   \n " );
									InsertSql.append( " E007,   E008,   E009,   E010,   E011,   E012,   E013,   E014,   E015,   E016, \n " );
									InsertSql.append( " E017,   E018,   E019,   E020,   E021,   E022,   E023,   E024,   E025,   E026, \n " );
									InsertSql.append( " E027,   E028,   E029,   \n " );
									InsertSql.append( " E030,   E031,   E032,   E033,   E034,   E035,   E036,   E037,   E038,   E039, \n " );
									InsertSql.append( " E040,   E041,   E042,   E043,   E044,   E045,   E046,   E047,   E048,   E049, \n " );
									InsertSql.append( " E050,   E051,   E052,   \n " );
									InsertSql.append( " E053,   E054,   E055,   E056,   E057,   E058,   E059,   E060,   E061,   E062, \n " );
									InsertSql.append( " E063,   E064,   E065,   E066,   E067,   E068,   E069,   E070,   E071,   E072, \n " );	
									InsertSql.append( " E073,   E074,   E075,   \n " );
									InsertSql.append( " E076,   E077,   E078,   E079,   E080,   E081,   E082,   E083,   E084,   E085, \n " );
									InsertSql.append( " E086,   E087,   E088,   E089,   E090,   E091,   E092,   E093,   E094,   E095, \n " );
									InsertSql.append( " E096,   E097,   E098,   \n " );
									InsertSql.append( " E099,   E100,   E101,   E102,   E103,   E104,   E105,   E106,   E107,   E108, \n " );
									InsertSql.append( " E109,   E110,   E111,   E112,   E113,   E114,   E115,   E116,   E117,   E118, \n " );
									InsertSql.append( " E119,   E120,   E121,   \n " );
									InsertSql.append( " E122,   E123                                                           \n " );
									InsertSql.append( " ) VALUES (  \n " );
									InsertSql.append( " '"+strAPPYY+"', '"+strWRKGB+"', '"+strEMPNO+"',  \n " );	
									InsertSql.append( " 'E', '20', '227', '"+strC004+"', '2218113834', '"+strC012+"',  \n " );	 //~E006
									InsertSql.append( " '"+strE007[0]+"','"+strE008[0]+"','"+strE009[0]+"','"+strE010[0]+"','"+strE011[0]+"',  \n " );	
									InsertSql.append( " '"+strE012[0]+"','"+strE013[0]+"','"+strE014[0]+"','"+strE015[0]+"','"+strE016[0]+"',  \n " );	
									InsertSql.append( "  "+intE017[0]+",  "+intE018[0]+",  "+intE019[0]+",  "+intE020[0]+",  "+intE021[0]+",   \n " );	
									InsertSql.append( "  "+intE022[0]+",  "+intE023[0]+",  "+intE024[0]+",  "+intE025[0]+",  "+intE026[0]+",   \n " );
									InsertSql.append( "  "+intE027[0]+",  "+intE028[0]+",  "+intE029[0]+",  \n " );
									InsertSql.append( " '"+strE007[1]+"','"+strE008[1]+"','"+strE009[1]+"','"+strE010[1]+"','"+strE011[1]+"',  \n " );	
									InsertSql.append( " '"+strE012[1]+"','"+strE013[1]+"','"+strE014[1]+"','"+strE015[1]+"','"+strE016[1]+"',  \n " );	
									InsertSql.append( "  "+intE017[1]+",  "+intE018[1]+",  "+intE019[1]+",  "+intE020[1]+",  "+intE021[1]+",   \n " );	
									InsertSql.append( "  "+intE022[1]+",  "+intE023[1]+",  "+intE024[1]+",  "+intE025[1]+",  "+intE026[1]+",   \n " );
									InsertSql.append( "  "+intE027[1]+",  "+intE028[1]+",  "+intE029[1]+",  \n " );
									InsertSql.append( " '"+strE007[2]+"','"+strE008[2]+"','"+strE009[2]+"','"+strE010[2]+"','"+strE011[2]+"',  \n " );	
									InsertSql.append( " '"+strE012[2]+"','"+strE013[2]+"','"+strE014[2]+"','"+strE015[2]+"','"+strE016[2]+"',  \n " );	
									InsertSql.append( "  "+intE017[2]+",  "+intE018[2]+",  "+intE019[2]+",  "+intE020[2]+",  "+intE021[2]+",   \n " );	
									InsertSql.append( "  "+intE022[2]+",  "+intE023[2]+",  "+intE024[2]+",  "+intE025[2]+",  "+intE026[2]+",   \n " );
									InsertSql.append( "  "+intE027[2]+",  "+intE028[2]+",  "+intE029[2]+",  \n " );										  
									InsertSql.append( " '"+strE007[3]+"','"+strE008[3]+"','"+strE009[3]+"','"+strE010[3]+"','"+strE011[3]+"',  \n " );	
									InsertSql.append( " '"+strE012[3]+"','"+strE013[3]+"','"+strE014[3]+"','"+strE015[3]+"','"+strE016[3]+"',  \n " );	
									InsertSql.append( "  "+intE017[3]+",  "+intE018[3]+",  "+intE019[3]+",  "+intE020[3]+",  "+intE021[3]+",   \n " );	
									InsertSql.append( "  "+intE022[3]+",  "+intE023[3]+",  "+intE024[3]+",  "+intE025[3]+",  "+intE026[3]+",   \n " );
									InsertSql.append( "  "+intE027[3]+",  "+intE028[3]+",  "+intE029[3]+",  \n " );;									  
									InsertSql.append( " '"+strE007[4]+"','"+strE008[4]+"','"+strE009[4]+"','"+strE010[4]+"','"+strE011[4]+"',  \n " );	
									InsertSql.append( " '"+strE012[4]+"','"+strE013[4]+"','"+strE014[4]+"','"+strE015[4]+"','"+strE016[4]+"',  \n " );	
									InsertSql.append( "  "+intE017[4]+",  "+intE018[4]+",  "+intE019[4]+",  "+intE020[4]+",  "+intE021[4]+",   \n " );	
									InsertSql.append( "  "+intE022[4]+",  "+intE023[4]+",  "+intE024[4]+",  "+intE025[4]+",  "+intE026[4]+",   \n " );
									InsertSql.append( "  "+intE027[4]+",  "+intE028[4]+",  "+intE029[4]+",  \n " );	
									InsertSql.append( "  "+intCnt+", '' \n " );	
									InsertSql.append( " ) \n " );	

									 //logger.dbg.println(this,"9999::");


									//logger.dbg.println(this,"STEP6::"+InsertSql.toString());

									gsmt = conn.getGauceStatement(InsertSql.toString());
									gsmt.executeUpdate();
									gsmt.close();
                         
						    }
							}
							
            }//while

				 } //getJobType
			}  //for j 
     			
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
}