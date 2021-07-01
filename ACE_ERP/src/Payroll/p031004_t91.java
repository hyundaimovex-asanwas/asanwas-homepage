package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p031004_t91 extends HttpServlet{

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

				/*********************************************************************
				 ��α� �̿����� �ѵ� üũ 
				 -- ��α� �̿����� �� �ٷμҵ�ݾ� �ܾ��� ��αݺ��� ���� ��� 
				*********************************************************************/

				int intChkamt01 =0;  //�ѵ�üũ���� ��α� �ѵ� üũ ������ �ٷμҵ�ݾ� ���� �ܾ�
				int intCnt=0;
				int intGIVAMT = 0;	//*�ش翬�������ݾ�*/
				int intCARAMT = 0;	//*�̿��ݾ�*/        
				int intTGIVAMT =0;  //��αݾ�

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPYY    = userSet.indexOfColumn("APPYY");   //�ͼӳ⵵       
				int idxEMPNO    = userSet.indexOfColumn("EMPNO");   //�ͼӳ⵵       

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
        		
						//A.ACCAMT, -/*���⴩�������ݾ�*/
						//A.DEDAMT, -/*�������ݾ�*/
						//A.GIVAMT, -/*�ش翬�������ݾ�*/ 
						//A.EXTAMT, -/*�Ҹ�ݾ�*/  
						//A.CARAMT, -/*�̿��ݾ�*/ 

					  SelectSql = new StringBuffer();
						SelectSql.append( "  SELECT A.APPYY,  A.EMPNO,   A.GIVCOD,  A.GIVYY,   A.TGIVAMT,            \n" ); 
						SelectSql.append( "         A.ACCAMT, A.DEDAMT,  A.GIVAMT,  A.EXTAMT,  A.CARAMT,             \n" ); 
						SelectSql.append( "         B.LABPAY, B.CHKAMT01,                                            \n" ); 
						SelectSql.append( "          B.CONLMT10, B.CONLMT30, B.CONLMT31, B.CONLMT40, B.CONLMT41      \n" ); 
						SelectSql.append( "    FROM PAYROLL.YCPRSNGC A, PAYROLL.YCPAY10 B								             \n" ); 
						SelectSql.append( "   WHERE A.APPYY = B.APPYY																		             \n" ); 
						SelectSql.append( "     AND A.EMPNO = B.EMPNO																		             \n" ); 
						SelectSql.append( "     AND A.APPYY='"+rows[j].getString(idxAPPYY)+"'	  				             \n" ); 
						SelectSql.append( "     AND A.EMPNO='"+rows[j].getString(idxEMPNO)+"'	  				             \n" ); 
						SelectSql.append( "     AND A.EMPNO IN ( 	SELECT  X.EMPNO                                    \n" ); 
						SelectSql.append( "                       	FROM ( SELECT APPYY, EMPNO, SUM(TGIVAMT)TGIVAMT  \n" ); 
						SelectSql.append( "                       					 FROM PAYROLL.YCPRSNGC                   \n" ); 
						SelectSql.append( "                       					WHERE APPYY='"+rows[j].getString(idxAPPYY)+"' \n" ); 
						SelectSql.append( "                       					GROUP BY APPYY,EMPNO                     \n" ); 
						SelectSql.append( "                       			 )X, PAYROLL.YCPAY10 B                       \n" ); 
						SelectSql.append( "                       WHERE X.APPYY =B.APPYY                             \n" ); 
						SelectSql.append( "                       	AND X.EMPNO =B.EMPNO                             \n" ); 
						SelectSql.append( "                       	AND X.APPYY='"+rows[j].getString(idxAPPYY)+"'    \n" ); 
						SelectSql.append( "                       	AND X.TGIVAMT > B.CHKAMT01                       \n" ); 
						SelectSql.append( "                       	AND B.CHKAMT01<>0                                \n" ); 
						SelectSql.append( "                       )                                                  \n" );						
						
						logger.dbg.println(this,"SelectSql::"+SelectSql.toString());
					
						stmt = conn.createStatement();
						rs = stmt.executeQuery(SelectSql.toString());

					 logger.dbg.println(this,"40:::");

           //�ʱ�ȭ
					 intChkamt01=0;
					 intCnt=0;
				
						while(rs.next()){  
							logger.dbg.println(this,"41:::");
							intGIVAMT =rs.getInt("GIVAMT");
							intCARAMT =rs.getInt("CARAMT");
							intCnt+=1;
							if(intCnt==1){ // ������ �Ǹ�
								intChkamt01 = rs.getInt("CHKAMT01");
							}

							if(intChkamt01>0 ){ //��α� üũ���� �ѵ��� 
								if(rs.getInt("TGIVAMT")>intChkamt01){  // ��α�>��α� üũ�� �ٷμҵ�ݾ� �ܾ� ���� ū ���
									if(rs.getInt("GIVAMT")>intChkamt01){ // �����ݾ�> ��α� üũ�� �ٷμҵ�ݾ� �ܾ� ���� ū ���
										intGIVAMT = intChkamt01;
										intCARAMT = rs.getInt("DEDAMT") - intGIVAMT;   //�̿��ݾ�=�������ݾ� - �̿��ݾ�
										logger.dbg.println(this,"42:::");
									}
								}else{
									intChkamt01-=rs.getInt("GIVAMT"); //
								}
							}//if(intChkamt01>0){ //��α� üũ���� �ѵ��� 0 �̸� ��� ��α��� �̿�������Ŵ

							logger.dbg.println(this,"50:::");

							UpdateSql = new StringBuffer();
							UpdateSql.append( "  UPDATE PAYROLL.YCPRSNGC SET    \n");   
							UpdateSql.append( "    GIVAMT='"+intGIVAMT+"'     \n"); 
							UpdateSql.append( "   ,CARAMT='"+intCARAMT+"'     \n"); 
							UpdateSql.append( "   WHERE APPYY = '"+rows[j].getString(idxAPPYY)+"' " );
							UpdateSql.append( "     AND EMPNO = '"+rows[j].getString(idxEMPNO)+"'  " );
							UpdateSql.append( "     AND GIVCOD= '"+rs.getString("GIVCOD")+"'  " );
							UpdateSql.append( "     AND GIVYY = '"+rs.getString("GIVYY")+"'  " );
							logger.dbg.println(this,"UpdateSql.toString()::"+UpdateSql.toString());
							gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.executeUpdate();
							gsmt.close();

							logger.dbg.println(this,"60:::");

           }//while(rs.next()){  
					 stmt.close();
					 rs.close();
				 } //getJobType
			}  //for j     			
		} //try
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,"errno::");
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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