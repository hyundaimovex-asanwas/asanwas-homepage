package pms.menu.si;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Si030I2 extends HttpServlet{

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
				
				//transaction 
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				// 웹페이지에서 조건값을 넘겨받음
				//String  strDate = reqGauce.getParameter("v_str1"); //작업일자
				//String  strEmpno= reqGauce.getParameter("v_str2"); //작업ID		
				//String  strCnt  = reqGauce.getParameter("v_str3"); //생성건수		
	
				/*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				출납등록  
				>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
				GauceDataSet  userSet0 = reqGauce.getGauceDataSet("DS_DEFAULT");
				int idxINOUT_SID   = userSet0.indexOfColumn("INOUT_SID");     //출납SID
				GauceDataRow[] rows0 = userSet0.getDataRows();	

				/*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				매입등록 mst 
				>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
				GauceDataSet userSet1 = reqGauce.getGauceDataSet("DS_MST");
				
				String[] StrArrCN1 = new String[] {
					   "TAXNBR",      "COCODE",   "DEPTCD",   "EMPNO",      "TAXIODIV",
					   "TAXDIV",      "TAXKND",    "VEND_CD", "TAXDAT",      "TAXSUM",
					   "TAXVATAMT",   "TAXTOT",    "REMARK",   "TAXCDNBR", "ATCODE",
					   "TAXPRTYN",    "TAXCNT",    "LASTPRT",  "TAXTYPE",    "FSDAT",	
					   "FSNBR",       "TAXKIDIV",   "FDCODE",   "WORKTYPE", "WRDT",  
					   "WRID",        "SEQ",        "GUBUN",     "AMEND_CODE", "AMEND_REMARK" , "EXTCHK", "REMARK2",
					   "REMARK3",     "S_BIZPLACE", "COST_CD"
				};
				
				int[] idx1 = new int[35];
				for(int i=0;i<StrArrCN1.length;i++) {
				   idx1[i] = userSet1.indexOfColumn(StrArrCN1[i]);
				}
				
				GauceDataRow[] rows1 = userSet1.getDataRows();		
					
				String strTaxnbr = "";
				String taxch="";
				String strGB="A";  //매입 
				
			  /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			    매입등록 dtl 
			   >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>*/
			   GauceDataSet userSet2 = reqGauce.getGauceDataSet("DS_DTL");

			    String[] StrArrCN2 = new String[] {
				  "TAXNBR",  "TAXSEQ", "TAXPDTNAM","TAXSTD","TAXQTY",
				  "TAXPRIC", "TAXSUM", "TAXVATAMT"  ,"BIGO", "WRDT",
				  "WRID",        "UPDT",      "UPID"
			    };

				int[] idx2 = new int[13];
				for(int i=0;i<StrArrCN2.length;i++) {
					idx2[i] = userSet2.indexOfColumn(StrArrCN2[i]);
				}
				
				GauceDataRow[] rows2 = userSet2.getDataRows();	

                StringBuffer Sql = null;        
				StringBuffer InsertSql1 = null;        
				StringBuffer InsertSql2 = null;     
				StringBuffer UpdateSql0 = null;    
 				
				//매입 Master
				Statement stmt1 = null;
				ResultSet rs1 = null;
	
				//매입 Detali
				Statement stmt2 = null;
				ResultSet rs2 = null;		
				
				 for (int j = 0; j < rows1.length; j++){
					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {  
						
						strTaxnbr =strGB+ rows1[0].getString(idx1[8]);
						strTaxnbr=strTaxnbr.substring(0,7);
						taxch ="";
							
						StringBuffer sql = new StringBuffer();
						if (j==0) {
							/*
							sql.append( " SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(SUBSTR(TAXNBR,8,11)),0)+1)),4)	");
							sql.append( " FROM ACCOUNT.ATTAXMST												                                    ");
							sql.append( " WHERE SUBSTR(TAXNBR,1,7)='"+strTaxnbr+"'                                                       ");
                            */
							sql.append( " SELECT LPAD(NVL(MAX(SUBSTR(TAXNBR,8,11)),0)+1,4,'0') \n");
							sql.append( "   FROM ACCOUNT.ATTAXMST		                       \n");
							sql.append( "  WHERE TAXNBR LIKE '"+strTaxnbr+"%'                  \n");
	
							
							
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(sql.toString());
	
							while(rs1.next())	{
								taxch = rs1.getString(1);
							}
								
							strTaxnbr = strTaxnbr+taxch ; //계산서번호 구분자 포함. 
								
							InsertSql1 = new StringBuffer();
							InsertSql1.append( " INSERT INTO ACCOUNT.ATTAXMST (						    \n");
							InsertSql1.append( " TAXNBR,COCODE,DEPTCD,EMPNO,TAXIODIV,			\n");
							InsertSql1.append( " TAXDIV,TAXKND,VEND_CD,TAXDAT,TAXSUM,			    \n");
							InsertSql1.append( " TAXVATAMT,TAXTOT,REMARK,TAXCDNBR,ATCODE,	\n");
							InsertSql1.append( " TAXPRTYN,TAXCNT,LASTPRT,TAXTYPE,FSDAT,	    	\n");
							InsertSql1.append( " FSNBR,TAXKIDIV,FDCODE,WORKTYPE,WRDT,WRID,	\n");
							InsertSql1.append( " SEQ, GUBUN, AMEND_CODE, AMEND_REMARK, EXTCHK, REMARK2,	\n");
							InsertSql1.append( " REMARK3, S_BIZPLACE, COSTCD  \n");
							InsertSql1.append( " ) VALUES(						\n");
							InsertSql1.append( " '"+strTaxnbr+"', ?,?,?,?,	");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,?,");
							InsertSql1.append( " ?,?,?,?,? ");
							InsertSql1.append( " ) ");
				            	
							System.out.println("Si030I5 :");
							//logger.dbg.println(this,"step5::"+InsertSql1.toString() );
							GauceStatement gsmt = conn.getGauceStatement(InsertSql1.toString());
							gsmt.setGauceDataRow(rows1[0]);
								
							for(int m=1;m<=34;m++) {
							   gsmt.bindColumn(m, idx1[m]);
							}
	
							gsmt.executeUpdate();
							gsmt.close();
								
						}//if(j=0)
						
						//logger.dbg.println(this,"step7::");
						System.out.println("Si030I6 :");
					 	 
						 String taxseq = rows2[j].getString(idx2[1]);
						 StringBuffer sql2 = new StringBuffer();
						 
						 sql2.append(" SELECT LPAD(NVL(MAX(TAXSEQ),0)+1,3,'0')  ");
						 sql2.append("   FROM ACCOUNT.ATTAXDTL				    ");
						 sql2.append(" WHERE TAXNBR = '"+strTaxnbr+"'		    ");
						 /*
						 sql2.append(" SELECT RIGHT(CHAR(DIGITS(COALESCE(MAX(TAXSEQ),0)+1)),3)");
						 sql2.append("   FROM ACCOUNT.ATTAXDTL								          ");
						 sql2.append(" WHERE TAXNBR = '"+strTaxnbr+"'		                          ");
		                 */  
						 stmt2 = conn.createStatement();
						 rs2 = stmt2.executeQuery(sql2.toString());
		
						 while(rs2.next()) {
							 taxseq = rs2.getString(1);
						 }
	
						 InsertSql2 = new StringBuffer();
						 InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL (				    	");
						 InsertSql2.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,	");
						 InsertSql2.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,					");
						 InsertSql2.append( " WRDT,WRID															");
						 InsertSql2.append( " ) VALUES(														");
						 InsertSql2.append( " '"+strTaxnbr+"','"+taxseq+"',?,?,?,	                ");
						 InsertSql2.append( " ?, ?, ?, ?,														");
						 InsertSql2.append( " ?, ? )			                                 					");
		
						 GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						 gsmt2.setGauceDataRow(rows2[j]);
		
						 for(int k=1;k<=9;k++) {
							gsmt2.bindColumn(k, idx2[k+1]);
						 }
							 
						 gsmt2.executeUpdate();
						 gsmt2.close();
						 InsertSql2=null;
						 taxseq = "";
							 
					}//if

					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  

					}

					if(rows1[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {  
					
					}
				}//for

                //TSI010 UPDATE : 계산서 번호 UPDATE 
 				for (int i = 0; i < rows0.length; i++){
					if(rows0[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  
						UpdateSql0 = new StringBuffer();
						UpdateSql0.append( " UPDATE PMS.TSI010 SET TAXNBR = '"+strTaxnbr+"'  ");
						UpdateSql0.append( "  WHERE INOUT_SID =? ");
						
						GauceStatement gsmt0 = conn.getGauceStatement(UpdateSql0.toString());
						gsmt0.setGauceDataRow(rows0[i]);
						gsmt0.bindColumn(1, idxINOUT_SID);		 
						gsmt0.executeUpdate();
						gsmt0.close();
						UpdateSql0=null;	
					}
				}
						
                //계산서 번호 RETURN 
				GauceDataSet userSet99 = reqGauce.getGauceDataSet("DS_NBR");
				if (userSet99 != null) {
					resGauce.enableFirstRow(userSet99);
					userSet99.addDataColumn(new GauceDataColumn("TAXNBR", GauceDataColumn.TB_STRING,11));
					GauceDataRow row = null;
					row = userSet99.newDataRow();
					row.addColumnValue(strTaxnbr);
					userSet99.addDataRow(row);
					userSet99.flush();
				}
			}
			catch(Exception e){
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