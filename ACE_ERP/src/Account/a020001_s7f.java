package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class a020001_s7f extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;

		try {
			
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();

			try {
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	���� �������� �����Ͻ� �κ�
**********************************************************************************************/
				// ������������ ���ǰ��� �Ѱܹ���
				String [] str = new String [6];
				str[0]	= req.getParameter("v_str1");		//�����ڵ�
				str[1]	= req.getParameter("v_str2");		//��������
				str[2]	= req.getParameter("v_str3");		//������ȣ
				str[3]	= req.getParameter("v_str4");		//��ǥ����
				str[4]	= req.getParameter("v_str5");		//��ǥ��ȣ
				str[5]	= req.getParameter("v_str6");		//��ǥ��ȣ ȸ������

				int intyyyy=0;

				for (int s=0;s<=5;s++) {
					if (str[s]==null||str[s].equals("undefined")) str[s] = "";
				}
   
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "FDCODE",  "FSDAT",  "FSNBR",  "FSSEQ",  "ATCODE" ,
					                              "ATKORNAM","ATDECR", "REMARK", "CHAAMT", "DAEAMT",  
					                              "FSREFSEQ01","FSREFSEQ02","FSREFSEQ03","FSREFSEQ04","FSREFSEQ05", 
				                                  "FSREFSEQ06","FSREFSEQ07","FSREFSEQ08","FSREFSEQ09",
					                              "FSREFCD01", "FSREFCD02", "FSREFCD03", "FSREFCD04", "FSREFCD05",
					                              "FSREFCD06", "FSREFCD07", "FSREFCD08", "FSREFCD09",
					                              "FSREFVAL01","FSREFVAL02","FSREFVAL03","FSREFVAL04","FSREFVAL05",
					                              "FSREFVAL06","FSREFVAL07","FSREFVAL08","FSREFVAL09",
					                              "FSREFNM01","FSREFNM02","FSREFNM03","FSREFNM04","FSREFNM05",
					                              "FSREFNM06","FSREFNM07","FSREFNM08","FSREFNM09",
					                              "FSRVALNM01","FSRVALNM02","FSRVALNM03","FSRVALNM04","FSRVALNM05",
					                              "FSRVALNM06","FSRVALNM07","FSRVALNM08","FSRVALNM09",
					                              "TYPE01",    "TYPE02",     "TYPE03",   "TYPE04",   "TYPE05",
					                              "TYPE06",    "TYPE07",     "TYPE08",   "TYPE09",
					                              "ARBALDIV01","ARBALDIV02","ARBALDIV03","ARBALDIV04","ARBALDIV05",
					                              "ARBALDIV06","ARBALDIV07","ARBALDIV08","ARBALDIV09",
					                              "CNT", "DOCUMCD", "DOCUMNM", "FSWRKDIV",
					                              "WRDT",	"WRID",	"UPDT",	"UPID" , 
					                              "BANJAEYN","FSSTAT", "DOCUVAL", "FSNUM","DIVCD",
					                              "BGTDIV","FUNDDIV","BANJAEREF","LASTREF","BANJAEMOD","ATCURTYPE","ATDEBTYN", "CREDGB"
																				};

				int[] intArrCN = new int[]{  2, 9,  6,  5,  7,
					                          66, 1, 132, 15, 15, 
					                           2, 2, 2, 2, 2, 
					                           2, 2, 2, 2,
					                           4, 4,  4,  4,  4,
					                           4, 4,  4,  4,  
					                          30,30, 30, 30, 30, 
					                          30,30, 30, 30, 
					                          40,40, 40, 40, 40, 
					                          40,40, 40, 40, 
					                          40,40, 40, 40, 40, 
					                          40,40, 40, 40,
					                          1, 1,  1,  1,  1,
					                           1, 1,  1,  1,  
					                           1, 1,  1,  1,  1,
					                           1, 1,  1,  1,  
					                           1, 3, 40,  2, 
					                           8, 7,  8,  7,
					                           1, 1, 20,  3, 4,
					                           4, 2,  4,  1, 1,1, 1, 1
																	}; 

				int[] intArrCN2 = new int[]{ -1, -1, -1, -1, -1,
					                           -1, -1, -1, 0,  0, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1,  
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1, 
					                           -1, -1, -1, -1, 
					                            0, -1, -1, -1,
					                           -1, -1, -1, -1, 
					                           -1, -1, -1, -1, -1,
					                           -1, -1, -1, -1, -1, -1, -1, -1
																	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					

					
					Statement stmt0 = conn.createStatement();
					StringBuffer sql0 = new StringBuffer();
					sql0.append( " SELECT ACTDAT 						" );
					sql0.append( "   FROM ACCOUNT.FSLIPMST    " );
					sql0.append( "  WHERE 1=1     						" );
					if(!str[0].equals("")) { sql0.append( " AND FDCODE = '"+str[0]+"' \n "); }                                                  
					if(!str[1].equals("")) { sql0.append( " AND FSDAT = '"+str[1]+"' \n"); }                                                 
					if(!str[2].equals("")) { sql0.append( " AND FSNBR = '"+str[2]+"' \n"); }    
					if(!str[3].equals("")) { sql0.append( " AND SSDAT = '"+str[3]+"' \n"); }                                                 
					if(!str[4].equals("")) { sql0.append( " AND SSNBR = '"+str[4]+"' \n"); }   
					ResultSet rs0 = stmt0.executeQuery(sql0.toString()); 
					if(rs0.next()){
						 intyyyy = Integer.parseInt(rs0.getString(1).substring(0,4));
					}
					rs0.close();
					stmt0.close();

					StringBuffer sql = new StringBuffer();
					sql.append( "  SELECT X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ, MAX(X.ATCODE)ATCODE      \n ");
					
					sql.append( "    ,MAX(X.ATKORNAM)ATKORNAM,    MAX(X.ATDECR)ATDECR,   MAX(X.REMARK)REMARK, X.CHAAMT,X.DAEAMT,  \n ");
					sql.append( "    MAX(FSREFSEQ01)FSREFSEQ01,  MAX(FSREFSEQ02)FSREFSEQ02, \n ");
					sql.append( "    MAX(FSREFSEQ03)FSREFSEQ03,  MAX(FSREFSEQ04)FSREFSEQ04, \n ");
					sql.append( "    MAX(FSREFSEQ05)FSREFSEQ05,  MAX(FSREFSEQ05)FSREFSEQ06, \n ");
					sql.append( "    MAX(FSREFSEQ07)FSREFSEQ07,  MAX(FSREFSEQ06)FSREFSEQ08, \n ");
					sql.append( "    MAX(FSREFSEQ09)FSREFSEQ09,                              \n ");  
					
					/**
					sql.append( "	 MAX(FSREFCD01)FSREFCD01,    MAX(FSREFNM01)FSREFNM01,    \n "); 
 					//2008.01.22. ������ �߰� (�μ����� �μ� ���̺��� ������.)
					//2008.02.01  �μ�- ȸ��⵵�� 2007�� ������ ����Ÿ�� �����׸񿡼� ������ 
					//                  2008�⵵ ���ʹ� �μ����̺���.
					
					
					if(intyyyy>=2008){
						sql.append( "	   MAX(FSREFVAL01)FSREFVAL01, MAX(L.DEPTNM)FSRVALNM01,  \n "); 
					}else{         
					  sql.append( "	   MAX(FSREFVAL01)FSREFVAL01, MAX(FSRVALNM01)FSRVALNM01,  \n ");
					}
                    
					sql.append( "	   MAX(FSREFCD02)FSREFCD02,   MAX(FSREFNM02)FSREFNM02,    \n "); 
					sql.append( "	   MAX(FSREFVAL02)FSREFVAL02, MAX(FSRVALNM02)FSRVALNM02,  \n "); 
					sql.append( "	   MAX(FSREFCD03)FSREFCD03,   MAX(FSREFNM03)FSREFNM03,   MAX(FSREFVAL03)FSREFVAL03,   \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM03) IS NULL OR RTRIM(FSRVALNM03)='' THEN FSREFVAL03 ELSE FSRVALNM03 END) AS FSRVALNM03,  \n "); 
					sql.append( "	   MAX(FSREFCD04)FSREFCD04,   MAX(FSREFNM04)FSREFNM04,   MAX(FSREFVAL04)FSREFVAL04,   \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM04) IS NULL OR RTRIM(FSRVALNM04)='' THEN FSREFVAL04 ELSE FSRVALNM04 END) AS FSRVALNM04,  \n "); 
					sql.append( "	   MAX(FSREFCD05)FSREFCD05,   MAX(FSREFNM05)FSREFNM05,   MAX(FSREFVAL05)FSREFVAL05,   \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM05) IS NULL OR RTRIM(FSRVALNM05)='' THEN FSREFVAL05 ELSE FSRVALNM05 END) AS FSRVALNM05,  \n "); 
					sql.append( "	   MAX(FSREFCD06)FSREFCD06,   MAX(FSREFNM06)FSREFNM06,   MAX(FSREFVAL06)FSREFVAL06,   \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM06) IS NULL OR RTRIM(FSRVALNM06)='' THEN FSREFVAL06 ELSE FSRVALNM06 END) AS FSRVALNM06,  \n "); 
					sql.append( "	   MAX(FSREFCD07)FSREFCD07,   MAX(FSREFNM07)FSREFNM07,   MAX(FSREFVAL07)FSREFVAL07,  \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM07) IS NULL OR RTRIM(FSRVALNM07)='' THEN FSREFVAL07 ELSE FSRVALNM07 END) AS FSRVALNM07,  \n "); 
					sql.append( "	   MAX(FSREFCD08)FSREFCD08,   MAX(FSREFNM08)FSREFNM08,   MAX(FSREFVAL08)FSREFVAL08,  \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM08) IS NULL OR RTRIM(FSRVALNM08)='' THEN FSREFVAL08 ELSE FSRVALNM08 END) AS FSRVALNM08,  \n "); 
					sql.append( "	   MAX(FSREFCD09)FSREFCD09,   MAX(FSREFNM09)FSREFNM09,   MAX(FSREFVAL09)FSREFVAL09,  \n "); 
					sql.append( "	   MAX(CASE WHEN RTRIM(FSRVALNM09) IS NULL OR RTRIM(FSRVALNM09)='' THEN FSREFVAL09 ELSE FSRVALNM09 END) AS FSRVALNM09,  \n "); 
		
		           **/
					
					sql.append( "	 MAX(FSREFCD01)FSREFCD01,    MAX(FSREFCD02)FSREFCD02, MAX(FSREFCD03)FSREFCD03, MAX(FSREFCD04)FSREFCD04, MAX(FSREFCD05)FSREFCD05,     \n "); 
					sql.append( "	 MAX(FSREFCD06)FSREFCD06,    MAX(FSREFCD07)FSREFCD07, MAX(FSREFCD08)FSREFCD08, MAX(FSREFCD09)FSREFCD09,      \n "); 
					sql.append( "	 MAX(FSREFVAL01)FSREFVAL01, MAX(FSREFVAL02)FSREFVAL02, MAX(FSREFVAL03)FSREFVAL03,  MAX(FSREFVAL04)FSREFVAL04,  MAX(FSREFVAL05)FSREFVAL05, \n "); 
					sql.append( "	 MAX(FSREFVAL06)FSREFVAL06, MAX(FSREFVAL07)FSREFVAL07, MAX(FSREFVAL08)FSREFVAL08, MAX(FSREFVAL09)FSREFVAL09,\n "); 
					sql.append( "	 MAX(FSREFNM01)FSREFNM01,   MAX(FSREFNM02)FSREFNM02,MAX(FSREFNM03)FSREFNM03,MAX(FSREFNM04)FSREFNM04,MAX(FSREFNM05)FSREFNM05, \n "); 
					sql.append( "	 MAX(FSREFNM06)FSREFNM06,   MAX(FSREFNM07)FSREFNM07,MAX(FSREFNM08)FSREFNM08,MAX(FSREFNM09)FSREFNM09, \n "); 
                    
					if(intyyyy>=2008){
						//sql.append( "	 MAX(L.DEPTNM)FSRVALNM01,  \n "); 
						sql.append( "	 ACCOUNT.FN_DEPTNM(MAX(FSREFVAL01),'200801','')FSRVALNM01,  \n ");
						//sql.append( "	'' FSRVALNM01,  \n ");
					}else{         
						sql.append( "	 MAX(FSRVALNM01)FSRVALNM01,  \n ");
					}
					sql.append( "	MAX(FSRVALNM02)FSRVALNM02, \n "); 
					sql.append( "	MAX(CASE WHEN RTRIM(FSRVALNM03) IS NULL OR RTRIM(FSRVALNM03)='' THEN FSREFVAL03 ELSE FSRVALNM03 END) AS FSRVALNM03,  \n "); 
					sql.append( "	MAX(CASE WHEN RTRIM(FSRVALNM04) IS NULL OR RTRIM(FSRVALNM04)='' THEN FSREFVAL04 ELSE FSRVALNM04 END) AS FSRVALNM04,  \n "); 
					sql.append( "	MAX(CASE WHEN RTRIM(FSRVALNM05) IS NULL OR RTRIM(FSRVALNM05)='' THEN FSREFVAL05 ELSE FSRVALNM05 END) AS FSRVALNM05,  \n "); 
					sql.append( "	MAX(CASE WHEN RTRIM(FSRVALNM06) IS NULL OR RTRIM(FSRVALNM06)='' THEN FSREFVAL06 ELSE FSRVALNM06 END) AS FSRVALNM06,  \n "); 
					sql.append( "	MAX(CASE WHEN RTRIM(FSRVALNM07) IS NULL OR RTRIM(FSRVALNM07)='' THEN FSREFVAL07 ELSE FSRVALNM07 END) AS FSRVALNM07,  \n "); 
					sql.append( "	MAX(CASE WHEN RTRIM(FSRVALNM08) IS NULL OR RTRIM(FSRVALNM08)='' THEN FSREFVAL08 ELSE FSRVALNM08 END) AS FSRVALNM08,  \n "); 
					sql.append( "	MAX(CASE WHEN RTRIM(FSRVALNM09) IS NULL OR RTRIM(FSRVALNM09)='' THEN FSREFVAL09 ELSE FSRVALNM09 END) AS FSRVALNM09,  \n "); 
					
					sql.append( "    MAX(TYPE01)TYPE01,   MAX(TYPE02)TYPE02,   \n");
					sql.append( "    MAX(TYPE03)TYPE03,   MAX(TYPE04)TYPE04,   \n");
					sql.append( "    MAX(TYPE05)TYPE05,   MAX(TYPE06)TYPE06,   \n");
					sql.append( "    MAX(TYPE07)TYPE07,   MAX(TYPE08)TYPE08,   \n");
					sql.append( "    MAX(TYPE09)TYPE09,                        \n");

					sql.append( "    MAX(ARBALDIV01)ARBALDIV01,   MAX(ARBALDIV02)ARBALDIV02,\n");
					sql.append( "    MAX(ARBALDIV03)ARBALDIV03,   MAX(ARBALDIV04)ARBALDIV04,\n");
					sql.append( "    MAX(ARBALDIV05)ARBALDIV05,   MAX(ARBALDIV06)ARBALDIV06,\n");
					sql.append( "    MAX(ARBALDIV07)ARBALDIV07,   MAX(ARBALDIV08)ARBALDIV08,\n");
					sql.append( "    MAX(ARBALDIV09)ARBALDIV09,                             \n");
        
					sql.append( "        (COUNT(X.FSREFCD01)+COUNT(X.FSREFCD02)+COUNT(X.FSREFCD03)+COUNT(X.FSREFCD04)+COUNT(X.FSREFCD05)      \n ");
					sql.append( "        +COUNT(X.FSREFCD06)+COUNT(X.FSREFCD07)+COUNT(X.FSREFCD08)+COUNT(X.FSREFCD09))CNT ,                    \n ");
					sql.append( "        MAX(X.DOCUMCD) DOCUMCD, MAX(X.DOCUMNM) DOCUMNM, MAX(X.FSWRKDIV)FSWRKDIV, \n ");
					sql.append( "        MAX(X.WRDT)WRDT, MAX(X.WRID)WRID, MAX(X.UPDT)UPDT, MAX(X.UPID) UPID, \n ");
					sql.append( "        MAX(X.BANJAEYN)BANJAEYN , MAX(X.FSSTAT)FSSTAT,  MAX(X.DOCUVAL)DOCUVAL,  MAX(X.FSNUM)FSNUM,  MAX(X.DIVCD)DIVCD, \n ");
					sql.append( "        MAX(X.BGTDIV)BGTDIV, MAX(X.FUNDIV) FUNDDIV, MAX(X.FSREFCD) BANJAEREF , '' LASTREF, '' BANJAEMOD,MAX(X.ATCURTYPE) ATCURTYPE, MAX(X.ATDEBTYN)ATDEBTYN,  MAX(X.CREDGB)CREDGB \n ");
					
					sql.append( "  FROM(  \n ");
					sql.append( "        SELECT A.FDCODE, A.FSDAT, A.FSNBR, B.FSSEQ, B.ATCODE,\n ");
					sql.append( "               CASE WHEN B.ATCODE='1' THEN '�빫��'        \n ");
					sql.append( "   			           WHEN B.ATCODE='2' THEN '���ֺ�'       \n ");
					sql.append( "   			           WHEN B.ATCODE='3' THEN '����'       \n ");
					sql.append( "   			           WHEN B.ATCODE='4' THEN '�����'       \n ");
					sql.append( "   			           WHEN B.ATCODE='5' THEN '������(���)' \n ");
					sql.append( "   			           WHEN B.ATCODE='6' THEN '���ֺ�ΰ���'       \n ");
					sql.append( "   			           WHEN B.ATCODE='7' THEN '����ΰ���'       \n ");
					sql.append( "   			           WHEN B.ATCODE='8' THEN '�����ΰ���'       \n ");
					sql.append( "   			           WHEN B.ATCODE='9' THEN '���ΰ���'   \n ");
					sql.append( "   	          ELSE D.ATKORNAM END  ATKORNAM              \n ");
					sql.append( "               ,D.ATDECR, B.REMARK,  \n ");
					sql.append( "                CASE WHEN B.ATDECR='1' THEN B.FSAMT ELSE 0 END CHAAMT,                     \n ");
					sql.append( "								 CASE WHEN B.ATDECR='2' THEN B.FSAMT ELSE 0 END DAEAMT,                     \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFSEQ END FSREFSEQ01, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFSEQ END FSREFSEQ02, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFSEQ END FSREFSEQ03, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFSEQ END FSREFSEQ04, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFSEQ END FSREFSEQ05, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFSEQ END FSREFSEQ06, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFSEQ END FSREFSEQ07, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFSEQ END FSREFSEQ08, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFSEQ END FSREFSEQ09, \n ");
					sql.append( "								 CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFCD END FSREFCD01,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFCD END FSREFCD02,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFCD END FSREFCD03,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFCD END FSREFCD04,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFCD END FSREFCD05,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFCD END FSREFCD06,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFCD END FSREFCD07,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFCD END FSREFCD08,   \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFCD END FSREFCD09,   \n ");
					
					sql.append( "							   CASE WHEN C.FSREFSEQ ='01' THEN C.FSREFVAL END FSREFVAL01, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='02' THEN C.FSREFVAL END FSREFVAL02, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='03' THEN C.FSREFVAL END FSREFVAL03, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='04' THEN C.FSREFVAL END FSREFVAL04, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='05' THEN C.FSREFVAL END FSREFVAL05, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='06' THEN C.FSREFVAL END FSREFVAL06, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='07' THEN C.FSREFVAL END FSREFVAL07, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='08' THEN C.FSREFVAL END FSREFVAL08, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='09' THEN C.FSREFVAL END FSREFVAL09, \n ");          
					
					sql.append( "							   CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(F.CDNAM) END FSREFNM01,  \n ");  
					sql.append( "							   CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(F.CDNAM)END FSREFNM02,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(F.CDNAM) END FSREFNM03,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(F.CDNAM) END FSREFNM04,  \n ");  
					sql.append( "							   CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(F.CDNAM) END FSREFNM05,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(F.CDNAM) END FSREFNM06,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(F.CDNAM) END FSREFNM07,  \n ");  
					sql.append( "							   CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(F.CDNAM) END FSREFNM08,  \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(F.CDNAM) END FSREFNM09,  \n "); 
         
					sql.append( "							   CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(G.CDNAM) END FSRVALNM01, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(G.CDNAM) END FSRVALNM02, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(G.CDNAM) END FSRVALNM03, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(G.CDNAM) END FSRVALNM04, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(G.CDNAM) END FSRVALNM05, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(G.CDNAM) END FSRVALNM06, \n "); 
					sql.append( "							   CASE WHEN C.FSREFCD ='0029' THEN K.VEND_NM    \n "); 
					sql.append( "							        WHEN C.FSREFCD!='0029' AND C.FSREFSEQ ='07' THEN RTRIM(G.CDNAM) END FSRVALNM07, \n ");
					sql.append( "							   CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(G.CDNAM) END FSRVALNM08, \n "); 
					sql.append( "							   CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(G.CDNAM) END FSRVALNM09, \n "); 

					sql.append( "	               CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(H.TYPE) END TYPE01,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(H.TYPE) END TYPE02,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(H.TYPE) END TYPE03,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(H.TYPE) END TYPE04,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(H.TYPE) END TYPE05,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(H.TYPE) END TYPE06,    \n "); 
					sql.append( "				   CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(H.TYPE) END TYPE07,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(H.TYPE) END TYPE08,    \n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(H.TYPE) END TYPE09,    \n "); 

					sql.append( "	               CASE WHEN C.FSREFSEQ ='01' THEN RTRIM(H.ARBALDIV) END ARBALDIV01,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='02' THEN RTRIM(H.ARBALDIV) END ARBALDIV02,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='03' THEN RTRIM(H.ARBALDIV) END ARBALDIV03,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='04' THEN RTRIM(H.ARBALDIV) END ARBALDIV04,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='05' THEN RTRIM(H.ARBALDIV) END ARBALDIV05,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='06' THEN RTRIM(H.ARBALDIV) END ARBALDIV06,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='07' THEN RTRIM(H.ARBALDIV) END ARBALDIV07,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='08' THEN RTRIM(H.ARBALDIV) END ARBALDIV08,\n "); 
					sql.append( "	               CASE WHEN C.FSREFSEQ ='09' THEN RTRIM(H.ARBALDIV) END ARBALDIV09,\n "); 

					sql.append( "		           B.DOCUMCD,RTRIM(E.CDNAM)DOCUMNM, B.FSWRKDIV, B.BANJAEYN, \n ");      
					sql.append( "	               B.WRDT, B.WRID, B.UPDT, B.UPID , A.FSSTAT, B.DOCUVAL, B.FSNUM ,B.DIVCD,B.BGTDIV,D.FUNDIV,D.FSREFCD, D.ATCURTYPE,D.ATDEBTYN, T.CREDGB \n ");
					sql.append( "			  FROM ACCOUNT.FSLIPMST A                                                                             \n ");
					sql.append( "			  LEFT JOIN ACCOUNT.FSLIPDTL B ON A.FDCODE = B.FDCODE AND A.FSDAT = B.FSDAT AND A.FSNBR = B.FSNBR     \n ");
					sql.append( "			  LEFT JOIN ACCOUNT.FSLIPREF C ON A.FDCODE = C.FDCODE AND A.FSDAT = C.FSDAT AND A.FSNBR = C.FSNBR  AND B.FSSEQ = C.FSSEQ   \n ");
					sql.append( "			  LEFT JOIN ACCOUNT.ACTCODE D ON D.ATCODE = B.ATCODE                                                  \n ");			
					sql.append( "             LEFT JOIN ACCOUNT.COMMDTIL E ON E.CDCODE= B.DOCUMCD AND E.CMTYPE='0052'  \n ");
					sql.append( "	          LEFT JOIN ACCOUNT.COMMDTIL F ON C.FSREFCD = F.CDCODE AND F.CMTYPE='0050'   \n "); 
					sql.append( "	          LEFT JOIN ACCOUNT.COMMDTIL G ON C.FSREFVAL = G.CDCODE AND C.FSREFCD=G.CMTYPE  \n "); 
					sql.append( "             LEFT JOIN ACCOUNT.ACTREFCODE H ON B.ATCODE = H.ATCODE AND CAST(C.FSREFSEQ AS NUMERIC) = H.ARSEQ \n");
					sql.append( "	          LEFT JOIN ACCOUNT.COMMDTIL I ON I.CDCODE= C.FSREFVAL AND I.CMTYPE='0003' \n "); 
					sql.append( "	          LEFT JOIN ACCOUNT.GCZM_VENDER K ON C.FSREFVAL = K.VEND_CD AND C.FSREFCD='0029' \n "); 
					
					sql.append( "	          LEFT JOIN ( SELECT U.VEND_CD, MAX(U.CREDGB)CREDGB  \n ");
					sql.append( "	                        FROM ACCOUNT.BOND_ATTACH U           \n ");
					sql.append( "	                       WHERE U.CREDGB IN ('1','2')           \n ");
					sql.append( "	                       GROUP BY U.VEND_CD                    \n ");
					sql.append( "	                    ) T ON  C.FSREFVAL = T.VEND_CD   AND C.FSREFCD='0020'\n ");
					sql.append( "					 WHERE A.FDCODE IS NOT NULL   \n ");
					if(!str[0].equals("")) { sql.append( " AND A.FDCODE = '"+str[0]+"' \n "); }                                                  
					if(!str[1].equals("")) { sql.append( " AND A.FSDAT = '"+str[1]+"' \n"); }                                                 
					if(!str[2].equals("")) { sql.append( " AND A.FSNBR = '"+str[2]+"' \n"); }    
					if(!str[3].equals("")) { sql.append( " AND A.SSDAT = '"+str[3]+"' \n"); }                                                 
					if(!str[4].equals("")) { sql.append( " AND A.SSNBR = '"+str[4]+"' \n"); }   
					sql.append( "                          ) X                        \n ");
					//2008.02.01  �μ�- ȸ��⵵�� 2007�� ������ ����Ÿ�� �����׸񿡼� ������ 
					//                  2008�⵵ ���ʹ� �μ����̺���.
					
					//if(intyyyy>=2008){
					//	sql.append( "  LEFT JOIN PAYROLL.HCDEPT L ON L.DEPTCD = X.FSREFVAL01 AND L.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n ");
					
						//sql.append( "  LEFT JOIN PAYROLL.HCDEPT L ON L.DEPTCD = X.FSREFVAL01 AND L.CHGYM = '200801' \n ");
						
						//sql.append( "  LEFT OUTER JOIN PAYROLL.HCDEPT L ON L.DEPTCD = 'J500' AND L.CHGYM = '200801' \n ");
						
						//sql.append( "   , PAYROLL.HCDEPT L \n ");
						//sql.append( "   WHERE L.DEPTCD(+) = X.FSREFVAL01 AND L.CHGYM(+) = '200801'    \n ");
					//}
					//sql.append( " GROUP BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSSEQ   \n ");
					sql.append( " GROUP BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSNUM,X.FSSEQ,X.CHAAMT,X.DAEAMT  \n ");
					sql.append( " ORDER BY X.FDCODE, X.FSDAT, X.FSNBR, X.FSNUM, X.FSSEQ                   \n ");
				
					//System.out.println("a020001_s7f : " + sql);
					//logger.dbg.println(this,sql.toString());
/*********************************************************************************************/

					stmt = conn.getGauceStatement(sql.toString());
	 		        stmt.executeQuery(dSet);
	 		
				}
			} catch(Exception e) {
		  	logger.err.println(this,e);
			} finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close(true);} catch (Exception e) {}
			}

		  dSet.flush();
		  GauceRes.commit();
		  GauceRes.close();

		} catch (Exception e) {
			logger.err.println(this,e);
			logger.dbg.println(this,e.toString());
		} finally {
			loader.restoreService(service);
  	}
	}
}