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
public class dsOrderSts1 extends HttpServlet {

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
				
				String str0 = GauceReq.getParameter("gstr0");   
					if (str0==null || str0.trim().length()==0 ) {   str0=null; }
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
				String str7 = GauceReq.getParameter("gstr7");   
					if (str7==null || str7.trim().length()==0 ) {   str7=null; } //2008.10.29 정영식 추가 - 납품구분

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{"CHECK","ORDER_NO","ORDER_STS","ETD_DT","LINE_PART","CDNAM","CUST","SHIPPER","CARGO_TYPE","PROJECT","CAR_SEQ_NO","CARTYPENO","CAR_CNT","LD_DATE","EDT_DATE","ARTC_NM","ARTC_CNT","PKG_CNT","PKG_CBM","PKG_WGHT","ORDER_SEQ","CARINFO","CRE_DATE","LD_CARGO","OFF_CARGO","OBJ_REMK", "CAR_NO","DLVL_TYPE"}; 
				int[] intArrCN = new int[] { 1,10,4,8,4,50,50,50,4,10,10,10,4,8,8,50,13,13,13,13,10,30,10,10,10,100, 20, 4 }; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,-1,-1,-1,0,2,2,2,-1 ,-1,-1,-1,-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append(" SELECT '' AS CHECK,A.ORDER_NO, \n ")
							 .append("				CASE WHEN A.ORDER_STS <> IFNULL(F.ORDER_STS,'0001') THEN '0004' ELSE A.ORDER_STS END  AS ORDER_STS,A.ETD_DT,A.LINE_PART,E.CDNAM, \n ")
							 .append("				B.VEND_NM AS CUST,C.VEND_NM AS SHIPPER,CARGO_TYPE,A.PROJECT, \n ")
							 .append("				IFNULL(D.CAR_SEQ_NO,'') AS CAR_SEQ_NO,\n ")
							 .append("				IFNULL(D.CARTYPENO,'') AS CARTYPENO,IFNULL(D.CAR_CNT,0) AS CAR_CNT,  \n ")
							 .append("				IFNULL(G.ENTER_DATE,'') AS LD_DATE, \n ")
							 .append("				IFNULL(A.ETD_DT,'') AS EDT_DATE,F.ORDER_SEQ CONCAT ':' CONCAT F.ARTC_NM AS ARTC_NM, \n ")
							 .append("				CASE WHEN  K.ARTC_CNT IS NULL THEN F.ARTC_CNT ELSE K.ARTC_CNT END  AS ARTC_CNT, \n ")
							 .append("				CASE WHEN  K.PKG_CNT IS NULL THEN F.PKG_CNT ELSE K.PKG_CNT END  AS PKG_CNT, \n ")
							 .append("				CASE WHEN  K.PKG_CBM IS NULL THEN   F.PKG_CBM*F.PKG_CBM ELSE K.PKG_CBM END  AS PKG_CBM, \n ")
							 .append("				CASE WHEN  K.PKG_WGHT IS NULL THEN F.PUNIT_WGHT*F.PKG_CBM ELSE K.PKG_WGHT END  AS PKG_WGHT, \n ")
							 .append("				F.ORDER_SEQ, \n ")
							 .append("				CASE WHEN D.CAR_SEQ_NO IS NOT  NULL THEN \n")
							 .append("				IFNULL(D.CAR_SEQ_NO,'') concat ' : ' CONCAT IFNULL(P.CAR_NAME,'') CONCAT ' ' CONCAT  IFNULL(D.CAR_CNT,0) CONCAT ' 대 ' \n")
							 .append("				ELSE '혼재' END AS CARINFO, DATE(A.CREATE_DT) CRE_DATE, IFNULL(D.LD_CARGO,'') LD_CARGO, IFNULL(D.OFF_CARGO,'') OFF_CARGO, A.OBJ_REMK,\n ")
							 .append("				RTRIM(Q.CAR_NO)CAR_NO,A.DLVL_TYPE \n ") //2008.10.29 JYS 추가
							 .append("	 FROM TRANSFER.LTORDERMST A   \n ")
							 .append("				LEFT JOIN ACCOUNT.COMMDTIL E ON E.CMTYPE = '0030' AND A.PROJECT = E.CDCODE, \n ")
							 .append("				TRANSFER.LTORDERDTL F   \n ")
							 //.append("				LEFT JOIN TRANSFER.LTINWRHS G ON F.ORDER_NO = G.ORDER_NO AND F.ORDER_SEQ = G.ORDER_SEQ \n ")
							 .append("		    LEFT JOIN ( SELECT DISTINCT ENTER_DATE, ORDER_NO, ORDER_SEQ     \n ")
							 .append("				              FROM TRANSFER.LTINWRHS                            \n ")
               .append("				          ) G ON F.ORDER_NO = G.ORDER_NO AND F.ORDER_SEQ = G.ORDER_SEQ   \n ") 
							 .append("				LEFT JOIN TRANSFER.LTCARGOODS K ON F.ORDER_NO = K.ORDER_NO AND  F.ORDER_SEQ = K.ORDER_SEQ \n ")
							 .append("				LEFT JOIN TRANSFER.LTORDCAR D ON D.ORDER_NO = K.ORDER_NO AND D.CAR_SEQ_NO = K.CAR_SEQ_NO \n ")
							 .append("				LEFT JOIN TRANSFER.LTCARTYPE P ON D.CARTYPENO = P.CAR_TYPE \n ")
               .append("				LEFT JOIN TRANSFER.LTCARACC Q ON Q.CAR_SEQ_NO = D.CAR_SEQ_NO AND Q.ACCSECTION = D.IN_OUT, \n ") //2008.10.29. 정영식 추가 
							 .append("				ACCOUNT.GCZM_VENDER B , ACCOUNT.GCZM_VENDER C  \n ")
							 .append("  WHERE A.CUST_CD = B.VEND_CD   \n ")
							 .append("		AND A.SHIPPER = C.VEND_CD   \n ")
							 .append("		AND A.ORDER_NO = F.ORDER_NO \n ")
							 .append("		AND A.IN_OUT = '" + str0 +  "' ");

						if(str1 != null && str2 != null)   	sql.append(" AND A.ETD_DT BETWEEN '" +str1 + "' AND  '" + str2 + "'" ) ;  
						if(str3 != null )sql.append(" AND A.LINE_PART = '" + str3 + "'" ) ; 
						if(str4 != null )sql.append(" AND A.ORDER_NO = '" + str4 + "'" ) ; 
						if(str5 != null &&!str5.equals("0004"))  sql.append( " AND A.ORDER_STS = '" + str5 + "'" ) ; 
						if(str5 != null && str5.equals("0004"))  sql.append( " AND A.ORDER_STS = '0002' AND ( F.ORDER_STS <> '0002'  OR  F.ORDER_STS is null )" ) ; 
						if(str6 !=null  )sql.append(" AND A.ETD_DT     =   '" +str6 + "'" );
						if(str7 !=null  )sql.append(" AND A.DLVL_TYPE  =   '" +str7 + "'" );
						sql.append(" ORDER BY A.ORDER_NO,D.CAR_SEQ_NO,INTEGER(F.ORDER_SEQ)  \n ") ;

						logger.dbg.println(this, sql.toString());
						stmt = conn.getGauceStatement(sql.toString());
		 				stmt.executeQuery(dSet);
						 
					}
				
/*********************************************************************************************/

			} catch(Exception e) {
			GauceRes.writeException("Sql",":",e.toString());	
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