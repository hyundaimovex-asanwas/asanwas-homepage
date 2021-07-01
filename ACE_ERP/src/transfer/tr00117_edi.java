package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class �̸��� ȭ�ϸ�� �׻� �����ؾ� ��.
public class tr00117_edi extends HttpServlet {

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
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }
				
				
				String str0 = GauceReq.getParameter("v_str0");   
					if (str0==null || str0.trim().length()==0 ) {   str0=null; } //�����Ա���
				String str1 = GauceReq.getParameter("v_str1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; } //������Ʈ �ڵ�
				String str2 = GauceReq.getParameter("v_str2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; } //��������_from
				String str3 = GauceReq.getParameter("v_str3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; } //��������_to
				String str4 = GauceReq.getParameter("v_str4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; } //���ۿ���
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "EDI_STS", "PL_NO","IN_OUT","PL_SHIPPER","PL_SHPPRNM","PL_SHPADD1","PL_SHPADD2","PL_SHPADD3","PL_SHPTEL","PL_CSTM","PL_CSTMNM","PL_CSTADD1","PL_CSTADD2","PL_CSTADD3","PL_CSTTEL","PL_BRKR","PL_BRKRNM","PL_BRKADD1","PL_BRKADD2","PL_BRKADD3","PL_BRKTEL","PL_NOTICE","PLNOTICENM","START_LCT","REACH_LCT","TRANS_CAR","START_DT","INVOICE_NO","INVOICE_DT","REMARK","LCNO","LCDATE","LCBANK","WEIGHT","T_WEIGHT","T_CBM","GORDER_NO","PACKING_CNT","PACKING_UNIT","PACKING_CBM","TELEPHONE","RPR_GOODS","CARGO_TYPE","DNG_TYPE","CAR_TYPE","ORDER_NO","DCL_DATE","DCL_NO","CURRENCY","CREATE_DT","CREATE_USR","UPDATE_DT","UPDATE_USR" ,"START_TIME","LINE_PART","PL_CSN","PL_CSNNM","PL_CSNTEL","PL_CSNADDR","PL_CSNADDR2","PL_CSNADDR3",
					"START_LCTNM", "REACH_LCTNM"}; 

				int[] intArrCN = new int[] { 10, 20,1,13,35,35,35,35,25,13,35,35,35,35,25,13,35,35,35,35,25,13,100,10,10,100,8,20,8,512,15,8,4,13,13,13,15,13,10,13,14,100,4,4,4,10,8,18,10,10,10,10,10,4,10,13,35,25,35,35,35,
					30, 30 }; 
			
				int[] intArrCN2 = new int[]{ -1, -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,2,2,2,-1,2,-1,2,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
					-1, -1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {					
					StringBuffer sql = new StringBuffer();
					sql.append( " SELECT	  \n")
						 .append("				CASE WHEN A.EDI_STS = 'S'  THEN '����'  ELSE  '������'  END AS EDI_STS, \n")		 						 
						 .append( "				A.PL_NO,A.IN_OUT,A.PL_SHIPPER,A.PL_SHPPRNM,A.PL_SHPADD1,A.PL_SHPADD2, \n")
						 .append( "					A.PL_SHPADD3,A.PL_SHPTEL,A.PL_CSTM,A.PL_CSTMNM,A.PL_CSTADD1, \n")
						 .append( "					A.PL_CSTADD2,A.PL_CSTADD3,A.PL_CSTTEL,A.PL_BRKR,A.PL_BRKRNM, \n")
						 .append( "					A.PL_BRKADD1,A.PL_BRKADD2,A.PL_BRKADD3,A.PL_BRKTEL,'' AS PL_NOTICE, \n")
						 .append( "					'' AS PLNOTICENM,A.START_LCT,A.REACH_LCT,A.TRANS_CAR,A.START_DT, \n")
						 .append( "					A.INVOICE_NO,A.INVOICE_DT,A.REMARK,A.LCNO,A.LCDATE,A.LCBANK,A.WEIGHT, \n")
						 .append( "					A.T_WEIGHT,A.T_CBM,A.GORDER_NO,A.PACKING_CNT,A.PACKING_UNIT, \n")
						 .append( "					A.PACKING_CBM,A.TELEPHONE,A.RPR_GOODS,A.CARGO_TYPE,A.DNG_TYPE, \n")
						 .append( "					A.CAR_TYPE,A.ORDER_NO,A.DCL_DATE,A.DCL_NO,A.CURRENCY, \n")
						 .append( "					A.CREATE_DT,A.CREATE_USR,A.UPDATE_DT,A.UPDATE_USR,A.START_TIME,IFNULL(A.LINE_PART,'') AS LINE_PART,  \n")
						 .append(" 					IFNULL(A.PL_CSN,'') AS PL_CSN ,IFNULL(A.PL_CSNNM,'') AS PL_CSNNM ,IFNULL(A.PL_CSNTEL,'') AS PL_CSNTEL, \n")
						 .append(" 					IFNULL(A.PL_CSNADDR,'') AS PL_CSNADDR ,IFNULL(A.PL_CSNADDR2,'') AS PL_CSNADDR2, \n")
						 .append(" 					IFNULL(A.PL_CSNADDR3,'') AS PL_CSNADDR3, B.MINORNM AS START_LCTNM, C.MINORNM AS REACH_LCTNM  \n")
						 .append( "		FROM	TRANSFER.LTPCKLSCI A \n")
						 .append( "		LEFT JOIN TRANSFER.LTLCODE B ON B.MINORCD = A.START_LCT   AND B.MAJORCD = '0007'  \n")
						 .append( "		LEFT JOIN TRANSFER.LTLCODE C ON C.MINORCD = A.REACH_LCT   AND C.MAJORCD = '0007' \n")		
						 .append( "	 WHERE	 A.PL_NO IS NOT NULL \n")
						 .append( "    AND  A.IN_OUT = '" + str0 + "' \n");

					if(str1 != null ){     sql.append( " AND A.LINE_PART ='" + str1 + "'" ) ;  }
					if(str2 != null  &&  str3 != null ) {sql.append ( "  AND A.START_DT BETWEEN '" + str2 + "' AND '" + str3 + "'" ) ; }
			    	if(str4 != null  &&  !str4.equals("K"))    			     sql.append    (" AND  A.EDI_STS = '" + str4 + "' ") ;	 
					if(str4.equals("K"))					 sql.append    (" AND  ( A.EDI_STS = ''  OR A.EDI_STS IS NULL ) " ) ;	  

					logger.dbg.println(this,sql.toString());

//					if (isDebug) GauceRes.writeException("Sql",":",sql.toString());

					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
				}
				
/*********************************************************************************************/

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