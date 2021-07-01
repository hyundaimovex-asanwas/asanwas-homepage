package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trOrderRegCarGoodsEtc extends HttpServlet{

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
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String ord_no = reqGauce.getParameter("gstr1"); 
   				if ( ord_no==null || ord_no.trim().length()==0 ) { ord_no=null; }
				String ord_seq = reqGauce.getParameter("gstr2"); 
   				if ( ord_seq==null || ord_seq.trim().length()==0 ) { ord_seq=null; }
				String ls_check = null ; 
                
//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 
				
				int idxCHECK         =  userSet.indexOfColumn("CHECK") ;
				int idxARTC_NM       = userSet.indexOfColumn("ARTC_NM") ;
				int idxORDER_NO      = userSet.indexOfColumn("ORDER_NO") ;
				int idxORDER_SEQ     = userSet.indexOfColumn("ORDER_SEQ") ;
				int idxARTC_CNT      = userSet.indexOfColumn("ARTC_CNT") ;
				int idxARTC_UNIT     = userSet.indexOfColumn("ARTC_UNIT") ;
				int idxPUNIT_CNT     = userSet.indexOfColumn("PUNIT_CNT") ;
				int idxPUNIT_UNIT    = userSet.indexOfColumn("PUNIT_UNIT") ;
				int idxPUNIT_WGHT    = userSet.indexOfColumn("PUNIT_WGHT") ;
				int idxPKG_LNGTH     = userSet.indexOfColumn("PKG_LNGTH") ;
				int idxPKG_HEIGHT    = userSet.indexOfColumn("PKG_HEIGHT") ;
				int idxPKG_WIDTH     = userSet.indexOfColumn("PKG_WIDTH") ;
				int idxPKG_CBM       = userSet.indexOfColumn("PKG_CBM") ;
				int idxPKG_CNT       = userSet.indexOfColumn("PKG_CNT") ;
				int idxSAMEAS        = userSet.indexOfColumn("SAMEAS") ;
				int idxCAR_SEQ_NO    = userSet.indexOfColumn("CAR_SEQ_NO") ;
				int idxLD_ARTC_CNT   = userSet.indexOfColumn("LD_ARTC_CNT") ;
				int idxLD_ARTC_UNIT  = userSet.indexOfColumn("LD_ARTC_UNIT") ;
				int idxLD_PKG_CNT    = userSet.indexOfColumn("LD_PKG_CNT") ;
				int idxLD_PKG_UNIT   = userSet.indexOfColumn("LD_PKG_UNIT") ;
				int idxLD_PKG_WGHT   = userSet.indexOfColumn("LD_PKG_WGHT") ;
				int idxLD_PKG_CBM    = userSet.indexOfColumn("LD_PKG_CBM") ;
				int idxEXT_ARTC_CNT  = userSet.indexOfColumn("EXT_ARTC_CNT") ;
				int idxEXT_PKG_CNT   = userSet.indexOfColumn("EXT_PKG_CNT") ;
				int IDXEXT_PKG_CBM   = userSet.indexOfColumn("EXT_PKG_CBM") ;

				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;  
				GauceStatement gsmt = null ; 

/**********************************************************************************
  ��ü Data����
**********************************************************************************/
				DeleteSql = new StringBuffer();
				
				DeleteSql.append("DELETE FROM TRANSFER.LTCARGOODS ") ; 
				DeleteSql.append(" WHERE ORDER_NO IS NOT NULL ") ; 
//				DeleteSql.append(" WHERE 1 = 1 ") ; 

//if(ord_no != null)DeleteSql.append(" AND ORDER_NO='" +ord_no +"'") ; 
        if(ord_seq != null) DeleteSql.append(" AND CAR_SEQ_NO = '"+ ord_seq + "'") ;  

				//logger.dbg.println(this,DeleteSql.toString());

				gsmt = conn.getGauceStatement(DeleteSql.toString()); 
				gsmt.executeUpdate();
				gsmt.close();

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						ls_check= rows[j].getString(idxCHECK);//   ��������
						String ls_check1= rows[j].getString(idxORDER_SEQ);//   ��������
						
						if(ls_check.equals("T")) {  
							
//logger.dbg.println(this,"sssssssssssssssssssss");
							StringBuffer sql = new StringBuffer();
							sql.append( " SELECT COUNT(*) CNT \n")
								 .append( "   FROM TRANSFER.LTCARGOODS  \n")
								 .append( "  WHERE ORDER_NO = '" + rows[j].getString(idxORDER_NO) + "' \n")
								 .append( "		 AND CAR_SEQ_NO = 'null' \n")
								 .append( "		 AND ORDER_SEQ = " + rows[j].getString(idxORDER_SEQ) + " " );

//logger.dbg.println(this,sql.toString());

							Statement stmt = null;
							ResultSet rs = null;
							int ccnt = 0;

							stmt = conn.createStatement();
							rs = stmt.executeQuery(sql.toString());

							while (rs.next()){
								ccnt = rs.getInt(1);
							}

							stmt.close();
							rs.close();

							if (ccnt > 0) {
								UpdateSql = new StringBuffer();
								UpdateSql.append(" UPDATE TRANSFER.LTCARGOODS  ")
												 .append("	  SET CAR_SEQ_NO = ?, ")
												 .append(" ARTC_CNT = ?,ARTC_UNIT = ?,PKG_CNT = ?, ")
												 .append(" PKG_UNIT = ?,PKG_WGHT = ?,PKG_CBM = ?, ")
												 .append(" CREATE_DT = CURRENT TIMESTAMP,CREATE_USR = ?,UPDATE_DT = CURRENT TIMESTAMP,UPDATE_USR  = ? ")
												 .append(" WHERE ORDER_NO = ? \n")
												 .append("   AND ORDER_SEQ = ? \n");

//logger.dbg.println(this,UpdateSql.toString());

								gsmt = conn.getGauceStatement(UpdateSql.toString()); 
								gsmt.setGauceDataRow(rows[j]); 
								
								gsmt.setString(1,ord_seq);
								gsmt.bindColumn(2,idxLD_ARTC_CNT);
								gsmt.bindColumn(3,idxLD_ARTC_UNIT);
								gsmt.bindColumn(4,idxLD_PKG_CNT);
								gsmt.bindColumn(5,idxLD_PKG_UNIT);
								gsmt.bindColumn(6,idxLD_PKG_WGHT);
								gsmt.bindColumn(7,idxLD_PKG_CBM);
								gsmt.setString(8,"");
								gsmt.setString(9,""); 
								gsmt.bindColumn(10, idxORDER_NO); 
								gsmt.bindColumn(11,idxORDER_SEQ);

								gsmt.executeUpdate(); 
								gsmt.close(); 
								InsertSql = null ;
							} else {
								InsertSql = new StringBuffer();
								InsertSql.append(" INSERT INTO TRANSFER.LTCARGOODS ( ") ; 
								InsertSql.append(" ORDER_NO,CAR_SEQ_NO,ORDER_SEQ, ") ; 
								InsertSql.append(" ARTC_CNT,ARTC_UNIT,PKG_CNT, ") ; 
								InsertSql.append(" PKG_UNIT,PKG_WGHT,PKG_CBM, ") ; 
								InsertSql.append(" CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR ) ") ; 
								InsertSql.append(" VALUES( ") ; 
								InsertSql.append(" ?,?,?,?,?,?,?,?,?, ") ; 
								InsertSql.append(" CURRENT TIMESTAMP,?,CURRENT TIMESTAMP, ") ; 
								InsertSql.append(" ? ) ") ;  

								gsmt = conn.getGauceStatement(InsertSql.toString()); 
								gsmt.setGauceDataRow(rows[j]); 
								
								gsmt.bindColumn(1, idxORDER_NO); 
								gsmt.setString(2,ord_seq);
								gsmt.bindColumn(3,idxORDER_SEQ);
								gsmt.bindColumn(4,idxLD_ARTC_CNT);
								gsmt.bindColumn(5,idxLD_ARTC_UNIT);
								gsmt.bindColumn(6,idxLD_PKG_CNT);
								gsmt.bindColumn(7,idxLD_PKG_UNIT);
								gsmt.bindColumn(8,idxLD_PKG_WGHT);
								gsmt.bindColumn(9,idxLD_PKG_CBM);
								//gsmt.bindColumn(10,idxPKG_CBM); 
								gsmt.setString(10,"");
								gsmt.setString(11,""); 
								gsmt.executeUpdate(); 
								gsmt.close(); 
								InsertSql = null ;
							}
						} 
					}
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						
							 
					}   
						
					 
				}
			}
			catch(SQLException se){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+se.toString()+")");
				logger.dbg.println(this,se);
				logger.err.println(this,se);
				//logger.dbg.println(this,se.toString());
			}

			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}