package Payroll;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class p020003_t1 extends HttpServlet{
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

				//String str1 = reqGauce.getParameter("v_str1");	//사번
				//String str2 = reqGauce.getParameter("v_str2");	//년월
				//String str3 = reqGauce.getParameter("v_str3");	//급여구분
				//String str4 = reqGauce.getParameter("v_str4");	//지급일
				//String str5 = reqGauce.getParameter("v_str5");	//변경일(막음)

				//if (str1==null) str1 = "";
				//if (str2==null) str2 = "";
				//if (str3==null) str3 = "";
				//if (str4==null) str4 = "";
			//	if (str5==null) str5 = "";

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
                    "BR0040", "CHAGDT", "APLAMT", "APLRAT", "APJAMT","TRAINYN"                     //[64]  
	
				};

				int[] idx = new int[65];
        for (int i=0; i<strArrCN.length; i++) {
  				idx[i] = userSet.indexOfColumn(strArrCN[i]);
				}

				GauceDataRow[] rows = userSet.getDataRows();

				StringBuffer InsertSql = null;
				StringBuffer UpdateSql = null;
				StringBuffer DeleteSql = null;

				for (int j = 0; j < rows.length; j++){
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_INSERT) {
						InsertSql = new StringBuffer();
						InsertSql=null;
					}

					if(rows[j].getJobType() == GauceDataRow.TB_JOB_UPDATE) {
						UpdateSql = new StringBuffer();
					
						UpdateSql.append( " UPDATE PAYROLL.PBPAY " );
						UpdateSql.append( "		 SET DEPTCD = '"+rows[j].getString(idx[4])+"',	");
						UpdateSql.append( "        PAYNUM = '"+rows[j].getString(idx[5])+"', DUYNOT = "+rows[j].getInt(idx[6])+", ");
						UpdateSql.append( "        P10000 = "+rows[j].getInt(idx[7])+",  P11000 = "+rows[j].getInt(idx[8])+", ");
						UpdateSql.append( "        P12000 = "+rows[j].getInt(idx[9])+",  P21000 = "+rows[j].getInt(idx[10])+", ");
						UpdateSql.append( "        P22000 = "+rows[j].getInt(idx[11])+", P23000 = "+rows[j].getInt(idx[12])+", ");
						UpdateSql.append( "        P24000 = "+rows[j].getInt(idx[13])+", P25000 = "+rows[j].getInt(idx[14])+", ");
						UpdateSql.append( "        P26000 = "+rows[j].getInt(idx[15])+", P27000 = "+rows[j].getInt(idx[16])+", ");
						UpdateSql.append( "        P28000 = "+rows[j].getInt(idx[17])+", P29000 = "+rows[j].getInt(idx[18])+", ");
						UpdateSql.append( "        P30000 = "+rows[j].getInt(idx[19])+", P31000 = "+rows[j].getInt(idx[20])+", ");
						UpdateSql.append( "        P32000 = "+rows[j].getInt(idx[21])+", P36000 = "+rows[j].getInt(idx[22])+", ");
						UpdateSql.append( "        P37000 = "+rows[j].getInt(idx[23])+", P38000 = "+rows[j].getInt(idx[24])+", ");
						UpdateSql.append( "        PX0010 = "+rows[j].getInt(idx[25])+", PX0020 = "+rows[j].getInt(idx[26])+", ");
						UpdateSql.append( "        PX0030 = "+rows[j].getInt(idx[27])+", S91000 = "+rows[j].getInt(idx[28])+", ");
						UpdateSql.append( "        T11000 = "+rows[j].getInt(idx[29])+", T12000 = "+rows[j].getInt(idx[30])+", ");
						UpdateSql.append( "        B11000 = "+rows[j].getInt(idx[31])+", B12000 = "+rows[j].getInt(idx[32])+", ");
						UpdateSql.append( "        B13000 = "+rows[j].getInt(idx[33])+", B14000 = "+rows[j].getInt(idx[34])+", ");
						UpdateSql.append( "        B15000 = "+rows[j].getInt(idx[35])+", B16000 = "+rows[j].getInt(idx[36])+", "); 
						UpdateSql.append( "        BX0010 = "+rows[j].getInt(idx[37])+", BX0020 = "+rows[j].getInt(idx[38])+", "); 
						UpdateSql.append( "        BX0030 = "+rows[j].getInt(idx[39])+", BX0040 = "+rows[j].getInt(idx[40])+", "); 
						UpdateSql.append( "        S93000 = "+rows[j].getInt(idx[41])+", S94000 = "+rows[j].getInt(idx[42])+", "); 
						UpdateSql.append( "        P34000 = "+rows[j].getInt(idx[43])+", P39000 = "+rows[j].getInt(idx[44])+", ");
						UpdateSql.append( "        P41000 = "+rows[j].getInt(idx[45])+", P42000 = "+rows[j].getInt(idx[46])+", "); 
						UpdateSql.append( "        T21000 = "+rows[j].getInt(idx[47])+", T22000 = "+rows[j].getInt(idx[48])+", "); 
						UpdateSql.append( "        STRTDT = '"+rows[j].getString(idx[49])+"', B17000 = "+rows[j].getInt(idx[50])+", "); 
						UpdateSql.append( "        P43000 = "+rows[j].getInt(idx[51])+", P35000 = "+rows[j].getInt(idx[52])+", "); 
						UpdateSql.append( "		     PX0040 = "+rows[j].getInt(idx[53])+", ");
			      UpdateSql.append( "        PR0020 = '"+rows[j].getString(idx[54])+"'," );		
						UpdateSql.append( "        PR0030 = '"+rows[j].getString(idx[55])+"'," );		
						UpdateSql.append( "        PR0040 = '"+rows[j].getString(idx[56])+"'," );		
            UpdateSql.append( "        BR0020 = '"+rows[j].getString(idx[57])+"'," );		
            UpdateSql.append( "        BR0030 = '"+rows[j].getString(idx[58])+"'," );		
            UpdateSql.append( "        BR0040 = '"+rows[j].getString(idx[59])+"'," );		
            UpdateSql.append( "        CHAGDT = '"+rows[j].getString(idx[60])+"'," );	
						UpdateSql.append( "        APLAMT = '"+rows[j].getString(idx[61])+"'," );	
            UpdateSql.append( "        APLRAT = '"+rows[j].getString(idx[62])+"'," );	
						UpdateSql.append( "        APJAMT = '"+rows[j].getString(idx[63])+"'," );	
            UpdateSql.append( "        TRAINYN ='"+rows[j].getString(idx[64])+"'" );		
						UpdateSql.append( "  WHERE EMPNO ='"+rows[j].getString(idx[0])+"'  AND APPDT ='"+rows[j].getString(idx[1])+"' ");
						UpdateSql.append( "    AND PAYDIV ='"+rows[j].getString(idx[2])+"' AND PAYDT ='"+rows[j].getString(idx[3])+"' " );
						//UpdateSql.append( "  WHERE EMPNO = "+row[j].getString(idx[0])+" AND APPDT = ? AND PAYDIV = ? AND PAYDT = ? ");
						//UpdateSql.append( "  WHERE EMPNO = ? AND APPDT = ? AND PAYDIV = ? AND PAYDT = ? ");

						GauceStatement gsmt = conn.getGauceStatement(UpdateSql.toString());
						gsmt.setGauceDataRow(rows[j]);

						//for (int s=1;s<52;s++) {							
						//	if (s<=52) gsmt.bindColumn(s, idx[s]);
						
						gsmt.executeUpdate(); 
						gsmt.close();
                           
						//}//end for
					}
						
					if(rows[j].getJobType() == GauceDataRow.TB_JOB_DELETE ) {
						DeleteSql = new StringBuffer();
						DeleteSql.append( " DELETE FROM PAYROLL.PBPAY " );
						DeleteSql.append( "  WHERE EMPNO = ? AND APPDT = ? AND PAYDIV = ? AND PAYDT = ? " );

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