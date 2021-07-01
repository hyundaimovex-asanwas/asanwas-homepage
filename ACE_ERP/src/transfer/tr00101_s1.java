package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
 
// class 이름은 화일명과 항상 동일해야 함.
public class tr00101_s1 extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
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
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				boolean isNotOnlyHeader = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				
				String str1 = GauceReq.getParameter("gstr1");   //order No
				if (str1==null || str1.trim().length()==0 ) {   str1=null; }

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "ORDER_NO","IN_OUT","ORDER_STS","ETD_DT","LINE_PART","PROJECT","CUST_CD","CUST_PRSN","CUST_TELNO","CARGO_TYPE","DLVL_TYPE","DLVL_DATE","SHIPPER","SHIPPERPS","SHIPPERTEL","ETA_DT","ORDER_DATE","FEE_IN","FEE_OUT","GORDER_NO","RQST_NO","PL_TYPE","PL_SHIPPER","PL_SHPPRNM","PL_CSTM","PL_CSTMNM","PL_BRKR","PL_BRKRNM","RPST_GOODS","TOTAL_CNT","TOTAL_UNIT","TOTAL_WGHT","TOTAL_CBM","CANCLE_DATE","REMARK","PRICETYPE","SETTLETYPE","LC_NO","LC_DATE","LC_BANK","EXPRT_NO","EXPRT_DATE","LDCARGO","LDCARGONM","OFFCARGO","OFFCARGONM" ,"CREATE_USR","UPDATE_USR","CONSIGNEE" ,"CUST_HPNO","SHIPPERHP","DIV_IO","PL_SHIPADDR","PL_SHIPTEL","PL_CSTADDR","PL_CSTTEL","PL_BRKADDR","PL_BRKTEL","PL_SHPADDR2","PL_SHPADDR3","PL_CSTADDR2","PL_CSTADDR3","PL_BRKADDR2","PL_BRKADDR3","PL_CSN","PL_CSNNM","PL_CSNTEL","PL_CSNADDR","PL_CSNADDR2","PL_CSNADDR3","ETD_DT1","FAC_PERSON","FAC_PRSTEL","ATT_FILENM","OBJ_REMK", "RECIPIENT", "RECP_OWN", "RECP_TEL", "RECP_ADD"}; 

				int[] intArrCN = new int[] { 10,1,4,12,4,10,13,50,13,4,4,8,13,50,13,8,8,1,1,8,12,1,13,50,13,50,13,100,10,13,4,13,13,8,400,4,4,20,8,4,14,8,10,30 ,10,30,10,10 ,160,15,15,1,105,25,105,25,105,25,35,35,35,35,35,35,13,35,25,35,35,35,8,30,20,3,100,50,50,20,70}; 
			
				int[] intArrCN2 = new int[]{ -1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,2,-1,2,2,-1,-1,-1,-1,-1,-1,-1,-1,-1, -1 ,-1, -1 ,-1, -1 ,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				//dSet.addDataColumn(new GauceDataColumn("ATT_FILE", GauceDataColumn.TB_URL));
				dSet.addDataColumn(new GauceDataColumn("ATT_FILE", GauceDataColumn.TB_URL));
				
				if (isNotOnlyHeader) {			
					StringBuffer sql = new StringBuffer();
					  sql.append(" SELECT ORDER_NO,IN_OUT,ORDER_STS,ETD_DT,LINE_PART, \n " )
						 .append("		  PROJECT,CUST_CD,CUST_PRSN,CUST_TELNO,CARGO_TYPE, \n " )
						 .append("		  DLVL_TYPE,DLVL_DATE,SHIPPER,SHIPPERPS,SHIPPERTEL, \n " )
						 .append("		  ETA_DT,ORDER_DATE,FEE_IN,FEE_OUT,GORDER_NO, \n " )
						 .append("		  RQST_NO,PL_TYPE,PL_SHIPPER,PL_SHPPRNM,PL_CSTM, \n " )
						 .append("		  PL_CSTMNM,PL_BRKR,PL_BRKRNM,RPST_GOODS,TOTAL_CNT, \n " )
						 .append("	   	  TOTAL_UNIT,TOTAL_WGHT,TOTAL_CBM,CANCLE_DATE,REMARK, \n " )
						 .append("		  PRICETYPE,SETTLETYPE,LC_NO,LC_DATE,LC_BANK, \n " )
						 .append("		  EXPRT_NO,EXPRT_DATE, \n " )
						 .append("		  LDCARGO,LDCARGONM,OFFCARGO,OFFCARGONM, \n " )
						 .append("		  CREATE_USR, UPDATE_USR ,NVL(CONSIGNEE,'') AS CONSIGNEE, \n " )
						 .append("		  NVL(CUST_HPNO,'') AS CUST_HPNO,NVL(SHIPPERHP,'') AS SHIPPERHP, \n " )
						 .append("		  NVL(DIV_IO,'') AS DIV_IO , NVL(PL_SHIPADDR,'') AS PL_SHIPADDR, \n " )
						 .append("		  NVL(PL_SHIPTEL,'') AS PL_SHIPTEL,NVL(PL_CSTADDR,'') AS PL_CSTADDR, \n " )
						 .append("		  NVL(PL_CSTTEL,'') AS PL_CSTTEL ,NVL(PL_BRKADDR,'') AS PL_BRKADDR, \n " )
						 .append("		  NVL(PL_BRKTEL,'') AS PL_BRKTEL, \n " )
						 .append("		  NVL(PL_SHPADDR2,'') AS PL_SHPADDR2,NVL(PL_SHPADDR3,'') AS PL_SHPADDR3, \n " )
						 .append("		  NVL(PL_CSTADDR2,'') AS PL_CSTADDR2,NVL(PL_CSTADDR3,'') AS PL_CSTADDR3, \n " )
						 .append("		  NVL(PL_BRKADDR2,'') AS PL_BRKADDR2,NVL(PL_BRKADDR3,'') AS PL_BRKADDR3, \n " )
						 .append("		  NVL(PL_CSN,'') AS PL_CSN ,NVL(PL_CSNNM,'') AS PL_CSNNM ,NVL(PL_CSNTEL,'') AS PL_CSNTEL, \n " )
						 .append("		  NVL(PL_CSNADDR,'') AS PL_CSNADDR ,NVL(PL_CSNADDR2,'') AS PL_CSNADDR2, \n " )
						 .append("		  NVL(PL_CSNADDR3,'') AS PL_CSNADDR3,NVL(ETD_DT1,'') AS ETD_DT1, FAC_PERSON, FAC_PRSTEL, ATT_FILENM, \n " )
						 .append("		  RTRIM(OBJ_REMK) OBJ_REMK, RTRIM(RECIPIENT) RECIPIENT, RTRIM(RECP_OWN) RECP_OWN, RTRIM(RECP_TEL) RECP_TEL, RTRIM(RECP_ADD) RECP_ADD, ATT_FILE\n " )
						 .append("	 FROM TRANSFER.LTORDERMST \n " )
						 .append("  WHERE ORDER_NO IS NOT NULL \n " );

					if (str1 !=null) sql.append(" AND ORDER_NO = '" + str1 + "'");
					
					System.out.println("tr00101_s1::"+sql.toString());

					stmt = conn.getGauceStatement(sql.toString());
					System.out.println("tr00101_s1:: success1");
					stmt.executeQuery(dSet);
					
					System.out.println("tr00101_s1:: success2");
				}
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
			GauceRes.writeException("Sql",":",e.toString());
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