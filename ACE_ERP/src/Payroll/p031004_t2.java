package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t2 extends HttpServlet{

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

				String strYyyy="";
				
				int intBacnt01=0; //기본공제수
				int intBacnt02=0; //배우자공제수
				int intBacnt03=0; //부양가족공제수

				int intAdcnt01=0; //경로우대수
				int intAdcnt02=0; //장애인수
				int intAdcnt03=0; //부녀자수
				int intAdcnt04=0; //자녀양육수
				int intAdcnt05=0; //출산입양자수
				int intAdcnt06=0; //다자녀수

				int intAdamt06=0; //다자녀공제
				
     
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
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            /*************************************************************************************
						 인적공제 
						**************************************************************************************/
						intBacnt01=0;	
						intBacnt02=0;	
						intBacnt03=0;				              
						intAdcnt01=0;	
						intAdcnt02=0;	
						intAdcnt03=0;	
						intAdcnt04=0;	
						intAdcnt05=0;	
						intAdcnt06=0;
						intAdamt06=0;

						SelectSql = new StringBuffer();
						SelectSql.append( " SELECT                                                              \n" ); 
						SelectSql.append( "  EMPNO,  APPDT,  RELAT1, FAMNM1, COALESCE(RESINO1,'')COALESCE,      \n" ); 
						SelectSql.append( "  IFNULL(REF1,'')REF1, IFNULL(REF2,'')REF2, IFNULL(REF3,'')REF3,     \n" ); 
						SelectSql.append( "  IFNULL(REF4,'')REF4, IFNULL(REF5,'')REF5,                          \n" ); 
						SelectSql.append( "  IFNULL(REF6,'')REF6, IFNULL(REF7,'')REF7, IFNULL(REF8,'')REF8,     \n" ); 
						SelectSql.append( "  REF11,  REF12,  REF13,  REF14,  REF15,  REF16,                     \n" ); 
						SelectSql.append( "  REF21,  REF22,  REF23,  REF24,  REF25,  REF26,                     \n" ); 
						SelectSql.append( "  REF121, REF122, REF221, REF222, REF261,                            \n" ); 
            SelectSql.append( "  CASE WHEN SUBSTR(RESINO1,1,2)>='11' THEN '19'||SUBSTR(RESINO1,1,6) \n" );
						SelectSql.append( "        ELSE '20'||SUBSTR(RESINO1,1,6) END AS YYMMDD                 \n" );
						SelectSql.append( "   FROM PAYROLL.YCPRSN                                               \n" ); 
						SelectSql.append( "  WHERE EMPNO = '"+rows[j].getString(idxEMPNO)+"'                    \n" ); 
						SelectSql.append( "    AND APPDT = '"+rows[j].getString(idxAPPYY)+"12'                    \n" ); 

						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

						while(rs.next()){  
							/////////////////////////////////////////////////////////////////////////////////////////////
							//0 본인, 1 직계존속, 2 배우자 직계존속, 3 배우자, 4 직계비속(자녀 입양자)
							//5 직계비속(4 제외), 6 형제자매, 7 수급자(1~6 제외), 8 위탁아동 
							/////////////////////////////////////////////////////////////////////////////////////////////
							if(rs.getString("REF2").equals("T")){  //기본공제
								if(rs.getString("RELAT1").equals("0")){        //본인
									intBacnt01+=1;
								}else if(rs.getString("RELAT1").equals("3")){  //배우자
                  intBacnt02+=1;
								}else if(rs.getString("RELAT1").equals("1")||rs.getString("RELAT1").equals("2")||
												 rs.getString("RELAT1").equals("4")||rs.getString("RELAT1").equals("5")||
												 rs.getString("RELAT1").equals("6")||rs.getString("RELAT1").equals("7")||
												 rs.getString("RELAT1").equals("8")){ 
							    intBacnt03+=1;  //부양가족수
								}
                 
								//경로우대 
								if(rs.getString("REF5").equals("T")){
									if(rs.getInt("YYMMDD")<=19401231)	 intAdcnt01+=1;
								}
								
								if(rs.getString("REF3").equals("T")) intAdcnt02+=1; //장애인
								if(rs.getString("REF6").equals("T")) intAdcnt03+=1; //부녀자 
								if(rs.getString("REF4").equals("T")) intAdcnt04+=1; //자녀양육자수
								if(rs.getString("REF8").equals("T")) intAdcnt05+=1; //출산입양자수					
								if(rs.getString("REF7").equals("T")) intAdcnt06+=1; //다자녀수 

								/*
								logger.dbg.println(this,"intBacnt01::"+intBacnt01);
								logger.dbg.println(this,"intBacnt02::"+intBacnt02);
								logger.dbg.println(this,"intBacnt03::"+intBacnt03);
								logger.dbg.println(this,"intAdcnt01::"+intAdcnt01);
								logger.dbg.println(this,"intAdcnt02::"+intAdcnt02);
								logger.dbg.println(this,"intAdcnt03::"+intAdcnt03);
								logger.dbg.println(this,"intAdcnt04::"+intAdcnt04);
								logger.dbg.println(this,"intAdcnt05::"+intAdcnt05);
								logger.dbg.println(this,"intAdcnt06::"+intAdcnt06);
								*/
							}else if(!rs.getString("REF2").equals("T")){
                //자녀양육자수 ( 맞벌이 부분의 경우 기본공제 받지 않은 배우자도 가능 )
								if(rs.getString("REF4").equals("T")) intAdcnt04+=1; 
							}
						}//while

					  stmt.close();
						rs.close();
           
						if(intAdcnt06>=2) intAdamt06 = 500000+(intAdcnt06-2)*1000000; //다자녀		

						if(intBacnt01<=0) intBacnt01=1;
				
  					UpdateSql = new StringBuffer();
						UpdateSql.append( "  UPDATE PAYROLL.YCPAY10 SET  \n" );
						UpdateSql.append( "   BAAMT01="+intBacnt01+"*1500000 \n");
						UpdateSql.append( "  ,BAAMT02="+intBacnt02+"*1500000 \n");
						UpdateSql.append( "  ,BACNT03="+intBacnt03+" \n");
						UpdateSql.append( "  ,BAAMT03="+intBacnt03+"*1500000 \n");
						UpdateSql.append( "  ,ADCNT01="+intAdcnt01+" \n");
						UpdateSql.append( "  ,ADAMT01="+intAdcnt01+"*1000000 \n");
						UpdateSql.append( "  ,ADCNT02="+intAdcnt02+" \n");
						UpdateSql.append( "  ,ADAMT02="+intAdcnt02+"*2000000 \n");
						UpdateSql.append( "  ,ADAMT03="+intAdcnt03+"*500000 \n");
						UpdateSql.append( "  ,ADCNT04="+intAdcnt04+" \n");
						UpdateSql.append( "  ,ADAMT04="+intAdcnt04+"*1000000 \n");
						UpdateSql.append( "  ,ADCNT05="+intAdcnt05+" \n");
						UpdateSql.append( "  ,ADAMT05="+intAdcnt05+"*2000000 \n");
						UpdateSql.append( "  ,ADCNT06="+intAdcnt06+" \n");
						UpdateSql.append( "  ,ADAMT06="+intAdamt06+" \n");
						UpdateSql.append( "  WHERE APPYY = '"+rows[j].getString(idxAPPYY)+"'  " );
						UpdateSql.append( "    AND EMPNO = '"+rows[j].getString(idxEMPNO)+"' " );

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