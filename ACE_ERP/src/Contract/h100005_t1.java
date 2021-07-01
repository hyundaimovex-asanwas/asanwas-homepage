package Contract;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class h100005_t1 extends HttpServlet{
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

				GauceDataSet userSet = reqGauce.getGauceDataSet("USER");

				//String str1 = reqGauce.getParameter("v_str1");	

				//if (str1==null) str1 = "";

				String[] strArrCN = new String[]{	
					"EMPNO",  "APPDT",  "PAYDIV", "PAYDT",  "DEPTCD",	//[4]
					"PAYNUM", "DUYNOT", "P10000", "P11000", "P12000",	//[9]
					"P21000", "P22000", "P23000", "P24000", "P25000",	//[14]
					"P26000", "P27000", "P28000", "P29000", "P30000",	//[19]
					"P31000", "P32000", "P36000", "P37000", "P38000",	//[24]
					"PX0010", "PX0020", "PX0030", "S91000", "T11000",	//[29]
					"T12000", "B11000", "B12000", "B13000", "B14000",	//[34]
					"B15000", "B16000", "BX0010", "BX0020", "BX0030",	//[39]
					"BX0040", "S93000", "S94000", "P34000", "P39000",	//[44]
					"P41000", "P42000", "T21000", "T22000", "STRTDT",	//[49]
					"B17000", "P43000", "P35000", "PX0040",						//[53]
					"PR0020", "PR0030", "PR0040", "BR0020",	"BR0030",	//[58]
					"BR0040", "CHAGDT", "TRAINYN"                   //[62]  
				};

				int[] idx = new int[62];
			for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();


				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;
				

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {	
						
				UpdateSql = new StringBuffer();
				
						UpdateSql.append( " UPDATE PAYROLL.PBPAY \n" );
						UpdateSql.append( "		 SET DEPTCD = '"+rows[j].getString(idx[4])+"',	\n");
						UpdateSql.append( "        PAYNUM = '"+rows[j].getString(idx[5])+"', DUYNOT = "+rows[j].getInt(idx[6])+", \n");
						UpdateSql.append( "        P10000 = "+rows[j].getInt(idx[7])+",  P11000 = "+rows[j].getInt(idx[8])+", \n");
						UpdateSql.append( "        P12000 = "+rows[j].getInt(idx[9])+",  P21000 = "+rows[j].getInt(idx[10])+", \n");
						UpdateSql.append( "        P22000 = "+rows[j].getInt(idx[11])+", P23000 = "+rows[j].getInt(idx[12])+", \n");
						UpdateSql.append( "        P24000 = "+rows[j].getInt(idx[13])+", P25000 = "+rows[j].getInt(idx[14])+", \n");
						UpdateSql.append( "        P26000 = "+rows[j].getInt(idx[15])+", P27000 = "+rows[j].getInt(idx[16])+", \n");
						UpdateSql.append( "        P28000 = "+rows[j].getInt(idx[17])+", P29000 = "+rows[j].getInt(idx[18])+", \n");
						UpdateSql.append( "        P30000 = "+rows[j].getInt(idx[19])+", P31000 = "+rows[j].getInt(idx[20])+", \n");
						UpdateSql.append( "        P32000 = "+rows[j].getInt(idx[21])+", P36000 = "+rows[j].getInt(idx[22])+", \n");
						UpdateSql.append( "        P37000 = "+rows[j].getInt(idx[23])+", P38000 = "+rows[j].getInt(idx[24])+", \n");
						UpdateSql.append( "        PX0010 = "+rows[j].getInt(idx[25])+", PX0020 = "+rows[j].getInt(idx[26])+", \n");
						UpdateSql.append( "        PX0030 = "+rows[j].getInt(idx[27])+", S91000 = "+rows[j].getInt(idx[28])+", \n");
						UpdateSql.append( "        T11000 = "+rows[j].getInt(idx[29])+", T12000 = "+rows[j].getInt(idx[30])+", \n");
						UpdateSql.append( "        B11000 = "+rows[j].getInt(idx[31])+", B12000 = "+rows[j].getInt(idx[32])+", \n");
						UpdateSql.append( "        B13000 = "+rows[j].getInt(idx[33])+", B14000 = "+rows[j].getInt(idx[34])+", \n");
						UpdateSql.append( "        B15000 = "+rows[j].getInt(idx[35])+", B16000 = "+rows[j].getInt(idx[36])+", \n"); 
						UpdateSql.append( "        BX0010 = "+rows[j].getInt(idx[37])+", BX0020 = "+rows[j].getInt(idx[38])+", \n"); 
						UpdateSql.append( "        BX0030 = "+rows[j].getInt(idx[39])+", BX0040 = "+rows[j].getInt(idx[40])+", \n"); 
						UpdateSql.append( "        S93000 = "+rows[j].getInt(idx[41])+", S94000 = "+rows[j].getInt(idx[42])+", \n"); 
						UpdateSql.append( "        P34000 = "+rows[j].getInt(idx[43])+", P39000 = "+rows[j].getInt(idx[44])+", \n");
						UpdateSql.append( "        P41000 = "+rows[j].getInt(idx[45])+", P42000 = "+rows[j].getInt(idx[46])+", \n"); 
						UpdateSql.append( "        T21000 = "+rows[j].getInt(idx[47])+", T22000 = "+rows[j].getInt(idx[48])+", \n"); 
						UpdateSql.append( "        STRTDT = '"+rows[j].getString(idx[49])+"', B17000 = "+rows[j].getInt(idx[50])+",\n"); 
						UpdateSql.append( "        P43000 = "+rows[j].getInt(idx[51])+", P35000 = "+rows[j].getInt(idx[52])+", \n"); 
						UpdateSql.append( "		   PX0040 = "+rows[j].getInt(idx[53])+", \n");
						UpdateSql.append( "        PR0020 = '"+rows[j].getString(idx[54])+"',\n" );		
						UpdateSql.append( "        PR0030 = '"+rows[j].getString(idx[55])+"',\n" );		
						UpdateSql.append( "        PR0040 = '"+rows[j].getString(idx[56])+"',\n" );		
						UpdateSql.append( "        BR0020 = '"+rows[j].getString(idx[57])+"',\n" );		
						UpdateSql.append( "        BR0030 = '"+rows[j].getString(idx[58])+"',\n" );		
						UpdateSql.append( "        BR0040 = '"+rows[j].getString(idx[59])+"',\n" );		
						UpdateSql.append( "        CHAGDT = '"+rows[j].getString(idx[60])+"',\n" );		
						UpdateSql.append( "        TRAINYN = '"+rows[j].getString(idx[61])+"'\n" );
						UpdateSql.append( "  WHERE EMPNO ='"+rows[j].getString(idx[0])+"' AND APPDT ='"+rows[j].getString(idx[1])+"' \n");
						UpdateSql.append( "   AND PAYDIV ='"+rows[j].getString(idx[2])+"' AND PAYDT ='"+rows[j].getString(idx[3])+"' \n" );
						
						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						
//						logger.dbg.println(this,UpdateSql.toString());

						gsmt.executeUpdate(); 
						gsmt.close();         //}//end for
		

						 UpdateSql = null;
						 UpdateSql = new StringBuffer();
						 //logger.dbg.println(this,"999");

						UpdateSql.append( " UPDATE PAYROLL.PBPAY \n" );
						UpdateSql.append( "		   SET S92000 = (SELECT (A.S91000-H.BP35000-H.BP24000) AS S92000S \n" );
						UpdateSql.append( "        FROM PAYROLL.PBPAY A \n" );
						UpdateSql.append( "        LEFT JOIN (SELECT G.EMPNO,G.APPDT,G.PAYDIV, \n" );
						UpdateSql.append( "				CASE WHEN G.P35000 >= 100000 THEN  100000 ELSE G.P35000 END BP35000 , \n" );
						UpdateSql.append( "				CASE WHEN G.P24000 >= 200000 THEN  200000 ELSE G.P24000 END BP24000 \n" );
						UpdateSql.append( "				FROM PAYROLL.PBPAY G)H ON A.EMPNO = H.EMPNO AND H.APPDT ='"+rows[j].getString(idx[1])+"' AND H.PAYDIV ='"+rows[j].getString(idx[2])+"'  \n" );
						UpdateSql.append( "			WHERE A.EMPNO ='"+rows[j].getString(idx[0])+"' AND A.APPDT ='"+rows[j].getString(idx[1])+"' AND A.PAYDIV ='"+rows[j].getString(idx[2])+"' ) \n");
						UpdateSql.append( "  WHERE EMPNO ='"+rows[j].getString(idx[0])+"' AND APPDT ='"+rows[j].getString(idx[1])+"' \n");
						UpdateSql.append( "   AND PAYDIV ='"+rows[j].getString(idx[2])+"' AND PAYDT ='"+rows[j].getString(idx[3])+"' \n" );
						
						//logger.dbg.println(this,"777");	

//						logger.dbg.println(this,UpdateSql.toString());	

						 gsmt = conn.getGauceStatement(UpdateSql.toString());
//						 logger.dbg.println(this,"666");	

						gsmt.setGauceDataRow(rows[j]);
						
//						logger.dbg.println(this,"888");	

						gsmt.executeUpdate(); 
						gsmt.close();         //}//end for


					}
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.PBPAY \n" );
						DeleteSql.append( "  WHERE EMPNO = ? AND APPDT = ? AND PAYDIV = ? AND PAYDT = ? \n" );

						GauceStatement gsmt = conn.getGauceStatement(DeleteSql.toString());
						gsmt.setGauceDataRow(rows[j]);
						gsmt.bindColumn(1, idx[0]);
						gsmt.bindColumn(2, idx[1]);
						gsmt.bindColumn(3, idx[2]);
						gsmt.bindColumn(4, idx[3]);

						gsmt.executeUpdate();
						gsmt.close();
						DeleteSql=null;
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