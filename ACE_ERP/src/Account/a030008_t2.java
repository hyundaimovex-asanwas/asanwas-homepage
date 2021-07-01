package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a030008_t2 extends HttpServlet{
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
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				
				/*******************************************************
				 * �ݰ��� ��ȭ ���� ���� ����
				 * 2013.02.13 �� 
				 * ��ȭȯ������(�ս�) -> �ݰ��� ��������
				 * ��ȭȯ������ -> �ݰ��� �������� �뺯
				 * ��ȭȯ������ -> �ݰ��� �������� ����
				 * 
				 *******************************************************/

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

                double dblfoamt=0; 
				double dblChk=0;
				double dblfodetot=0;
				double dblfocrtot=0;
				int intCnt=0;
				String strAtcode="";

				String strYYMM = reqGauce.getParameter("v_str1");     //ȸ����
				String strFDCODE = reqGauce.getParameter("v_str2");   //����
                String strYYYY="";
                strYYYY=strYYMM.substring(0,4);
       
				int idxFDCODE   = userSet.indexOfColumn("FDCODE");
				
				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j < rows.length; j++){ 
	        
                    //ȯ����ȯ ������ �ʱ�ȭ 
					//2011.02.10 JYS ��������
                    //2013.02.13 JYS ��������

					StringBuffer sql00 = new StringBuffer();
					sql00.append( " DELETE FROM ACCOUNT.MTOTALBAL  " );
					sql00.append( "  WHERE FDCODE = '03'  " );
					sql00.append( "    AND ACTYYMM LIKE '"+strYYYY+"%'" );
					sql00.append( " 	 AND ATCODE ='1240000' "  );
					sql00.append( "    AND COCODE ='02'   " );
					sql00.append( "    AND DETOT  =0 AND CRTOT=0   " );
					sql00.append( "    AND DIVCD  = 'F000'" );                   
					sql00.append( "    AND DEPTCD = 'F999'" );  //ȯ����ȯ ������ ����                 

                    //logger.dbg.println(this,sql00.toString());
					GauceStatement gsmt00 = conn.getGauceStatement(sql00.toString());
					gsmt00.executeUpdate();
					gsmt00.close(); 



					//�ݰ��� ��ȯ�� ȯ����ȯ �ݾ�
					// ���� - �뺯  (-) : ��ȯ ���� (����)
					//                    (+) : ��ȯ ���� (�뺯)
                    //��ȯ����/��ȯ���� ��ȸ 
					Statement stmt2 = conn.createStatement(); 
					StringBuffer sql2 = new StringBuffer();
		
					sql2.append( " SELECT SUM(FODETOT)AS FODETOT, SUM(FOCRTOT) AS FOCRTOT,   " );
					sql2.append( "        (SUM(FODETOT)-SUM(FOCRTOT)) AS CHK ,               " );
					sql2.append( "        (ABS(SUM(FODETOT)-SUM(FOCRTOT))) AS FOAMT          " );
					sql2.append( "   FROM ACCOUNT.MTOTALBAL A, ACCOUNT.ACTCODE B             " );
					sql2.append( "  WHERE A.ATCODE=B.ATCODE                                  " );
                    sql2.append( "    AND A.FDCODE ='03'                                     " );
					sql2.append( "    AND A.ACTYYMM  >= '"+strYYYY+"00'                      " );
					sql2.append( "    AND A.ACTYYMM  <= '"+strYYMM+"'                         " );
					sql2.append( "    AND B.ATUSEYN='Y'                                      " );

					ResultSet rs2 = stmt2.executeQuery(sql2.toString()); 
					if(rs2.next()){
						 dblChk   = rs2.getDouble(3);
						 dblfoamt = rs2.getDouble(4);
					}
					rs2.close();
					stmt2.close();

                   //�ݾ� ��
                   if(dblChk>0){ // (+) : ��ȯ ���� (�뺯)  ==>  ��ȭȯ������ ���� ����
					    strAtcode="1240000";
						dblfodetot=0;
						dblfocrtot=dblfoamt;
					}else{        // (-) : ��ȯ ���� (����)  ==>  ��ȭȯ��ս� �� ����
					    strAtcode="1240000"; 
						dblfodetot=dblfoamt;
						dblfocrtot=0;
					}

					if(dblChk!=0){

						// +  ��ȯ���� �뺯                                         
						// -  ��ȯ���� ����                                 
						// �μ��ڵ带 F999�� �Ͽ� �̰Ÿ� ó����.            
						Statement stmt3 = conn.createStatement(); 
						StringBuffer sql3 = new StringBuffer();			 
						sql3.append( " SELECT COUNT(*) AS CNT FROM ACCOUNT.MTOTALBAL 	" );
						sql3.append( "  WHERE FDCODE='03'              									" );
						sql3.append( " 	 AND ACTYYMM='"+strYYMM+"'     								" );
						sql3.append( " 	 AND ATCODE='"+strAtcode+"'    								" );
						sql3.append( " 	 AND COCODE='02'               									" );
						sql3.append( " 	 AND DIVCD='F000'              										" );
						sql3.append( " 	 AND DEPTCD='F999'             									" );

						ResultSet rs3 = stmt3.executeQuery(sql3.toString()); 
						if(rs3.next()){
							 intCnt   = rs3.getInt(1);
						}
						rs3.close();
						stmt3.close();

					
						//������ �����ϴ��� ��ȸ
						if (intCnt==0){
							//������ INSERT
							StringBuffer sql4_1 = new StringBuffer();
							sql4_1.append( " INSERT INTO ACCOUNT.MTOTALBAL(  														" );
							sql4_1.append( " FDCODE,	  ACTYYMM,    ATCODE,	   COCODE,	  DIVCD,     DEPTCD,	  	" );
							sql4_1.append( " DETOT,	    CRTOT,	    DECASH,	   CRCASH,    EDECASH,	 ECRCASH,	  		" );
							sql4_1.append( " DEUPTOT,   CRUPTOT,	  DEUPCASH,	 CRUPCASH,	                      					" );
							sql4_1.append( " FODETOT,   FOCRTOT,	  FODECASH,	 FOCRCASH,	FOEDECASH, FOECRCASH, " );
							sql4_1.append( " FODEUPTOT, FOCRUPTOT,	FODEUPCASH,FOCRUPCASH,	                    		" );
							sql4_1.append( " EXRATE,    EXRATEDT,	  EXRATEGB ) 															" );
							sql4_1.append( " VALUES ( '03','"+strYYMM+"','"+strAtcode+"','02','F000','F999', 							" );
							sql4_1.append( " 0,0,0,0,0,0,																									" );
							sql4_1.append( " 0,0,0,0,																										" );
							sql4_1.append( " "+dblfodetot+","+dblfocrtot+",0,0,0,0,																	" );
							sql4_1.append( " 0,0,0,0,																										" );
							sql4_1.append( " 0,'','' )																										"); 

							GauceStatement gsmt4_1 = conn.getGauceStatement(sql4_1.toString());
							gsmt4_1.executeUpdate();
							gsmt4_1.close();
						
						}else{
							//�����ϸ� UPDATE
							StringBuffer sql4_1 = new StringBuffer();
							sql4_1.append( " UPDATE ACCOUNT.MTOTALBAL SET    " );
							sql4_1.append( "        FODETOT = "+dblfodetot+"," );
							sql4_1.append( "        FOCRTOT = "+dblfocrtot+"" );
							sql4_1.append( "  WHERE FDCODE = '03'  " );
							sql4_1.append( "    AND ACTYYMM = '"+strYYMM+"'"  );
							sql4_1.append( "    AND ATCODE ='"+strAtcode+"' " );
							sql4_1.append( "    AND COCODE ='02'   " );
							sql4_1.append( "    AND DIVCD  = 'F000'" );                   
							sql4_1.append( "    AND DEPTCD = 'F999'" );                   

							GauceStatement gsmt4_1 = conn.getGauceStatement(sql4_1.toString());
							gsmt4_1.executeUpdate();
							gsmt4_1.close(); 
						}
					}
		     		
				}//for
			}
			catch(Exception e){
				conn.rollback(); 
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