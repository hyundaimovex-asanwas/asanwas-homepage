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
public class dsLdCarGoods extends HttpServlet {
 
	// ���������� ���� ���۹���� Post Ÿ���� ���
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		//System.out.println("dsLdCarGoods:;����");
		//ServiceLoader loader = new ServiceLoader(req, res);
		com.gauce.ServiceLoader loader = new com.gauce.ServiceLoader(req, res);
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
				 
				
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
							 

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CHK","ARTC_NM","ORDER_NO","ORDER_SEQ","ARTC_CNT","ARTC_UNIT","PUNIT_CNT",
								"PUNIT_UNIT","PUNIT_WGHT","PKG_LNGTH","PKG_HEIGHT","PKG_WIDTH",
								"PKG_CBM","PKG_CNT","SAMEAS","CAR_SEQ_NO","LD_ARTC_CNT","LD_ARTC_UNIT",
								"LD_PKG_CNT","LD_PKG_UNIT","LD_PKG_WGHT","LD_PKG_CBM", "EXT_ARTC_CNT","EXT_PKG_CNT",
								"EXT_PKG_CBM" }; 

				int[] intArrCN = new int[] {1,50,10,10,13,10,13,10,13,13,13,13,13,13,10,10,13,13,13,13,13,13,13,13,13 }; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,2,-1,2,-1,2,2,2,2,2,2,-1,-1,2,-1,2,-1,2,2,2,2,2}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT CASE WHEN CAR_SEQ_NO IS NULL THEN 'F' ELSE 'T' END AS CHK,") ;  
						sql.append( " D.ARTC_NM,D.ORDER_NO, D.ORDER_SEQ ,D.ARTC_CNT, D.ARTC_UNIT ,   ") ;    
						sql.append( " D.PUNIT_CNT, D.PUNIT_UNIT,D.PUNIT_WGHT, D.PKG_LNGTH  ,   ") ;   
						sql.append( " D.PKG_HEIGHT, D.PKG_WIDTH,D.PKG_CBM,D.PKG_CNT  ,D.SAMEAS, ") ;  
						sql.append( " NVL(G.CAR_SEQ_NO,'') AS CAR_SEQ_NO, ") ;  
						sql.append( " NVL(G.ARTC_CNT,0) AS LD_ARTC_CNT,   ") ;  
						sql.append( " NVL(G.ARTC_UNIT,0) AS LD_ARTC_UNIT ,") ;  
						sql.append( " NVL(G.PKG_CNT,0) AS LD_PKG_CNT ,  ") ;  
						sql.append( " NVL(G.PKG_UNIT,0) AS LD_PKG_UNIT, ") ;  
						sql.append( " NVL(G.PKG_WGHT,0) AS LD_PKG_WGHT,   ") ;   
						sql.append( " NVL(G.PKG_CBM,0)  AS LD_PKG_CBM, ") ;  
						//sql.append( " NVL(G.PKG_HEIGHT,0) AS LD_PKG_HEIGHT,  ") ;     
						//sql.append( " NVL(G.PKG_WIDTH,0) AS LD_PKG_WIDTH, ") ;  
						//sql.append( " NVL(G.PKG_CBM,0) AS LD_PKG_CBM,  ") ;  
						//sql.append( " NVL(G.PKG_CNT,0) AS LD_PKG_CNT , ") ;  
						sql.append( " D.ARTC_CNT-(SELECT NVL(SUM(G1.ARTC_CNT),0) FROM  TRANSFER.LTCARGOODS G1  ") ;  
						sql.append( " WHERE D.ORDER_NO = G1.ORDER_NO  AND  D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_ARTC_CNT, ") ;  
						sql.append( " D.PKG_CNT-(SELECT NVL(SUM(G1.PKG_CNT),0) FROM  TRANSFER.LTCARGOODS G1  ") ;  
						sql.append( " WHERE D.ORDER_NO = G1.ORDER_NO  AND  D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_PKG_CNT, ") ;  
						sql.append( " D.PKG_CBM-(SELECT NVL(SUM(G1.PKG_CBM),0) FROM  TRANSFER.LTCARGOODS G1  ") ;  
						sql.append( " WHERE D.ORDER_NO = G1.ORDER_NO  AND  D.ORDER_SEQ = G1.ORDER_SEQ   ) AS EXT_PKG_CBM ") ;  
						sql.append( " FROM TRANSFER.LTORDERDTL D LEFT JOIN TRANSFER.LTCARGOODS G ") ;  
						sql.append( " ON D.ORDER_NO = G.ORDER_NO  AND  D.ORDER_SEQ = G.ORDER_SEQ   ") ; 
                        if(str2 !=null) {	sql.append( " AND G.CAR_SEQ_NO = '"  +  str2  + "'" ) ;  }
                        if(str1 !=null) {	sql.append( " WHERE D.ORDER_NO = '"  +  str1  + "'" ) ;  }

                        sql.append(" ORDER BY D.ORDER_NO, TO_NUMBER(D.ORDER_SEQ) ");
                        
                       

// if (isDebug) {	
						//GauceRes.writeException("Sql",":",sql.toString()); }
						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);
		 				
					}
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
			//GauceRes.writeException("Sql",":",e.toString());
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