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
public class dsLdCarGoodsEtc extends HttpServlet {
 
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
				
				
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = GauceReq.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
				String str4 = GauceReq.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }
				String str5 = GauceReq.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; } 
				String str6 = GauceReq.getParameter("gstr6");   
					if (str6==null || str6.trim().length()==0 ) {   str6=null; } 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CHECK","ARTC_NM","ORDER_NO","ORDER_SEQ","ARTC_CNT","ARTC_UNIT","PUNIT_CNT",
																				 "PUNIT_UNIT","PUNIT_WGHT","PKG_LNGTH","PKG_HEIGHT","PKG_WIDTH",
																				 "PKG_CBM","PKG_CNT","SAMEAS","CAR_SEQ_NO","LD_ARTC_CNT","LD_ARTC_UNIT",
																				 "LD_PKG_CNT","LD_PKG_UNIT","LD_PKG_WGHT","LD_PKG_CBM", "EXT_ARTC_CNT","EXT_PKG_CNT",
																				 "EXT_PKG_CBM","VEND_NM","IN_OUT", "I_ORDER_SEQ" }; 

				int[] intArrCN = new int[] {1,50,10,10,13,10,13,10,13,13,13,13,13,13,10,10,13,13,13,13,13,13,13,13,13,50 ,1,10}; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,2,-1,2,-1,2,2,2,2,2,2,-1,-1,2,-1,2,-1,2,2,2,2,2,-1,-1,0}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (isNotOnlyHeader) {		
					StringBuffer sql = new StringBuffer();

		sql.append( " SELECT	* FROM ( \n")
						 .append( " SELECT	* FROM ( \n")
						 .append( " SELECT	CASE WHEN CAR_SEQ_NO IS NULL THEN 'F' ELSE 'T' END AS CHECK, \n")
						 .append( "					D.ARTC_NM,D.ORDER_NO, D.ORDER_SEQ ,D.ARTC_CNT, D.ARTC_UNIT ,   \n")
						 .append( "					D.PUNIT_CNT, D.PUNIT_UNIT,D.PUNIT_WGHT, D.PKG_LNGTH  ,   \n")
						 .append( "					D.PKG_HEIGHT, D.PKG_WIDTH,D.PKG_CBM,D.PKG_CNT  ,D.SAMEAS, \n")
						 .append( "					IFNULL(G.CAR_SEQ_NO,'') AS CAR_SEQ_NO, \n")
						 .append( "					IFNULL(G.ARTC_CNT,0) AS LD_ARTC_CNT,   \n")
						 .append( "					IFNULL(G.ARTC_UNIT,0) AS LD_ARTC_UNIT , \n")
						 .append( "					IFNULL(G.PKG_CNT,0) AS LD_PKG_CNT ,  \n")
						 .append( "					IFNULL(G.PKG_UNIT,0) AS LD_PKG_UNIT, \n")
						 .append( "					IFNULL(G.PKG_WGHT,0) AS LD_PKG_WGHT, \n")
						 .append( "					IFNULL(G.PKG_CBM,0)  AS LD_PKG_CBM, \n")
						 .append( "					D.ARTC_CNT-(SELECT IFNULL(SUM(G1.ARTC_CNT),0) \n ")
						 .append( "												FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											 WHERE D.ORDER_NO = G1.ORDER_NO  \n")
						 .append( "												 AND D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_ARTC_CNT, \n")
						 .append( "					D.PKG_CNT-(SELECT IFNULL(SUM(G1.PKG_CNT),0)  \n")
						 .append( "											 FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											WHERE D.ORDER_NO = G1.ORDER_NO \n")
						 .append( "												AND  D.ORDER_SEQ = G1.ORDER_SEQ ) AS EXT_PKG_CNT, \n")
						 .append( "					D.PKG_CBM-(SELECT IFNULL(SUM(G1.PKG_CBM),0)   \n")
						 .append( "											 FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											WHERE D.ORDER_NO = G1.ORDER_NO \n")
						 .append( "												AND D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_PKG_CBM, \n")
						 .append( "					V.VEND_NM,M.IN_OUT,INTEGER(D.ORDER_SEQ)AS I_ORDER_SEQ\n")
						 .append( "		FROM  TRANSFER.LTORDERDTL D  \n")
						 .append( "					LEFT JOIN TRANSFER.LTCARGOODS G ON D.ORDER_NO = G.ORDER_NO AND D.ORDER_SEQ = G.ORDER_SEQ \n") ; 

if(str2 !=null) {	sql.append( " AND G.CAR_SEQ_NO = '"  +  str2  + "'" ) ;  }

					sql.append("					,TRANSFER.LTORDERMST M ,ACCOUNT.GCZM_VENDER V \n") ; 
					sql.append(" WHERE M.ORDER_NO = D.ORDER_NO AND V.VEND_CD = M.SHIPPER  \n") ; 

if(str1 !=null) {	sql.append( " AND D.ORDER_NO = '"  +  str1  + "'" ) ;  }
if(str3 !=null) {	sql.append( " AND M.IN_OUT = '"  +  str3  + "'" ) ;  }
if(str5 !=null) { sql.append( " AND M.ETD_DT = '" +str5 + "'");} //분할 반출
if(str6 !=null) { sql.append( " AND M.LINE_PART = '" +str6 + "'");} //분할 반출
/*
					sql.append( " SELECT	* FROM ( \n")
						 .append( " SELECT	CASE WHEN CAR_SEQ_NO IS NULL THEN 'F' ELSE 'T' END AS CHECK, \n")
						 .append( "					D.ARTC_NM,D.ORDER_NO, D.ORDER_SEQ ,D.ARTC_CNT, D.ARTC_UNIT ,   \n")
						 .append( "					D.PUNIT_CNT, D.PUNIT_UNIT,D.PUNIT_WGHT, D.PKG_LNGTH  ,   \n")
						 .append( "					D.PKG_HEIGHT, D.PKG_WIDTH,D.PKG_CBM,D.PKG_CNT  ,D.SAMEAS, \n")
						 .append( "					IFNULL(G.CAR_SEQ_NO,'') AS CAR_SEQ_NO, \n")
						 .append( "					IFNULL(G.ARTC_CNT,0) AS LD_ARTC_CNT,   \n")
						 .append( "					IFNULL(G.ARTC_UNIT,0) AS LD_ARTC_UNIT , \n")
						 .append( "					IFNULL(G.PKG_CNT,0) AS LD_PKG_CNT ,  \n")
						 .append( "					IFNULL(G.PKG_UNIT,0) AS LD_PKG_UNIT, \n")
						 .append( "					IFNULL(G.PKG_WGHT,0) AS LD_PKG_WGHT, \n")
						 .append( "					IFNULL(G.PKG_CBM,0)  AS LD_PKG_CBM, \n")
						 .append( "					D.ARTC_CNT-(SELECT IFNULL(SUM(G1.ARTC_CNT),0) \n ")
						 .append( "												FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											 WHERE D.ORDER_NO = G1.ORDER_NO  \n")
						 .append( "												 AND D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_ARTC_CNT, \n")
						 .append( "					D.PKG_CNT-(SELECT IFNULL(SUM(G1.PKG_CNT),0)  \n")
						 .append( "											 FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											WHERE D.ORDER_NO = G1.ORDER_NO \n")
						 .append( "												AND  D.ORDER_SEQ = G1.ORDER_SEQ ) AS EXT_PKG_CNT, \n")
						 .append( "					D.PKG_CBM-(SELECT IFNULL(SUM(G1.PKG_CBM),0)   \n")
						 .append( "											 FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											WHERE D.ORDER_NO = G1.ORDER_NO \n")
						 .append( "												AND D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_PKG_CBM, \n")
						 .append( "					V.VEND_NM,M.IN_OUT \n")
						 .append( "		FROM  TRANSFER.LTORDERDTL D  \n")
						 .append( "					LEFT JOIN TRANSFER.LTCARGOODS G ON D.ORDER_NO = G.ORDER_NO AND D.ORDER_SEQ = G.ORDER_SEQ \n") ; 

//if(str2 !=null) {	sql.append( " AND G.CAR_SEQ_NO = '"  +  str2  + "'" ) ;  }

					sql.append("					,TRANSFER.LTORDERMST M ,ACCOUNT.GCZM_VENDER V \n") ; 
					sql.append(" WHERE M.ORDER_NO = D.ORDER_NO AND V.VEND_CD = M.SHIPPER  \n") ; 

if(str1 !=null) {	sql.append( " AND  D.ORDER_NO = '"  +  str1  + "'" ) ;  }
if(str3 !=null) {	sql.append( " AND  M.IN_OUT = '"  +  str3  + "'" ) ;  }
//if(str5 !=null) { sql.append(" AND M.ETD_DT = '" +str5 + "'");} //분할 반출
*/
		//  str4 != null && !str4.equals("Y") &&

					sql.append(" ) T WHERE T.LD_ARTC_CNT > 0 OR EXT_ARTC_CNT > 0 ") ; 

					sql.append(" UNION ALL ") ; 

					sql.append( " SELECT	* FROM ( \n")
						 .append( " SELECT	'F' AS CHECK, \n")
						 .append( "					D.ARTC_NM,D.ORDER_NO, D.ORDER_SEQ ,D.ARTC_CNT, D.ARTC_UNIT ,   \n")
						 .append( "					D.PUNIT_CNT, D.PUNIT_UNIT,D.PUNIT_WGHT, D.PKG_LNGTH  ,   \n")
						 .append( "					D.PKG_HEIGHT, D.PKG_WIDTH,D.PKG_CBM,D.PKG_CNT  ,D.SAMEAS, \n")
						 .append( "					IFNULL(G.CAR_SEQ_NO,'') AS CAR_SEQ_NO, \n")
						 .append( "					0 AS LD_ARTC_CNT,   \n")
						 .append( "					IFNULL(G.ARTC_UNIT,0) AS LD_ARTC_UNIT , \n")
						 .append( "					0 AS LD_PKG_CNT ,  \n")
						 .append( "					IFNULL(G.PKG_UNIT,0) AS LD_PKG_UNIT, \n")
						 .append( "					0 AS LD_PKG_WGHT, \n")
						 .append( "					0  AS LD_PKG_CBM, \n")
						 .append( "					(SELECT IFNULL(SUM(G1.ARTC_CNT),0) \n ")
						 .append( "												FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											 WHERE D.ORDER_NO = G1.ORDER_NO  \n")
						 .append( "												 AND D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_ARTC_CNT, \n")
						 .append( "					(SELECT IFNULL(SUM(G1.PKG_CNT),0)  \n")
						 .append( "											 FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											WHERE D.ORDER_NO = G1.ORDER_NO \n")
						 .append( "												AND  D.ORDER_SEQ = G1.ORDER_SEQ ) AS EXT_PKG_CNT, \n")
						 .append( "					(SELECT IFNULL(SUM(G1.PKG_CBM),0)   \n")
						 .append( "											 FROM TRANSFER.LTCARGOODS G1  \n")
						 .append( "											WHERE D.ORDER_NO = G1.ORDER_NO \n")
						 .append( "												AND D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_PKG_CBM, \n")
						 .append( "					V.VEND_NM,M.IN_OUT,INTEGER(D.ORDER_SEQ)AS I_ORDER_SEQ \n")
						 .append( "		FROM  TRANSFER.LTORDERDTL D  \n")
						 .append( "					LEFT JOIN TRANSFER.LTCARGOODS G ON D.ORDER_NO = G.ORDER_NO AND D.ORDER_SEQ = G.ORDER_SEQ , \n" )
						 .append("					TRANSFER.LTORDERMST M , \n")
						 .append("					ACCOUNT.GCZM_VENDER V \n")
						 .append("	 WHERE M.ORDER_NO = D.ORDER_NO AND V.VEND_CD = M.SHIPPER \n")
						 .append("		 AND G.CAR_SEQ_NO = 'null' \n");

if(str1 !=null) {	sql.append( " AND D.ORDER_NO = '"  +  str1  + "'" ) ;  }
if(str3 !=null) {	sql.append( " AND M.IN_OUT = '"  +  str3  + "'" ) ;  }
if(str5 !=null) { sql.append( " AND M.ETD_DT = '" +str5 + "'");} //분할 반출
if(str6 !=null) { sql.append( " AND M.LINE_PART = '" +str6 + "'");} //분할 반출
					sql.append(" ) T  ") ; 

					sql.append(" ) X ORDER BY ORDER_NO, INTEGER(I_ORDER_SEQ) ") ; 

			    //logger.dbg.println(this,sql.toString());

					stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
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