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

public class h050020_t1 extends HttpServlet{

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

				GauceStatement gsmt=null;

				String strGB = reqGauce.getParameter("v_str1");      // ������, ����� ����
				String strEmpno  = reqGauce.getParameter("v_str2");  // ���
				String strCreate = reqGauce.getParameter("v_str3");  // �ű�, ���� �� �����

				String strTODT ="";   //�޿����� �������� 15��
        String strFRDT ="";   //�޿����� ù��
				String strTODT_TYPE=""; 
        String strBTODT ="";  //�������� 16��

				String strTable="";
				String strNm="";

				String strYYMMDD16=""; //�޿����16��
				String strYYMMDD31=""; //�޿����31��

				String strRemark="";

				int intJTGB =0;   //���ñ���
				
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER"); 

				int idxAPPDT    = userSet.indexOfColumn("APPDT");	   // �޿����
						
				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer DeleteSql = null;
				StringBuffer UpdateSql = null;
        
				for (int j = 0; j < rows.length; j++){

					strFRDT = rows[j].getString(idxAPPDT)+"01";
					strTODT = rows[j].getString(idxAPPDT)+"15";

					strYYMMDD16 = rows[j].getString(idxAPPDT)+"16";
					strYYMMDD31 = rows[j].getString(idxAPPDT)+"31";


					strTODT_TYPE =strTODT.substring(0,4)+"-"+strTODT.substring(4,6)+"-"+strTODT.substring(6,8);



					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {	

						if(strCreate.equals("New")) {	//�űԻ���
								if(strGB.equals("R")){ //������
									InsertSql = new StringBuffer();
									InsertSql.append( " INSERT INTO PAYROLL.HLJTGB(               \n");
									InsertSql.append( " APPDT,	EMPNO,	JTGB,	CURDPT,	BEFDPT,     \n");
									InsertSql.append( " JTWK,	  REMARK,	CLOSEYN,                  \n");
									InsertSql.append( " I_EMPNO,	I_DATE                          \n");
									InsertSql.append( " )                                         \n");
									InsertSql.append( " SELECT '"+rows[j].getString(idxAPPDT)+"', EMPNO, 0, '','',         \n");
									InsertSql.append( "         '','','N','"+strEmpno+"',CURRENT TIMESTAMP        \n");
									InsertSql.append( "   FROM PAYROLL.HIPERSON                                                         \n");
									InsertSql.append( "  WHERE (STRTDT <='"+strTODT+"' AND USESTS = '1 ')                                \n");
									InsertSql.append( "     OR (SUBSTR(COALESCE(ENDDT,'0000000'),1,6) >= '"+rows[j].getString(idxAPPDT)+"' AND USESTS  = '3')  \n");
		
									gsmt = conn.getGauceStatement(InsertSql.toString());							
									gsmt.executeUpdate();
									gsmt.close();  
								}else{ //�����
									InsertSql = new StringBuffer();
									InsertSql.append( " INSERT INTO PAYROLL.HLJTGB(               \n");
									InsertSql.append( " APPDT,	EMPNO,	JTGB,	CURDPT,	BEFDPT,     \n");
									InsertSql.append( " JTWK,	  REMARK,	CLOSEYN,                  \n");
									InsertSql.append( " I_EMPNO,	I_DATE                          \n");
									InsertSql.append( " )                                         \n");
									InsertSql.append( " SELECT '"+rows[j].getString(idxAPPDT)+"', EMPNO, 0, '','',         \n");
									InsertSql.append( "         '','','N','"+strEmpno+"',CURRENT TIMESTAMP        \n");
									InsertSql.append( "   FROM PAYROLL.T_HIPERSON                                                         \n");
									InsertSql.append( "  WHERE (STRTDT <='"+strTODT+"' AND USESTS = '1' ) AND EMPDIV='3'                                \n");
									InsertSql.append( "     OR (SUBSTR(COALESCE(ENDDT,'0000000'),1,6) >= '"+rows[j].getString(idxAPPDT)+"' AND USESTS  = '3')  \n");
		
									gsmt = conn.getGauceStatement(InsertSql.toString());
									
									gsmt.executeUpdate();
									gsmt.close();  
								}

						}else if(strCreate.equals("ReNew")){ //���� �� ����
                
								DeleteSql = new StringBuffer();
                DeleteSql.append( " DELETE FROM PAYROLL.HLJTGB \n");
								DeleteSql.append( "  WHERE APPDT = ? \n");
								if(strGB.equals("R"))DeleteSql.append( " AND SUBSTR(EMPNO,1,1) IN ('1','2') \n");
								if(strGB.equals("T"))DeleteSql.append( " AND SUBSTR(EMPNO,1,1) IN ('3') \n");

								gsmt = conn.getGauceStatement(DeleteSql.toString());

								gsmt.setGauceDataRow(rows[j]);
						    gsmt.bindColumn(1, idxAPPDT);
								gsmt.executeUpdate();
								gsmt.close();
								gsmt=null;
						
								if(strGB.equals("R")){ //������
									InsertSql = new StringBuffer();
									InsertSql.append( " INSERT INTO PAYROLL.HLJTGB(               \n");
									InsertSql.append( " APPDT,	EMPNO,	JTGB,	CURDPT,	BEFDPT,     \n");
									InsertSql.append( " JTWK,	  REMARK,	CLOSEYN,                  \n");
									InsertSql.append( " I_EMPNO,	I_DATE                          \n");
									InsertSql.append( " )                                         \n");
									InsertSql.append( " SELECT '"+rows[j].getString(idxAPPDT)+"', EMPNO, 0, '','',         \n");
									InsertSql.append( "         '','','N','"+strEmpno+"',CURRENT TIMESTAMP        \n");
									InsertSql.append( "   FROM PAYROLL.HIPERSON                                                         \n");
									InsertSql.append( "  WHERE (STRTDT <='"+strTODT+"' AND USESTS = '1 ')                                \n");
									InsertSql.append( "     OR (SUBSTR(COALESCE(ENDDT,'0000000'),1,6) >= '"+rows[j].getString(idxAPPDT)+"' AND USESTS  = '3')  \n");
		
									gsmt = conn.getGauceStatement(InsertSql.toString());
									
									gsmt.executeUpdate();
									gsmt.close();  
								}else{ //�����
									InsertSql = new StringBuffer();
									InsertSql.append( " INSERT INTO PAYROLL.HLJTGB(               \n");
									InsertSql.append( " APPDT,	EMPNO,	JTGB,	CURDPT,	BEFDPT,     \n");
									InsertSql.append( " JTWK,	  REMARK,	CLOSEYN,                  \n");
									InsertSql.append( " I_EMPNO,	I_DATE                          \n");
									InsertSql.append( " )                                         \n");
									InsertSql.append( " SELECT '"+rows[j].getString(idxAPPDT)+"', EMPNO, 0, '','',         \n");
									InsertSql.append( "         '','','N','"+strEmpno+"',CURRENT TIMESTAMP        \n");
									InsertSql.append( "   FROM PAYROLL.T_HIPERSON                                                         \n");
									InsertSql.append( "  WHERE (STRTDT <='"+strTODT+"' AND USESTS = '1') AND EMPDIV='3'                                \n");
									InsertSql.append( "     OR (SUBSTR(COALESCE(ENDDT,'0000000'),1,6) >= '"+rows[j].getString(idxAPPDT)+"' AND USESTS  = '3')  \n");
		
									gsmt = conn.getGauceStatement(InsertSql.toString());
									
									gsmt.executeUpdate();
									gsmt.close();  
								} //if(strGB.equals("R")){ //������

						}//if(strCreate.equals("New")) {	//�űԻ���

            gsmt=null;


            //������ �����͸� �Ǻ��� ��ȸ�ؼ�  �系��°� ���Ѵ�.
/*
								A	B	C				
		            ��������	��������	�����߷�����		����		
�ſ���	3070015	20090101	20081201	20090101		A>B AND A=C	����	
���ؿ�	3080077	20081111	20081201	20081201		A<B AND B=C	����(�ٹ�)	
���ؿ�	3080055	20081101	20081111	20081219		A<B AND B<C	����(�ٹ�)	
���ع�	3070054	20081201		20081201		A>B AND A=C	����	B�� ���� ��� 19990101�� �Ѵ�.
����ȣ	3030001			20070201		A, B �� ���°��	����ٹ�	A�� ���� ��� 19990101 
								B�� ���� ��� 19990102
								C�� ����ŭ
*/

            //��¥��� - �������ϱ�  
            
            StringBuffer sql0 = new StringBuffer();
						Statement stmt0= null;
						ResultSet rs0 = null;     

						sql0.append( " SELECT REPLACE(CHAR(CAST('"+strTODT_TYPE+"' AS DATE)-1 MONTH,ISO),'-','')    \n ");
						sql0.append( " FROM SYSIBM.SYSDUMMY1                                                  \n ");
						stmt0 = conn.createStatement();
						rs0 = stmt0.executeQuery(sql0.toString());
						while(rs0.next())	{				
							strBTODT = rs0.getString(1);
						}


						if(strGB.equals("R")){
              strTable = "HOORDER";
							strNm ="'1','2'";
						}else{
							strTable = "T_HOORDER";
							strNm ="'3'";
						}
           

            StringBuffer sql = new StringBuffer();
						Statement stmt= null;
						ResultSet rs = null;

						sql.append( " SELECT X.EMPNO,                                                                                                                                    \n ");
						sql.append( "        CASE WHEN (D7_DATE>C3_DATE AND D7_DATE = MX_DATE) THEN 'JT'                                                                                 \n ");
						//sql.append( "             WHEN (D7_DATE>C3_DATE AND D7_DATE < MX_DATE) THEN 'WK'                                                                                 \n ");
						sql.append( "             WHEN (D7_DATE>C3_DATE ) THEN 'JT'                                                                       \n ");
						sql.append( "             WHEN (D7_DATE<C3_DATE AND D7_DATE<>'19990101' AND ( C3_DATE>'"+strFRDT+"'  AND C3_DATE<='"+strYYMMDD31+"')) THEN 'JT'                                                                               \n ");
						sql.append( "             WHEN (D7_DATE<C3_DATE AND C3_DATE <= MX_DATE) THEN 'WK'                                                                                \n ");
						sql.append( "             END AS JTGB,                                                                                                                           \n ");
						sql.append( "        CASE WHEN (D7_DATE>C3_DATE AND D7_DATE = MX_DATE) THEN D7_DEPT                                                                              \n ");
						sql.append( "             WHEN (D7_DATE>C3_DATE AND D7_DATE < MX_DATE) THEN MX_DEPT                                                                              \n ");
						sql.append( "             WHEN (D7_DATE<C3_DATE AND C3_DATE <= MX_DATE) THEN MX_DEPT                                                                             \n ");
						sql.append( "             END AS DEPPT,                                                                                                                          \n ");
						sql.append( "        X.BEFDTP, IFNULL(D.DEPTGB,'X')DEPTGB, E.MINORNM, F.DEPTCD AS CURDPT,                                                                         \n ");
						sql.append( "        CASE WHEN D7_DATE<>'19990101' AND (D7_DATE<C3_DATE AND D7_DATE>'"+strBTODT+"' AND ( C3_DATE>'"+strFRDT+"' AND C3_DATE<='"+strYYMMDD31+"')) THEN 'Y' ELSE 'N' END JTWK ,  \n ");
						sql.append( "        X.D7_DATE                                                                         \n ");
						sql.append( " FROM (                                                                                                                                             \n ");
						sql.append( "       SELECT EMPNO,                                                                                                                                \n ");
						sql.append( "              INTEGER(IFNULL(MAX(CASE WHEN A.ORDCD ='D7' THEN A.ORDDT END),'19990101')) AS D7_DATE,                                                 \n ");
						sql.append( "              MAX(CASE WHEN A.ORDCD ='D7' THEN DEPTCD END) AS D7_DEPT,                                                                              \n ");
						sql.append( "              INTEGER(IFNULL(MAX(CASE WHEN A.ORDCD IN('C1','C3') THEN A.ORDDT END),'19990102')) AS C3_DATE,                                                 \n ");
						sql.append( "              MAX(CASE WHEN A.ORDCD ='C3' THEN A.DEPTCD END) AS C3_DEPT,                                                                            \n ");
						sql.append( "              (SELECT MAX(K.ORDDT) FROM PAYROLL."+strTable+" K WHERE A.EMPNO =K.EMPNO AND K.ORDDT<='"+strYYMMDD31+"')AS MX_DATE,                                                                                                     \n ");
						sql.append( "              MAX(CASE WHEN A.ORDDT = (SELECT MAX(B.ORDDT) FROM PAYROLL."+strTable+" B                 \n ");
						sql.append( "                                        WHERE A.EMPNO =B.EMPNO AND B.ORDDT<='"+strYYMMDD31+"')THEN DEPTCD END) MX_DEPT,                \n ");
						sql.append( "              MAX(CASE WHEN A.ORDDT = (SELECT MAX(B.ORDDT) FROM PAYROLL."+strTable+" B   \n ");
						sql.append( "                                        WHERE A.EMPNO =B.EMPNO AND B.ORDDT<='"+strYYMMDD31+"' AND ORDCD<>'D7')THEN DEPTCD END) BEFDTP  \n ");
						sql.append( "         FROM PAYROLL."+strTable+" A                                                                                                                   \n ");
						sql.append( "        WHERE A.EMPNO IN ( SELECT EMPNO FROM PAYROLL.HLJTGB                                                                                         \n ");
						sql.append( "                            WHERE APPDT ='"+rows[j].getString(idxAPPDT)+"'                                                                          \n ");
						sql.append( "                              AND SUBSTR(EMPNO,1,1) IN ( "+strNm+")                                                                                               \n ");
						sql.append( "                         )                                                                                                                          \n ");
						sql.append( "          AND A.ORDDT <='"+strYYMMDD31+"'                                                                                    \n ");
						sql.append( "        GROUP BY A.EMPNO                                                                                                                            \n ");
						sql.append( " )X                                                                                                                                                 \n ");
						sql.append( " LEFT JOIN PAYROLL.HCDEPT D ON X.BEFDTP = D.DEPTCD                                                                                                  \n ");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON D.DEPTGB = E.MINORCD AND E.MAJORCD='2050'                                                                           \n ");
						sql.append( " LEFT JOIN PAYROLL.YIPERSON F ON F.EMPNO = X.EMPNO        \n ");      

            /** 2010.08.18 jys ��� 16�� ���� ���ñٹ��� ������.
						sql.append( " SELECT X.EMPNO,                                                                                                                                    \n ");
						sql.append( "        CASE WHEN (D7_DATE>C3_DATE AND D7_DATE = MX_DATE) THEN 'JT'                                                                                 \n ");
						//sql.append( "             WHEN (D7_DATE>C3_DATE AND D7_DATE < MX_DATE) THEN 'WK'                                                                                 \n ");
						sql.append( "             WHEN (D7_DATE>C3_DATE ) THEN 'JT'                                                                       \n ");
						sql.append( "             WHEN (D7_DATE<C3_DATE AND D7_DATE<>'19990101' AND ( C3_DATE>'"+strFRDT+"'  AND C3_DATE<='"+strTODT+"')) THEN 'JT'                                                                               \n ");
						sql.append( "             WHEN (D7_DATE<C3_DATE AND C3_DATE <= MX_DATE) THEN 'WK'                                                                                \n ");
						sql.append( "             END AS JTGB,                                                                                                                           \n ");
						sql.append( "        CASE WHEN (D7_DATE>C3_DATE AND D7_DATE = MX_DATE) THEN D7_DEPT                                                                              \n ");
						sql.append( "             WHEN (D7_DATE>C3_DATE AND D7_DATE < MX_DATE) THEN MX_DEPT                                                                              \n ");
						sql.append( "             WHEN (D7_DATE<C3_DATE AND C3_DATE <= MX_DATE) THEN MX_DEPT                                                                             \n ");
						sql.append( "             END AS DEPPT,                                                                                                                          \n ");
						sql.append( "        X.BEFDTP, IFNULL(D.DEPTGB,'X')DEPTGB, E.MINORNM, F.DEPTCD AS CURDPT,                                                                         \n ");
						sql.append( "        CASE WHEN D7_DATE<>'19990101' AND (D7_DATE<C3_DATE AND D7_DATE>'"+strBTODT+"' AND ( C3_DATE>'"+strFRDT+"' AND C3_DATE<='"+strTODT+"')) THEN 'Y' ELSE 'N' END JTWK   \n ");
						sql.append( " FROM (                                                                                                                                             \n ");
						sql.append( "       SELECT EMPNO,                                                                                                                                \n ");
						sql.append( "              INTEGER(IFNULL(MAX(CASE WHEN A.ORDCD ='D7' THEN A.ORDDT END),'19990101')) AS D7_DATE,                                                 \n ");
						sql.append( "              MAX(CASE WHEN A.ORDCD ='D7' THEN DEPTCD END) AS D7_DEPT,                                                                              \n ");
						sql.append( "              INTEGER(IFNULL(MAX(CASE WHEN A.ORDCD IN('C1','C3') THEN A.ORDDT END),'19990102')) AS C3_DATE,                                                 \n ");
						sql.append( "              MAX(CASE WHEN A.ORDCD ='C3' THEN A.DEPTCD END) AS C3_DEPT,                                                                            \n ");
						sql.append( "              (SELECT MAX(K.ORDDT) FROM PAYROLL."+strTable+" K WHERE A.EMPNO =K.EMPNO AND K.ORDDT<='"+strTODT+"')AS MX_DATE,                                                                                                     \n ");
						sql.append( "              MAX(CASE WHEN A.ORDDT = (SELECT MAX(B.ORDDT) FROM PAYROLL."+strTable+" B                 \n ");
						sql.append( "                                        WHERE A.EMPNO =B.EMPNO AND B.ORDDT<='"+strTODT+"')THEN DEPTCD END) MX_DEPT,                \n ");
						sql.append( "              MAX(CASE WHEN A.ORDDT = (SELECT MAX(B.ORDDT) FROM PAYROLL."+strTable+" B   \n ");
						sql.append( "                                        WHERE A.EMPNO =B.EMPNO AND B.ORDDT<='"+strTODT+"' AND ORDCD<>'D7')THEN DEPTCD END) BEFDTP  \n ");
						sql.append( "         FROM PAYROLL."+strTable+" A                                                                                                                   \n ");
						sql.append( "        WHERE A.EMPNO IN ( SELECT EMPNO FROM PAYROLL.HLJTGB                                                                                         \n ");
						sql.append( "                            WHERE APPDT ='"+rows[j].getString(idxAPPDT)+"'                                                                          \n ");
						sql.append( "                              AND SUBSTR(EMPNO,1,1) IN ( "+strNm+")                                                                                               \n ");
						sql.append( "                         )                                                                                                                          \n ");
						sql.append( "          AND A.ORDDT <='"+strTODT+"'                                                                                    \n ");
						sql.append( "        GROUP BY A.EMPNO                                                                                                                            \n ");
						sql.append( " )X                                                                                                                                                 \n ");
						sql.append( " LEFT JOIN PAYROLL.HCDEPT D ON X.BEFDTP = D.DEPTCD                                                                                                  \n ");
						sql.append( " LEFT JOIN PAYROLL.HCLCODE E ON D.DEPTGB = E.MINORCD AND E.MAJORCD='2050'                                                                           \n ");
						sql.append( " LEFT JOIN PAYROLL.YIPERSON F ON F.EMPNO = X.EMPNO                                                                                                \n ");

            **/
					  logger.dbg.println(this,sql.toString());

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());
						while(rs.next())	{				
                intJTGB=0;
								if(rs.getString(2).equals("JT")){ //����
									 if(rs.getString(5).equals("1")){ //����
                      intJTGB =1;
									 }else if(rs.getString(5).equals("3")){ //��������
                      intJTGB =6;
									 }else if(rs.getString(5).equals("4")){ //�ݰ���
                      intJTGB =2;
									 }else if(rs.getString(5).equals("5")){ //����
                      intJTGB =4;
									 }else if(rs.getString(5).equals("6")){ //��
                      intJTGB =3; 
									 }else if(rs.getString(5).equals("8")){ //�����
                      intJTGB =5;
									 }
								}

								//logger.dbg.println(this,"rs.getString(8)::"+rs.getString(8));
								//logger.dbg.println(this,"strYYMMDD16::"+strYYMMDD16);

								if(rs.getString(9).equals(strYYMMDD16)){
									strRemark="2��";
								}else{
                  strRemark="";
								}

  							UpdateSql = new StringBuffer();
								UpdateSql.append( " UPDATE PAYROLL.HLJTGB SET " );
								UpdateSql.append( "        JTGB = "+intJTGB+"," );
								UpdateSql.append( "        CURDPT = '"+rs.getString(7)+"'," );
								UpdateSql.append( "        BEFDPT = '"+rs.getString(4)+"'," );
								UpdateSql.append( "        JTWK ='"+rs.getString(8)+"'," );
								UpdateSql.append( "        REMARK ='"+strRemark+"'" );
								UpdateSql.append( "  WHERE APPDT='"+rows[j].getString(idxAPPDT)+"'" );
								UpdateSql.append( "    AND EMPNO='"+rs.getString(1)+"'" );

 							 // logger.dbg.println(this,":update:::::"+UpdateSql.toString());

								gsmt = conn.getGauceStatement(UpdateSql.toString());
								gsmt.executeUpdate();
								gsmt.close();
  					}//while

	
					}//if

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {

					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
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