package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

public class trOrderPkgFL extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		ServiceLoader loader = null;
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
	  GauceDataSet dSetMstID = null;
		GauceStatement gsmt = null ; 
		 

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String porder_no = reqGauce.getParameter("gstr1"); 
   				if ( porder_no==null || porder_no.trim().length()==0 ) { porder_no=null; }
				String str2 = reqGauce.getParameter("gstr2"); 
   				if ( str2==null || str2.trim().length()==0 ) { str2=null; }
				String str3 = reqGauce.getParameter("gstr3"); 
   				if ( str3==null || str3.trim().length()==0 ) { str3=null; }
        String enter_no = null ;         
				//logger.err.println(this,"start");

				 

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				
				
					//int idxPORDER_NO   =userSet.indexOfColumn("PORDER_NO") ;
					int idxORDER_DATE =userSet.indexOfColumn("ORDER_DATE") ;
					int idxPORDER_NO =userSet.indexOfColumn("PORDER_NO");
					int idxFTYPE =userSet.indexOfColumn("FTYPE");
					int idxIMG =userSet.indexOfColumn("IMG");
					int idxFIELNAME  =userSet.indexOfColumn("FIELNAME");
					int idxCREATE_USR =userSet.indexOfColumn("CREATE_USR");
					int idxUPDATE_USR=userSet.indexOfColumn("UPDATE_USR");
					

				 logger.err.println(this,"START" ); 
				 

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				 
				//logger.err.println(this,"start2");

				for (int j = 0; j < rows.length; j++){
				int  ls_value = rows[j].getJobType() ; 
				 
 logger.err.println(this, "type"  + String.valueOf(ls_value)  ); 
//logger.err.println(this,   "insert" + S ring.valueOf(GauceDataRow.TB_JOB_INSERT)  ); 
//logger.err.println(this,   "update" + String.valueOf(GauceDataRow.TB_JOB_UPDATE)  ); 
//logger.err.println(this,   "delete" + String.valueOf(GauceDataRow.TB_JOB_DELETE)  ); 
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) { 

 
						InsertSql = new StringBuffer();
						InsertSql.append(" INSERT INTO TRANSFER.LTORDPCKFL ( ") ; 
						InsertSql.append(" PORDER_NO,FTYPE,IMG, ") ; 
						InsertSql.append(" FIELNAME,CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR )") ; 
						InsertSql.append(" values ( ") ; 
						InsertSql.append(" ?,?,? ") ; 
						InsertSql.append(" ,?,CURRENT TIMESTAMP,?,CURRENT TIMESTAMP,? )") ;  
												
logger.err.println(this,InsertSql.toString());
						 
						gsmt = conn.getGauceStatement(InsertSql.toString()); 
						gsmt.setGauceDataRow(rows[j]);  
					
						gsmt.setString(1,porder_no);
						gsmt.bindColumn(2,idxFTYPE);
						InputStream nst_file = (InputStream) rows[j].getInputStream(idxIMG);
						gsmt.setBinaryStream(3, nst_file, nst_file.available());	 //첨부파일  
						gsmt.bindColumn(4,idxFIELNAME);		
						gsmt.bindColumn(5,idxCREATE_USR);	
						gsmt.bindColumn(6,idxUPDATE_USR);	
						gsmt.executeUpdate(); 
						gsmt.close();  

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
 
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						
						DeleteSql = new StringBuffer();
						DeleteSql.append(" DELETE FROM  TRANSFER.LTORDPCKFL  ") ; 
						DeleteSql.append(" WHERE PORDER_NO = ?  AND FTYPE = ?") ; 
						
						gsmt = conn.getGauceStatement(DeleteSql.toString());
						////logger.err.println(this,UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.setString(1,porder_no);
						gsmt.bindColumn(2,idxFTYPE);
						/*gsmt.bindColumn(1, idxCAR_TYPE);*/
						gsmt.executeUpdate();
						gsmt.close();
					}
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se.toString());
				//logger.err.println(this,se);
				 logger.err.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			//logger.err.println(this,e);
			 logger.err.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}