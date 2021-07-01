package Person;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class h050010_t2 extends HttpServlet{

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

			String stryymm="";
			String strEmpno="";
			String strSeq="";
			String strHlno="";

			try {
				
				conn = service.getDBConnection();
				conn.setAutoCommit(false);

				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				String strDetpcd="";
				String strPaygrd="";

        /*********************************************************
         �������� MST
				**********************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				int idxAPPDT   = userSet.indexOfColumn("APPDT");	  //��û����
				int idxEMPNO   = userSet.indexOfColumn("EMPNO");	  //��û���
				int idxLAZCD   = userSet.indexOfColumn("LAZCD");	  //�����ڵ�
				int idxFRDT    = userSet.indexOfColumn("FRDT");	    //�����
				int idxTODT    = userSet.indexOfColumn("TODT");	    //������
				int idxDIVCD   = userSet.indexOfColumn("DIVCD");	  //����  
				int idxDEPTCD  = userSet.indexOfColumn("DEPTCD");	  //�μ�  
				int idxPAYGRD  = userSet.indexOfColumn("PAYGRD");	  //����
				int idxOBJECT  = userSet.indexOfColumn("OBJECT");	  //������
				int idxTRIPOBJ = userSet.indexOfColumn("TRIPOBJ");	//�������
				int idxCARAMT  = userSet.indexOfColumn("CARAMT");	  //�����
				int idxOVRATEGB= userSet.indexOfColumn("OVRATEGB");	//ȯ������(�ؿ�)
				int idxOVDSAMT = userSet.indexOfColumn("OVDSAMT");	//�޷��ݾ�(�ؿ�)
				int idxOVRATE  = userSet.indexOfColumn("OVRATE");	  //ȯ��(�ؿ�)
				int idxOVWNAMT = userSet.indexOfColumn("OVWNAMT");	//��ȭ��
				int idxOVETC   = userSet.indexOfColumn("OVETC");	  //���
				int idxINTRDAY = userSet.indexOfColumn("INTRDAY");	//�����ϼ�
				int idxAPPLYID = userSet.indexOfColumn("APPLYID");	//�����(��û�ڻ��)
				int idxCLOSYN  = userSet.indexOfColumn("CLOSYN");	  //�������
				int idxWRDT    = userSet.indexOfColumn("WRDT");	    //�ۼ�����
				int idxWRID    = userSet.indexOfColumn("WRID");	    //�ۼ�ID
				int idxUPDT    = userSet.indexOfColumn("UPDT");	    //��������
				int idxUPID    = userSet.indexOfColumn("UPID");	    //����ID
				int idxORGFRDT = userSet.indexOfColumn("ORGFRDT");  //�����������
				int idxORGTODT = userSet.indexOfColumn("ORGTODT");  //������������
				int idxMEMO = userSet.indexOfColumn("MEMO");     //���� ����( 0 - �ӿ� , 20-�����̻�, 22- �븮����)
				int idxHLNO = userSet.indexOfColumn("HLNO");     //���¹�ȣ
				int idxREMARK1 = userSet.indexOfColumn("REMARK1");  //���ڰ��� ���1
				int idxREMARK2 = userSet.indexOfColumn("REMARK2");  //���ڰ��� ���2
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				StringBuffer DeleteSql_2 = null;
				StringBuffer DeleteSql_3 = null;

				InsertSql = new StringBuffer();
				
				InsertSql.append( " INSERT INTO PAYROLL.HLOTMST(  ");
				InsertSql.append( " APPDT,   EMPNO,    LAZCD,  FRDT,    TODT, ");
				InsertSql.append( " DIVCD,   DEPTCD,   PAYGRD, OBJECT,  TRIPOBJ,  ");
				InsertSql.append( " CARAMT,  OVRATEGB, OVRATE, OVDSAMT, OVWNAMT, OVETC,  ");
				InsertSql.append( " INTRDAY, APPLYID,  CLOSYN, WRDT,    WRID, ");
				InsertSql.append( " UPDT,    UPID,     HLNO,   REMARK1, REMARK2 ");
				InsertSql.append( ") VALUES (  ");
				InsertSql.append( " ?, ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ?, ");
				InsertSql.append( " ?, ?, ?, ?, ? ");
				InsertSql.append( " ) ");

				UpdateSql = new StringBuffer();
				UpdateSql.append( " UPDATE PAYROLL.HLOTMST SET " );
				UpdateSql.append( " TODT =?,    DIVCD = ?,   DEPTCD = ?,  PAYGRD = ?,  OBJECT = ?, ");
				UpdateSql.append( " TRIPOBJ =?, CARAMT = ?,  OVRATEGB =?, OVRATE = ?,  OVDSAMT = ?, OVWNAMT = ?, ");
				UpdateSql.append( " OVETC =?,   INTRDAY = ?, APPLYID =?,  CLOSYN = ?,  UPDT = ?, ");
				UpdateSql.append( " UPID =?,    REMARK1=?,   REMARK2=? ");
				UpdateSql.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? " );

				DeleteSql = new StringBuffer();
				DeleteSql.append( "DELETE FROM PAYROLL.HLOTMST WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? " );

				DeleteSql_2 = new StringBuffer();
				DeleteSql_2.append( "DELETE FROM PAYROLL.HLOTDTLE WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? " );

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

           //���ڰ��縦 ���� Ű������ HLNO ===============================
			      strEmpno=rows[j].getString(idxEMPNO);
						stryymm=rows[j].getString(idxFRDT);
						stryymm=stryymm.substring(2,6);

            Statement stmt0 = conn.createStatement();
						StringBuffer sql0 = new StringBuffer();
						sql0.append( " SELECT COALESCE(MAX(SUBSTR(HLNO,13,2)),0)+1 ");
						sql0.append( "	 FROM PAYROLL.HLOTMST "); 
						sql0.append( "	WHERE SUBSTR(HLNO,2,7)='"+strEmpno+"'");
						sql0.append( "	  AND SUBSTR(HLNO,9,4)='"+stryymm+"'"); 
						sql0.append( "	  AND SUBSTR(HLNO,1,1)='B'"); 

						ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
						if(rs0.next()){
							 strSeq= rs0.getString(1);
						}
						rs0.close();
						stmt0.close();

						int ichk = Integer.parseInt(strSeq);
						if(ichk<10) strSeq = "0"+strSeq;
						strHlno = "B"+strEmpno+stryymm+strSeq;       
						rows[j].setString(idxHLNO,strHlno);
						//==============================================================

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);
            
						gsmt.bindColumn(1, idxAPPDT);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxLAZCD);
						gsmt.bindColumn(4, idxFRDT);
						gsmt.bindColumn(5, idxTODT);
						gsmt.bindColumn(6, idxDIVCD);
						gsmt.bindColumn(7, idxDEPTCD);
						gsmt.bindColumn(8, idxPAYGRD);
						gsmt.bindColumn(9, idxOBJECT);
						gsmt.bindColumn(10, idxTRIPOBJ);
						gsmt.bindColumn(11, idxCARAMT);
						gsmt.bindColumn(12, idxOVRATEGB);
						gsmt.bindColumn(13, idxOVRATE);
						gsmt.bindColumn(14, idxOVDSAMT);
						gsmt.bindColumn(15, idxOVWNAMT);
						gsmt.bindColumn(16, idxOVETC);
						gsmt.bindColumn(17, idxINTRDAY);
						gsmt.bindColumn(18, idxAPPLYID);
						gsmt.bindColumn(19, idxCLOSYN);
						gsmt.bindColumn(20, idxWRDT);
						gsmt.bindColumn(21, idxWRID);
						gsmt.bindColumn(22, idxUPDT);
						gsmt.bindColumn(23, idxUPID);
						gsmt.bindColumn(24, idxHLNO);
						gsmt.bindColumn(25, idxREMARK1);
						gsmt.bindColumn(26, idxREMARK2);
						
						gsmt.executeUpdate();
						gsmt.close();
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						//�������� MST ����
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxTODT);
						gsmt.bindColumn(2, idxDIVCD);
						gsmt.bindColumn(3, idxDEPTCD);
						gsmt.bindColumn(4, idxPAYGRD);
						gsmt.bindColumn(5, idxOBJECT);
						gsmt.bindColumn(6, idxTRIPOBJ);
						gsmt.bindColumn(7, idxCARAMT);
						gsmt.bindColumn(8, idxOVRATEGB);
						gsmt.bindColumn(9, idxOVRATE);
						gsmt.bindColumn(10, idxOVDSAMT);
						gsmt.bindColumn(11, idxOVWNAMT);
						gsmt.bindColumn(12, idxOVETC);
						gsmt.bindColumn(13, idxINTRDAY);
						gsmt.bindColumn(14, idxAPPLYID);
						gsmt.bindColumn(15, idxCLOSYN);
						gsmt.bindColumn(16, idxUPDT);
						gsmt.bindColumn(17, idxUPID);
						gsmt.bindColumn(18, idxREMARK1);
						gsmt.bindColumn(19, idxREMARK2);
						gsmt.bindColumn(20, idxAPPDT);
						gsmt.bindColumn(21, idxEMPNO);
						gsmt.bindColumn(22, idxLAZCD);
						gsmt.bindColumn(23, idxFRDT);
						gsmt.executeUpdate(); 
						gsmt.close();      
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						//�������� MST ����
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idxAPPDT);
						gsmt.bindColumn(2, idxEMPNO);
						gsmt.bindColumn(3, idxLAZCD);
						gsmt.bindColumn(4, idxFRDT);
						gsmt.executeUpdate();
						gsmt.close();

						//�������� DTL����
						GauceStatement gsmt_2 = conn.getGauceStatement(DeleteSql_2.toString());
						gsmt_2.setGauceDataRow(rows[j]);
						gsmt_2.bindColumn(1, idxAPPDT);
						gsmt_2.bindColumn(2, idxEMPNO);
						gsmt_2.bindColumn(3, idxLAZCD);
						gsmt_2.bindColumn(4, idxFRDT);
						gsmt_2.executeUpdate();
						gsmt_2.close();

						//���ϱ��� ����
						DeleteSql_3 = new StringBuffer();
						DeleteSql_3.append( "DELETE FROM PAYROLL.HLDUTY " );
						DeleteSql_3.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD ='S05' " );
						DeleteSql_3.append( "   AND FRDT BETWEEN '"+rows[j].getString(idxORGFRDT)+"' AND '"+rows[j].getString(idxORGTODT)+"' " );
						DeleteSql_3.append( "   AND OTLAZCD = ? " );

						GauceStatement gsmt_3 = conn.getGauceStatement(DeleteSql_3.toString());
						gsmt_3.setGauceDataRow(rows[j]);
						gsmt_3.bindColumn(1, idxAPPDT);
						gsmt_3.bindColumn(2, idxEMPNO);
						gsmt_3.bindColumn(3, idxLAZCD);
						gsmt_3.executeUpdate();
						gsmt_3.close();	  
					}
				
        
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
				//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//

					/*********************************************************
					 �������� DTL
					**********************************************************/
					GauceDataSet userSet2 = reqGauce.getGauceDataSet("USER2");

					int idxAPPDT2    = userSet2.indexOfColumn("APPDT");	    //��û����
					int idxEMPNO2    = userSet2.indexOfColumn("EMPNO");	    //��û���
					int idxLAZCD2    = userSet2.indexOfColumn("LAZCD");	    //�����ڵ�
					int idxFRDT2     = userSet2.indexOfColumn("FRDT");	    //�����
					int idxOTDT2     = userSet2.indexOfColumn("OTDT");	    //������
					int idxOTSEQ2    = userSet2.indexOfColumn("OTSEQ");	    //����  
					int idxSECTION2  = userSet2.indexOfColumn("SECTION");	  //���屸��  
					int idxTRAFFIC2  = userSet2.indexOfColumn("TRAFFIC");	  //������
					int idxCARFARE2  = userSet2.indexOfColumn("CARFARE");	  //�����
					int idxINSTAMT2  = userSet2.indexOfColumn("INSTAMT");	  //���ں�
					int idxINFDAMT2  = userSet2.indexOfColumn("INFDAMT");	  //�Ĵ�
					int idxINDAYAMT2 = userSet2.indexOfColumn("INDAYAMT");	//�Ϻ�
					int idxWRDT2     = userSet2.indexOfColumn("WRDT");	    //�ۼ�����
					int idxWRID2     = userSet2.indexOfColumn("WRID");	    //�ۼ�ID
					int idxUPDT2     = userSet2.indexOfColumn("UPDT");	    //��������
					int idxUPID2     = userSet2.indexOfColumn("UPID");	    //����ID
					int idxORGAPPDT2 = userSet2.indexOfColumn("ORGAPPDT");	//��������û����
					int idxORGEMPNO2 = userSet2.indexOfColumn("ORGEMPNO");	//��������û���
					int idxORGLAZCD2 = userSet2.indexOfColumn("ORGLAZCD");	//�����������ڵ�
					int idxORGFRDT2  = userSet2.indexOfColumn("ORGFRDT");	  //�����������
					int idxORGOTDT2  = userSet2.indexOfColumn("ORGOTDT");	  //������������
					int idxORGOTSEQ2 = userSet2.indexOfColumn("ORGOTSEQ");	//����������  
					int idxDEPTCD2  = userSet2.indexOfColumn("DEPTCD"); 	  //�μ�
					int idxPAYGRD2  = userSet2.indexOfColumn("PAYGRD");	    //���� 
					int idxMEMO2  = userSet2.indexOfColumn("MEMO");	        //���� ����( 0 - �ӿ� , 20-�����̻�, 22- �븮����) 
					int idxHLNO2  = userSet2.indexOfColumn("HLNO");

					String strOtseq="0";

					GauceDataRow[] rows2 = userSet2.getDataRows();

					StringBuffer InsertSql2 = null;
					StringBuffer UpdateSql2 = null;
					StringBuffer DeleteSql2 = null;

					StringBuffer InsertSql3 = null;
					StringBuffer DeleteSql3 = null;

					InsertSql2 = new StringBuffer();
					
					InsertSql2.append( " INSERT INTO PAYROLL.HLOTDTLE(  ");
					InsertSql2.append( " APPDT,   EMPNO,    LAZCD,   FRDT,     OTDT, ");
					InsertSql2.append( " OTSEQ,   SECTION,  TRAFFIC, CARFARE,  INSTAMT, ");
					InsertSql2.append( " INFDAMT, INDAYAMT, WRDT,    WRID,     UPDT,");
					InsertSql2.append( " UPID ");
					InsertSql2.append( ") VALUES (  ");
					InsertSql2.append( " ?, ?, ?, ?, ?, ");
					InsertSql2.append( " ?, ?, ?, ?, ?, ");
					InsertSql2.append( " ?, ?, ?, ?, ?, ");
					InsertSql2.append( " ? ");
					InsertSql2.append( " ) ");

					UpdateSql2 = new StringBuffer();
					UpdateSql2.append( " UPDATE PAYROLL.HLOTDTLE SET " );
					UpdateSql2.append( " OTDT = ?, SECTION =?,    TRAFFIC = ?,   CARFARE = ?,  INSTAMT = ?,  INFDAMT = ?, ");
					UpdateSql2.append( " INDAYAMT =?,   UPDT=?,        UPID =? ");
					UpdateSql2.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? AND OTDT = ? AND OTSEQ = ? " );

					DeleteSql2 = new StringBuffer();
					DeleteSql2.append( "DELETE FROM PAYROLL.HLOTDTLE WHERE APPDT = ? AND EMPNO = ? AND LAZCD = ? AND FRDT = ? AND OTDT = ? AND OTSEQ = ? " );
					String strPreOtdt2="";

					for (int i = 0; i < rows2.length; i++){
						if(rows2[i].getJobType() == GauceDataRow.TB_JOB_INSERT) {

							if(i==0) strPreOtdt2="";
							if(i>=1) strPreOtdt2=rows2[i-1].getString(idxOTDT2); //������ OTDT
							//ä��
							Statement stmt = conn.createStatement();
							StringBuffer sql = new StringBuffer();
							sql.append( " SELECT COALESCE(MAX(OTSEQ),0)+1 FROM PAYROLL.HLOTDTLE ");
							sql.append( "	WHERE APPDT ='"+rows2[i].getString(idxAPPDT2)+"'"); 
							sql.append( "	  AND EMPNO='"+rows2[i].getString(idxEMPNO2)+"'");
							sql.append( "	  AND LAZCD='"+rows2[i].getString(idxLAZCD2)+"'"); 
							sql.append( "	  AND FRDT='"+rows2[i].getString(idxFRDT2)+"'"); 
							sql.append( "	  AND OTDT='"+rows2[i].getString(idxOTDT2)+"'"); 
							ResultSet rs = stmt.executeQuery(sql.toString()); 
							if(rs.next()){
								 strOtseq= rs.getString(1);
							}
							rs.close();
							stmt.close();

							int ichk = Integer.parseInt(strOtseq);
							if(ichk<10) strOtseq = "0"+strOtseq;

							rows2[i].setString(idxOTSEQ2,strOtseq);

							GauceStatement gsmt = conn.getGauceStatement(InsertSql2.toString());
							gsmt.setGauceDataRow(rows2[i]);
							
							gsmt.bindColumn(1, idxAPPDT2);
							gsmt.bindColumn(2, idxEMPNO2);
							gsmt.bindColumn(3, idxLAZCD2);
							gsmt.bindColumn(4, idxFRDT2);
							gsmt.bindColumn(5, idxOTDT2);
							gsmt.bindColumn(6, idxOTSEQ2);
							gsmt.bindColumn(7, idxSECTION2);
							gsmt.bindColumn(8, idxTRAFFIC2);
							gsmt.bindColumn(9, idxCARFARE2);
							gsmt.bindColumn(10, idxINSTAMT2);
							gsmt.bindColumn(11, idxINFDAMT2);
							gsmt.bindColumn(12, idxINDAYAMT2);
							gsmt.bindColumn(13, idxWRDT2);
							gsmt.bindColumn(14, idxWRID2);
							gsmt.bindColumn(15, idxUPDT2);
							gsmt.bindColumn(16, idxUPID2);
							
							gsmt.executeUpdate();
							gsmt.close();

							//logger.dbg.println(this,"strPreOtdt2::::::"+strPreOtdt2);


							if(strPreOtdt2==""||!strPreOtdt2.equals(rows2[i].getString(idxOTDT2))){
								//logger.dbg.println(this,"insert::::::");
								//�������ڰ� �����̸� ���� Table�� �ڵ� ������.///////////////////////////////////////////////////	

								if(!rows2[i].getString(idxMEMO2).equals("0")){
									StringBuffer sql2 = new StringBuffer();
									Statement stmt2= null;
									ResultSet rs2 = null;
									String strGubun2="";
									int cnt2=0;
									long lngamt2=0;
									sql2.append( " SELECT COUNT(*) CNT, C.LAZCD, C.AMT     ");
									sql2.append( "   FROM PAYROLL.HCHOLDAY A               ");
									sql2.append( "   LEFT JOIN ( SELECT B.LAZCD, B.AMT     ");
									sql2.append( " 							  FROM PAYROLL.HCHOLFEE B  ");
									sql2.append( " 						   WHERE LAZCD='S05'         ");
									sql2.append( " 					  ) C ON 1=1                   ");
									sql2.append( "  WHERE A.HOLDT = '"+rows2[i].getString(idxOTDT2)+"'");
									sql2.append( "  GROUP BY C.LAZCD, C.AMT                 ");

									stmt2 = conn.createStatement();
									rs2 = stmt2.executeQuery(sql2.toString());
									while(rs2.next())	{
										strGubun2="1";
										cnt2 = rs2.getInt(1);
										lngamt2=rs2.getLong(3);
									}//while
									rs2.close();
									stmt2.close();
							
									//logger.dbg.println(this,"cnt2::::::"+cnt2);
									//�����̸鼭, ���ÿ� ���ϱٹ�
									if(cnt2>=1){
										//�Է��� ������ �������� ����///////////////////////////////////////////////////////////
										DeleteSql2 = new StringBuffer();
										DeleteSql2.append( "DELETE FROM PAYROLL.HLDUTY " );
										DeleteSql2.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD ='S05' " );
										DeleteSql2.append( "   AND FRDT=?"  );
										DeleteSql2.append( "   AND OTLAZCD = ? " );

										GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
										gsmt2.setGauceDataRow(rows2[i]);
										gsmt2.bindColumn(1, idxAPPDT2);
										gsmt2.bindColumn(2, idxEMPNO2);
										gsmt2.bindColumn(3, idxOTDT2);
										gsmt2.bindColumn(4, idxLAZCD2);

										/*
										logger.dbg.println(this,"idxAPPDT2:::"+rows2[i].getString(idxAPPDT2));
										logger.dbg.println(this,"idxEMPNO2:::"+rows2[i].getString(idxEMPNO2));
										logger.dbg.println(this,"idxOTDT2:::"+rows2[i].getString(idxOTDT2));
										logger.dbg.println(this,"idxLAZCD2:::"+rows2[i].getString(idxLAZCD2));								
										logger.dbg.println(this,DeleteSql2.toString());
										*/

										gsmt2.executeUpdate();
										gsmt2.close();
										///////////////////////////////////////////////////////////////////////////////////////
										
										if(rows2[i].getString(idxMEMO2).equals("20")){ //�����̻�
											lngamt2=40000;
										}else if(rows2[i].getString(idxMEMO2).equals("22")){ //�븮����
											lngamt2=30000;
										}

										if(strHlno.equals("")) strHlno = rows2[i].getString(idxHLNO2);
										//logger.dbg.println(this,"strHlno::"+strHlno);

										//�������� ������...
										InsertSql3 = new StringBuffer();
										InsertSql3.append( " INSERT INTO PAYROLL.HLDUTY(  ");
										InsertSql3.append( " APPDT,    EMPNO,   LAZCD,   DEPTCD,  PAYSEQ, ");
										InsertSql3.append( " FRDT,     TODT,    FRTIME,  TOTIME,  DTYREM,");
										InsertSql3.append( " CLOSYN,   AMT,     OTLAZCD, HLNO  ");
										InsertSql3.append( ") VALUES (  ");
										InsertSql3.append( " ?, ?, 'S05', '"+rows2[i].getString(idxDEPTCD2)+"', '"+rows2[i].getString(idxPAYGRD2)+"', ");
										InsertSql3.append( " '"+rows2[i].getString(idxOTDT2)+"','', '090000','180000', '��������',");
										InsertSql3.append( " 'N',"+lngamt2+", ?, '"+strHlno+"' ");
										InsertSql3.append( " ) ");

										//logger.dbg.println(this,InsertSql3.toString());
										GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
										gsmt3.setGauceDataRow(rows2[i]);
										
										gsmt3.bindColumn(1, idxAPPDT2);
										gsmt3.bindColumn(2, idxEMPNO2);
										gsmt3.bindColumn(3, idxLAZCD2);  //���屸���ڵ带 �������̺� �־�д�.(�ܷ�Ű ����)
									
										gsmt3.executeUpdate();
										gsmt3.close();
									}
								}
							}
							//END - �������̺�//////////////////////////////////////////////////////////////////////
						}//if

						if(rows2[i].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

							if(!rows2[i].getString(idxMEMO2).equals("0")){
								//������ ������ �������� ����///////////////////////////////////////////////////////////
								DeleteSql3 = new StringBuffer();
								DeleteSql3.append( "DELETE FROM PAYROLL.HLDUTY " );
								DeleteSql3.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD ='S05' " );
								DeleteSql3.append( "   AND FRDT=?"  );
								DeleteSql3.append( "   AND OTLAZCD = ? " );

								GauceStatement gsmt03 = conn.getGauceStatement(DeleteSql3.toString());
								gsmt03.setGauceDataRow(rows2[i]);
								gsmt03.bindColumn(1, idxORGAPPDT2);
								gsmt03.bindColumn(2, idxORGEMPNO2);
								gsmt03.bindColumn(3, idxORGOTDT2);
								gsmt03.bindColumn(4, idxORGLAZCD2);
								gsmt03.executeUpdate();
								gsmt03.close();
								///////////////////////////////////////////////////////////////////////////////////////

								//������ȸ
								StringBuffer sql2 = new StringBuffer();
								Statement stmt2= null;
								ResultSet rs2 = null;
								String strGubun2="";
								int cnt2=0;
								long lngamt2=0;
								sql2.append( " SELECT COUNT(*) CNT, C.LAZCD, C.AMT      ");
								sql2.append( "   FROM PAYROLL.HCHOLDAY A                ");
								sql2.append( "   LEFT JOIN ( SELECT B.LAZCD, B.AMT      ");
								sql2.append( " 							  FROM PAYROLL.HCHOLFEE B  ");
								sql2.append( " 						   WHERE LAZCD='S05'         ");
								sql2.append( " 					  ) C ON 1=1                   ");
								sql2.append( "  WHERE A.HOLDT = '"+rows2[i].getString(idxOTDT2)+"'");
								sql2.append( "  GROUP BY C.LAZCD, C.AMT                 ");

								stmt2 = conn.createStatement();
								rs2 = stmt2.executeQuery(sql2.toString());
								while(rs2.next())	{
									strGubun2="1";
									cnt2 = rs2.getInt(1);
									lngamt2=rs2.getLong(3);
								}//while
								rs2.close();
								stmt2.close();
								
								//�����̸鼭, ���ÿ� ���ϱٹ�
								if(cnt2>=1){
									if(rows2[i].getString(idxMEMO2).equals("20")){ //�����̻�
										lngamt2=40000;
									}else if(rows2[i].getString(idxMEMO2).equals("22")){ //�븮����
										lngamt2=30000;
									}

									InsertSql3 = new StringBuffer();
									InsertSql3.append( " INSERT INTO PAYROLL.HLDUTY(  ");
									InsertSql3.append( " APPDT,    EMPNO,   LAZCD,   DEPTCD,  PAYSEQ, ");
									InsertSql3.append( " FRDT,     TODT,    FRTIME,  TOTIME,  DTYREM,");
									InsertSql3.append( " CLOSYN,   AMT,     OTLAZCD, HLNO ");
									InsertSql3.append( ") VALUES (  ");
									InsertSql3.append( " ?, ?, 'S05', '"+rows2[i].getString(idxDEPTCD2)+"', '"+rows2[i].getString(idxPAYGRD2)+"', ");
									InsertSql3.append( " '"+rows2[i].getString(idxOTDT2)+"','', '090000','180000', '��������',");
									InsertSql3.append( " 'N',"+lngamt2+", ?, '"+rows2[i].getString(idxHLNO2)+"' ");
									InsertSql3.append( " ) ");

									GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
									gsmt3.setGauceDataRow(rows2[i]);
									
									gsmt3.bindColumn(1, idxAPPDT2);
									gsmt3.bindColumn(2, idxEMPNO2);
									gsmt3.bindColumn(3, idxLAZCD2);  //���屸���ڵ带 �������̺� �־�д�.(�ܷ�Ű ����)
								
									gsmt3.executeUpdate();
									gsmt3.close();
								}
							}
							//END - �������̺�//////////////////////////////////////////////////////////////////////	

							//��������DTL
							GauceStatement gsmt = conn.getGauceStatement(UpdateSql2.toString());
							gsmt.setGauceDataRow(rows2[i]);

							gsmt.bindColumn(1, idxOTDT2);
							gsmt.bindColumn(2, idxSECTION2);
							gsmt.bindColumn(3, idxTRAFFIC2);
							gsmt.bindColumn(4, idxCARFARE2);
							gsmt.bindColumn(5, idxINSTAMT2);
							gsmt.bindColumn(6, idxINFDAMT2);
							gsmt.bindColumn(7, idxINDAYAMT2);
							gsmt.bindColumn(8, idxUPDT2);
							gsmt.bindColumn(9, idxUPID2);
							gsmt.bindColumn(10, idxORGAPPDT2);
							gsmt.bindColumn(11, idxORGEMPNO2);
							gsmt.bindColumn(12, idxORGLAZCD2);
							gsmt.bindColumn(13, idxORGFRDT2);
							gsmt.bindColumn(14, idxORGOTDT2);
							gsmt.bindColumn(15, idxORGOTSEQ2);

							gsmt.executeUpdate(); 
							gsmt.close();       						
						}    
							
						if(rows2[i].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
							//�������� �� 
							GauceStatement gsmt = conn.getGauceStatement(DeleteSql2.toString());
							gsmt.setGauceDataRow(rows2[i]);
							gsmt.bindColumn(1, idxAPPDT2);
							gsmt.bindColumn(2, idxEMPNO2);
							gsmt.bindColumn(3, idxLAZCD2);
							gsmt.bindColumn(4, idxFRDT2);
							gsmt.bindColumn(5, idxOTDT2);
							gsmt.bindColumn(6, idxOTSEQ2);
							gsmt.executeUpdate();
							gsmt.close();

							int intcnt=0;

							if(!rows2[i].getString(idxMEMO2).equals("0")){
								//������ �� �������� �󼼿� �����ϸ� ���¿��� ��������.
								Statement stmt = conn.createStatement();
								StringBuffer sql = new StringBuffer();
								sql.append( " SELECT COUNT(*) CNT  FROM PAYROLL.HLOTDTLE ");
								sql.append( "	WHERE APPDT ='"+rows2[i].getString(idxAPPDT2)+"'"); 
								sql.append( "	  AND EMPNO='"+rows2[i].getString(idxEMPNO2)+"'");
								sql.append( "	  AND LAZCD='"+rows2[i].getString(idxLAZCD2)+"'"); 
								sql.append( "	  AND FRDT='"+rows2[i].getString(idxFRDT2)+"'"); 
								sql.append( "	  AND OTDT='"+rows2[i].getString(idxOTDT2)+"'"); 
								ResultSet rs = stmt.executeQuery(sql.toString()); 
								if(rs.next()){
									 intcnt= rs.getInt(1);
								}
								rs.close();
								stmt.close();

							//	logger.dbg.println(this,String.valueOf(intcnt));

								if(intcnt==0){
									//������������ ���� Ư�ٻ���
									//������ ������ �������� ����/////////////////////////////////////////////////////////////
									DeleteSql3 = new StringBuffer();
									DeleteSql3.append( "DELETE FROM PAYROLL.HLDUTY " );
									DeleteSql3.append( " WHERE APPDT = ? AND EMPNO = ? AND LAZCD ='S05' " );
									DeleteSql3.append( "   AND FRDT BETWEEN '"+rows2[i].getString(idxORGOTDT2)+"' AND '"+rows2[i].getString(idxORGOTDT2)+"' " );
									DeleteSql3.append( "   AND OTLAZCD = ? " );

									GauceStatement gsmt00 = conn.getGauceStatement(DeleteSql3.toString());
									gsmt00.setGauceDataRow(rows2[i]);
									gsmt00.bindColumn(1, idxAPPDT2);
									gsmt00.bindColumn(2, idxEMPNO2);
									gsmt00.bindColumn(3, idxLAZCD2);
									gsmt00.executeUpdate();
									gsmt00.close();	  
								}
							}
						}
					}//for (int i = 0; i < rows2.length; i++){

				}//for for (int j = 0; j < rows.length; j++){
			
			}catch(Exception e){
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