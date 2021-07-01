package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080005_t1 extends HttpServlet{
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

				String str1  = reqGauce.getParameter("v_str1");		//지점구분
				String str2  = reqGauce.getParameter("v_str2");		//신청서번호

				GauceDataSet userSet  = reqGauce.getGauceDataSet("USER");
                
								
				String[] StrArrCN = new String[] {
					"CHK",      "BGTRQNO",  "FDCODE", "BGTYY",	"BGTMM", 	
					"BGTDIV",   "BGTDPT",   "ATCODE", "FSREFCD","SATCODE",
					"BGTRQDIV", "BGTRQAMT", "CNT",    "P_BGTMM","M_ATCODE",
					"M_FSREFCD","M_SATCODE","P_BGTDEPT", "P_BGTDIV"
				};

				int[] idx = new int[20];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();
				
				
				StringBuffer InsertSql11 = null;
				StringBuffer InsertSql12 = null;	
				StringBuffer InsertSql13 = null;	
				StringBuffer InsertSql14 = null;	
				StringBuffer InsertSql15 = null;	
				StringBuffer InsertSql21 = null;
				StringBuffer InsertSql22 = null;
				StringBuffer InsertSql23 = null;
				StringBuffer InsertSql24 = null;
				StringBuffer InsertSql31 = null;
				StringBuffer InsertSql32 = null;
				StringBuffer InsertSql33 = null;
				StringBuffer InsertSql34 = null;
				StringBuffer InsertSql35 = null;
				StringBuffer InsertSql36 = null;
				StringBuffer InsertSql37 = null;
				StringBuffer InsertSql41 = null;
				StringBuffer InsertSql42 = null;
				StringBuffer InsertSql43 = null;
				StringBuffer InsertSql44 = null;
				StringBuffer InsertSql45 = null;
				StringBuffer InsertSql46 = null;
				StringBuffer InsertSql47 = null;

				Statement stmt11 = null;
				Statement stmt12 = null;
				Statement stmt21 = null;
				Statement stmt31 = null;
				Statement stmt32 = null;
				Statement stmt41 = null;
				Statement stmt42 = null;				

				ResultSet rs11 = null;
				ResultSet rs12 = null;
				ResultSet rs21 = null;
				ResultSet rs31 = null;
				ResultSet rs32 = null;
				ResultSet rs41 = null;
				ResultSet rs42 = null;

				for (int j = 0; j < rows.length; j++){

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						String param9 = rows[j].getString(idx[9]);
						String param16 = rows[j].getString(idx[16]);
						if (param9==null || param9.equals(""))
						{
							param9="00";
						}
						if (param16==null || param16.equals(""))
						{
							param16="00";
						}

						if (rows[j].getString(idx[10]).equals("01")) { 
							/*******************************************************************
								추가예산신청 Detail 조회 - 신청테이블에 DATA 유무에 따라 등록/변경
							********************************************************************/
							StringBuffer sql11 = new StringBuffer();
							String a_tst = "";

							sql11.append( " SELECT										   \n"); 
							sql11.append( " RTRIM(A.FDCODE) FDCODE                	       \n"); 
							sql11.append( " FROM ACCOUNT.BGTDTL A		                   \n"); 
							sql11.append( " WHERE A.FDCODE ='"+rows[j].getString(idx[2])+"'\n");
							sql11.append( " AND A.BGTYY    ='"+rows[j].getString(idx[3])+"'\n");
							sql11.append( " AND A.BGTMM    ='"+rows[j].getString(idx[4])+"'\n");
							sql11.append( " AND A.BGTDIV   ='"+rows[j].getString(idx[5])+"'\n");
							sql11.append( " AND A.BGTDPT   ='"+rows[j].getString(idx[6])+"'\n");
							sql11.append( " AND A.ATCODE   ='"+rows[j].getString(idx[7])+"'\n");
							sql11.append( " AND A.FSREFCD  ='"+rows[j].getString(idx[8])+"'\n");
							sql11.append( " AND A.SATCODE  ='"+param9+"'\n");

							stmt11 = conn.createStatement();
							rs11 = stmt11.executeQuery(sql11.toString());

							while(rs11.next())	{
								a_tst	= rs11.getString(1);
							}

							if(!a_tst.equals("")){
								/*******************************************************************
									추가예산신청 Detail Update - 추가예산,실행예산 적용
								********************************************************************/
								InsertSql11 = new StringBuffer();
								InsertSql11.append( " UPDATE ACCOUNT.BGTDTL SET							\n");
								InsertSql11.append( "	ADDBGT =ADDBGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql11.append( "	REALBGT=REALBGT+"+rows[j].getString(idx[11])+",	\n");	
								InsertSql11.append( "	CHGAPPROV='Y'	                                \n");				               												
								InsertSql11.append( " WHERE FDCODE  ='"+rows[j].getString(idx[2])+"'	\n");
								InsertSql11.append( "	 AND BGTYY  ='"+rows[j].getString(idx[3])+"'	\n");
								InsertSql11.append( "	 AND BGTMM  ='"+rows[j].getString(idx[4])+"'	\n");
								InsertSql11.append( "	 AND BGTDIV ='"+rows[j].getString(idx[5])+"'	\n");
								InsertSql11.append( "	 AND BGTDPT ='"+rows[j].getString(idx[6])+"'	\n");
								InsertSql11.append( "	 AND ATCODE ='"+rows[j].getString(idx[7])+"'	\n");
								InsertSql11.append( "	 AND FSREFCD='"+rows[j].getString(idx[8])+"'	\n");
								InsertSql11.append( "	 AND SATCODE='"+param9+"'	\n");

								GauceStatement gsmt11 = conn.getGauceStatement(InsertSql11.toString());
								gsmt11.setGauceDataRow(rows[j]);
								gsmt11.executeUpdate();
								gsmt11.close();
								InsertSql11 = null;
							}else{
								/*******************************************************************
									추가예산신청 Detail Insert - 추가예산,실행예산 등록
								********************************************************************/
								InsertSql12 = new StringBuffer();
								InsertSql12.append( " INSERT INTO ACCOUNT.BGTDTL");
								InsertSql12.append( " (FDCODE,BGTYY,BGTMM,BGTDIV,BGTDPT,ATCODE,FSREFCD,SATCODE,BGTMACT,CHGAPPROV,ADDBGT,REALBGT)");
								InsertSql12.append( " VALUES(");
								InsertSql12.append( " '"+rows[j].getString(idx[2])+"',");
								InsertSql12.append( " '"+rows[j].getString(idx[3])+"',");
								InsertSql12.append( " '"+rows[j].getString(idx[4])+"',");
								InsertSql12.append( " '"+rows[j].getString(idx[5])+"',");
								InsertSql12.append( " '"+rows[j].getString(idx[6])+"',");
								InsertSql12.append( " '"+rows[j].getString(idx[7])+"',");
								InsertSql12.append( " '"+rows[j].getString(idx[8])+"',");
								InsertSql12.append( " '"+param9+"',");
								InsertSql12.append( " '01','Y', ");
								InsertSql12.append( " "+rows[j].getString(idx[11])+",");
								InsertSql12.append( " "+rows[j].getString(idx[11])+"");
								InsertSql12.append( " )");

								GauceStatement gsmt12 = conn.getGauceStatement(InsertSql12.toString());
								gsmt12.setGauceDataRow(rows[j]);
								gsmt12.executeUpdate();
								gsmt12.close();
								InsertSql12 = null;
							}

							/*******************************************************************
								추가예산신청 Master 조회 - 신청테이블에 DATA 유무에 따라 등록/변경
							********************************************************************/
							StringBuffer sql12 = new StringBuffer();
							String b_tst = "";

							sql12.append( " SELECT						\n"); 
							sql12.append( " RTRIM(A.ATCODE)  ATCODE, 	\n"); 
							sql12.append( " RTRIM(A.FSREFCD) FSREFCD, 	\n"); 
							sql12.append( " RTRIM(A.SATCODE) SATCODE 	\n"); 
							sql12.append( " FROM ACCOUNT.BGTMST A		\n"); 
							sql12.append( " LEFT JOIN ACCOUNT.BGTRQMST B ON A.FDCODE=B.FDCODE  AND A.BGTYY=B.BGTYY	\n"); 
							sql12.append( " AND A.BGTDIV=B.BGTDIV  AND A.BGTDPT=B.BGTDPT AND A.ATCODE=B.ATCODE		\n"); 
							sql12.append( " AND A.FSREFCD=B.FSREFCD AND A.SATCODE=B.SATCODE	\n"); 
							sql12.append( " WHERE A.FDCODE ='"+rows[j].getString(idx[2])+"'	\n");
							sql12.append( " AND A.BGTYY    ='"+rows[j].getString(idx[3])+"'	\n");
							sql12.append( " AND A.BGTDIV   ='"+rows[j].getString(idx[5])+"'	\n");
							sql12.append( " AND A.BGTDPT   ='"+rows[j].getString(idx[6])+"'	\n");
							sql12.append( " AND A.ATCODE   ='"+rows[j].getString(idx[7])+"'	\n");
							sql12.append( " AND A.FSREFCD  ='"+rows[j].getString(idx[8])+"'	\n");
							sql12.append( " AND A.SATCODE  ='"+param9+"'	\n");

							stmt12 = conn.createStatement();
							rs12 = stmt12.executeQuery(sql12.toString());

							while(rs12.next())	{
								b_tst	= rs12.getString(1);
							}

							if(!b_tst.equals("")){
								/*******************************************************************
									추가예산신청 Master  - 수정
								********************************************************************/
								InsertSql13 = new StringBuffer();
								InsertSql13.append( " UPDATE ACCOUNT.BGTMST SET	");
								InsertSql13.append( "  ADDBGT =ADDBGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql13.append( "  REALBGT=REALBGT+"+rows[j].getString(idx[11])+"	\n");
								InsertSql13.append( " WHERE FDCODE    ='"+rows[j].getString(idx[2])+"'	\n");
								InsertSql13.append( "    AND BGTYY    ='"+rows[j].getString(idx[3])+"'	\n");
								InsertSql13.append( "	 AND BGTDIV   ='"+rows[j].getString(idx[5])+"'	\n");
								InsertSql13.append( "	 AND BGTDPT   ='"+rows[j].getString(idx[6])+"'	\n");
								InsertSql13.append( "	 AND ATCODE   ='"+rows[j].getString(idx[7])+"'	\n");
								InsertSql13.append( "	 AND FSREFCD  ='"+rows[j].getString(idx[8])+"'	\n");
								InsertSql13.append( "	 AND SATCODE  ='"+param9+"'	\n");

								GauceStatement gsmt13 = conn.getGauceStatement(InsertSql13.toString());
								gsmt13.setGauceDataRow(rows[j]);
								gsmt13.executeUpdate();
								gsmt13.close();
								InsertSql13 = null;
							}else{
								/*******************************************************************
									추가예산신청 Master - 등록
								********************************************************************/
								InsertSql14 = new StringBuffer();
								InsertSql14.append( " INSERT INTO ACCOUNT.BGTMST");
								InsertSql14.append( " (FDCODE,BGTYY,BGTDIV,BGTDPT,ATCODE,FSREFCD,SATCODE,BGTMACT,ADDBGT,REALBGT,INITBGT)");
								InsertSql14.append( " VALUES(");
								InsertSql14.append( " '"+rows[j].getString(idx[2])+"',");
								InsertSql14.append( " '"+rows[j].getString(idx[3])+"',");
								InsertSql14.append( " '"+rows[j].getString(idx[5])+"',");
								InsertSql14.append( " '"+rows[j].getString(idx[6])+"',");
								InsertSql14.append( " '"+rows[j].getString(idx[7])+"',");
								InsertSql14.append( " '"+rows[j].getString(idx[8])+"',");
								InsertSql14.append( " '"+param9+"',");
								InsertSql14.append( " '01',");
								InsertSql14.append( " "+rows[j].getString(idx[11])+",");
								InsertSql14.append( " "+rows[j].getString(idx[11])+",");
								InsertSql14.append( " "+rows[j].getString(idx[11])+"");
								InsertSql14.append( " )");

								GauceStatement gsmt14 = conn.getGauceStatement(InsertSql14.toString());
								gsmt14.setGauceDataRow(rows[j]);
								gsmt14.executeUpdate();
								gsmt14.close();
								InsertSql14 = null;
							}

							/*******************************************************************
								추가예산신청 Master Update - 승인처리
							********************************************************************/
							InsertSql15 = new StringBuffer();
							InsertSql15.append( " UPDATE ACCOUNT.BGTRQDTL1 SET			 	    \n");
							InsertSql15.append( " BGTRQST='Y'									\n");
							InsertSql15.append( " WHERE FDCODE='"+rows[j].getString(idx[2])+"'	\n");
							InsertSql15.append( " AND BGTRQNO ='"+rows[j].getString(idx[1])+"'	\n");									
							InsertSql15.append( " AND BGTRQDIV='"+rows[j].getString(idx[10])+"'	\n");									

							GauceStatement gsmt15 = conn.getGauceStatement(InsertSql15.toString());
							gsmt15.setGauceDataRow(rows[j]);
							gsmt15.executeUpdate();
							gsmt15.close();
							InsertSql15 = null;

						}else if (rows[j].getString(idx[10]).equals("02")) { 
							/*******************************************************************
								기간전용예산 Detail 조회 - 신청테이블에 DATA 유무에 따라 등록/변경
							********************************************************************/
							StringBuffer sql21 = new StringBuffer();
							String t_tst = "";

							sql21.append( " SELECT									       \n"); 
							sql21.append( " RTRIM(A.FDCODE) FDCODE 	                       \n"); 
							sql21.append( " FROM ACCOUNT.BGTDTL A		                   \n"); 
							sql21.append( " WHERE A.FDCODE ='"+rows[j].getString(idx[2])+"'\n");
							sql21.append( " AND A.BGTYY    ='"+rows[j].getString(idx[3])+"'\n");
							sql21.append( " AND A.BGTMM    ='"+rows[j].getString(idx[13])+"'\n");
							sql21.append( " AND A.BGTDIV   ='"+rows[j].getString(idx[5])+"'\n");
							sql21.append( " AND A.BGTDPT   ='"+rows[j].getString(idx[6])+"'\n");
							sql21.append( " AND A.ATCODE   ='"+rows[j].getString(idx[7])+"'\n");
							sql21.append( " AND A.FSREFCD  ='"+rows[j].getString(idx[8])+"'\n");
							sql21.append( " AND A.SATCODE  ='"+param9+"'\n");

							stmt21 = conn.createStatement();
							rs21 = stmt21.executeQuery(sql21.toString());

							while(rs21.next())	{
								t_tst	= rs21.getString(1);
							}

							/*******************************************************************
								기간전용예산  Update - 배정월에 마이너스 반영
							********************************************************************/
							InsertSql21 = new StringBuffer();
							InsertSql21.append( " UPDATE ACCOUNT.BGTDTL SET							\n");
							InsertSql21.append( "	CHGTBGT=CHGTBGT-"+rows[j].getString(idx[11])+",	\n");
							InsertSql21.append( "	REALBGT=REALBGT-"+rows[j].getString(idx[11])+",	\n");
							InsertSql21.append( "	CHGAPPROV='Y'		                        																\n");
							InsertSql21.append( " WHERE FDCODE  ='"+rows[j].getString(idx[2])+"'	\n");
							InsertSql21.append( "	 AND BGTYY  ='"+rows[j].getString(idx[3])+"'	\n");
							InsertSql21.append( "	 AND BGTMM  ='"+rows[j].getString(idx[4])+"'	\n");
							InsertSql21.append( "	 AND BGTDIV ='"+rows[j].getString(idx[5])+"'	\n");
							InsertSql21.append( "	 AND BGTDPT ='"+rows[j].getString(idx[6])+"'	\n");
							InsertSql21.append( "	 AND ATCODE ='"+rows[j].getString(idx[7])+"'	\n");
							InsertSql21.append( "	 AND FSREFCD='"+rows[j].getString(idx[8])+"'	\n");
							InsertSql21.append( "	 AND SATCODE='"+param9+"'	\n");

							GauceStatement gsmt21 = conn.getGauceStatement(InsertSql21.toString());
							gsmt21.setGauceDataRow(rows[j]);
							gsmt21.executeUpdate();
							gsmt21.close();
							InsertSql21 = null;

							if(!t_tst.equals("")){
								/*******************************************************************
									기간전용예산 Update - 전용월에 추가 하여 준다
								********************************************************************/
								InsertSql22 = new StringBuffer();
								InsertSql22.append( " UPDATE ACCOUNT.BGTDTL SET							\n");
								InsertSql22.append( "	CHGTBGT=CHGTBGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql22.append( "	REALBGT=REALBGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql22.append( "	CHGAPPROV='Y'			 	                    															\n");
								InsertSql22.append( " WHERE FDCODE  ='"+rows[j].getString(idx[2])+"'	\n");
								InsertSql22.append( "	 AND BGTYY  ='"+rows[j].getString(idx[3])+"'	\n");
								InsertSql22.append( "	 AND BGTMM  ='"+rows[j].getString(idx[13])+"'	\n");
								InsertSql22.append( "	 AND BGTDIV ='"+rows[j].getString(idx[5])+"'	\n");
								InsertSql22.append( "	 AND BGTDPT ='"+rows[j].getString(idx[6])+"'	\n");
								InsertSql22.append( "	 AND ATCODE ='"+rows[j].getString(idx[7])+"'	\n");
								InsertSql22.append( "	 AND FSREFCD='"+rows[j].getString(idx[8])+"'	\n");
								InsertSql22.append( "	 AND SATCODE='"+param9+"'	\n");

								GauceStatement gsmt22 = conn.getGauceStatement(InsertSql22.toString());
								gsmt22.setGauceDataRow(rows[j]);
								gsmt22.executeUpdate();
								gsmt22.close();
								InsertSql22 = null;

							}else{
								/*******************************************************************
									기간전용예산 Update - 전용월에 추가 하여 준다-전용월에 없을때
								********************************************************************/
								InsertSql23 = new StringBuffer();
								InsertSql23.append( " INSERT INTO ACCOUNT.BGTDTL	");
								InsertSql23.append( "	(FDCODE,BGTYY,BGTMM,BGTDIV,BGTDPT,ATCODE,FSREFCD,SATCODE,BGTMACT,CHGAPPROV,CHGTBGT,REALBGT)	\n");
								InsertSql23.append( " VALUES(							\n");
								InsertSql23.append( " '"+rows[j].getString(idx[2])+"',");
								InsertSql23.append( " '"+rows[j].getString(idx[3])+"',");
								InsertSql23.append( " '"+rows[j].getString(idx[13])+"',");
								InsertSql23.append( " '"+rows[j].getString(idx[5])+"',");
								InsertSql23.append( " '"+rows[j].getString(idx[6])+"',");
								InsertSql23.append( " '"+rows[j].getString(idx[7])+"',");
								InsertSql23.append( " '"+rows[j].getString(idx[8])+"',");
								InsertSql23.append( " '"+param9+"',");
								InsertSql23.append( " '01','Y', ");
								InsertSql23.append( " "+rows[j].getString(idx[11])+",");
								InsertSql23.append( " "+rows[j].getString(idx[11])+"");
								InsertSql23.append( " )");

								GauceStatement gsmt23 = conn.getGauceStatement(InsertSql23.toString());
								gsmt23.setGauceDataRow(rows[j]);
								gsmt23.executeUpdate();
								gsmt23.close();
								InsertSql23 = null;
							}

							/*******************************************************************
								기간전용예산 - 승인처리
							********************************************************************/
							InsertSql24 = new StringBuffer();
							InsertSql24.append( " UPDATE ACCOUNT.BGTRQDTL1 SET					\n");
							InsertSql24.append( "	BGTRQST='Y'									\n");
							InsertSql24.append( " WHERE FDCODE='"+rows[j].getString(idx[2])+"'	\n");
							InsertSql24.append( " AND BGTRQNO ='"+rows[j].getString(idx[1])+"'	\n");
							InsertSql24.append( " AND BGTRQDIV='"+rows[j].getString(idx[10])+"'	\n");

							GauceStatement gsmt24 = conn.getGauceStatement(InsertSql24.toString());
							gsmt24.setGauceDataRow(rows[j]);
							gsmt24.executeUpdate();
							gsmt24.close();
							InsertSql24 = null;

						}else if (rows[j].getString(idx[10]).equals("03")) { 
							/*******************************************************************
								항목전용예산 Detail 조회 - 신청테이블에 DATA 유무에 따라 등록/변경
							********************************************************************/

							StringBuffer sql31 = new StringBuffer();
							String v_tst = "";

							sql31.append( " SELECT						  				   \n"); 
							sql31.append( " RTRIM(A.FDCODE) FDCODE 	                       \n"); 
							sql31.append( " FROM ACCOUNT.BGTDTL A		                   \n"); 
							sql31.append( " WHERE A.FDCODE ='"+rows[j].getString(idx[2])+"'\n");
							sql31.append( " AND A.BGTYY    ='"+rows[j].getString(idx[3])+"'\n");
							sql31.append( " AND A.BGTMM    ='"+rows[j].getString(idx[4])+"'\n");
							sql31.append( " AND A.BGTDIV   ='"+rows[j].getString(idx[5])+"'\n");
							sql31.append( " AND A.BGTDPT   ='"+rows[j].getString(idx[6])+"'\n");
							sql31.append( " AND A.ATCODE   ='"+rows[j].getString(idx[14])+"'\n");
							sql31.append( " AND A.FSREFCD  ='"+rows[j].getString(idx[15])+"'\n");
							sql31.append( " AND A.SATCODE  ='"+param16+"'\n");

							stmt31 = conn.createStatement();
							rs31 = stmt31.executeQuery(sql31.toString());

							while(rs31.next())	{
								v_tst	= rs31.getString(1);
							}

							/*******************************************************************
								항목전용예산 Detail Update - 배정월에 마이너스 적용
							********************************************************************/
							InsertSql31 = new StringBuffer();
							InsertSql31.append( " UPDATE ACCOUNT.BGTDTL SET							\n");
							InsertSql31.append( "	CHGABGT=CHGABGT-"+rows[j].getString(idx[11])+",	\n");
							InsertSql31.append( "	REALBGT=REALBGT-"+rows[j].getString(idx[11])+",	\n");
							InsertSql31.append( "	CHGAPPROV='Y'									\n");
							InsertSql31.append( " WHERE FDCODE  ='"+rows[j].getString(idx[2])+"'	\n");
							InsertSql31.append( "	 AND BGTYY  ='"+rows[j].getString(idx[3])+"'	\n");
							InsertSql31.append( "	 AND BGTMM  ='"+rows[j].getString(idx[4])+"'	\n");
							InsertSql31.append( "	 AND BGTDIV ='"+rows[j].getString(idx[5])+"'	\n");
							InsertSql31.append( "	 AND BGTDPT ='"+rows[j].getString(idx[6])+"'	\n");
							InsertSql31.append( "	 AND ATCODE ='"+rows[j].getString(idx[7])+"'	\n");
							InsertSql31.append( "	 AND FSREFCD='"+rows[j].getString(idx[8])+"'	\n");
							InsertSql31.append( "	 AND SATCODE='"+param9+"'	\n");								

							GauceStatement gsmt31 = conn.getGauceStatement(InsertSql31.toString());
							gsmt31.setGauceDataRow(rows[j]);
							gsmt31.executeUpdate();
							gsmt31.close();
							InsertSql31 = null;

							if(!v_tst.equals("")){								

								/*******************************************************************
									항목전용예산 Detail Update - 전용월에 추가 하여 준다
								********************************************************************/
								InsertSql32 = new StringBuffer();
								InsertSql32.append( " UPDATE ACCOUNT.BGTDTL SET							\n");
								InsertSql32.append( "	CHGABGT=CHGABGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql32.append( "	REALBGT=REALBGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql32.append( "   CHGAPPROV='Y'									\n");
								InsertSql32.append( " WHERE FDCODE  ='"+rows[j].getString(idx[2])+"'	\n");
								InsertSql32.append( "	 AND BGTYY  ='"+rows[j].getString(idx[3])+"'	\n");
								InsertSql32.append( "	 AND BGTMM  ='"+rows[j].getString(idx[4])+"'	\n");
								InsertSql32.append( "	 AND BGTDIV ='"+rows[j].getString(idx[5])+"'	\n");
								InsertSql32.append( "	 AND BGTDPT ='"+rows[j].getString(idx[6])+"'	\n");
								InsertSql32.append( "	 AND ATCODE ='"+rows[j].getString(idx[14])+"'	\n");
								InsertSql32.append( "	 AND FSREFCD='"+rows[j].getString(idx[15])+"'	\n");
								InsertSql32.append( "	 AND SATCODE='"+param16+"'	\n");								

								GauceStatement gsmt32 = conn.getGauceStatement(InsertSql32.toString());
								gsmt32.setGauceDataRow(rows[j]);
								gsmt32.executeUpdate();
								gsmt32.close();
								InsertSql32 = null;

							}else{
								/*******************************************************************
									항목전용예산 Detail Insert - 전용월이 없으면 레코드를 추가 한다
								********************************************************************/
								InsertSql33 = new StringBuffer();
								InsertSql33.append( " INSERT INTO ACCOUNT.BGTDTL	  ");
								InsertSql33.append( " (FDCODE,BGTYY,BGTMM,BGTDIV,BGTDPT,ATCODE,FSREFCD,SATCODE,BGTMACT,CHGAPPROV,CHGABGT,REALBGT)	\n");
								InsertSql33.append( " VALUES(						\n");
								InsertSql33.append( " '"+rows[j].getString(idx[2])+"',");
								InsertSql33.append( " '"+rows[j].getString(idx[3])+"',");
								InsertSql33.append( " '"+rows[j].getString(idx[4])+"',");
								InsertSql33.append( " '"+rows[j].getString(idx[5])+"',");
								InsertSql33.append( " '"+rows[j].getString(idx[6])+"',");
								InsertSql33.append( " '"+rows[j].getString(idx[14])+"',");
								InsertSql33.append( " '"+rows[j].getString(idx[15])+"',");
								InsertSql33.append( " '"+param16+"',");
								InsertSql33.append( " '01','Y', ");
								InsertSql33.append( " "+rows[j].getString(idx[11])+",");
								InsertSql33.append( " "+rows[j].getString(idx[11])+"");
								InsertSql33.append( " )");						

								GauceStatement gsmt33 = conn.getGauceStatement(InsertSql33.toString());
								gsmt33.setGauceDataRow(rows[j]);
								gsmt33.executeUpdate();
								gsmt33.close();
								InsertSql33 = null;
							}

							/*******************************************************************
								항목전용예산 Master 조회 - 신청테이블에 DATA 유무에 따라 등록/변경
							********************************************************************/
							StringBuffer sql32 = new StringBuffer();
							String m_tst = "";

							sql32.append( " SELECT											                        \n"); 
							sql32.append( " RTRIM(A.ATCODE)  ATCODE, 	                                            \n"); 
							sql32.append( " RTRIM(A.FSREFCD) FSREFCD, 	                                            \n"); 
							sql32.append( " RTRIM(A.SATCODE) SATCODE 	                                            \n"); 
							sql32.append( " FROM ACCOUNT.BGTMST A			                                        \n"); 
							sql32.append( " LEFT JOIN ACCOUNT.BGTRQMST B ON A.FDCODE=B.FDCODE  AND A.BGTYY=B.BGTYY	\n"); 
							sql32.append( " AND A.BGTDIV=B.BGTDIV  AND A.BGTDPT=B.BGTDPT AND A.ATCODE=B.ATCODE		\n"); 
							sql32.append( " AND A.FSREFCD=B.FSREFCD AND A.SATCODE=B.SATCODE	                        \n"); 
							sql32.append( " WHERE A.FDCODE ='"+rows[j].getString(idx[2])+"'	  \n");
							sql32.append( " AND A.BGTYY    ='"+rows[j].getString(idx[3])+"'	  \n");
							sql32.append( " AND A.BGTDIV   ='"+rows[j].getString(idx[5])+"'	  \n");
							sql32.append( " AND A.BGTDPT   ='"+rows[j].getString(idx[6])+"'	  \n");
							sql32.append( " AND A.ATCODE   ='"+rows[j].getString(idx[14])+"'  \n");
							sql32.append( " AND A.FSREFCD  ='"+rows[j].getString(idx[15])+"'  \n");
							sql32.append( " AND A.SATCODE  ='"+param16+"'  \n");

							stmt32 = conn.createStatement();
							rs32 = stmt32.executeQuery(sql32.toString());

							while(rs32.next())	{
								m_tst	= rs32.getString(1);
							}

							/*******************************************************************
							  항목전용예산 Master Insert - 기준월에 마이너스 적용
							********************************************************************/
							InsertSql34 = new StringBuffer();
							InsertSql34.append( " UPDATE ACCOUNT.BGTMST SET	");
							InsertSql34.append( "	CHGABGT=CHGABGT-"+rows[j].getString(idx[11])+",	\n");
							InsertSql34.append( "	REALBGT=REALBGT-"+rows[j].getString(idx[11])+" 	\n");
							InsertSql34.append( " WHERE  FDCODE   ='"+rows[j].getString(idx[2])+"'	\n");
							InsertSql34.append( "	 AND BGTYY    ='"+rows[j].getString(idx[3])+"'	\n");
							InsertSql34.append( "	 AND BGTDIV   ='"+rows[j].getString(idx[5])+"'	\n");
							InsertSql34.append( "	 AND BGTDPT   ='"+rows[j].getString(idx[6])+"'	\n");
							InsertSql34.append( "	 AND ATCODE   ='"+rows[j].getString(idx[7])+"'	\n");
							InsertSql34.append( "	 AND FSREFCD  ='"+rows[j].getString(idx[8])+"'	\n");
							InsertSql34.append( "	 AND SATCODE  ='"+param9+"'	\n");

							GauceStatement gsmt34 = conn.getGauceStatement(InsertSql34.toString());
							gsmt34.setGauceDataRow(rows[j]);
							gsmt34.executeUpdate();
							gsmt34.close();
							InsertSql34 = null;

							if(!m_tst.equals("")){
								/*******************************************************************
									항목전용예산 Master Insert - 전용월에 변경 적용
								********************************************************************/
								InsertSql35 = new StringBuffer();
								InsertSql35.append( " UPDATE ACCOUNT.BGTMST SET	");
								InsertSql35.append( "    CHGABGT=CHGABGT+"+rows[j].getString(idx[11])+",\n");//항목전용
								InsertSql35.append( "    REALBGT=REALBGT+"+rows[j].getString(idx[11])+"	\n");//실행예산
								InsertSql35.append( " WHERE FDCODE    ='"+rows[j].getString(idx[2])+"'	\n");
								InsertSql35.append( "	 AND BGTYY    ='"+rows[j].getString(idx[3])+"'	\n");
								InsertSql35.append( "	 AND BGTDIV   ='"+rows[j].getString(idx[5])+"'	\n");
								InsertSql35.append( "	 AND BGTDPT   ='"+rows[j].getString(idx[6])+"'	\n");
								InsertSql35.append( "	 AND ATCODE   ='"+rows[j].getString(idx[14])+"'	\n");
								InsertSql35.append( "	 AND FSREFCD  ='"+rows[j].getString(idx[15])+"'	\n");
								InsertSql35.append( "	 AND SATCODE  ='"+param16+"'	\n");

								GauceStatement gsmt35 = conn.getGauceStatement(InsertSql35.toString());
								gsmt35.setGauceDataRow(rows[j]);
								gsmt35.executeUpdate();
								gsmt35.close();
								InsertSql35 = null;
							 }else{
								/*******************************************************************
									항목전용예산 Master Insert - 등록 - 전용월에 레코드추가
								********************************************************************/
								InsertSql36 = new StringBuffer();
								InsertSql36.append( " INSERT INTO ACCOUNT.BGTMST");
								InsertSql36.append( " (FDCODE,BGTYY,BGTDIV,BGTDPT,ATCODE,FSREFCD,SATCODE,BGTMACT,CHGABGT,REALBGT)");
								InsertSql36.append( " VALUES(");
								InsertSql36.append( " '"+rows[j].getString(idx[2])+"',");
								InsertSql36.append( " '"+rows[j].getString(idx[3])+"',");
								InsertSql36.append( " '"+rows[j].getString(idx[5])+"',");
								InsertSql36.append( " '"+rows[j].getString(idx[6])+"',");
								InsertSql36.append( " '"+rows[j].getString(idx[14])+"',");
								InsertSql36.append( " '"+rows[j].getString(idx[15])+"',");
								InsertSql36.append( " '"+param16+"',");
								InsertSql36.append( " '01',");
								InsertSql36.append( " "+rows[j].getString(idx[11])+",");
								InsertSql36.append( " "+rows[j].getString(idx[11])+"");
								InsertSql36.append( " )");

								GauceStatement gsmt36 = conn.getGauceStatement(InsertSql36.toString());
								gsmt36.setGauceDataRow(rows[j]);
								gsmt36.executeUpdate();
								gsmt36.close();
								InsertSql36 = null;
							}

						
							/*******************************************************************
								항목전용예산 - 승인처리
							********************************************************************/
							InsertSql37 = new StringBuffer();
							InsertSql37.append( " UPDATE ACCOUNT.BGTRQDTL1 SET					\n");
							InsertSql37.append( "	BGTRQST='Y'									\n");
							InsertSql37.append( " WHERE FDCODE='"+rows[j].getString(idx[2])+"'	\n");
							InsertSql37.append( " AND BGTRQNO ='"+rows[j].getString(idx[1])+"'	\n");
							InsertSql37.append( " AND BGTRQDIV='"+rows[j].getString(idx[10])+"'	\n");

							GauceStatement gsmt37 = conn.getGauceStatement(InsertSql37.toString());
							gsmt37.setGauceDataRow(rows[j]);
							gsmt37.executeUpdate();
							gsmt37.close();
							InsertSql37 = null;

						}else if (rows[j].getString(idx[10]).equals("04")) { 
							/*******************************************************************
								부서전용 Detail 조회 - 신청테이블에 DATA 유무에 따라 등록/변경
							********************************************************************/
							StringBuffer sql41 = new StringBuffer();
							String s_tst = "";

							sql41.append( " SELECT							    		    \n"); 
							sql41.append( " RTRIM(A.FDCODE) FDCODE 	                        \n"); 
							sql41.append( " FROM ACCOUNT.BGTDTL A		                    \n"); 
							sql41.append( " WHERE A.FDCODE ='"+rows[j].getString(idx[2])+"' \n");
							sql41.append( " AND A.BGTYY    ='"+rows[j].getString(idx[3])+"' \n");
							sql41.append( " AND A.BGTMM    ='"+rows[j].getString(idx[4])+"' \n");
							sql41.append( " AND A.BGTDIV   ='"+rows[j].getString(idx[18])+"' \n");
							sql41.append( " AND A.BGTDPT   ='"+rows[j].getString(idx[17])+"' \n");
							sql41.append( " AND A.ATCODE   ='"+rows[j].getString(idx[7])+"' \n");
							sql41.append( " AND A.FSREFCD  ='"+rows[j].getString(idx[8])+"' \n");
							sql41.append( " AND A.SATCODE  ='"+param9+"' \n");

							stmt41 = conn.createStatement();
							rs41 = stmt41.executeQuery(sql41.toString());

							while(rs41.next())	{
								s_tst	= rs41.getString(1);
							}

							/*******************************************************************
								부서전용 Detail Update - 부서전용 마이너스 배정월에 적용
							********************************************************************/
							InsertSql41 = new StringBuffer();
							InsertSql41.append( " UPDATE ACCOUNT.BGTDTL SET								\n");
							InsertSql41.append( "		DEPTBGT=DEPTBGT-"+rows[j].getString(idx[11])+",	\n");
							InsertSql41.append( "		REALBGT=REALBGT-"+rows[j].getString(idx[11])+",	\n");
							InsertSql41.append( "       CHGAPPROV='Y'									\n");
							InsertSql41.append( " WHERE FDCODE  ='"+rows[j].getString(idx[2])+"'		\n");
							InsertSql41.append( "	 AND BGTYY  ='"+rows[j].getString(idx[3])+"'		\n");
							InsertSql41.append( "	 AND BGTMM  ='"+rows[j].getString(idx[4])+"'		\n");
							InsertSql41.append( "	 AND BGTDIV ='"+rows[j].getString(idx[5])+"'		\n");
							InsertSql41.append( "	 AND BGTDPT ='"+rows[j].getString(idx[6])+"'		\n");
							InsertSql41.append( "	 AND ATCODE ='"+rows[j].getString(idx[7])+"'		\n");
							InsertSql41.append( "	 AND FSREFCD='"+rows[j].getString(idx[8])+"'		\n");
							InsertSql41.append( "	 AND SATCODE='"+param9+"'		\n");								

							GauceStatement gsmt41 = conn.getGauceStatement(InsertSql41.toString());
							gsmt41.setGauceDataRow(rows[j]);
							gsmt41.executeUpdate();
							gsmt41.close();
							InsertSql41 = null;

							if(!s_tst.equals("")){
								/*******************************************************************
									부서전용 Detail Update - 부서전용 전용월에 추가 하여 준다
								********************************************************************/
								InsertSql42 = new StringBuffer();
								InsertSql42.append( " UPDATE ACCOUNT.BGTDTL SET								\n");
								InsertSql42.append( "		DEPTBGT=DEPTBGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql42.append( "		REALBGT=REALBGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql42.append( "		CHGAPPROV='Y'									\n");
								InsertSql42.append( " WHERE FDCODE='"+rows[j].getString(idx[2])+"'			\n");
								InsertSql42.append( "	 AND BGTYY  ='"+rows[j].getString(idx[3])+"'		\n");
								InsertSql42.append( "	 AND BGTMM  ='"+rows[j].getString(idx[4])+"'		\n");
								InsertSql42.append( "	 AND BGTDIV ='"+rows[j].getString(idx[18])+"'		\n");
								InsertSql42.append( "	 AND BGTDPT ='"+rows[j].getString(idx[17])+"'		\n");
								InsertSql42.append( "	 AND ATCODE ='"+rows[j].getString(idx[7])+"'		\n");
								InsertSql42.append( "	 AND FSREFCD='"+rows[j].getString(idx[8])+"'		\n");
								InsertSql42.append( "	 AND SATCODE='"+param9+"'		\n");								

								GauceStatement gsmt42 = conn.getGauceStatement(InsertSql42.toString());
								gsmt42.setGauceDataRow(rows[j]);
								gsmt42.executeUpdate();
								gsmt42.close();
								InsertSql42 = null;

							}else{
								/*******************************************************************
									부서전용 Detail Insert - 부서전용 없을때 전용월 레코드 추가
								********************************************************************/
								InsertSql43 = new StringBuffer();
								InsertSql43.append( " INSERT INTO ACCOUNT.BGTDTL	  ");
								InsertSql43.append( " (FDCODE,BGTYY,BGTMM,BGTDIV,BGTDPT,ATCODE,FSREFCD,SATCODE,BGTMACT,CHGAPPROV,DEPTBGT,REALBGT)	\n");
								InsertSql43.append( " VALUES(						\n");
								InsertSql43.append( " '"+rows[j].getString(idx[2])+"',");
								InsertSql43.append( " '"+rows[j].getString(idx[3])+"',");
								InsertSql43.append( " '"+rows[j].getString(idx[4])+"',");
								InsertSql43.append( " '"+rows[j].getString(idx[18])+"',");
								InsertSql43.append( " '"+rows[j].getString(idx[17])+"',");
								InsertSql43.append( " '"+rows[j].getString(idx[7])+"',");
								InsertSql43.append( " '"+rows[j].getString(idx[8])+"',");
								InsertSql43.append( " '"+param9+"',");
								InsertSql43.append( " '01','Y', ");
								InsertSql43.append( " "+rows[j].getString(idx[11])+",");
								InsertSql43.append( " "+rows[j].getString(idx[11])+"");
								InsertSql43.append( " )");		

								GauceStatement gsmt43 = conn.getGauceStatement(InsertSql43.toString());
								gsmt43.setGauceDataRow(rows[j]);
								gsmt43.executeUpdate();
								gsmt43.close();
								InsertSql43 = null;
							}

							/*******************************************************************
								부서전용 Master 조회 - 신청테이블에 DATA 유무에 따라 등록/변경
							********************************************************************/
							StringBuffer sql42 = new StringBuffer();
							String j_tst = "";

							sql42.append( " SELECT														\n"); 
							sql42.append( " RTRIM(A.ATCODE)  ATCODE, 		                	\n"); 
							sql42.append( " RTRIM(A.FSREFCD) FSREFCD, 	                    \n"); 
							sql42.append( " RTRIM(A.SATCODE) SATCODE 		                \n"); 
							sql42.append( " FROM ACCOUNT.BGTMST A				            \n"); 
							sql42.append( " LEFT JOIN ACCOUNT.BGTRQMST B ON A.FDCODE=B.FDCODE  AND A.BGTYY=B.BGTYY	\n"); 
							sql42.append( " AND A.BGTDIV=B.BGTDIV  AND A.BGTDPT=B.BGTDPT AND A.ATCODE=B.ATCODE		\n"); 
							sql42.append( " AND A.FSREFCD=B.FSREFCD AND A.SATCODE=B.SATCODE	\n"); 
							sql42.append( " WHERE A.FDCODE ='"+rows[j].getString(idx[2])+"'	\n");
							sql42.append( " AND A.BGTYY    ='"+rows[j].getString(idx[3])+"'	\n");
							sql42.append( " AND A.BGTDIV   ='"+rows[j].getString(idx[18])+"'	\n");
							sql42.append( " AND A.BGTDPT   ='"+rows[j].getString(idx[17])+"'\n");
							sql42.append( " AND A.ATCODE   ='"+rows[j].getString(idx[7])+"'	\n");
							sql42.append( " AND A.FSREFCD  ='"+rows[j].getString(idx[8])+"'	\n");
							sql42.append( " AND A.SATCODE  ='"+param9+"'						\n");

							stmt42 = conn.createStatement();
							rs42 = stmt42.executeQuery(sql42.toString());

							while(rs42.next())	{
								j_tst	= rs42.getString(1);
							}

							/*******************************************************************
								부서전용 Master Insert - 부서전용 등록-배정월에 마이너스 적용
							********************************************************************/
							InsertSql44 = new StringBuffer();
							InsertSql44.append( " UPDATE ACCOUNT.BGTMST SET	");
							InsertSql44.append( "	DEPTBGT=DEPTBGT-"+rows[j].getString(idx[11])+",	\n");
							InsertSql44.append( "	REALBGT=REALBGT-"+rows[j].getString(idx[11])+"	\n");
							InsertSql44.append( " WHERE FDCODE   ='"+rows[j].getString(idx[2])+"'	\n");
							InsertSql44.append( "	 AND BGTYY   ='"+rows[j].getString(idx[3])+"'	\n");
							InsertSql44.append( "	 AND BGTDIV  ='"+rows[j].getString(idx[5])+"'	\n");
							InsertSql44.append( "	 AND BGTDPT  ='"+rows[j].getString(idx[6])+"'   \n");
							InsertSql44.append( "	 AND ATCODE  ='"+rows[j].getString(idx[7])+"'	\n");
							InsertSql44.append( "	 AND FSREFCD ='"+rows[j].getString(idx[8])+"'	\n");
							InsertSql44.append( "	 AND SATCODE ='"+param9+"'	\n");

							GauceStatement gsmt44 = conn.getGauceStatement(InsertSql44.toString());
							gsmt44.setGauceDataRow(rows[j]);
							gsmt44.executeUpdate();
							gsmt44.close();
							InsertSql44 = null;

							if(!j_tst.equals("")){
								/*******************************************************************
									부서전용 Master Insert - 부서전용 등록-피전용
								********************************************************************/
								InsertSql45 = new StringBuffer();
								InsertSql45.append( " UPDATE ACCOUNT.BGTMST SET	");
								InsertSql45.append( "	DEPTBGT=DEPTBGT+"+rows[j].getString(idx[11])+",	\n");
								InsertSql45.append( "	REALBGT=REALBGT+"+rows[j].getString(idx[11])+"	\n");
								InsertSql45.append( " WHERE FDCODE   ='"+rows[j].getString(idx[2])+"'	\n");
								InsertSql45.append( "	 AND BGTYY   ='"+rows[j].getString(idx[3])+"'	\n");
								InsertSql45.append( "	 AND BGTDIV  ='"+rows[j].getString(idx[18])+"'	\n");
								InsertSql45.append( "	 AND BGTDPT  ='"+rows[j].getString(idx[17])+"'	\n");
								InsertSql45.append( "	 AND ATCODE  ='"+rows[j].getString(idx[7])+"'	\n");
								InsertSql45.append( "	 AND FSREFCD ='"+rows[j].getString(idx[8])+"'	\n");
								InsertSql45.append( "	 AND SATCODE ='"+param9+"'	\n");

								GauceStatement gsmt45 = conn.getGauceStatement(InsertSql45.toString());
								gsmt45.setGauceDataRow(rows[j]);
								gsmt45.executeUpdate();
								gsmt45.close();
								InsertSql45 = null;
								
							}else{
								/*******************************************************************
									부서전용 Master Insert - 부서전용 등록
								********************************************************************/
								InsertSql46 = new StringBuffer();
								InsertSql46.append( " INSERT INTO ACCOUNT.BGTMST"  );
								InsertSql46.append( " (FDCODE,BGTYY,BGTDIV,BGTDPT,ATCODE,FSREFCD,SATCODE,BGTMACT,DEPTBGT,REALBGT)");
								InsertSql46.append( " VALUES(");
								InsertSql46.append( " '"+rows[j].getString(idx[2])+"',");
								InsertSql46.append( " '"+rows[j].getString(idx[3])+"',");
								InsertSql46.append( " '"+rows[j].getString(idx[18])+"',");
								InsertSql46.append( " '"+rows[j].getString(idx[17])+"',");
								InsertSql46.append( " '"+rows[j].getString(idx[7])+"',");
								InsertSql46.append( " '"+rows[j].getString(idx[8])+"',");
								InsertSql46.append( " '"+param9+"',");
								InsertSql46.append( " '01',");
								InsertSql46.append( " "+rows[j].getString(idx[11])+",");
								InsertSql46.append( " "+rows[j].getString(idx[11])+"");
								InsertSql46.append( " )");

								GauceStatement gsmt46 = conn.getGauceStatement(InsertSql46.toString());
								gsmt46.setGauceDataRow(rows[j]);
								gsmt46.executeUpdate();
								gsmt46.close();
								InsertSql46 = null;
							}
							
							/*******************************************************************
								부서전용  - 승인처리
							********************************************************************/
							InsertSql47 = new StringBuffer();
							InsertSql47.append( " UPDATE ACCOUNT.BGTRQDTL1 SET						\n");
							InsertSql47.append( "	BGTRQST='Y'										\n");
							InsertSql47.append( " WHERE FDCODE='"+rows[j].getString(idx[2])+"'		\n");
							InsertSql47.append( " AND BGTRQNO ='"+rows[j].getString(idx[1])+"'		\n");
							InsertSql47.append( " AND BGTRQDIV='"+rows[j].getString(idx[10])+"'  	\n");

							GauceStatement gsmt47 = conn.getGauceStatement(InsertSql47.toString());
							gsmt47.setGauceDataRow(rows[j]);
							gsmt47.executeUpdate();
							gsmt47.close();
							InsertSql47 = null;
						}

					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
					}
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
					}
				}
			}
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
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		}
		finally {
			if (conn != null) {	try {	conn.close(true);	}	catch (Exception e) {}}
			loader.restoreService(service);
	 	}
	}
}