//**참고사항. delete,update할떼는 where절 이후에 primary key 컬럼을 꼭 추가해서 써준다***
package sales.menu.em;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class Em010_T1 extends HttpServlet{

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


				//파라메타 받아오는것 선언
				String str1 = reqGauce.getParameter("v_str1");
				String useid = reqGauce.getParameter("v_str2");

				String strEnd_dt=""; //계약만료일
				String strYyyymm=""; //입사년월
				
				/******************************** **********************************************
				 * Insert 처리
				 *********************************************************************************/
				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");
				logger.dbg.println(this,"step1");//로그남기는것
				
				String[] strArrCN = new String[]{
																					"EMPNO",	  "USESTS",    "EMPNMK",  "EMPNMC",   "START_DT",//5
																					"JOB_CD",   "AGENCY_CD", "VEND_CD",	"DEPT_CD",  "TEAM_CD",//10
																					"WORK_CD",  "SKILL_CD",  "I_DATE",	"U_DATE",   "CON_YEAR",//15
																					"CUST_SID",	"I_EMPNO", 	 "U_EMPNO",	"NATION_CD","USTS",		//20
																					"ADDRESS1",	"ADDRESS2",  "TEL_NO",	"MOBILE_NO","HEIGHT", //25
																					"WEIGHT",		"SIZE_UP",	"SIZE_DN",	"SIZE_FT",	"SIZE_WT",//30
																					"BLOOD",		"ZIP_CD",   "PASS_NO",  "SKILL_CD", "ORD_CD", //35 
																				  "END_DT",   "CHGYMD",   "C_VEND_CD","CHI_NM",	  "CHI_RNM",//40
																					"CHI_TEL",  "CHI_ADD",	"SCH_FR",	  "SCH_TO",	  "ATT_CD", //45 
                                          "SCH_NM",	  "HOBBY",    "SPC_NM",	  "REM_BNK",  "SAV_NM", //50
                                          "SAV_TEL",  "REM_ACC"                                     //52 	
																			  }; 

				int[] idx = new int[52]; //컬럼갯수를 넣어준다.

        for (int i=0; i<strArrCN.length; i++){
					idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				StringBuffer InsertSql2 = null;
				StringBuffer UpdateSql2 = null;
				StringBuffer DeleteSql2 = null;

				StringBuffer InsertSql3 = null;

				for (int j = 0; j < rows.length; j++){
				/******************************** **********************************************
				* INSERT 처리
				*********************************************************************************/   

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {

            //사번채번 : 
						StringBuffer sql = new StringBuffer();
						Statement stmt= null;
						ResultSet rs = null;
						String strSeq = "0000";
						String strEmpno = "";

						sql.append( "SELECT IFNULL(MAX(SUBSTR(EMPNO,4,4)),0)+1 AS EMPNO	\n" )//PK EMPNO
								.append( "FROM SALES.TCM300																	\n" )
								.append( "WHERE SUBSTR(EMPNO,1,3) ='"+str1+"'								\n" );

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while (rs.next())	{
							strSeq = rs.getString(1);
						}
						rs.close();
						stmt.close();

						int ichk = Integer.parseInt(strSeq);
						if (ichk<10) strEmpno = str1 + "000" + ichk;
						else if (ichk<100 && ichk>9) strEmpno = str1 + "00" + ichk;
						else if (ichk<1000 && ichk>99) strEmpno = str1 + "0" + ichk;
						else if (ichk>999) strEmpno =""+ str1 + ichk;

						rows[j].setString(idx[0],strEmpno);//데이터셋 setString으로 가져오기
						rows[j].setString(idx[16],useid);
						rows[j].setString(idx[17],useid);

						/*TABLE TCM300---------------------------------------------------------------------------------------*/
					 InsertSql = new StringBuffer();
					 InsertSql.append( " INSERT INTO SALES.TCM300														\n" )
										.append( " (EMPNO,	USESTS,	EMPNMK,	EMPNMC,	START_DT,					\n" )//5
										.append( " JOB_CD,	AGENCY_CD, VEND_CD,	DEPT_CD,	TEAM_CD,	  \n" )//10
										.append( " WORK_CD,	SKILL_CD,  I_DATE,	U_DATE,	  CON_YEAR,	  \n" )//15
										.append( " CUST_SID,I_EMPNO,	 U_EMPNO,	NATION_CD,	HEIGHT,	  \n" )//20
										.append( " WEIGHT,	SIZE_UP,	 SIZE_DN,	SIZE_FT,	SIZE_WT,		\n" )//25
										.append( " BLOOD,   PASS_NO, B_SKILL_CD, ORD_CD, END_DT,      \n" )//30
										.append( " CHGYMD,  C_VEND_CD,CHI_NM ,CHI_RNM ,CHI_TEL,       \n" )//35
										.append( " CHI_ADD, SCH_FR,   SCH_TO, ATT_CD,  SCH_NM,        \n" )//40
										.append( " HOBBY,   SPC_NM,   REM_BNK, SAV_NM, SAV_TEL,       \n" )//45
										.append( " REM_ACC )                                          \n" )//47
										.append( " VALUES																							\n" )
										.append( " (?,?,?,?,?,																				\n" )
										.append( " ?,?,?,?,?,																					\n" )
										.append( " ?,?,CURRENT TIMESTAMP,CURRENT TIMESTAMP,?,					\n" )//13
										.append( " ?,?,?,?,?,																					\n" )//18
										.append( " ?,?,?,?,?,																					\n" )//23
										.append( " ?,?,?,?,?,   																			\n" )//
										.append( " ?,?,?,?,?,																	    		\n" )//
										.append( " ?,?,?,?,?,															    				\n" )//
										.append( " ?,?,?,?,?, 	  											      				\n" )
										.append( " ?)	         					 			    			      				\n" );//

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.bindColumn(1, idx[0]);
							gsmt.bindColumn(2, idx[19]);   //USESTS임.
							gsmt.bindColumn(3, idx[2]);
							gsmt.bindColumn(4, idx[3]);
							gsmt.bindColumn(5, idx[4]);    //START_DT
							gsmt.bindColumn(6, idx[5]);
							gsmt.bindColumn(7, idx[6]);
							gsmt.bindColumn(8, idx[7]);
							gsmt.bindColumn(9, idx[8]);
							gsmt.bindColumn(10, idx[9]);  //TEAM_CD
							gsmt.bindColumn(11, idx[10]); //WORK_CD
							gsmt.bindColumn(12, idx[11]); //SKILL_CD
							gsmt.bindColumn(13, idx[14]); //CON_YEAR
							gsmt.bindColumn(14, idx[15]); 
							gsmt.bindColumn(15, idx[16]);
							gsmt.bindColumn(16, idx[17]); 
							gsmt.bindColumn(17, idx[18]); //
							gsmt.bindColumn(18, idx[24]); //HEIGHT
							gsmt.bindColumn(19, idx[25]); //WEIGHT
							gsmt.bindColumn(20, idx[26]); //SIZE_UP
							gsmt.bindColumn(21, idx[27]); //SIZE_DN
							gsmt.bindColumn(22, idx[28]); //SIZE_FT
							gsmt.bindColumn(23, idx[29]); //SIZE_WT
							gsmt.bindColumn(24, idx[30]); //BLOOD
							gsmt.bindColumn(25, idx[32]); //PASS_NO
							gsmt.bindColumn(26, idx[11]); //SKILL_CD
							gsmt.bindColumn(27, idx[34]); //ORD_CD
							gsmt.bindColumn(28, idx[35]); 
							gsmt.bindColumn(29, idx[36]);
							gsmt.bindColumn(30, idx[37]);
							gsmt.bindColumn(31, idx[38]);
							gsmt.bindColumn(32, idx[39]);//CHI_RNM
							gsmt.bindColumn(33, idx[40]);
							gsmt.bindColumn(34, idx[41]);
							gsmt.bindColumn(35, idx[42]);
							gsmt.bindColumn(36, idx[43]);
							gsmt.bindColumn(37, idx[44]);
							gsmt.bindColumn(38, idx[45]);
							gsmt.bindColumn(39, idx[46]);
							gsmt.bindColumn(40, idx[47]);
							gsmt.bindColumn(41, idx[48]);
							gsmt.bindColumn(42, idx[49]);
							gsmt.bindColumn(43, idx[50]);
							gsmt.bindColumn(44, idx[51]);

							gsmt.executeUpdate();
							gsmt.close();
       
			        /********
							최초급여는 필요 없어서 막음.
              strYyyymm = rows[j].getString(idx[11]).substring(0,6);
							//최초기본급 자동생성 ==> 최초 입력할 때 한 번만 입력된다. 수정시 변경 같은 건 없다.
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE SALES.TCM300		\n")
											 .append( "	   SET F_PAY = (SELECT B_PAY FROM SALES.TCM410						        \n")
											 .append( "	                 WHERE YYYYMM <= (SELECT MAX(YYYYMM) FROM SALES.TCM410 WHERE YYYYMM <='"+strYyyymm+"'\n")
											 .append( "	                   AND SKILL_CD ='"+rows[j].getString(idx[11])+"'	\n")
											 .append( "	                   AND CON_YEAR ="+rows[j].getInt(idx[14])+"		  \n")
											 .append( "	                )	\n")
											 .append( "	 WHERE EMPNO ='"+rows[j].getString(idx[0])+"'	\n");
							GauceStatement gsmt8 = conn.getGauceStatement(UpdateSql.toString());
							gsmt8.executeUpdate();
							gsmt8.close();
							********/

							/*TABLE TCM345(계약관리)---------------------------------------------------------------------------------------*/
							//계약관리의 만기일자 생성
							StringBuffer sql_1 = new StringBuffer();
							Statement stmt_1= null;
							ResultSet rs_1 = null;
							sql_1.append( " SELECT REPLACE(CAST((CAST(SUBSTR(START_DT,1,4)||'-'||SUBSTR(START_DT,5,2)||'-'||SUBSTR(START_DT,7,2)AS DATE) + 1 YEAR) - 1 DAY AS VARCHAR(10)),'-','')	\n" )
									 .append( "   FROM SALES.TCM300														\n" )
									 .append( "  WHERE EMPNO ='"+rows[j].getString(idx[0])+"'	\n" );
							stmt_1 = conn.createStatement();
							rs_1 = stmt_1.executeQuery(sql_1.toString());

							while (rs_1.next())	{
								strEnd_dt = rs_1.getString(1);  //입사일(계약시작일 + 1년 -1일로 자동 생성함)
							}
							rs_1.close();
							stmt_1.close();

							rows[j].setString(idx[0],strEmpno);
							rows[j].setString(idx[16],useid);
							rows[j].setString(idx[17],useid);

							InsertSql2 = new StringBuffer();
							InsertSql2.append( "INSERT INTO SALES.TCM345									\n" )
												.append( "(EMPNO, SEQ, CUST_SID, JOB_CD,VEND_CD,    \n" )
												.append( "DEPT_CD,TEAM_CD,WORK_CD,START_DT,I_EMPNO, \n" )
												.append( "U_EMPNO,CONT_GB,I_DATE,U_DATE, END_DT, CON_YEAR, CLOSE_YN)    \n" )
												.append( "VALUES                                    \n" )
												.append( "(?,'1',?,?,?,                             \n" )
												.append( " ?,?,?,?,?,                               \n" )
												.append( " ?,'001',CURRENT TIMESTAMP,CURRENT TIMESTAMP,'"+strEnd_dt+"',1,'') \n" );
							GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
							gsmt2.setGauceDataRow(rows[j]);

							gsmt2.bindColumn(1, idx[0]);
							gsmt2.bindColumn(2, idx[15]);
							gsmt2.bindColumn(3, idx[5]);
							gsmt2.bindColumn(4, idx[7]);
							gsmt2.bindColumn(5, idx[8]);
							gsmt2.bindColumn(6, idx[9]);
							gsmt2.bindColumn(7, idx[10]);
							gsmt2.bindColumn(8, idx[4]);
							gsmt2.bindColumn(9, idx[16]);
							gsmt2.bindColumn(10, idx[17]);
							gsmt2.executeUpdate();
							gsmt2.close();
							strEnd_dt="";

							/*TABLE TCM305(사내경력)---------------------------------------------------------------------------------------*/
							//입사일이 발령일자이다.
							InsertSql3 = new StringBuffer();
							InsertSql3.append( "INSERT INTO SALES.TCM305									  \n" )
												.append( "( EMPNO, ORD_DT, SEQ, CUST_SID, ORD_CD,     \n" )
												.append( "  VEND_CD, DEPT_CD, TEAM_CD, WORK_CD,JOB_CD,\n" )
												.append( "  SKILL_CD, I_EMPNO, U_EMPNO, I_DATE,U_DATE \n" )
												.append( " )    \n" )
												.append( "VALUES                                      \n" )
												.append( "(?,?,1,?,?,                                \n" )
												.append( " ?,?,?,?,?,                                 \n" )
												.append( " ?,?,?,CURRENT TIMESTAMP,CURRENT TIMESTAMP) \n" );
						 
							GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
							gsmt3.setGauceDataRow(rows[j]);

							gsmt3.bindColumn(1, idx[0]);
							gsmt3.bindColumn(2, idx[4]);
							gsmt3.bindColumn(3, idx[15]);
							gsmt3.bindColumn(4, idx[34]);
							gsmt3.bindColumn(5, idx[7]);
							gsmt3.bindColumn(6, idx[8]);
							gsmt3.bindColumn(7, idx[9]);
							gsmt3.bindColumn(8, idx[10]);
							gsmt3.bindColumn(9, idx[5]);
							gsmt3.bindColumn(10, idx[11]);
							gsmt3.bindColumn(11, idx[16]);
							gsmt3.bindColumn(12, idx[17]);
							
							gsmt3.executeUpdate();
							gsmt3.close();

					}

					/******************************************************************************
					* Update 처리
					*********************************************************************************/
					if (rows[j].getJobType() ==  GauceDataRow.TB_JOB_UPDATE) {

						 rows[j].setString(idx[17],useid);//데이터셋 setString으로 가져오기

						 logger.dbg.println(this,"Update::");

             /*TABLE TCM300---------------------------------------------------------------------------------------*/
						 UpdateSql = new StringBuffer();
						 UpdateSql.append( " UPDATE SALES.TCM300	\n")
											.append( " SET									\n")
											.append( " USESTS=?,						\n")
											.append( " EMPNMK=?,						\n")
											.append( " EMPNMC=?,						\n")
											.append( " START_DT=?,					\n")
											.append( " JOB_CD=?,						\n")
											.append( " AGENCY_CD=?,					\n")
											.append( " VEND_CD=?,						\n")
											.append( " DEPT_CD=?,						\n")
											.append( " TEAM_CD=?,						\n")
											.append( " WORK_CD=?,						\n")//10
											.append( " SKILL_CD=?,					\n")
											.append( " U_DATE=CURRENT TIMESTAMP,	\n")
											.append( " CON_YEAR=?,					\n")
											.append( " U_EMPNO=?,						\n")
											.append( " NATION_CD=?,					\n")
											.append( " HEIGHT=?,						\n")
											.append( " WEIGHT=?,						\n")
											.append( " SIZE_UP=?,						\n")
											.append( " SIZE_DN=?,						\n")
											.append( " SIZE_FT=?,						\n")
											.append( " SIZE_WT=?,						\n")
											.append( " BLOOD=?,							\n")
											
											.append( " C_VEND_CD=?,					\n")
											.append( " CHI_NM=?,						\n")
											.append( " CHI_RNM=?,						\n")
											.append( " CHI_TEL=?,						\n")
											.append( " CHI_ADD=?,						\n")
											.append( " SCH_FR=?,						\n")
											.append( " SCH_TO=?,						\n")
											.append( " ATT_CD=?,						\n")
											.append( " SCH_NM=?,						\n")
											.append( " HOBBY=?,							\n")
											.append( " SPC_NM=?,						\n")

											.append( " REM_BNK=?,						\n")
											.append( " SAV_NM=?,						\n")
											.append( " SAV_TEL=?,						\n")
											.append( " REM_ACC=?						\n")

											.append( " WHERE EMPNO=?				\n");

											logger.dbg.println(this,"idx[49]::" + rows[j].getString(idx[49]));
											logger.dbg.println(this,"UpdateSql.toString()::" + UpdateSql.toString());
											GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
											gsmt.setGauceDataRow(rows[j]);
												
											gsmt.bindColumn(1,  idx[1]);
											gsmt.bindColumn(2,  idx[2]);
											gsmt.bindColumn(3,  idx[3]);
											gsmt.bindColumn(4,  idx[4]);
											gsmt.bindColumn(5,  idx[5]);
											gsmt.bindColumn(6,  idx[6]);
											gsmt.bindColumn(7,  idx[7]);
											gsmt.bindColumn(8,  idx[8]);
											gsmt.bindColumn(9,  idx[9]);
											gsmt.bindColumn(10, idx[10]);
											gsmt.bindColumn(11, idx[11]);
											gsmt.bindColumn(12, idx[14]);
											gsmt.bindColumn(13, idx[17]);
											gsmt.bindColumn(14, idx[18]);
											gsmt.bindColumn(15, idx[24]);
											gsmt.bindColumn(16, idx[25]);
											gsmt.bindColumn(17, idx[26]);
											gsmt.bindColumn(18, idx[27]);
											gsmt.bindColumn(19, idx[28]);
											gsmt.bindColumn(20, idx[29]);
											gsmt.bindColumn(21, idx[30]);

											gsmt.bindColumn(22, idx[37]);
											gsmt.bindColumn(23, idx[38]);
                      gsmt.bindColumn(24, idx[39]); //CHI_RNM
											gsmt.bindColumn(25, idx[40]);
											gsmt.bindColumn(26, idx[41]);
											gsmt.bindColumn(27, idx[42]);
											gsmt.bindColumn(28, idx[43]);
											gsmt.bindColumn(29, idx[44]);
											gsmt.bindColumn(30, idx[45]);
											gsmt.bindColumn(31, idx[46]);
											gsmt.bindColumn(32, idx[47]);
											
											gsmt.bindColumn(33, idx[48]);
											gsmt.bindColumn(34, idx[49]);
											gsmt.bindColumn(35, idx[50]);
											gsmt.bindColumn(36, idx[51]);

											gsmt.bindColumn(37, idx[0]);
																							
											gsmt.executeUpdate();
											gsmt.close();

					}
					/******************************** **********************************************
					 * DELETE 처리
					 *********************************************************************************/

          /*TABLE TCM300---------------------------------------------------------------------------------------*/
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE) {

						  DeleteSql = new StringBuffer();
							DeleteSql.append( " DELETE  FROM SALES.TCM300		\n")
											 .append( "	 WHERE  EMPNO=?								\n");
							GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
							gsmt.setGauceDataRow(rows[j]);
	  					gsmt.bindColumn(1, idx[0]);

							gsmt.executeUpdate();
							gsmt.close();

							//계약과 발령은 삭제하지 않음.

					}
				}
			}
			catch(Exception e){
        conn.rollback();
				logger.err.println(this,e.getMessage());	
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
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
