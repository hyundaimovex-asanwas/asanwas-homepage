package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class trOrderSts extends HttpServlet{

	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		
		//System.out.println("trOrderSts::시작");
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
			GauceDataSet dSetMstID = null;
			GauceStatement gstmt = null;

			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
//-----------------------------------------------------------------------------
//	Description : PARAMETER GET
//-----------------------------------------------------------------------------				
				String ord_no = reqGauce.getParameter("gstr1"); 
   				if ( ord_no==null || ord_no.trim().length()==0 ) { ord_no=null; }
				String auth_no  = null ; 
				String ls_check = null ; 
				String str_order_sts="";
                
				dSetMstID = new GauceDataSet(); 
				dSetMstID.addDataColumn(new GauceDataColumn("AUTH_NO", GauceDataColumn.TB_STRING));

//-----------------------------------------------------------------------------
//	Description : DataSet Index Setting
//-----------------------------------------------------------------------------	

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxCHECK      = userSet.indexOfColumn("CHK") ; 
				int idxORDER_NO   = userSet.indexOfColumn("ORDER_NO") ; 
				int idxORDER_STS  = userSet.indexOfColumn("ORDER_STS") ; 
				int idxETD_DT     = userSet.indexOfColumn("ETD_DT") ; 
				int idxLINE_PART  = userSet.indexOfColumn("LINE_PART") ; 
				int idxCDNAM      = userSet.indexOfColumn("CDNAM") ; 
				int idxCUST       = userSet.indexOfColumn("CUST") ; 
				int idxSHIPPER    = userSet.indexOfColumn("SHIPPER") ; 
				int idxCARGO_TYPE = userSet.indexOfColumn("CARGO_TYPE") ; 
				int idxPROJECT    = userSet.indexOfColumn("PROJECT") ; 
				int idxCAR_SEQ_NO = userSet.indexOfColumn("CAR_SEQ_NO") ; 
				int idxCARTYPENO  = userSet.indexOfColumn("CARTYPENO") ; 
				int idxCAR_CNT    = userSet.indexOfColumn("CAR_CNT") ; 
				int idxLD_DATE    = userSet.indexOfColumn("LD_DATE") ; 
				int idxEDT_DATE   = userSet.indexOfColumn("EDT_DATE") ; 
				int idxARTC_NM    = userSet.indexOfColumn("ARTC_NM") ; 
				int idxARTC_CNT   = userSet.indexOfColumn("ARTC_CNT") ; 
				int idxPKG_CNT    = userSet.indexOfColumn("PKG_CNT") ; 
				int idxPKG_CBM    = userSet.indexOfColumn("PKG_CBM") ; 
				int idxPKG_WGHT   = userSet.indexOfColumn("PKG_WGHT") ; 
				int idxORDER_SEQ  = userSet.indexOfColumn("ORDER_SEQ") ; 
				int idxCARINFO    = userSet.indexOfColumn("CARINFO") ; 

				GauceDataRow[] rows = userSet.getDataRows();
				
				StringBuffer GetAuthNoSql = null;
				StringBuffer  Sql = null;
				
				GetAuthNoSql = new StringBuffer();
				
				GetAuthNoSql.append(" SELECT TO_CHAR(SYSDATE,'YYMMDD')||                                                                                            \n")
							.append("       CASE WHEN MAX(AUTH_NO) IS NULL THEN '01'                                                                                \n")
							.append("           WHEN LENGTH(TO_NUMBER(MAX(SUBSTR(AUTH_NO,7,2)))+1)IN(1,2) THEN LPAD(TO_NUMBER(MAX(SUBSTR(AUTH_NO,7,2)))+ 1,2,'0')   \n")
							.append("       ELSE '01' END AS AUTH_NO                                                                                                \n")
							.append("  FROM TRANSFER.LTORDERDTL                                                                                                     \n")
							.append(" WHERE SUBSTR(AUTH_NO,1,6) = TO_CHAR(SYSDATE,'YYMMDD')        				                                                    \n");
				/*
				GetAuthNoSql.append(" SELECT  SUBSTR(CHAR(CURRENT DATE),3,2)  CONCAT SUBSTR(CHAR(CURRENT DATE),6,2) \n")
							.append("					CONCAT SUBSTR(CHAR(CURRENT DATE),9,2) CONCAT \n")
							.append("					CASE WHEN MAX(AUTH_NO) IS NULL then  '01' \n")
							.append("					WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(AUTH_NO,7,2)))+ 1)) = 1  \n")
							.append("					THEN '0' CONCAT TRIM(DEC(MAX(SUBSTRING(AUTH_NO,7,2)))+ 1) \n")
							.append("					WHEN LENGTH(TRIM(DEC(MAX(SUBSTRING(AUTH_NO,7,2)))+ 1)) = 2 \n")
							.append("					THEN TRIM(DEC(MAX(SUBSTRING(AUTH_NO,7,2)))+ 1) \n")
							.append("					ELSE '01'   END  as AUTH_NO \n")
							.append("		FROM TRANSFER.LTORDERDTL \n")
							.append("	 WHERE SUBSTR(AUTH_NO,1,6) = SUBSTR(CHAR(CURRENT DATE),3,2) \n")
							.append(" CONCAT SUBSTR(CHAR(CURRENT DATE),6,2) CONCAT SUBSTR(CHAR(CURRENT DATE),9,2) ");
				*/
				
				//System.out.println("trOrderSts::"+GetAuthNoSql.toString());
				gstmt = conn.getGauceStatement(GetAuthNoSql.toString());
				gstmt.executeQuery(dSetMstID);
				gstmt.close(); 

				if ( dSetMstID!=null && dSetMstID.getDataRowCnt() > 0 ) {
					GauceDataRow[] dRowMstID = dSetMstID.getDataRows();
									 
					auth_no = dRowMstID[0].getString(0);  
					//AUTHNO1 = rowsTemp1[0].getLong(1);  
				}

				//System.out.println("trOrderSts::6"+auth_no);

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					ls_check= rows[j].getString(idxCHECK);//   상차여부	

						if(ls_check.equals("T")){
							Sql = new StringBuffer();
							Sql.append(" UPDATE TRANSFER.LTORDERDTL  \n")
							   .append("	SET ORDER_STS  = '0002', \n") 
							   .append("		AUTH_NO = ? \n")
							   .append("  WHERE ORDER_NO = ? \n")
							   .append("		AND ORDER_SEQ  = ? ");

							GauceStatement gsmt = conn.getGauceStatement(Sql.toString()); 
							gsmt.setGauceDataRow(rows[j]); 
							gsmt.setString(1, auth_no); 
							gsmt.bindColumn(2, idxORDER_NO); 
							gsmt.bindColumn(3, idxORDER_SEQ );
							gsmt.executeUpdate(); 
							gsmt.close();
							Sql = null ; 
						}
					}
				} //Loop While 
							
				//****************Master Update****************/

				Sql = new StringBuffer();
				Sql.append(" UPDATE TRANSFER.LTORDERMST \n")
				   .append("	SET ORDER_STS = '0002' \n")
				   .append("  WHERE ORDER_NO IN (SELECT DISTINCT ORDER_NO FROM TRANSFER.LTORDERDTL WHERE AUTH_NO ='" + auth_no + "') \n")
				   .append("	AND ORDER_STS <> '0002' \n");

				GauceStatement gsmt1 = conn.getGauceStatement(Sql.toString()); 
				gsmt1.executeUpdate(); 
				gsmt1.close();
				Sql = null ; 

				// 주문 Master
				Sql = new StringBuffer();
				Sql.append(" INSERT INTO TRANSFER.BTORDERMST \n")
				   .append(" ( SELECT * FROM TRANSFER.LTORDERMST \n")
				   .append("	WHERE ORDER_NO IN (SELECT DISTINCT ORDER_NO \n")
				   .append("						 FROM TRANSFER.LTORDERDTL \n")
				   .append("						WHERE AUTH_NO = '" + auth_no + "') \n")
				   .append("	  AND ORDER_STS = '0002') \n");

				GauceStatement gsmt2 = conn.getGauceStatement(Sql.toString()); 
				gsmt2.executeUpdate(); 
				gsmt2.close();
				Sql = null ; 

				// 주문 Detail
				Sql = new StringBuffer();
				Sql.append(" INSERT INTO TRANSFER.BTORDERDTL \n")
					 .append(" ( SELECT * FROM TRANSFER.LTORDERDTL \n")
					 .append("	  WHERE ORDER_NO IN (SELECT DISTINCT ORDER_NO \n")
					 .append("		  				   FROM TRANSFER.LTORDERDTL \n")
					 .append("						  WHERE AUTH_NO = '" + auth_no + "') \n")
					 .append("		AND ORDER_STS = '0002') \n");
				
				GauceStatement gsmt3 = conn.getGauceStatement(Sql.toString()); 
				gsmt3.executeUpdate(); 
				gsmt3.close();
				Sql = null ; 

				//데이타가 존재 할 경우만 INSERT
				/*
        StringBuffer  Sql_T = null;
				Sql_T = new StringBuffer(); 
				
				CAR_SEQ_NO  ORDER_NO	   LINE_PART	 CARTYPENO	   CAR_CNT	
				LD_CARGO	  LD_CARGONM	 OFF_CARGO	 OFF_CARGONM	 CUST_CD	
				CUST_NAME	  CUST_PS	     CUST_TEL	   LD_DATE	     PERSON_NO	
				CAR_TYPE	  REMARK	     CTN_STDRD	 EDT_DATE	     LCT_URL	
				IN_OUT	    ADDR_FILE	   CREATE_DT	 CREATE_USR	   UPDATE_DT	
				UPDATE_USR
				*/
        /*
				Sql_T.append(" SELECT  \n")
					 .append(" CAR_SEQ_NO,  ORDER_NO,	   LINE_PART,	 CARTYPENO,	   CAR_CNT,	   \n")
					 .append(" LD_CARGO,	  LD_CARGONM,	 OFF_CARGO,	 OFF_CARGONM,	 CUST_CD,	   \n")
					 .append(" CUST_NAME,	  CUST_PS,	   CUST_TEL,	 LD_DATE,	     PERSON_NO,  \n")
					 .append(" CAR_TYPE,	  REMARK,	     CTN_STDRD,	 EDT_DATE,	   LCT_URL,	   \n")
					 .append(" IN_OUT,	    ADDR_FILE,	 CREATE_DT,	 CREATE_USR,	 UPDATE_DT,	  \n")
					 .append(" UPDATE_USR                                                     \n")
					 .append(" FROM TRANSFER.LTORDCAR  \n")
					 .append("		WHERE ORDER_NO IN (SELECT DISTINCT ORDER_NO \n")
					 .append("												 FROM TRANSFER.LTORDERDTL \n")
					 .append("												WHERE AUTH_NO = '" + auth_no + "') \n");
			
				Statement stmt = null;
				ResultSet rs = null;
				logger.dbg.println(this,""+Sql_T.toString());
				stmt = conn.createStatement();
				rs = stmt.executeQuery(Sql_T.toString());
								
				while (rs.next())	{
					logger.dbg.println(this,"CAR_SEQ_NO"+rs.getString(1));
					logger.dbg.println(this,"ORDER_NO"+rs.getString(2));
					logger.dbg.println(this,"LINE_PART"+rs.getString(3));
					logger.dbg.println(this,"CARTYPENO"+rs.getString(4));
					logger.dbg.println(this,"CAR_CNT"+rs.getInt(5));
					logger.dbg.println(this,"LD_CARGO"+rs.getString(6));
					logger.dbg.println(this,"LD_CARGONM"+rs.getString(7));
					logger.dbg.println(this,"OFF_CARGO"+rs.getString(8));
					logger.dbg.println(this,"OFF_CARGONM"+rs.getString(9));
					logger.dbg.println(this,"CUST_CD"+rs.getString(10));
					logger.dbg.println(this,"CUST_NAME"+rs.getString(11));
					logger.dbg.println(this,"CUST_PS"+rs.getString(12));
					logger.dbg.println(this,"CUST_TEL"+rs.getString(13));
					logger.dbg.println(this,"LD_DATE"+rs.getString(14));
					logger.dbg.println(this,"PERSON_NO"+rs.getString(15));
					logger.dbg.println(this,"CAR_TYPE"+rs.getString(16));
					logger.dbg.println(this,"REMARK"+rs.getString(17));
					logger.dbg.println(this,"CTN_STDRD"+rs.getString(18));
					logger.dbg.println(this,"EDT_DATE"+rs.getString(19));
					logger.dbg.println(this,"LCT_URL"+rs.getString(20));
					logger.dbg.println(this,"IN_OUT"+rs.getString(21));
					logger.dbg.println(this,"ADDR_FILE"+rs.getString(22));
					logger.dbg.println(this,"CREATE_DT"+rs.getString(23));
					logger.dbg.println(this,"CREATE_USR"+rs.getString(24));
					logger.dbg.println(this,"UPDATE_DT"+rs.getString(25));
					logger.dbg.println(this,"UPDATE_USR"+rs.getString(26));

			
				// 배정 Master
				
				Sql.append(" INSERT INTO TRANSFER.BTORDCAR \n")
					 .append("  (  CAR_SEQ_NO,  ORDER_NO,	   LINE_PART,	 CARTYPENO,	   CAR_CNT, \n")
					 .append("     LD_CARGO,	  LD_CARGONM,	 OFF_CARGO,	 OFF_CARGONM,	 CUST_CD,\n")
					 .append("   CUST_NAME,	  CUST_PS,	   CUST_TEL,	 LD_DATE,	     PERSON_NO, \n")
					 .append("   CAR_TYPE,	  REMARK,	     CTN_STDRD,	 EDT_DATE,	   LCT_URL,	  \n")
					 .append("   IN_OUT,	    CREATE_DT,	 CREATE_USR,	 UPDATE_DT,	\n")
					 .append("   UPDATE_USR                                                     \n")
					 .append("   )\n")
					 .append("  VALUES( \n")
					 .append("  '"+rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(3)+"','"+rs.getString(4)+"',"+rs.getInt(5)+",  \n")
					 .append("  '"+rs.getString(6)+"','"+rs.getString(7)+"','"+rs.getString(8)+"','"+rs.getString(9)+"','"+rs.getString(10)+"',  \n")
					 .append("  '"+rs.getString(11)+"','"+rs.getString(12)+"','"+rs.getString(13)+"','"+rs.getString(14)+"','"+rs.getString(15)+"',  \n")
					 .append("  '"+rs.getString(16)+"','"+rs.getString(17)+"','"+rs.getString(18)+"','"+rs.getString(19)+"','"+rs.getString(20)+"',  \n")
					 .append("  '"+rs.getString(21)+"','','"+rs.getString(24)+"','',  \n")
					 .append("  '"+rs.getString(26)+"' )\n");
				*/
					 
			      Sql = new StringBuffer();
				  Sql.append(" INSERT INTO TRANSFER.BTORDCAR \n")
					 .append(" ( SELECT * FROM TRANSFER.LTORDCAR \n")
					 .append("	  WHERE ORDER_NO IN (SELECT DISTINCT ORDER_NO \n")
					 .append("						   FROM TRANSFER.LTORDERDTL \n")
					 .append("						  WHERE AUTH_NO = '" + auth_no + "')) \n");
				GauceStatement gsmt4 = conn.getGauceStatement(Sql.toString()); 
				gsmt4.executeUpdate(); 
				gsmt4.close();
				Sql = null ; 

				// 배정 Detail
				Sql = new StringBuffer();
				Sql.append(" INSERT INTO TRANSFER.BTCARGOODS \n")
					 .append(" ( SELECT * FROM TRANSFER.LTCARGOODS \n")
					 .append("		WHERE ORDER_NO IN (SELECT DISTINCT ORDER_NO \n")
					 .append("							 FROM TRANSFER.LTORDERDTL \n")
					 .append("							WHERE AUTH_NO = '" + auth_no + "')) \n");

				GauceStatement gsmt5 = conn.getGauceStatement(Sql.toString()); 
				gsmt5.executeUpdate(); 
				gsmt5.close();
				Sql = null ; 

			}
			catch(SQLException se){
				conn.rollback();
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+se.toString()+")");
				logger.err.println(this,se);
			}

			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e);
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}