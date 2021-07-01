package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a040001_t3 extends HttpServlet{
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

				//Master
				String str1 = reqGauce.getParameter("v_str1");	//계산서일자
				String str2 = reqGauce.getParameter("v_str2");	//지점코드
				String str3 = reqGauce.getParameter("v_str3");	//전표일자
				String str4 = reqGauce.getParameter("v_str4");	//전표번호
				String str5 = reqGauce.getParameter("v_str5");	//증빙코드
				String str6 = reqGauce.getParameter("v_str6");	//증빙명(계산서번호)
				String str7 = reqGauce.getParameter("v_str7");	//전표상태(DEL:대기)
				String str8 = reqGauce.getParameter("v_str8");	//작업(=수정)일
				String str9 = reqGauce.getParameter("v_str9");	//작업(=수정)자
				//Detail
				String str10 = reqGauce.getParameter("v_str10");	//품명
				String str11 = reqGauce.getParameter("v_str11");	//규격
				String str12 = reqGauce.getParameter("v_str12");	//수량
				String str13 = reqGauce.getParameter("v_str13");	//단가
				String str14 = reqGauce.getParameter("v_str14");	//공급가액
				String str15 = reqGauce.getParameter("v_str15");	//부가세액
				String str16 = reqGauce.getParameter("v_str16");	//비고
				String str17 = reqGauce.getParameter("v_str17");	//저장구분(Y/N)

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				String[] StrArrCN = new String[] {
					"TAXNBR","COCODE","DEPTCD","EMPNO","TAXIODIV",
					"TAXDIV","TAXKND","VEND_CD","TAXDAT","TAXSUM",
					"TAXVATAMT","TAXTOT","REMARK","TAXCDNBR","ATCODE",
					"TAXPRTYN","TAXCNT","LASTPRT","TAXTYPE","FSDAT",
					"FSNBR","TAXKIDIV","FDCODE","WORKTYPE","WRDT",
					"WRID","UPDT","UPID"
				};

				int[] idx = new int[28];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;	//Master
				StringBuffer InsertSql2 = null;	//Detail
				StringBuffer UpdateSql  = null;
				StringBuffer DeleteSql  = null;
				StringBuffer DeleteSql2 = null;
				StringBuffer UpdateSql2  = null;

				//매출 Master
				Statement stmt = null;
				ResultSet rs = null;

				//매출 Detali
				Statement stmt2 = null;
				ResultSet rs2 = null;
				
				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						
						/*******************************************************************
								매출 Master
						********************************************************************/
						String taxch = rows[j].getString(idx[0]);
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT CAST(MAX(SUBSTR(TAXNBR,8,11)) AS INTEGER)+1 CNT	");
						sql.append( " FROM ACCOUNT.ATTAXMST																		");
						sql.append( " WHERE SUBSTR(TAXNBR,1,7)=SUBSTR('B"+str1+"',1,7)				");

						//System.out.println("a040001_t3# Query : \n" + sql);							
						
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

						InsertSql = new StringBuffer();
						InsertSql.append( " INSERT INTO ACCOUNT.ATTAXMST (						");
						InsertSql.append( " TAXNBR,COCODE,DEPTCD,EMPNO,TAXIODIV,			");
						InsertSql.append( " TAXDIV,TAXKND,VEND_CD,TAXDAT,TAXSUM,			");
						InsertSql.append( " TAXVATAMT,TAXTOT,REMARK,TAXCDNBR,ATCODE,	");
						InsertSql.append( " TAXPRTYN,TAXCNT,LASTPRT,TAXTYPE,FSDAT,		");
						InsertSql.append( " FSNBR,TAXKIDIV,FDCODE,WORKTYPE,WRDT,WRID	");
						InsertSql.append( " ) VALUES(																	");
						InsertSql.append( " 'B"+taxch+"',?, ?, ?, ?,									");
						InsertSql.append( " ?, ?, ?, ?, ?,														");
						InsertSql.append( " ?, ?, ?, ?, ?,														");
						InsertSql.append( " ?, ?, ?, ?, ?,														");
						InsertSql.append( " ?, ?, ?, ?, '"+str8+"', '"+str9+"'				");
						InsertSql.append( "  )																				");

						GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int k=1;k<=23;k++) {
							gsmt.bindColumn(k, idx[k]);
						}

						gsmt.executeUpdate();
						gsmt.close();
						//InsertSql=null;
						//taxch = "";

					if (str17.equals("Y")) {
						/*******************************************************************
								매출 Detail
						********************************************************************/
						String taxch2 = "000";
						StringBuffer sql2 = new StringBuffer();
						sql2.append(" SELECT COALESCE(MAX(TAXSEQ),0)+1 CNT	");
						sql2.append(" FROM ACCOUNT.ATTAXDTL									");
						sql2.append(" WHERE TAXNBR = 'B"+taxch+"'						");
						
						stmt2 = conn.createStatement();
						rs2   = stmt2.executeQuery(sql2.toString());

						while(rs2.next()) {
							taxch2 = rs2.getInt(1) + "";
						}
						
						if (taxch2.length()==1) taxch2 = "00"+taxch2;
						else if (taxch2.length()==2) taxch2 = "0"+taxch2;

						InsertSql2 = new StringBuffer();
						InsertSql2.append( " INSERT INTO ACCOUNT.ATTAXDTL (						");
						InsertSql2.append( " TAXNBR,TAXSEQ,TAXPDTNAM,TAXSTD,TAXQTY,		");
						InsertSql2.append( " TAXPRIC,TAXSUM,TAXVATAMT,BIGO,						");
						InsertSql2.append( " WRDT,WRID																");
						InsertSql2.append( " ) VALUES(																");
						InsertSql2.append( " 'B"+taxch+"','"+taxch2+"','"+str10+"','"+str11+"',"+str12+",	");
						InsertSql2.append( " "+str13+","+str14+","+str15+",'"+str16+"',										");
						InsertSql2.append( " '"+str8+"', '"+str9+"' )									");

						GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.executeUpdate();
						gsmt2.close();
						InsertSql2=null;
						taxch2 = "";
					}
				}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.ATTAXMST SET																							");
						UpdateSql.append( " COCODE = ?,		DEPTCD = ?,		EMPNO = ?,		TAXIODIV = ?, TAXDIV = ?,			");
						UpdateSql.append( " TAXKND = ?,		VEND_CD = ?,	TAXDAT = ?,		TAXSUM = ?,		TAXVATAMT = ?,	");
						UpdateSql.append( " TAXTOT = ?,		REMARK = ?,		TAXCDNBR = ?,	ATCODE = ?,		TAXPRTYN = ?,		");
						UpdateSql.append( " TAXCNT = ?,		LASTPRT = ?,	TAXTYPE = ?,	FSDAT = ?,		FSNBR = ?,			");
						UpdateSql.append( " TAXKIDIV = ?, FDCODE = ?,		WORKTYPE = ?, UPDT = '"+str8+"',	UPID = '"+str9+"'	");
						UpdateSql.append( " WHERE TAXNBR = ?																												");
			
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						for(int s=1;s<=23;s++) {
							gsmt.bindColumn(s, idx[s]);
						}
						
						gsmt.bindColumn(24, idx[0]);

						gsmt.executeUpdate(); 
						gsmt.close();
						
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();		/*세금계산서 MST*/
						DeleteSql.append( " DELETE FROM ACCOUNT.ATTAXMST WHERE TAXNBR = ? ");
						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.executeUpdate();
						gsmt.close();

						DeleteSql2 = new StringBuffer();	/*세금계산서 DTL*/
						DeleteSql2.append( " DELETE FROM ACCOUNT.ATTAXDTL WHERE TAXNBR = ? ");
						GauceStatement gsmt2 = conn.getGauceStatement(DeleteSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);
						gsmt2.bindColumn(1, idx[0]);
						gsmt2.executeUpdate();
						gsmt2.close();

						if (str7.equals("Y"))	{
							UpdateSql2 = new StringBuffer();	/*전표 MASTER*/
							UpdateSql2.append( " UPDATE ACCOUNT.FSLIPDTL SET   ");
							UpdateSql2.append( "				DOCUMCD='', DOCUVAL='' ");
							UpdateSql2.append( " WHERE FDCODE  = '"+str2+"' AND FSDAT   = '"+str3+"' AND FSNBR = '"+str4+"' ");
							UpdateSql2.append( "   AND DOCUMCD = '"+str5+"' AND DOCUVAL = '"+str6+"' ");
							
							GauceStatement gsmt3 = conn.getGauceStatement(UpdateSql2.toString());
							gsmt3.setGauceDataRow(rows[j]);
							gsmt3.executeUpdate();
							gsmt3.close();
						}
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","저장시 알수없는 에러발생!!(Error Code :"+e.toString()+")");
			}
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