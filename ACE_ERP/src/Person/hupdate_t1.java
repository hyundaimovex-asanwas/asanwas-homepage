package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class hupdate_t1 extends HttpServlet{

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

				String SCR1 ="";
				String AVG1 ="";
				String SCR2 ="";
				String AVG2 ="";
				String SCR3 ="";
				String AVG3 ="";
				String SCR4 ="";
				String AVG4 ="";

        /************************************************************************************
         @
				*************************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxTEMP      = userSet.indexOfColumn("TEMP");
				 
				GauceDataRow[] rows = userSet.getDataRows();
				
				for (int j=0;j<rows.length; j++){
								
				 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				 //전표번호생성 Start
				 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				
						Statement stmt = conn.createStatement();
						String sql = "  SELECT EMPNO, EVAYM, COALESCE(SCR1,0),	COALESCE(AVG1,0),	COALESCE(SCR2,0),	COALESCE(AVG2,0),	COALESCE(SCR3,0),	COALESCE(AVG3,0),	COALESCE(SCR4,0),	COALESCE(AVG4,0) "
											 + "    FROM PAYROLL.HVEMP_TM  "
											 + "	 WHERE EVAYM ='"+rows[j].getString(idxTEMP)+"'" 
											 + "	   AND (SCR1<>0 OR SCR2<>0 OR SCR3<>0 OR SCR4<>0) " ;
					  logger.dbg.println(this,"sql::"+sql);
						
						ResultSet rs = stmt.executeQuery(sql); 


						while(rs.next()){
													 
              StringBuffer sql9_3 = new StringBuffer();

              SCR1 =String.valueOf(rs.getInt(3));
							AVG1 =String.valueOf(rs.getInt(4));
							SCR2 =String.valueOf(rs.getInt(5));
							AVG2 =String.valueOf(rs.getInt(6));
							SCR3 =String.valueOf(rs.getInt(7));
							AVG3 =String.valueOf(rs.getInt(8));
							SCR4 =String.valueOf(rs.getInt(9));
							AVG4 =String.valueOf(rs.getInt(10));

						//	logger.dbg.println(this, "SCR1::"+SCR1);

							//logger.dbg.println(this, "SCR1::");


							sql9_3.append( " UPDATE PAYROLL.HVEMP SET  ");
              sql9_3.append( "        TOTAVG = 9,  ");
if(!SCR1.equals("0"))sql9_3.append( "        SCR1 = "+rs.getDouble(3)+"," );
if(!AVG1.equals("0"))sql9_3.append( "        AVG1 = "+rs.getDouble(4)+"," );
if(!SCR2.equals("0"))sql9_3.append( "        SCR2 = "+rs.getDouble(5)+"," );
if(!AVG2.equals("0"))sql9_3.append( "        AVG2 = "+rs.getDouble(6)+"," );
if(!SCR3.equals("0"))sql9_3.append( "        SCR3 = "+rs.getDouble(7)+"," );
if(!AVG3.equals("0"))sql9_3.append( "        AVG3 = "+rs.getDouble(8)+"," );
if(!SCR4.equals("0"))sql9_3.append( "        SCR4 = "+rs.getDouble(9)+"," );
if(!AVG4.equals("0"))sql9_3.append( "        AVG4 = "+rs.getDouble(10)+"," );
              sql9_3.append( "        EVAYM = '"+rs.getString(2)+"'" );
  						sql9_3.append( "  WHERE EMPNO = '"+rs.getString(1)+"'" );
              sql9_3.append( "    AND EVAYM = '"+rs.getString(2)+"'" );
							
														 
							GauceStatement gsmt9_3 = conn.getGauceStatement(sql9_3.toString());
							gsmt9_3.executeUpdate();
							gsmt9_3.close();

						}

					

				 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				 //전표번호생성 End
				 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
				   	if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					 //전표MST COPY START
					 //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
					   
           

				
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