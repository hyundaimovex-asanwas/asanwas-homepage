package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a090028_t1 extends HttpServlet{
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
				GauceStatement gsmt=null;

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();

				String  strAstym = reqGauce.getParameter("v_str1"); //�󰢳��
				String  strAstdat= reqGauce.getParameter("v_str2"); //ó������	
				String  strPrevym= reqGauce.getParameter("v_str3"); //��ü��� ���� �󰢳��(��ü�� ���⵵) -- ������.

				String strYm="";
				double intAmt=0;

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxFDCODE     = userSet.indexOfColumn("FDCODE");      //����  
				int idxATCODE     = userSet.indexOfColumn("ATCODE");      //����     
				int idxAST1ST     = userSet.indexOfColumn("AST1ST");      //��1����      
				int idxAST2ND     = userSet.indexOfColumn("AST2ND");      //��2����     
				int idxAST3RD     = userSet.indexOfColumn("AST3RD");      //��3����          
				int idxASTSEQ     = userSet.indexOfColumn("ASTSEQ");      //�Ϸù�ȣ     
				
				int idxASTAQAMT   = userSet.indexOfColumn("ASTAQAMT");    //���ݾ�   
				int idxASTYUSE    = userSet.indexOfColumn("ASTYUSE");     //���뿬��     
				int idxASTRMAMT   = userSet.indexOfColumn("ASTRMAMT");    //��������(��ΰ���)				
				int idxABDEPRAMT  = userSet.indexOfColumn("ABDEPRAMT");   //����󰢾� 
				int idxACDEPRAMT  = userSet.indexOfColumn("ACDEPRAMT");   //���󰢾�

				int idxASTDEPRST  = userSet.indexOfColumn("ASTDEPRST");   //�����󰢿Ϸ� ���� 0 -������ 1-�󰢿Ϸ�
				int idxDEPRENDDT  = userSet.indexOfColumn("DEPRENDDT");   //�����󰢿Ϸ��� .... 
			
                int idxCOSTCD     = userSet.indexOfColumn("COSTCD");   //�����ڵ�
                int idxASTAMT     = userSet.indexOfColumn("ASTAMT");   //���󰢱ݾ� ( ��ü�� �ݾ��� �����ؼ� ����) .... 

			    int idxACOSTCD   = userSet.indexOfColumn("ACOSTCD");  //��ü�� �����ڵ�
				
				//��ȭ
			    int idxASTAQAMTY = userSet.indexOfColumn("ASTAQAMTY");  //���ݾ�  
				int idxFOBDAMT   = userSet.indexOfColumn("FOBDAMT");    //���⴩���
				int idxFOCDAMT   = userSet.indexOfColumn("FOCDAMT");    //���󰢾�
				int idxFORMAMT   = userSet.indexOfColumn("FORMAMT");    //��������  
				int idxFOATAMT   = userSet.indexOfColumn("FOATAMT");    //�����󰢾�

				//ASTYEPR ///////////////////////////////////////////////////////////////////
				//2010.07.05 ��ü�� �ݾ��� �����ؼ� �� �󰢿� ���� ��� ���󰢾��� Ʋ����.
				//�׷���, ��ü ��Ͻ� ����󰢱ݾ��� �����⵵ 12��31�Ϸ� ó���ְ�
				//���󰢱ݾ��� ������� ���������ڷ� �ؼ� ����.
				/////////////////////////////////////////////////////////////////////////////

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;        
				StringBuffer UpdateSql = null;	     
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {  

						//logger.dbg.println(this,"idxABDEPRAMT::"+ rows[j].getString(idxABDEPRAMT));
                        //logger.dbg.println(this,"idxACDEPRAMT::"+ rows[j].getString(idxACDEPRAMT));
 
						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ASTDEPR (  " );
						InsertSql.append( " FDCODE,	   ATCODE,	  AST1ST,	   AST2ND,	  AST3RD,    " );
						InsertSql.append( " ASTSEQ,	   ASTAQAMT,  ASTYUSE,	 ASTRMAMT,  ASTDEPRST, " );
						InsertSql.append( " DEPRENDDT, ABINSAMT,  ACINSAMT,	 ABDECAMT,	ACDECAMT,  " );
						InsertSql.append( " ABDEPRAMT, ABBOOKAMT, ACDEPRAMT, " );
						InsertSql.append( " FOAQAMT,   FORMAMT,   FOBDAMT,   FOCDAMT, " );
						InsertSql.append( " MOAQAMT,   MORMAMT,   MOBDAMT,   MOCDAMT,  " );
						InsertSql.append( " FMOAQAMT,  FMORMAMT,  FMOBDAMT,  FMOCDAMT  ) " );
						InsertSql.append( " VALUES (   " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,?,?,?,?, " );
						InsertSql.append( " ?,0,0,0,0, " );
						InsertSql.append( " ?,0,?,     " );
						InsertSql.append( " ?,?,?,?,   " );
						InsertSql.append( " ?,?,?,?,   " );
						InsertSql.append( " ?,?,?,?  ) " );

                        if (rows[j].getDouble(idxACDEPRAMT)==0) {
							rows[j].setString(idxASTDEPRST,"1");
                        }else{
							rows[j].setString(idxASTDEPRST,"0");
                        }
						

						gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1,  idxFDCODE);
						gsmt.bindColumn(2,  idxATCODE);
						gsmt.bindColumn(3,  idxAST1ST);
						gsmt.bindColumn(4,  idxAST2ND);
						gsmt.bindColumn(5,  idxAST3RD);
						gsmt.bindColumn(6,  idxASTSEQ);
						gsmt.bindColumn(7,  idxASTAQAMT);
						gsmt.bindColumn(8,  idxASTYUSE);
						gsmt.bindColumn(9,  idxASTRMAMT);
						gsmt.bindColumn(10, idxASTDEPRST);
						gsmt.bindColumn(11, idxDEPRENDDT);
						gsmt.bindColumn(12, idxABDEPRAMT);
						gsmt.bindColumn(13, idxACDEPRAMT);
						gsmt.bindColumn(14, idxASTAQAMTY);
						gsmt.bindColumn(15, idxFORMAMT);
						gsmt.bindColumn(16, idxFOBDAMT);
						gsmt.bindColumn(17, idxFOCDAMT);
                        gsmt.bindColumn(18, idxASTAQAMT);
						gsmt.bindColumn(19, idxASTRMAMT);
						gsmt.bindColumn(20, idxABDEPRAMT);
						gsmt.bindColumn(21, idxACDEPRAMT);
						gsmt.bindColumn(22, idxASTAQAMTY);
						gsmt.bindColumn(23, idxFORMAMT);
						gsmt.bindColumn(24, idxFOBDAMT);
						gsmt.bindColumn(25, idxFOCDAMT);

						gsmt.executeUpdate();
						gsmt.close();

						gsmt=null;


						for (int i=1; i<=2;i++){

							if(i==1){       //���⴩��� ó��
								//�������󰢿� �߰���. ( �ش�⵵�� 00���� ���⴩��� �Է� ) 
								strYm = strAstym.substring(0,4)+"00";   
								intAmt = rows[j].getDouble(idxABDEPRAMT);

							}else if(i==2){ //���󰢾� ó��
								//�������󰢿� �߰���.
								strYm = strAstym;
								intAmt = rows[j].getDouble(idxACDEPRAMT);
							}


							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ASTYEPR (  " );
							InsertSql.append( " FDCODE,	 ATCODE,  AST1ST,	 AST2ND,	AST3RD, " );
							InsertSql.append( " ASTSEQ,	 ASTYM,   ASTAMT,	 ASTDAT,  COSTCD, ASTAQAMT, REGIGB, FOATAMT, FOAQAMT )	" );
							InsertSql.append( " VALUES (   " );
							InsertSql.append( " ?,?,?,?,?, " );
							InsertSql.append( " ?,'"+strYm+"',"+intAmt+",'"+strAstdat+"',?,?,'2',?,?" );
							InsertSql.append( " ) " );

							gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1,  idxFDCODE);
							gsmt.bindColumn(2,  idxATCODE);
							gsmt.bindColumn(3,  idxAST1ST);
							gsmt.bindColumn(4,  idxAST2ND);
							gsmt.bindColumn(5,  idxAST3RD);
							gsmt.bindColumn(6,  idxASTSEQ);
							gsmt.bindColumn(7,  idxACOSTCD); //��ü�� ������
							gsmt.bindColumn(8,  idxASTAQAMT);
							gsmt.bindColumn(9,  idxFOCDAMT);
							gsmt.bindColumn(10, idxASTAQAMTY);

							gsmt.executeUpdate();
							gsmt.close();

							gsmt=null;

						}

					}
				}
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