package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a020013_t1 extends HttpServlet{
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

			String strFdcode = null;
			String strFsdat = null;
			String strFsnbr = null;
			String strChgdt = null;
			String strTempFsdat = null;
			String strTempFsnbr = null;
    
			try {
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String str1 = reqGauce.getParameter("v_str1");  //WRDT
				String str2 = reqGauce.getParameter("v_str2");  //WRID
				String strloginfdcode = reqGauce.getParameter("v_str3");   //로그인 ID에 따른 지점 

				/************************************************************************************
        		@
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE       = userSet.indexOfColumn("FDCODE");
				int idxFSDAT        = userSet.indexOfColumn("FSDAT");
				int idxFSNBR        = userSet.indexOfColumn("FSNBR");
				int idxCHGDT        = userSet.indexOfColumn("CHGDT");  //변경일자
				 
				GauceDataRow[] rows = userSet.getDataRows();
				
				for (int j=0;j<rows.length; j++){
							
					strFdcode = rows[j].getString(idxFDCODE);
					strFsdat  = rows[j].getString(idxFSDAT);
					strFsnbr  = rows[j].getString(idxFSNBR);
					strChgdt  = rows[j].getString(idxCHGDT);

					strTempFsdat = strFsdat.substring(0,1)+strChgdt;
					
				 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				 //전표번호생성 Start
				 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					if(strloginfdcode.equals(strFdcode)){
            
						Statement stmt = conn.createStatement();
						String sql = " SELECT NVL(MAX(FSNBR),0)+1 FROM ACCOUNT.FSLIPMST "
											 + "	WHERE FDCODE ='"+strFdcode+"'" 
											 + "	  AND FSDAT='"+strTempFsdat+"'"
											 + "	  AND FSNBR<'100000'" ; 
						
						ResultSet rs = stmt.executeQuery(sql); 
						if(rs.next()){
							 strTempFsnbr = rs.getString(1);
						}
						rs.close();
						int ichk = Integer.parseInt(strTempFsnbr);

						if(ichk<10) strTempFsnbr = "00000"+strTempFsnbr;
						else if(ichk>=10 && ichk<100)strTempFsnbr = "0000"+strTempFsnbr;
						else if(ichk>=100 && ichk<1000) strTempFsnbr ="000"+strTempFsnbr;
						else if(ichk>=1000 && ichk<10000)strTempFsnbr = "00"+strTempFsnbr;
						else if(ichk>=10000 && ichk<100000) strTempFsnbr = "0"+strTempFsnbr;

					}else{
						Statement stmt = conn.createStatement();
						String sql = " SELECT NVL(MAX(FSNBR),0)+1 FROM ACCOUNT.FSLIPMST "
											 + "	WHERE FDCODE ='"+strFdcode+"'" 
											 + "	  AND FSDAT='"+strTempFsdat+"'"
											 + "	  AND FSNBR>='500000'" ; 
						ResultSet rs = stmt.executeQuery(sql); 
						if(rs.next()){
							 strTempFsnbr= rs.getString(1);
						}

						rs.close();
						int ichk = Integer.parseInt(strTempFsnbr);

						if(ichk<10) strTempFsnbr = "50000"+strTempFsnbr;
						else if(ichk>=10 && ichk<100)strTempFsnbr = "5000"+strTempFsnbr;
						else if(ichk>=100 && ichk<1000) strTempFsnbr ="500"+strTempFsnbr;
						else if(ichk>=1000 && ichk<10000)strTempFsnbr = "50"+strTempFsnbr;
						else if(ichk>=10000 && ichk<100000) strTempFsnbr = "5"+strTempFsnbr;		
					}
					

				 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				 //전표번호생성 End
				 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				   	if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표MST COPY START
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					   
				   		StringBuffer sql_mst = new StringBuffer();
		
							sql_mst.append( " INSERT INTO ACCOUNT.FSLIPMST  												\n");
							sql_mst.append( " ( FDCODE,	FSDAT,	FSNBR,	FSKND,	FSWRTDAT,  							\n");
							sql_mst.append( "   COCODE,	DEPTCD,	EMPNO,	DIVCD,	FSAMT,  						\n");
							sql_mst.append( "   FSVAT,	DETOT,	CRTOT,	REMARK,	SGNDAT, 							\n");
							sql_mst.append( "   FSSTAT,	ACTDAT,	SSDAT,	SSNBR,	WRDT,   								\n");
							sql_mst.append( "   WRID,	  UPDT,	  UPID  )                 											\n");
							sql_mst.append( "   SELECT FDCODE,'"+strTempFsdat+"','"+strTempFsnbr+"','C','"+str1+"',\n");
							sql_mst.append( "          nvl(COCODE,''),nvl(DEPTCD,''),'"+str2+"',nvl(DIVCD,''),FSAMT,	               \n");
							sql_mst.append( "          FSVAT,DETOT,CRTOT,REMARK,'', 										\n");
							sql_mst.append( "          'N','"+strChgdt+"','',	'','"+str1+"', 										\n");
							sql_mst.append( "          '"+str2+"','"+str1+"','"+str2+"' 												\n");
							sql_mst.append( "     FROM ACCOUNT.FSLIPMST         												\n");
							sql_mst.append( "    WHERE FDCODE ='"+strFdcode+"'												\n");
							sql_mst.append( "      AND FSDAT = '"+strFsdat+"'   													\n");
							sql_mst.append( "      AND FSNBR = '"+strFsnbr+"'   													\n");
											
						GauceStatement gsmt_mst = conn.getGauceStatement(sql_mst.toString());
						gsmt_mst.executeUpdate();
						gsmt_mst.close();
           
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표MST COPY END
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표DTL COPY START
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					        StringBuffer sql_dtl = new StringBuffer();
			
									//sql_dtl=null;
									sql_dtl.append( " INSERT INTO ACCOUNT.FSLIPDTL  												\n");
									sql_dtl.append( " ( FDCODE,	  FSDAT,	  FSNBR,	  FSSEQ,	  ATCODE,   			\n");
									sql_dtl.append( "   ATDECR,	  FSAMT,	  ACNNBR,	  BANJAEYN,	PRIMCOST,	 	\n");
									sql_dtl.append( "   DOCUMCD,	DOCUVAL,	FSWRKDIV,	REMARK,   FSNUM,     			\n");
									sql_dtl.append( "   DIVCD,	  BGTDIV, 	SSDAT,  	SSNBR,  	WRDT,      					\n");
									sql_dtl.append( "   WRID,  	  UPDT,   	UPID    )                      								\n");
									sql_dtl.append( " SELECT FDCODE,	'"+strTempFsdat+"','"+strTempFsnbr+"',FSSEQ,ATCODE,  \n");
									sql_dtl.append( "        ATDECR,	FSAMT,	  ACNNBR,	  BANJAEYN,	PRIMCOST,	 	\n");
									sql_dtl.append( "        '',	'',	FSWRKDIV,	REMARK,   FSNUM,     								\n");
									sql_dtl.append( "        DIVCD,	  BGTDIV, 	'',  	'', '"+str1+"',          							\n");
									sql_dtl.append( "        '"+str2+"','"+str1+"','"+str2+"'                  								\n");
									sql_dtl.append( "  FROM ACCOUNT.FSLIPDTL					 									\n");
									sql_dtl.append( " WHERE FDCODE ='"+strFdcode+"'	   											\n");
									sql_dtl.append( "   AND FSDAT = '"+strFsdat+"'		 												\n");
									sql_dtl.append( "   AND FSNBR = '"+strFsnbr+"'		 												\n");
			
						GauceStatement gsmt_dtl = conn.getGauceStatement(sql_dtl.toString());
						gsmt_dtl.executeUpdate();
						gsmt_dtl.close();
						//sql_dtl=null;
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표DTL COPY END
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표REF COPY START
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					        StringBuffer sql_ref = new StringBuffer();
					
									sql_ref.append( " INSERT INTO ACCOUNT.FSLIPREF  											\n");
									sql_ref.append( "   ( FDCODE,	FSDAT,	  FSNBR,	FSSEQ,	FSREFSEQ,	 		\n");
									sql_ref.append( "     FSREFCD,	FSREFVAL,	SSDAT,	SSNBR,	WRDT,     				\n");
									sql_ref.append( "     WRID, UPDT, UPID)                             								\n");
									sql_ref.append( "  SELECT FDCODE,'"+strTempFsdat+"','"+strTempFsnbr+"',FSSEQ,FSREFSEQ, \n");
									sql_ref.append( "         FSREFCD,	FSREFVAL,	'',	'',	'"+str1+"',  							\n");
									sql_ref.append( "        '"+str2+"','"+str1+"','"+str2+"'         									\n");
									sql_ref.append( "    FROM ACCOUNT.FSLIPREF													\n");
									sql_ref.append( "   WHERE FDCODE ='"+strFdcode+"'											\n");
									sql_ref.append( "     AND FSDAT = '"+strFsdat+"'  												\n");
									sql_ref.append( "     AND FSNBR = '"+strFsnbr+"'  												\n");
																
						GauceStatement gsmt_ref = conn.getGauceStatement(sql_ref.toString());
						gsmt_ref.executeUpdate();
						gsmt_ref.close();
						//sql_ref=null;
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표REF COPY END
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				   	}
				}//for j
			} //try
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
			///^^logger.err.println(this,e);
			///^^logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}