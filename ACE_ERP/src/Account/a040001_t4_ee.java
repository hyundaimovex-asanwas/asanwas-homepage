package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

//�� �׽�Ʈ���� ���Ƿ� ������.  a040001_t4 ==>a040001_t4_9
public class a040001_t4_ee extends HttpServlet{
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

				String str1  = "";		//��꼭����
				String str2  = "";		//�۾�(=����)��
				String str3  = "";		//�۾�(=����)��
				//Master parameter ----------------------------------------------------
				String str4  = "";		//�����
				String str5  = "";		//�μ��ڵ�
				String str6  = "";		//���
				String str7  = "";	  //��꼭����
				String str8  = "";		//�ͼӱ���
				String str9  = "";		//��꼭����
				String str10 = "";	  //�ŷ�ó�ڵ�
				String str11 = "";		//��꼭����
				double str12 = 0;		  //���ް���
				double str13 = 0;	    //�ΰ�����
				double str14 = 0;		  //�հ�ݾ�
				String str15 = "";		//����
				String str16 = "";	  //�ſ�ī���ȣ
				String str17 = "";		//�����ڵ�
				String str18 = "";	  //���࿩��
				double str19 = 0;		  //����Ƚ��
				String str20 = "";	  //���������
				String str21 = "";	  //���౸��
				String str22 = "";		//��ǥ����
				String str23 = "";		//��ǥ��ȣ
				String str24 = "";	  //�������
				String str25 = "";	  //�����ڵ�
				String str26 = "";	  //ȸ�豸��
				String str27 = "";	  //��꼭��ȣ ������: ���� A-����, B-����, ���� C-����, D-���� , �ݰ��� E-����, F-����  
				
				str27 = reqGauce.getParameter("v_str1");

			  	int str28=0;  //SEQ
				String str29="";  //GUBUN
				String str30="";  //AMEND_CODE
				String str31="";  //AMEND_REMARK
				String str32="";  //EXTCHK
				String str33="";  //REMARK2
				String str34="";  //COSTCD


					String strTaxnbr="";
        
					GauceDataSet userSet1 = reqGauce.getGauceDataSet("USER1");
					String[] StrArrCN1 = new String[] {
					"TAXNBR",   "COCODE",   "DEPTCD",  "EMPNO",    "TAXIODIV",
					"TAXDIV",   "TAXKND",   "VEND_CD", "TAXDAT",   "TAXSUM",
					"TAXVATAMT","TAXTOT",   "REMARK",  "TAXCDNBR", "ATCODE",
					"TAXPRTYN", "TAXCNT",   "LASTPRT", "TAXTYPE",  "FSDAT",	
					"FSNBR",    "TAXKIDIV", "FDCODE",  "WORKTYPE", "WRDT",  
					"WRID",     "SEQ",      "GUBUN",   "AMEND_CODE", "AMEND_REMARK" , "EXTCHK", "REMARK2", "COSTCD" 
				};

				int[] idx1 = new int[33];
				for(int i=0;i<StrArrCN1.length;i++) {
					idx1[i] = userSet1.indexOfColumn(StrArrCN1[i]);
				}
				
				GauceDataRow[] rows1 = userSet1.getDataRows();
				
				str1=rows1[0].getString(idx1[8]);
				str2=rows1[0].getString(idx1[24]);
				str3=rows1[0].getString(idx1[25]);
				str4=rows1[0].getString(idx1[1]);
				str5=rows1[0].getString(idx1[2]);
				str6=rows1[0].getString(idx1[3]);
				str7=rows1[0].getString(idx1[4]);
				str8=rows1[0].getString(idx1[5]);
				str9=rows1[0].getString(idx1[6]);
				str10=rows1[0].getString(idx1[7]);
				str11=rows1[0].getString(idx1[8]);
				str12=rows1[0].getDouble(idx1[9]);
				str13=rows1[0].getDouble(idx1[10]);
				str14=rows1[0].getDouble(idx1[11]);
				str15=rows1[0].getString(idx1[12]);
				str16=rows1[0].getString(idx1[13]);
				str17=rows1[0].getString(idx1[14]);
				str18=rows1[0].getString(idx1[15]);
				str19=rows1[0].getDouble(idx1[16]);
				str20=rows1[0].getString(idx1[17]);
				str21=rows1[0].getString(idx1[18]);
				str22=rows1[0].getString(idx1[19]);
				str23=rows1[0].getString(idx1[20]);
				str24=rows1[0].getString(idx1[21]);
				str25=rows1[0].getString(idx1[22]);
				str26=rows1[0].getString(idx1[23]);
        
				str28=rows1[0].getInt(idx1[26]);     //SEQ
				str29=rows1[0].getString(idx1[27]);  //GUBUN
				str30=rows1[0].getString(idx1[28]);  //AMEND_CODE
				str31=rows1[0].getString(idx1[29]);  //AMEND_REMARK
				str32=rows1[0].getString(idx1[30]);  //EXTCHK
				str33=rows1[0].getString(idx1[31]);  //REMARK2
				str34=rows1[0].getString(idx1[32]);  //COSTCD
				

				//str27=rows1[0].getString(idx1[4]);			//  ���� A-����, B-����  , ���� C-����, D-���� , �ݰ��� E-����, F-���� 

				String temp = "";
				String taxch="";

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"TAXNBR",  "TAXSEQ", "TAXPDTNAM","TAXSTD","TAXQTY",
					"TAXPRIC", "TAXSUM", "TAXVATAMT","BIGO","WRDT",
					"WRID","UPDT","UPID"
				};

				int[] idx = new int[13];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;	//Master
				StringBuffer InsertSql2 = null;	//Detail
				StringBuffer UpdateSql  = null;
				StringBuffer UpdateSql2  = null;
				StringBuffer DeleteSql  = null;

				//���� Master
				Statement stmt = null;
				ResultSet rs = null;

				//���� Detali
				Statement stmt2 = null;
				ResultSet rs2 = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
							
						/*******************************************************************
								���� Master
						********************************************************************/
						taxch = rows[j].getString(idx[0]);
						StringBuffer sql = new StringBuffer();
						if (j==0) {
							sql.append( " SELECT CAST(MAX(SUBSTR(TAXNBR,8,11)) AS INTEGER)+1 CNT			\n");
							sql.append( " FROM ACCOUNT.ATTAXMST															\n");
							sql.append( " WHERE SUBSTR(TAXNBR,1,7)=SUBSTR('"+str27+str1+"',1,7)				\n");

							//System.out.println("a040001_t4_ee# Query : \n" + sql);							
							
							stmt = conn.createStatement();
							rs = stmt.executeQuery(sql.toString());

							while(rs.next())	{
								taxch = rs.getInt(1) + "";
							}
							//if (taxch==null||taxch.length()<10) taxch = str1.substring(0,6) + "0001";
							//else taxch = taxch + "";

							if(taxch.equals(null)||taxch.equals("0")){
								taxch = str1.substring(0,6) + "0001";
							}else if(!taxch.equals("0")&&taxch.length()==1) {
								taxch = str1.substring(0,6) + "000"+taxch;
							}else if(!taxch.equals("0")&&taxch.length()==2) {
								taxch = str1.substring(0,6) + "00"+taxch;
							}else if(!taxch.equals("0")&&taxch.length()==3) {	
								taxch = str1.substring(0,6) + "0"+taxch;
							}else if(!taxch.equals("0")&&taxch.length()==4) {
								taxch = str1.substring(0,6) + "" +taxch;
							}

							temp = taxch;

							strTaxnbr = str27+taxch ; //��꼭��ȣ ������ ����. 

							//logger.dbg.println(this,"REMARK::::"+rows[j]);
							//System.out.println("a040001_t4_ee REMARK# Query : \n" + strTaxnbr);
							
							
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.ATTAXMST (							\n");
							InsertSql.append( " TAXNBR,COCODE,DEPTCD,EMPNO,TAXIODIV,			\n");
							InsertSql.append( " TAXDIV,TAXKND,VEND_CD,TAXDAT,TAXSUM,				\n");
							InsertSql.append( " TAXVATAMT,TAXTOT,REMARK,TAXCDNBR,ATCODE,	\n");
							InsertSql.append( " TAXPRTYN,TAXCNT,LASTPRT,TAXTYPE,FSDAT,			\n");
							InsertSql.append( " FSNBR,TAXKIDIV,FDCODE,WORKTYPE,WRDT,WRID,	\n");
							InsertSql.append( " SEQ, GUBUN, AMEND_CODE, AMEND_REMARK, EXTCHK, REMARK2,COSTCD		\n");
							InsertSql.append( " ) VALUES(																					\n");
							InsertSql.append( " '"+str27+taxch+"','"+str4+"','"+str5+"','"+str6+"','"+str7+"',						\n");
							InsertSql.append( " '"+str8+"','"+str9+"','"+str10+"','"+str11+"', "+str12+",								\n");
							//InsertSql.append( "  "+str13+","+str14+",?,'"+str16+"','"+str17+"',										\n");
							InsertSql.append( "  "+str13+","+str14+",'"+str15+"','"+str16+"','"+str17+"',							\n");
							InsertSql.append( " '"+str18+"',"+str19+",'"+str20+"','"+str21+"','"+str22+"',							\n");
							InsertSql.append( " '"+str23+"','"+str24+"','"+str25+"','"+str26+"','"+str2+"', '"+str3+"',				\n");
							InsertSql.append( " "+str28+",'"+str29+"','"+str30+"','"+str31+"','"+str32+"','"+str33+"','"+str34+"'				\n");
							InsertSql.append( "  )																								\n");

							
							
							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows1[0]);

							//gsmt.bindColumn(1, idx1[12]);
							
							//System.out.println("a040001_t4_ee# InsertSql Query1 : \n" + InsertSql);		
							//System.out.println("a040001_t4_ee# InsertSql Query2 : \n" + idx1[12]);	
							//System.out.println("a040001_t4_ee# InsertSql Query3 : \n" + str15);				
							
							
							gsmt.executeUpdate();
							
							gsmt.close();
							//InsertSql=null;
							//System.out.println("a040001_t4_ee# InsertSql Query4 : \n");								
							//taxch = "";
						}//if (j==0) 

						/*******************************************************************
								���� Detail
						********************************************************************/
						
						String taxch2 = rows[j].getString(idx[1]);
						
						StringBuffer sql2 = new StringBuffer();
						
						sql2.append(" SELECT NVL(MAX(TAXSEQ),0)+1 CNT									\n");
						sql2.append(" 		FROM ACCOUNT.ATTAXDTL											\n");
						sql2.append(" WHERE TAXNBR = '"+str27+temp+"'										\n");
						
						//System.out.println("a040001_t4_ee# sql2 Query : \n" + sql2);		
						
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(sql2.toString());

						while(rs2.next()) {
							taxch2 = rs2.getInt(1) + "";
						}

						if (taxch2.length()==1) taxch2 = "00"+taxch2;
						else if (taxch2.length()==2) taxch2 = "0"+taxch2;
						
						//System.out.println("a040001_t4_ee# sql2 taxch2 : \n" + taxch2);							
						
						InsertSql2 = new StringBuffer();
						
						InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL (					\n");
						InsertSql2.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,	\n");
						InsertSql2.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,					\n");
						InsertSql2.append( " WRDT,WRID													\n");
						InsertSql2.append( " ) VALUES(														\n");
						InsertSql2.append( " '"+str27+temp+"','"+taxch2+"',?,?,?,						\n");
						InsertSql2.append( " ?, ?, ?, ?,														\n");
						InsertSql2.append( " '"+str2+"', '"+str3+"' )											\n");

						//System.out.println("a040001_t4_ee# Query : \n" + InsertSql);								
						
						
						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);

						for(int k=1;k<=7;k++) {
							gsmt2.bindColumn(k, idx[k+1]);
						}
						
						gsmt2.executeUpdate();
						gsmt2.close();
						InsertSql2=null;
						taxch2 = "";
				} //if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) 

				if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

						UpdateSql = new StringBuffer();
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate(); 
						gsmt.close();         
				 }
										
				 if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();
				 }
			}//for (int j = 0; j < rows.length; j++){

			/************************************************************************************
			 @ �ڻ� ���� Start  - �Է�
			*************************************************************************************/

		 GauceDataSet userSet6 = reqGauce.getGauceDataSet("USER6"); //�ι�° ����Ÿ�� �ѱ�
		 if (userSet6 != null) { //nullüũ
			 	int idx6FDCODE   = userSet6.indexOfColumn("FDCODE");
				int idx6ATCODE   = userSet6.indexOfColumn("ATCODE");
				int idx6AST1ST   = userSet6.indexOfColumn("AST1ST");
				int idx6AST2ND   = userSet6.indexOfColumn("AST2ND");
				int idx6AST3RD   = userSet6.indexOfColumn("AST3RD");
				int idx6ASTSEQ   = userSet6.indexOfColumn("ASTSEQ");

				GauceDataRow[] rows6 = userSet6.getDataRows();

				for (int ab = 0; ab < rows6.length; ab++){
				
					StringBuffer UpdateSql22 = null;
					UpdateSql22 = new StringBuffer();

					UpdateSql22.append( " UPDATE ACCOUNT.ASTMST SET " );
					UpdateSql22.append( " TAXNBR = 'A"+taxch+"' " );
					UpdateSql22.append( " WHERE FDCODE = '" + rows6[ab].getString(idx6FDCODE) + "' 	");
					UpdateSql22.append( " AND ATCODE =  '" + rows6[ab].getString(idx6ATCODE) + "'	");
					UpdateSql22.append( " AND AST1ST = '" + rows6[ab].getString(idx6AST1ST) + "' 	");
					UpdateSql22.append( " AND AST2ND = '" + rows6[ab].getString(idx6AST2ND) + "' 	");
					UpdateSql22.append( " AND AST3RD = '" + rows6[ab].getString(idx6AST3RD) + "' 	");
					UpdateSql22.append( " AND ASTSEQ = '" + rows6[ab].getString(idx6ASTSEQ) + "' 	");     
					
					GauceStatement gsmt6 = conn.getGauceStatement(UpdateSql22.toString());
									
					gsmt6.executeUpdate();
					gsmt6.close();
				}//for (int ab = 0; ab < rows6.length; ab++){
		
			}//if (userSet6 != null) { //nullüũ
		 	/************************************************************************************
			 @ �ڻ� End 
			*************************************************************************************/


		 	/************************************************************************************
			 @ ��꼭 ��ȣ return��
			*************************************************************************************/
				GauceDataSet userSet7 = reqGauce.getGauceDataSet("USER7");

				if (userSet7 != null) {
					resGauce.enableFirstRow(userSet7);
					userSet7.addDataColumn(new GauceDataColumn("TAXNBR", GauceDataColumn.TB_STRING,11));
								 
					GauceDataRow row = null;
					row = userSet7.newDataRow();
					row.addColumnValue(strTaxnbr);
					userSet7.addDataRow(row);
					userSet7.flush();
				} //(userSet7 != null) {

        //logger.dbg.println(this,"strTaxnbr::"+strTaxnbr);
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
