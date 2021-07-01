//**��������. delete,update�Ҷ��� where�� ���Ŀ� primary key �÷��� �� �߰��ؼ� ���ش�***
package sales.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em014_t1_b extends HttpServlet{

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
				reqGauce = service.getGauceRequest();
				resGauce = service.getGauceResponse();
				conn.setAutoCommit(false);

				//�Ķ��Ÿ �޾ƿ��°� ����
				String strGB = reqGauce.getParameter("v_str1"); //Y -�ű��Է�, N-������ �Է�
				String strATT_DT =reqGauce.getParameter("v_str2");
				String strEmpno = reqGauce.getParameter("v_str3"); //�α��� ���
				
				/*ó�� �ϰ������� ���� �ʿ���.*/
				String strto = reqGauce.getParameter("v_str4");

				/*���κ� ������ ���� �ʿ���.*/
				String strEmpno2 = reqGauce.getParameter("v_str5");

				/*�μ��� ������ ���� �ʿ���.*/
				String strTeamcd = reqGauce.getParameter("v_str6");

        if(strEmpno2==null) strEmpno2="";
				         
        String strPay_ymd ="";                  //�޿����޳��

				int intfr=Integer.parseInt(strATT_DT);  //�ϰ�����Ҷ� ���
				int intto=Integer.parseInt(strto);      //�ϰ�����Ҷ� ���
				
				String strWORK_GB="001"; //�ٹ�
				String strW_TIME="0730";
        String strW2_TIME="1800";
				String strW_TIME_TOT="10";
        String strO_TIME="0000";
        String strO2_TIME="0000";
				String strO3_TIME="0000";
        String strO4_TIME="0000";
				
				String strAttym=strATT_DT.substring(0,6);            //�⿪��� - ����ϰ� ��
        String strEndymd=strATT_DT.substring(0,6)+"31";  //�⿪����� �������� - �Ի��ϰ� ��
				strPay_ymd = strATT_DT.substring(0,4)+"-"+strATT_DT.substring(4,6)+"-"+strATT_DT.substring(6,8);

				/*********************************************************************************
				 * Insert ó��
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				/*
				String[] strArrCN = new String[]{ "EMPNO",     "ATT_DT",  "CUST_SID", "VEND_CD","DEPT_CD",
					                                "TEAM_CD",   "WORK_CD", "WORK_GB",  "W_TIME", "W2_TIME",
                                          "W_TIME_TOT","W_REMARK","O_TIME",   "O2_TIME","O_TIME_TOT",
                                          "O_DTIME",   "O_NTIME", "O_REMARK", "REMARK", "CHK",
					                               	"I_EMPNO",   "I_DATE",  "U_EMPNO",  "U_DATE"
																			  };
				int[] idx = new int[24]; //�÷������� �־��ش�.

				for (int i=0; i<strArrCN.length; i++) {
						idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}
				*/

				GauceDataRow[] rows = userSet.getDataRows();

				for (int j = 0; j<rows.length; j++){
				
				/******************************** **********************************************
				* INSERT ó��
				*********************************************************************************/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

           /**********************************************
            ���ں�����
					 **********************************************/
            /*

					 if(strGB.equals("N")){
							StringBuffer DeleteSql = new StringBuffer();
							DeleteSql.append( " DELETE FROM SALES.TCM350		\n")
											 .append( "	 WHERE ATT_DT='"+strATT_DT+"' \n");
							if(!strEmpno2.equals(""))DeleteSql.append( " AND EMPNO = '"+strEmpno2+"'		\n");
							
							logger.dbg.println(this,"DeleteSql:::"+DeleteSql);
							GauceStatement gsmt0 = conn.getGauceStatement(DeleteSql.toString());
  						gsmt0.setGauceDataRow(rows[j]);
							gsmt0.executeUpdate();
							gsmt0.close();
					 }	 

					 StringBuffer InsertSql = new StringBuffer();
					 InsertSql.append( " INSERT INTO SALES.TCM350(                                                     \n" )
										.append( " EMPNO,     ATT_DT,  CUST_SID, VEND_CD,DEPT_CD,                                \n" )
										.append( " TEAM_CD,   WORK_CD, WORK_GB,  W_TIME, W2_TIME,                                \n" )
										.append( " W_TIME_TOT,W_REMARK,O_TIME,   O2_TIME,O_TIME_TOT,                             \n" )
										.append( " O_DTIME,   O_NTIME, O_REMARK, REMARK,                                         \n" )
										.append( " I_EMPNO,   I_DATE,  U_EMPNO,  U_DATE, JOB_CD, SKILL_CD , PAY_YM )                     \n" )
										.append( " SELECT A.EMPNO,  '"+strATT_DT+"' AS ATT_DT, A.CUST_SID, A.VEND_CD,  A.DEPT_CD,    \n" )
										.append( "        A.TEAM_CD, A.WORK_CD, '"+strWORK_GB+"' AS WORK_GB, '"+strW_TIME+"' AS W_TIME, '"+strW2_TIME+"' AS W2_TIME, \n")
										.append( "        "+strW_TIME_TOT+" W_TIME_TOT, ''W_REMARK, '"+strO_TIME+"' AS  O_TIME, '"+strO2_TIME+"' AS O2_TIME, 0 O_TIME_TOT,   \n")
						        .append( "        0 O_DTIME,   0 O_NTIME, ''O_REMARK, ''REMARK,                          \n" )
										.append( "        '"+strEmpno+"' , CURRENT TIMESTAMP,'"+strEmpno+"',CURRENT TIMESTAMP, JOB_CD, SKILL_CD ,   \n" )
						        .append( "        SUBSTR(REPLACE(CAST(CAST('"+strPay_ymd+"' AS DATE)+1 MONTH AS CHAR(10)),'-',''),1,6)  \n" )
										.append( "   FROM SALES.TCM300 A    \n" )
										.append( "  WHERE A.EMPNO IS NOT NULL        \n" )
					          .append( "    AND A.EMPNO <> '' \n" )
 					          .append( "    AND ((A.USESTS='1' AND A.START_DT<='"+strEndymd+"')  \n" )
										.append( "      OR (A.USESTS='3' AND (A.END_DT='' OR A.END_DT IS NULL OR A.END_DT ='"+strAttym+"%')))  \n" )

                    .append( "    AND NOT EXISTS ( SELECT C.EMPNO FROM SALES.TCM355 C                \n" )
										.append( "                      WHERE '"+strATT_DT+"' BETWEEN C.START_DT AND C.END_DT \n" )
										.append( "                        AND A.EMPNO = C.EMPNO                          \n" )
										.append( "                    )                                                  \n" );
	                                               
					 logger.dbg.println(this,InsertSql.toString());
					 GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //�α׳���°�
					 gsmt.setGauceDataRow(rows[j]);
            
					 gsmt.executeUpdate();
					 gsmt.close();
					 */
           
           /**********************************************
            �ϰ�����
					 **********************************************/

					 if(strGB.equals("N")){
							StringBuffer DeleteSql = new StringBuffer();
							DeleteSql.append( " DELETE FROM SALES.TCM350		\n")
											 .append( "	 WHERE ATT_DT>='"+strATT_DT+"' AND ATT_DT <='"+strto+"' \n");
							if(!strEmpno2.equals(""))DeleteSql.append( " AND EMPNO = '"+strEmpno2+"'		\n");
							if(!strTeamcd.equals(""))DeleteSql.append( " AND TEAM_CD = '"+strTeamcd+"' \n" );

							
							GauceStatement gsmt0 = conn.getGauceStatement(DeleteSql.toString());
  						gsmt0.setGauceDataRow(rows[j]);
							gsmt0.executeUpdate();
							gsmt0.close();
					 }	 
	
           for(int i = intfr ; i<=intto; i++){
               StringBuffer InsertSql = new StringBuffer();
							 InsertSql.append( " INSERT INTO SALES.TCM350(                                                 \n" )
												.append( " EMPNO,     ATT_DT,  CUST_SID, VEND_CD,DEPT_CD,                                \n" )
												.append( " TEAM_CD,   WORK_CD, WORK_GB,  W_TIME, W2_TIME,                                \n" )
												.append( " W_TIME_TOT,W_REMARK,O_TIME,   O2_TIME,O_TIME_TOT,                             \n" )
												.append( " O_DTIME,   O_NTIME, O_REMARK, O3_TIME, O4_TIME,REMARK,                                         \n" )
												.append( " I_EMPNO,   I_DATE,  U_EMPNO,  U_DATE, JOB_CD, SKILL_CD , PAY_YM )                     \n" )
												.append( " SELECT A.EMPNO,  '"+i+"' AS ATT_DT, A.CUST_SID, A.VEND_CD,  A.DEPT_CD,    \n" )
												.append( "        A.TEAM_CD, A.WORK_CD,  \n")
			                  .append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.WORK_GB ELSE '"+strWORK_GB+"' END WORK_GB,  \n")
			                  .append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.W_TIME     ELSE '"+strW_TIME+"'     END W_TIME,      \n")
			                  .append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.W2_TIME   ELSE '"+strW2_TIME+"'   END W2_TIME,     \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.W_TIME_TOT   ELSE '"+strW_TIME_TOT+"' END W_TIME_TOT,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.W_REMARK  ELSE '' END W_REMARK,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.O_TIME    ELSE '"+strO_TIME+"'  END O_TIME,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.O2_TIME   ELSE '"+strO2_TIME+"' END O2_TIME,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.O_TIME_TOT   ELSE 0 END O_TIME_TOT,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.O_DTIME   ELSE 0 END O_DTIME,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.O_NTIME   ELSE 0 END O_NTIME,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.O_REMARK  ELSE '' END O_REMARK,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.O3_TIME   ELSE '"+strO3_TIME+"' END O3_TIME,  \n")
												.append( "        CASE WHEN ((B.EMPNO IS NOT NULL OR RTRIM(B.EMPNO)<>'') AND (RTRIM(B.WORK_GB)<>'' AND B.WORK_GB IS NOT NULL)) THEN B.O4_TIME   ELSE '"+strO4_TIME+"' END O4_TIME,  \n")
							          .append( "        ''REMARK,                          \n" )
												.append( "        '"+strEmpno+"' , CURRENT TIMESTAMP,'"+strEmpno+"',CURRENT TIMESTAMP, JOB_CD, SKILL_CD ,   \n" )
												.append( "        SUBSTR(REPLACE(CHAR(CAST('"+strPay_ymd+"' AS DATE)+1 MONTH,ISO),'-',''),1,6)  \n" )
												.append( "   FROM SALES.TCM300 A    \n" )
			                  .append( "     LEFT JOIN SALES.TCM360 B ON A.EMPNO = B.EMPNO    \n" )
												.append( "  WHERE A.EMPNO IS NOT NULL        \n" )
												.append( "    AND A.EMPNO <> '' \n" )
												.append( "    AND ((A.USESTS='1' AND A.START_DT<='"+i+"')  \n" )
												.append( "      OR (A.USESTS='3' AND (A.END_DT='' OR A.END_DT IS NULL OR A.END_DT>='"+strATT_DT+"')))  \n" );
							 if(!strEmpno2.equals(""))InsertSql.append( " AND EMPNO = '"+strEmpno2+"'		\n");
               if(!strTeamcd.equals(""))InsertSql.append( " AND A.TEAM_CD = '"+strTeamcd+"' \n" );


							 //logger.dbg.println(this,InsertSql.toString() ); 
							 
							 GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString()); //�α׳���°�
							 gsmt.setGauceDataRow(rows[j]);
								
							 gsmt.executeUpdate();
							 gsmt.close();
					 }	
				}
						/******************************** **********************************************
						* Update ó��
						*********************************************************************************/
            /*
         	  if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {
	
						
					}
					*/
					/******************************** **********************************************
					 * DELETE ó��
					 *********************************************************************************/
          /*
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						
			   	}
					*/
				}
			}
			catch(Exception e){
				conn.rollback();
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
			}

			conn.commit();
			resGauce.flush();
			resGauce.commit();
			resGauce.close();
		}
		catch (Exception e) {
			logger.err.println(this,e.getMessage());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}