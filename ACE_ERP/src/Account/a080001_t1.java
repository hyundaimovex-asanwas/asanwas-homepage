package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class a080001_t1 extends HttpServlet{
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

				String str1  = reqGauce.getParameter("v_str1");		//�����ڵ�    
				String str2  = reqGauce.getParameter("v_str2");		//����⵵              
				String str3  = reqGauce.getParameter("v_str3");		//�����                
				String str4  = reqGauce.getParameter("v_str4");		//���꺻��              
				String str5  = reqGauce.getParameter("v_str5");		//����μ�              
				String str6  = reqGauce.getParameter("v_str6");		//��������              
				String str7  = reqGauce.getParameter("v_str7");		//�����׸��ڵ�
				String str8  = reqGauce.getParameter("v_str8");		//����                  
				String str9  = reqGauce.getParameter("v_str9");		//����з�          
				String str10 = reqGauce.getParameter("v_str10");	//����Ÿ��
				String str11 = reqGauce.getParameter("v_str11");	//����Ÿ��
				String str12 = reqGauce.getParameter("v_str12");	//���⵵ 

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				if (str1==null)  str1	= "";
				if (str2==null)  str2	= "";
				if (str3==null)  str3	= "";
				if (str4==null)  str4	= "";
				if (str5==null)  str5	= "";
				if (str6==null)  str6	= "";
				if (str7==null)  str7	= "";
				if (str8==null)  str8	= "";
				if (str9==null)  str9	= "";
				if (str10==null) str10 = "";
				if (str11==null) str11 = "";
				if (str12==null) str12 = "";

				String[] StrArrCN = new String[] {
					"FDCODE","BGTYY","BGTMM","BGTDIV","BGTDPT",
					"ATCODE","FSREFCD","SATCODE","BGTTYPE","BGTMACT",
					"INITMAN","INITBGT","CHGMAN","CHGBGT","BASICBGT",
					"ADDBGT","CHGABGT","CHGTBGT","REALBGT","RESULTS",
					"BRESULTS","APPROVAL","CHGAPPROV","REMARK"
				};	

				int[] idx = new int[24];
				for(int i=0;i<StrArrCN.length;i++) {
					idx[i] = userSet.indexOfColumn(StrArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql  = null;	//����Master
				StringBuffer UpdateSql  = null;
				StringBuffer UpdateSq5  = null;	//����Master-����
				StringBuffer InsertSql2 = null;	//����Detail
				StringBuffer InsertSql3 = null;	//����Detail
				StringBuffer UpdateSql2 = null;
				StringBuffer UpdateSql3 = null;
				StringBuffer DeleteSql  = null;

				//insert Master
				Statement stmt = null;
				ResultSet rs = null;

				//insert Master -����
				Statement stmt5 = null;
				ResultSet rs5 = null;

				//Update Master
				Statement stmt2 = null;
				ResultSet rs2 = null;

				//insert Detail
				Statement stmt3 = null;
				ResultSet rs3 = null;

				//Delete Detail
				Statement stmt4 = null;
				ResultSet rs4 = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						/*******************************************************************
								���� Master InSert 
						********************************************************************/
						StringBuffer sql = new StringBuffer();
						String check = "";
						int initbgt = rows[j].getInt(idx[11]);
						int addbgt  = rows[j].getInt(idx[15]);
						int chgabgt = rows[j].getInt(idx[16]);
						int realbgt = rows[j].getInt(idx[18]);
						int results = rows[j].getInt(idx[19]);

						sql.append( " SELECT													\n"); 
						sql.append( " RTRIM(A.FDCODE)  FDCODE,				/*�����ڵ�*/			\n"); 
						sql.append( " RTRIM(A.BGTYY)   BGTYY,				/*����⵵*/		    \n"); 
						sql.append( " RTRIM(A.BGTDIV)  BGTDIV,				/*���꺻��*/			\n"); 
						sql.append( " RTRIM(A.BGTDPT)  BGTDPT,				/*����μ�*/			\n"); 
						sql.append( " RTRIM(A.ATCODE)  ATCODE,				/*�����ڵ�*/			\n"); 
						sql.append( " RTRIM(A.FSREFCD) FSREFCD,				/*�����׸��ڵ�*/		\n"); 
						sql.append( " RTRIM(A.SATCODE) SATCODE,				/*��    ��*/			\n"); 
						sql.append( " COALESCE(A.INITBGT,0) INITBGT,        /*���ʿ���*/			\n"); 
						sql.append( " COALESCE(A.ADDBGT,0) ADDBGT,		    /*�߰�����*/			\n"); 
						sql.append( " COALESCE(A.CHGABGT,0) CHGABGT,        /*�׸�����*/			\n"); 
						sql.append( " COALESCE(A.REALBGT,0) REALBGT,        /*���࿹��*/			\n"); 
						sql.append( " COALESCE(A.RESULTS,0) RESULTS         /*��    ��*/			\n"); 
						sql.append( " FROM ACCOUNT.BGTMST	A									\n"); 
						sql.append( " WHERE A.FDCODE='"+str1+"' AND A.BGTYY='"+str2+"'			\n");
						sql.append( " AND A.BGTDIV='"+str4+"'   AND A.BGTDPT='"+str5+"'			\n"); 
						sql.append( " AND A.ATCODE='"+str6+"'   AND A.FSREFCD='"+str7+"'		\n");
						sql.append( " AND A.SATCODE='"+str8+"'									\n");
						
						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while(rs.next())	{
							
							check   = rs.getString(1);
							initbgt = rs.getInt(8);
							addbgt  = rs.getInt(9);
							chgabgt = rs.getInt(10);
							realbgt = rs.getInt(11);
							results = rs.getInt(12);
						}
						

						if (!check.equals("")) {			
							check = "Y";		//����(�����ڵ尡 ������)
						}else if(check.equals("")) {	
							check = "N";		//����
							initbgt = 0;	addbgt  = 0;	chgabgt = 0;	realbgt = 0;	results = 0;
						}


						if (check.equals("N"))	{	//New Create
							
							InsertSql = new StringBuffer();
							InsertSql.append( " INSERT INTO ACCOUNT.BGTMST (																		");
							InsertSql.append( " FDCODE,BGTYY,BGTDIV,BGTDPT,ATCODE,															");
							InsertSql.append( " FSREFCD,SATCODE,BGTGBCD,BGTTYPE,BGTMACT,												");
							InsertSql.append( " BINITBGT,BADDBGT,BCHGABGT,BREALBGT,BYRESULTS,										");
							InsertSql.append( " INITBGT,ADDBGT,CHGABGT,REALBGT,RESULTS,BRESULTS									");
							InsertSql.append( " ) VALUES(																												");
							InsertSql.append( " '"+str1+"','"+str2+"','"+str4+"','"+str5+"', '"+str6+"',				");
							InsertSql.append( " '"+str7+"','"+str8+"','"+str9+"','"+str10+"','"+str11+"',				");
							InsertSql.append( "       0,         0,         0,          0,          0,					");
							InsertSql.append( " "+rows[j].getInt(idx[11])+",0,0,0,0,0	");
							InsertSql.append( " )																																");

							GauceStatement gsmt = conn.getGauceStatement(InsertSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.executeUpdate();
							gsmt.close();
						}else if(check.equals("Y")) {	//���� Master Update
														
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.BGTMST SET											\n");
							UpdateSql.append( " BGTGBCD='"+str9+"',BGTTYPE='"+str10+"',BGTMACT='"+str11+"',			\n");
							//UpdateSql.append( " INITBGT=DECIMAL("+initbgt+")+DECIMAL("+rows[j].getInt(idx[11])+"),	\n");
							UpdateSql.append( " INITBGT=TO_NUMBER("+initbgt+")+TO_NUMBER("+rows[j].getInt(idx[11])+"),	\n");
							UpdateSql.append( " REALBGT="+realbgt+"+"+rows[j].getInt(idx[18])+"						\n");
							UpdateSql.append( " WHERE FDCODE='"+str1+"' AND BGTYY='"+str2+"' AND BGTDIV='"+str4+"'	\n");
							UpdateSql.append( " AND BGTDPT='"+str5+"' AND ATCODE='"+str6+"' AND FSREFCD='"+str7+"'	\n");
							UpdateSql.append( " AND SATCODE='"+str8+"'												\n");

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.executeUpdate(); 
							gsmt.close();
						}

						/*******************************************************************
								���� Master InSert - ���⿹�� ���
						********************************************************************/
						StringBuffer sql5 = new StringBuffer();
						String check5 = "";
						int binitbgt = rows[j].getInt(idx[11]);
						int baddbgt  = rows[j].getInt(idx[15]);
						int bchgabgt = rows[j].getInt(idx[16]);
						int brealbgt = rows[j].getInt(idx[18]);
						int bresults = rows[j].getInt(idx[19]);

						sql5.append( " SELECT													\n"); 
						sql5.append( " RTRIM(A.FDCODE)         FDCODE,			/*�����ڵ�*/		\n"); 
						sql5.append( " COALESCE(A.BINITBGT,0)  BINITBGT,		/*������ʿ���*/	\n"); 
						sql5.append( " COALESCE(A.BADDBGT,0)   BADDBGT,			/*�����߰�����*/	\n"); 
						sql5.append( " COALESCE(A.BCHGABGT,0)  BCHGABGT,		/*�����׸�����*/	\n"); 
						sql5.append( " COALESCE(A.BREALBGT,0)  BREALBGT,		/*������࿹��*/	\n"); 
						sql5.append( " COALESCE(A.BYRESULTS,0) BYRESULTS,		/*�����    ��*/	\n"); 
						sql5.append( " COALESCE(A.INITBGT,0)   INITBGT,			/*���ʿ���*/		\n"); 
						sql5.append( " COALESCE(A.ADDBGT,0)    ADDBGT,			/*�߰�����*/		\n"); 
						sql5.append( " COALESCE(A.CHGABGT,0)   CHGABGT,			/*�׸�����*/		\n"); 
						sql5.append( " COALESCE(A.REALBGT,0)   REALBGT,			/*���࿹��*/		\n"); 
						sql5.append( " COALESCE(A.RESULTS,0)   RESULTS			/*��    ��*/		\n"); 
						sql5.append( " FROM ACCOUNT.BGTMST	A									\n"); 
						sql5.append( " WHERE A.FDCODE='"+str1+"' AND A.BGTYY='"+str12+"'		\n");
						sql5.append( " AND A.BGTDIV='"+str4+"'   AND A.BGTDPT='"+str5+"'		\n"); 
						sql5.append( " AND A.ATCODE='"+str6+"'   AND A.FSREFCD='"+str7+"'		\n");
						sql5.append( " AND A.SATCODE='"+str8+"'									\n"); 
						
						stmt5 = conn.createStatement();
						rs5   = stmt5.executeQuery(sql5.toString());

						while(rs5.next())	{
							check5   = rs5.getString(1);
							binitbgt = rs5.getInt(7);
							baddbgt  = rs5.getInt(8);
							bchgabgt = rs5.getInt(9);
							brealbgt = rs5.getInt(10);
							bresults = rs5.getInt(11);
						}

						if (!check5.equals("")) {			
							check5 = "Y";		//����
						}else if(check5.equals("")) {	
							check5 = "N";		//����
							binitbgt = 0;	baddbgt  = 0;	bchgabgt = 0;	brealbgt = 0;	bresults = 0;
						}


						if (check5.equals("Y"))	{	
							UpdateSq5 = new StringBuffer();
							UpdateSq5.append( " UPDATE ACCOUNT.BGTMST SET																						 \n");
							UpdateSq5.append( " BINITBGT ="+binitbgt+",					BADDBGT="+baddbgt+",								 \n");
							UpdateSq5.append( " BCHGABGT ="+bchgabgt+",					BREALBGT="+brealbgt+",							 \n");
							UpdateSq5.append( " BYRESULTS="+bresults+"  																						 \n");
							UpdateSq5.append( " WHERE FDCODE='"+str1+"' AND BGTYY='"+str2+"'  AND BGTDIV='"+str4+"'	 \n");
							UpdateSq5.append( " AND BGTDPT='"+str5+"'   AND ATCODE='"+str6+"' AND FSREFCD='"+str7+"' \n");
							UpdateSq5.append( " AND SATCODE='"+str8+"'																							 \n");

							GauceStatement gsmt6 = conn.getGauceStatement(UpdateSq5.toString());
							gsmt6.setGauceDataRow(rows[j]);
							gsmt6.executeUpdate();
							gsmt6.close();
						}


						/*******************************************************************
									���� Detail InSert - ��ġ�� ��ȸ
						********************************************************************/
						StringBuffer sql3 = new StringBuffer();
						String check3 = rows[j].getString(idx[0]);
						String bgtmm3 = rows[j].getString(idx[2]);

						sql3.append( " SELECT																							\n"); 
						sql3.append( " RTRIM(A.FDCODE)  FDCODE,				/*�����ڵ�*/				\n"); 
						sql3.append( " RTRIM(A.BGTYY)   BGTYY,				/*����⵵*/				\n"); 
						sql3.append( " RTRIM(A.BGTMM)   BGTMM,				/*�����*/					\n"); 
						sql3.append( " RTRIM(A.BGTDIV)  BGTDIV,				/*���꺻��*/				\n"); 
						sql3.append( " RTRIM(A.BGTDPT)  BGTDPT,				/*����μ�*/				\n"); 
						sql3.append( " RTRIM(A.ATCODE)  ATCODE,				/*�����ڵ�*/				\n"); 
						sql3.append( " RTRIM(A.FSREFCD) FSREFCD,			/*�����׸��ڵ�*/		\n"); 
						sql3.append( " RTRIM(A.SATCODE) SATCODE				/*��    ��*/				\n"); 
						sql3.append( " FROM ACCOUNT.BGTDTL A															\n"); 
						sql3.append( " WHERE A.FDCODE='"+str1+"' AND A.BGTYY='"+str2+"'		\n");
						sql3.append( " AND A.BGTMM='"+rows[j].getString(idx[2])+"'				\n"); 
						sql3.append( " AND A.BGTDIV='"+str4+"'														\n");
						sql3.append( " AND A.BGTDPT='"+str5+"'   AND A.ATCODE='"+str6+"'  \n");
						sql3.append( " AND A.FSREFCD='"+str7+"'  AND A.SATCODE='"+str8+"'	\n"); 

						stmt3 = conn.createStatement();
						rs3   = stmt3.executeQuery(sql3.toString());
						while(rs3.next())	{
							check3 = rs.getString(1) + "";
							bgtmm3 = rs.getString(3) + "";
						}

						if (!check.equals("")) {	
							check3 = "Y";		//����
						}else {							
							check3 = "N";		//����	
						}

						if (check.equals("N")) {
							/*******************************************************************
									���� Detail InSert - New Create
							********************************************************************/
							InsertSql2 = new StringBuffer();
							InsertSql2.append( " INSERT INTO ACCOUNT.BGTDTL (							");
							InsertSql2.append( " FDCODE,BGTYY,BGTMM,BGTDIV,BGTDPT,				");
							InsertSql2.append( " ATCODE,FSREFCD,SATCODE,BGTTYPE,BGTMACT, 	");
							InsertSql2.append( " INITMAN,INITBGT,CHGMAN,CHGBGT,BASICBGT,  ");
							InsertSql2.append( " ADDBGT,CHGABGT,CHGTBGT,REALBGT,RESULTS,	");
							InsertSql2.append( " BRESULTS,APPROVAL,CHGAPPROV,REMARK       ");
							InsertSql2.append( " ) VALUES(																");
							InsertSql2.append( " '"+str1+"','"+str2+"','"+rows[j].getString(idx[2])+"','"+str4+"','"+str5+"',	  ");
							InsertSql2.append( " '"+str6+"','"+str7+"','"+str8+"','"+str10+"','"+str11+"',	");
							InsertSql2.append( " ?, ?, ?, ?, ?,														");
							InsertSql2.append( " ?, ?, ?, ?, ?,														");
							InsertSql2.append( " ?, ?, ?, ?																");
							InsertSql2.append( "  )																				");

							GauceStatement gsmt2 = conn.getGauceStatement(InsertSql2.toString());
							gsmt2.setGauceDataRow(rows[j]);

							for(int k=1;k<=14;k++) {
								gsmt2.bindColumn(k, idx[k+9]);
							}
						
							gsmt2.executeUpdate();
							gsmt2.close();
						}else if(check.equals("Y")) {
							/*******************************************************************
									���� Detail InSert  - ����
							********************************************************************/
							InsertSql3 = new StringBuffer();
							InsertSql3.append( " INSERT INTO ACCOUNT.BGTDTL (							\n");
							InsertSql3.append( " FDCODE,BGTYY,BGTMM,BGTDIV,BGTDPT,				\n");
							InsertSql3.append( " ATCODE,FSREFCD,SATCODE,BGTTYPE,BGTMACT, 	\n");
							InsertSql3.append( " INITMAN,INITBGT,CHGMAN,CHGBGT,BASICBGT,  \n");
							InsertSql3.append( " ADDBGT,CHGABGT,CHGTBGT,REALBGT,RESULTS,	\n");
							InsertSql3.append( " BRESULTS,APPROVAL,CHGAPPROV,REMARK       \n");
							InsertSql3.append( " ) VALUES(																\n");
							InsertSql3.append( " '"+str1+"','"+str2+"','"+rows[j].getString(idx[2])+"','"+str4+"','"+str5+"',	  \n");
							InsertSql3.append( " '"+str6+"','"+str7+"','"+str8+"','"+str10+"','"+str11+"',	\n");
							InsertSql3.append( " "+rows[j].getString(idx[10])+", "+rows[j].getString(idx[11])+","+rows[j].getString(idx[12])+", "+rows[j].getString(idx[13])+", "+rows[j].getString(idx[14])+",	\n");
							InsertSql3.append( " "+rows[j].getString(idx[15])+", "+rows[j].getString(idx[16])+", "+rows[j].getString(idx[17])+", "+rows[j].getString(idx[18])+", "+rows[j].getString(idx[19])+",	\n");
							InsertSql3.append( " "+rows[j].getString(idx[20])+", '"+rows[j].getString(idx[21])+"', '"+rows[j].getString(idx[22])+"', '"+rows[j].getString(idx[23])+"'	\n");
							InsertSql3.append( " )																				\n");
							
							GauceStatement gsmt3 = conn.getGauceStatement(InsertSql3.toString());
							gsmt3.setGauceDataRow(rows[j]);

							gsmt3.executeUpdate();

							gsmt3.close();

						}
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						/*******************************************************************
								���� Master Update
						********************************************************************/
						StringBuffer sql2 = new StringBuffer();
						String check2 = rows[j].getString(idx[0]);
						int initbgt2  = rows[j].getInt(idx[11]);
						int results2  = rows[j].getInt(idx[19]);
						int initbgt3  = rows[j].getInt(idx[11]);
						int results3  = rows[j].getInt(idx[19]);
						int chgbgt3   = rows[j].getInt(idx[13]);
						int result01  = 0;	//�����
						int result02  = 0;
						int result03  = 0;
						String mark01 = "";	//��ȣ
						String mark02 = "";
						String mark03 = "";
						int idx11 = rows[j].getInt(idx[11]);	//������
						int idx19 = rows[j].getInt(idx[19]);	
						int idx13 = rows[j].getInt(idx[13]);	

						sql2.append( " SELECT																								\n");
						sql2.append( " COALESCE(A.INITBGT,0) INITBGT,    /*���ʿ���*/				\n");
						sql2.append( " COALESCE(A.REALBGT,0) REALBGT,    /*���࿹��*/				\n");
						sql2.append( " COALESCE(C.INITBGT,0) INITBGT,    /*���ʿ���*/				\n");
						sql2.append( " COALESCE(C.REALBGT,0) REALBGT,    /*���࿹��*/				\n");
						sql2.append( " COALESCE(C.CHGBGT,0)  CHGBGT      /*��������*/				\n");
						sql2.append( " FROM ACCOUNT.BGTMST A             /*�������MST*/		\n");
						sql2.append( " LEFT JOIN ACCOUNT.BGTDTL C ON A.FDCODE=C.FDCODE     AND A.BGTYY=C.BGTYY		\n");
						sql2.append( "      AND A.BGTDIV=C.BGTDIV   AND A.BGTDPT=C.BGTDPT  AND A.ATCODE=C.ATCODE	\n");
						sql2.append( "      AND A.FSREFCD=C.FSREFCD AND A.SATCODE=C.SATCODE	\n");
						sql2.append( " WHERE A.FDCODE='"+str1+"' AND A.BGTYY='"+str2+"'			\n");
						sql2.append( " AND A.BGTDIV='"+str4+"'   AND A.BGTDPT='"+str5+"'		\n"); 
						sql2.append( " AND A.ATCODE='"+str6+"'   AND A.FSREFCD='"+str7+"'		\n");
						sql2.append( " AND A.SATCODE='"+str8+"'															\n"); 
						sql2.append( " AND C.BGTMM='"+rows[j].getString(idx[2])+"'					\n");
						
						stmt2 = conn.createStatement();
						rs2   = stmt2.executeQuery(sql2.toString());

						while(rs2.next())	{
							check2   = rs2.getString(1) + "";
							//Master ����
							initbgt2 = rs2.getInt(1);
							results2 = rs2.getInt(2);
							//Detail ����
							initbgt3 = rs2.getInt(3);
							results3 = rs2.getInt(4);
							chgbgt3  = rs2.getInt(5);
						}

						if (initbgt3>=idx11) {			//DTL>UAMT
							result01 = initbgt3-idx11;
							mark01 = "-";
						}else if(idx11>=initbgt3) {	//UAMT>DTL
							result01 = idx11-initbgt3;
							mark01 = "+";
						}

						if (chgbgt3==idx13 && idx13 == 0) {
							mark02 = "A";
						}else {
							if (chgbgt3>=idx19) {
								result02 = chgbgt3-idx13;
								mark02 = "-";
							}else if(idx19>=results3) {
								result02 = idx19-results3;
								mark02 = "+";
							}
						}

						//�����û ������ ����....REALBGT="+initbgt2+mark01+result01+
						if(mark02.equals("A")){	//���������� ������ ��� : ���ʿ���ݾװ� ���࿹��ݾ� ��ġ
							UpdateSql = new StringBuffer();
							UpdateSql.append( " UPDATE ACCOUNT.BGTMST SET																										\n");
							UpdateSql.append( " BGTGBCD='"+str9+"',BGTTYPE='"+str10+"',BGTMACT='"+str11+"',									\n");
							UpdateSql.append( " INITBGT="+initbgt2+mark01+result01+" --,REALBGT="+initbgt2+mark01+result01+"	\n");
							UpdateSql.append( " WHERE FDCODE='"+str1+"' AND BGTYY='"+str2+"' AND BGTDIV='"+str4+"'					\n");
							UpdateSql.append( "		AND BGTDPT='"+str5+"' AND ATCODE='"+str6+"' AND FSREFCD='"+str7+"'				\n");
							UpdateSql.append( "		AND SATCODE='"+str8+"'																										\n");

							GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
							gsmt.setGauceDataRow(rows[j]);
							gsmt.executeUpdate(); 
							gsmt.close();
						}

						/*******************************************************************
								���� Detail Update
						********************************************************************/
						UpdateSql2 = new StringBuffer();
						UpdateSql2.append( " UPDATE ACCOUNT.BGTDTL SET																						\n");
						UpdateSql2.append( " BGTTYPE=?,BGTMACT =?,INITMAN =?,INITBGT =?,CHGMAN   =?,							\n");
						UpdateSql2.append( " CHGBGT =?,BASICBGT=?,ADDBGT  =?,CHGABGT =?,CHGTBGT  =?,							\n");
						UpdateSql2.append( " REALBGT=?,RESULTS =?,BRESULTS=?,APPROVAL=?,CHGAPPROV=?,							\n");
						UpdateSql2.append( " REMARK =?                                                      			\n");
						UpdateSql2.append( " WHERE FDCODE='"+str1+"' AND BGTYY='"+str2+"'  AND BGTMM='"+rows[j].getString(idx[2])+"'	\n");
						UpdateSql2.append( " AND BGTDIV='"+str4+"'   AND BGTDPT='"+str5+"' AND ATCODE='"+str6+"' 	\n");
						UpdateSql2.append( " AND FSREFCD='"+str7+"'  AND SATCODE='"+str8+"'												\n");

						GauceStatement gsmt2 = conn.getGauceStatement(UpdateSql2.toString());
						gsmt2.setGauceDataRow(rows[j]);

						for(int s=1;s<=16;s++) {
							gsmt2.bindColumn(s, idx[s+7]);
						}

						gsmt2.executeUpdate(); 
						gsmt2.close();
					}    
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						/*******************************************************************
								���� Master Delete
						********************************************************************/
						UpdateSql = new StringBuffer();
						UpdateSql.append( " UPDATE ACCOUNT.BGTMST SET												\n");
						UpdateSql.append( " INITBGT=0,	REALBGT=0														\n");
						UpdateSql.append( " WHERE FDCODE='"+str1+"'  AND BGTYY='"+str2+"' 	\n");
						UpdateSql.append( "   AND BGTDIV='"+str4+"'	 AND BGTDPT='"+str5+"' 	\n");
						UpdateSql.append( "		AND ATCODE='"+str6+"'  AND FSREFCD='"+str7+"'	\n");
						UpdateSql.append( "		AND SATCODE='"+str8+"'												\n");
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.executeUpdate();
						gsmt.close();

						/*******************************************************************
								���� Detail Delete
						********************************************************************/
						DeleteSql = new StringBuffer();		
						DeleteSql.append( " DELETE FROM ACCOUNT.BGTDTL												");
						DeleteSql.append( "  WHERE FDCODE  = '"+rows[j].getString(idx[0])+"'	");
						DeleteSql.append( "    AND BGTYY   = '"+rows[j].getString(idx[1])+"'	");
						DeleteSql.append( "    AND BGTDIV  = '"+rows[j].getString(idx[3])+"'	");
						DeleteSql.append( "    AND BGTDPT  = '"+rows[j].getString(idx[4])+"'	");
						DeleteSql.append( "    AND ATCODE  = '"+rows[j].getString(idx[5])+"'	");
						DeleteSql.append( "    AND FSREFCD = '"+rows[j].getString(idx[6])+"'	");
						DeleteSql.append( "    AND SATCODE = '"+rows[j].getString(idx[7])+"'	");

						GauceStatement gsmt5 = conn.getGauceStatement(DeleteSql.toString());
						gsmt5.setGauceDataRow(rows[j]);
						gsmt5.executeUpdate();
						gsmt5.close();
					}
				}
			}
			catch(Exception e){
				resGauce.writeException("Native","1111","����� �˼����� �����߻�!!(Error Code :"+e.toString()+")");
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