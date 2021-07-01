package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t4 extends HttpServlet{

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

				int intCnt=0;     //종전근무지수
				int intNtaxCnt=0; //종전비과세수

				int[] intBP11000 = new int[4];  //급여
				int[] intBP12000 = new int[4];  //상여
				int[] intBP13000 = new int[4];  //인정상여
				int[] intBP10SUM = new int[4];  //총급여계
				int[] intBP21000 = new int[3];  //국외근로비과세
				int[] intBP22000 = new int[3];  //야간근로비과세
				int[] intBP23000 = new int[3];  //기타비과세
				int[] intBP31000 = new int[4];  //국민연금
				int[] intBP32000 = new int[4];  //건강보험
				int[] intBP33000 = new int[4];  //고용보험
				int[] intBP34000 = new int[4];  //퇴직연금
				int[] intBP41000 = new int[3];  //소득세
				int[] intBP42000 = new int[3];  //지방소득세
				int[] intBP43000 = new int[3];  //농특세
				int[] intBP40SUM = new int[3];  //세액계

        String[] strWkresino = new String[3]; //사업자등록번호
				String[] strWknm = new String[3];     //근무처명
				String[] strStrtdt = new String[3];   //근무기간fr
				String[] strEnddt = new String[3];    //근무기간to

				String strNTAXCD02 ="";

    
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
         종전근무지 적용.
				 비과세의 금액적용은 전체 근무자 보고 약간의 수작업으로 적용하자..
				*************************************************************************************/

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //초기화 
						intCnt=0;
						intNtaxCnt=0;
						strNTAXCD02 ="";
						for(int i=0;i<3;i++){
							strWkresino[i]=""; 
							strWknm[i]  ="";
						  strStrtdt[i]=""; 	 
							strEnddt[i] ="";

							intBP11000[i] =0;intBP12000[i] =0;intBP13000[i] =0;intBP10SUM[i] =0;
							intBP21000[i] =0;intBP22000[i] =0;intBP23000[i] =0;
							intBP31000[i] =0;intBP32000[i] =0;intBP33000[i] =0;intBP34000[i] =0;
							intBP41000[i] =0;intBP42000[i] =0;intBP43000[i] =0;intBP40SUM[i] =0;
              
						}

            intBP31000[3]=0;
						intBP32000[3]=0;
						intBP33000[3]=0;
						intBP34000[3]=0;

						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT YYYY,    EMPNO,   SEQ,      WKRESINO, WKNM, \n" ); 
						SelectSql.append( "        DEPTCD,  PAYGRD,  STRTDT,   ENDDT,          \n" ); 
						SelectSql.append( "        BP11000, BP12000, BP13000,  BP10SUM,        \n" ); 
						SelectSql.append( "        BP21000, BP22000, BP23000,                  \n" ); 
						SelectSql.append( "        BP31000, BP32000, BP33000,  BP34000,        \n" ); 
						SelectSql.append( "        BP41000, BP42000, BP43000,  BP40SUM,        \n" ); 
						SelectSql.append( "        BTAXNM01,BTAXCD01,BTAXAMT01,                \n" ); 
						SelectSql.append( "        BTAXNM02,BTAXCD02,BTAXAMT02                 \n" );
						SelectSql.append( "   FROM PAYROLL.YCBEFOFF                            \n" ); 
						SelectSql.append( "  WHERE YYYY='"+rows[j].getString(idxAPPYY)+"'      \n" ); 
						SelectSql.append( "    AND EMPNO ='"+rows[j].getString(idxEMPNO)+"'    \n" ); 
						SelectSql.append( "  ORDER BY SEQ                                      \n" ); 
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						//BP22000, BP23000은 사용하지 않음....하지만. BP21000은 사용하는군.

						while(rs.next()){  
							intCnt+=1;
              strWkresino[intCnt-1]=rs.getString("WKRESINO"); 
							strWknm[intCnt-1]  =rs.getString("WKNM"); 
						  strStrtdt[intCnt-1]=rs.getString("STRTDT"); 
							strEnddt[intCnt-1] =rs.getString("ENDDT"); 

              intBP11000[intCnt-1] = rs.getInt("BP11000");  //급여          
            	intBP12000[intCnt-1] = rs.getInt("BP12000");	//상여          
							intBP13000[intCnt-1] = rs.getInt("BP13000");	//인정상여      
							intBP10SUM[intCnt-1] = rs.getInt("BP10SUM");	//총급여계 
							
							intBP21000[intCnt-1] = rs.getInt("BP21000");	//국외근로비과세
							intBP22000[intCnt-1] = rs.getInt("BP22000");	//야간근로비과세
							intBP23000[intCnt-1] = rs.getInt("BP23000");	//기타비과세    
							
							intBP31000[intCnt-1] = rs.getInt("BP31000");	//국민연금      
							intBP32000[intCnt-1] = rs.getInt("BP32000");	//건강보험      
							intBP33000[intCnt-1] = rs.getInt("BP33000");	//고용보험      
							intBP34000[intCnt-1] = rs.getInt("BP34000");	//퇴직연금      
							intBP41000[intCnt-1] = rs.getInt("BP41000");	//소득세        
							intBP42000[intCnt-1] = rs.getInt("BP42000");	//지방소득세    
							intBP43000[intCnt-1] = rs.getInt("BP43000");	//농특세        
							intBP40SUM[intCnt-1] = rs.getInt("BP40SUM");	//세액계   
							
							intBP11000[3] += intBP11000[intCnt-1];	//급여합계     
							intBP12000[3] += intBP12000[intCnt-1];	//상여합계      
							intBP13000[3] += intBP13000[intCnt-1];	//인정상여합계      
							intBP10SUM[3] += intBP10SUM[intCnt-1];	//총급여합계
							
							intBP31000[3] += intBP31000[intCnt-1];	//국민연금합계     
							intBP32000[3] += intBP32000[intCnt-1];	//건강보험합계      
							intBP33000[3] += intBP33000[intCnt-1];	//고용보험합계      
							intBP34000[3] += intBP34000[intCnt-1];	//퇴직연금합계
            

              if(rs.getInt("BP22000")!=0){   //
								intNtaxCnt+=1;
								//intBP22000[intNtaxCnt-1] = rs.getInt("BP22000");

								strNTAXCD02 ="O01"; //영문0 + 숫자01
              }


              //이건 담에 머리 써서 해결하자...올해는 없어서 그냥 패스 
              if(rs.getInt("BTAXAMT01")!=0){ //
								intNtaxCnt+=1;
              }

              if(rs.getInt("BTAXAMT02")!=0){
								intNtaxCnt+=1;
              }
 					 }//while			

					 stmt.close();
					 rs.close();

					 if(intNtaxCnt>2){ //종전근무지 비과세가 2건을 초과하면 수작업함.

					 }

           //종전근무지에서 세액계가 SUM 되지 않아서 다시 SUM함.
					 intBP40SUM[0] = intBP41000[0]+intBP42000[0]+intBP43000[0];
					 intBP40SUM[1] = intBP41000[1]+intBP42000[1]+intBP43000[1];
					 intBP40SUM[2] = intBP41000[2]+intBP42000[2]+intBP43000[2];

					/////////////////////////////////////////////////////////////////////////////////////////////
					//0 종전근무지 ==> 지급명세서
					/////////////////////////////////////////////////////////////////////////////////////////////
					UpdateSql = new StringBuffer();
					UpdateSql.append( "  UPDATE PAYROLL.YCPAY10 SET    \n");   
					UpdateSql.append( "  BWORKNM1='"+strWknm[0]+"'     \n");  //1차 근무처명
					UpdateSql.append( " ,BWORKNO1='"+strWkresino[0]+"' \n");  //1차 사업자등록번호
					UpdateSql.append( " ,BWORKFR1='"+strStrtdt[0]+"'   \n");  //1차 근무기간fr
					UpdateSql.append( " ,BWORKTO1='"+strEnddt[0]+"'    \n");  //1차 근무기간to
					UpdateSql.append( " ,BP11000="+intBP11000[0]+"     \n");  //1차 급여          
					UpdateSql.append( " ,BP12000="+intBP12000[0]+"     \n");	//1차 상여          
					UpdateSql.append( " ,BP13000="+intBP13000[0]+"     \n");	//1차 인정상여      
					UpdateSql.append( " ,BP10000="+intBP10SUM[0]+"     \n");	//1차 총급여계      
					UpdateSql.append( " ,BP41000="+intBP41000[0]+"     \n");	//1차 소득세      
					UpdateSql.append( " ,BP42000="+intBP42000[0]+"     \n");	//1차 지방소득세  
					UpdateSql.append( " ,BP43000="+intBP43000[0]+"     \n");	//1차 농특세      
					UpdateSql.append( " ,BP40000="+intBP40SUM[0]+"     \n");	//1차 세액계     
					UpdateSql.append( " ,BWORKNM2='"+strWknm[1]+"'     \n");	//2차 근무처명         
					UpdateSql.append( " ,BWORKNO2='"+strWkresino[1]+"' \n");	//2차 사업자등록번호   
					UpdateSql.append( " ,BWORKFR2='"+strStrtdt[1]+"'   \n");	//2차 근무기간fr       
					UpdateSql.append( " ,BWORKTO2='"+strEnddt[1]+"'    \n");	//2차 근무기간to       
					UpdateSql.append( " ,BP21000="+intBP11000[1]+"     \n");	//2차 급여             
					UpdateSql.append( " ,BP22000="+intBP12000[1]+"     \n");	//2차 상여             
					UpdateSql.append( " ,BP23000="+intBP13000[1]+"     \n");	//2차 인정상여         
					UpdateSql.append( " ,BP20000="+intBP10SUM[1]+"     \n");	//2차 총급여계      
					UpdateSql.append( " ,BP51000="+intBP41000[1]+"     \n");	//2차 소득세        
					UpdateSql.append( " ,BP52000="+intBP42000[1]+"     \n");	//2차 지방소득세    
					UpdateSql.append( " ,BP53000="+intBP43000[1]+"     \n");	//2차 농특세        
					UpdateSql.append( " ,BP50000="+intBP40SUM[1]+"     \n");	//2차 세액계        
					UpdateSql.append( " ,BWORKNM3='"+strWknm[2]+"'     \n");  //3차 근무처명       
					UpdateSql.append( " ,BWORKNO3='"+strWkresino[2]+"' \n");	//3차 사업자등록번호
					UpdateSql.append( " ,BWORKFR3='"+strStrtdt[2]+"'   \n");	//3차 근무기간fr    
					UpdateSql.append( " ,BWORKTO3='"+strEnddt[2]+"'    \n");	//3차 근무기간to    
					UpdateSql.append( " ,BP31000="+intBP11000[2]+"     \n");	//3차 급여          
					UpdateSql.append( " ,BP32000="+intBP12000[2]+"     \n");	//3차 상여          
					UpdateSql.append( " ,BP33000="+intBP13000[2]+"     \n");	//3차 인정상여      
					UpdateSql.append( " ,BP30000="+intBP10SUM[2]+"     \n");	//3차 총급여계      
					UpdateSql.append( " ,BP61000="+intBP41000[2]+"     \n");	//3차 소득세        
					UpdateSql.append( " ,BP62000="+intBP42000[2]+"     \n");	//3차 지방소득세    
					UpdateSql.append( " ,BP63000="+intBP43000[2]+"     \n");	//3차 농특세        
					UpdateSql.append( " ,BP60000="+intBP40SUM[2]+"     \n");	//3차 세액계  


          UpdateSql.append( " ,NTAXCD02='"+strNTAXCD02+"'     \n");	//비과세  야간근로 코드 (O01)

					UpdateSql.append( " ,BNTAX102="+intBP22000[0]+"     \n");	//1차 비과세  야간근로
					UpdateSql.append( " ,BNTAX202="+intBP22000[1]+"     \n");	//2차 비과세  야간근로
					UpdateSql.append( " ,BNTAX302="+intBP22000[2]+"     \n");	//3차 비과세  야간근로
					
					//UpdateSql.append( " ,CBP1000=CBP1000+"+intBP11000[3]+"     \n"); //급여합계     
					//UpdateSql.append( " ,CBP2000=CBP2000+"+intBP12000[3]+"     \n"); //상여합계     
          //UpdateSql.append( " ,CBP3000=CBP3000+"+intBP13000[3]+"     \n"); //인정상여합계 
          //UpdateSql.append( " ,CBPSUM =CBPSUM+"+intBP10SUM[3]+"      \n"); //총급여합계  

					//UpdateSql.append( " ,PENAMT01=PENAMT01+"+intBP31000[3]+"   \n"); //국민연금합계  
					//UpdateSql.append( " ,INSAMT01=INSAMT01+"+intBP32000[3]+"   \n"); //건강보험합계  
          //UpdateSql.append( " ,INSAMT02=INSAMT02+"+intBP33000[3]+"   \n"); //고용보험합계  
          //UpdateSql.append( " ,PENAMT03=PENAMT03+"+intBP34000[3]+"   \n"); //퇴직연금합계      

					UpdateSql.append( "   WHERE APPYY =  '"+rows[j].getString(idxAPPYY)+"' " );
					UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
					logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
					gsmt = conn.getGauceStatement(UpdateSql.toString());
					gsmt.executeUpdate();
					gsmt.close();

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