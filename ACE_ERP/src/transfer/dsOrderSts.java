package transfer;

import com.gauce.*;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;

import transfer.common.HDConnJndi;
import transfer.common.SuperServlet;

import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class dsOrderSts extends HttpServlet {

	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;
		GauceDataSet dSet = null;

		try {
			GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
            GauceOutputStream gos = ((HttpGauceResponse)res).getGauceOutputStream();
            			
            HDConnJndi JndiConn = new HDConnJndi();
            conn  = JndiConn.getHdConnection(req, res);
         
            dSet = new GauceDataSet();
            gos.fragment(dSet);
			try {
			
/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				boolean isNotOnlyHeader = false;
				if ( req.getParameter("NOH")!=null && req.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				
				String str0 = req.getParameter("gstr0");   
					if (str0==null || str0.trim().length()==0 ) {   str0=null; }
				String str1 = req.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = req.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				String str3 = req.getParameter("gstr3");   
					if (str3==null || str3.trim().length()==0 ) {   str3=null; }
				String str4 = req.getParameter("gstr4");   
					if (str4==null || str4.trim().length()==0 ) {   str4=null; }
				String str5 = req.getParameter("gstr5");   
					if (str5==null || str5.trim().length()==0 ) {   str5=null; }

		
					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append(" SELECT '' AS CHK, A.ORDER_NO, \n ")
							 .append("				CASE WHEN A.ORDER_STS <> NVL(F.ORDER_STS,'0001') THEN '수정' ELSE A.ORDER_STS END  AS ORDER_STS,A.ETD_DT,A.LINE_PART,E.CDNAM, \n ")
							 .append("				B.VEND_NM AS CUST,C.VEND_NM AS SHIPPER,CARGO_TYPE,A.PROJECT, \n ")
							 .append("				NVL(D.CAR_SEQ_NO,'') AS CAR_SEQ_NO,\n ")
							 .append("				NVL(D.CARTYPENO,'') AS CARTYPENO,NVL(D.CAR_CNT,0) AS CAR_CNT,  \n ")
							 .append("				'' LD_DATE, \n ")
							  // .append("				NVL(G.ENTER_DATE,'') AS LD_DATE, \n ")
							 .append("				NVL(A.ETD_DT,'') AS EDT_DATE,F.ORDER_SEQ || ':' || F.ARTC_NM AS ARTC_NM, \n ")
							 .append("				CASE WHEN  K.ARTC_CNT IS NULL THEN F.ARTC_CNT ELSE K.ARTC_CNT END  AS ARTC_CNT, \n ")
							 .append("				CASE WHEN  K.PKG_CNT IS NULL THEN F.PKG_CNT ELSE K.PKG_CNT END  AS PKG_CNT, \n ")
							 .append("				CASE WHEN  K.PKG_CBM IS NULL THEN   F.PKG_CBM*F.PKG_CBM ELSE K.PKG_CBM END  AS PKG_CBM, \n ")
							 .append("				CASE WHEN  K.PKG_WGHT IS NULL THEN F.PUNIT_WGHT*F.PKG_CBM ELSE K.PKG_WGHT END  AS PKG_WGHT, \n ")
							 .append("				F.ORDER_SEQ, \n ")
							 .append("				CASE WHEN D.CAR_SEQ_NO IS NOT  NULL THEN \n")
							 .append("				NVL(D.CAR_SEQ_NO,'') || ' : ' || NVL(P.CAR_NAME,'') || ' ' ||  NVL(D.CAR_CNT,0) || ' 대 ' \n")
							 .append("				ELSE '혼재' END AS CARINFO, TO_CHAR(A.CREATE_DT,'YYYY-MM-DD'), RTRIM(NVL(F.LDCARGO,'')) LD_CARGO, RTRIM(NVL(F.OFFCARGO,'')) OFF_CARGO, A.OBJ_REMK, \n ")
							 .append("				F.EDI_STS, NVL(F.ING_STS,'') ING_STS \n ") //2007.08.22 수정
						     .append("	 FROM TRANSFER.LTORDERMST A,   \n ")
						     .append("        TRANSFER.LTORDERDTL F,  \n ")
						     .append("        ACCOUNT.GCZM_VENDER B,  \n ")
						     .append("        ACCOUNT.GCZM_VENDER C,  \n ")
						     .append("        ACCOUNT.COMMDTIL E,     \n ")
						     .append("        TRANSFER.LTCARGOODS K,  \n ")
						     .append("        TRANSFER.LTORDCAR D,    \n ")
						     .append("        TRANSFER.LTCARTYPE P    \n ")
						     
						     /* 2013.11.03 JYS 오라클로 변경
							 .append("				LEFT JOIN ACCOUNT.COMMDTIL E ON E.CMTYPE = '0030' AND A.PROJECT = E.CDCODE, \n ")
							 .append("				TRANSFER.LTORDERDTL F   \n ")
							 //.append("				LEFT JOIN TRANSFER.LTINWRHS G ON F.ORDER_NO = G.ORDER_NO AND F.ORDER_SEQ = G.ORDER_SEQ \n ")
							 .append("				LEFT JOIN TRANSFER.LTCARGOODS K ON F.ORDER_NO = K.ORDER_NO AND  F.ORDER_SEQ = K.ORDER_SEQ \n ")
							 .append("				LEFT JOIN TRANSFER.LTORDCAR D ON D.ORDER_NO = K.ORDER_NO AND D.CAR_SEQ_NO = K.CAR_SEQ_NO \n ")
							 .append("				LEFT JOIN TRANSFER.LTCARTYPE P ON D.CARTYPENO = P.CAR_TYPE, \n ")
							 .append("				ACCOUNT.GCZM_VENDER B , ACCOUNT.GCZM_VENDER C  \n ")
							 */
						     
							 .append("  WHERE A.CUST_CD = B.VEND_CD \n ")
							 .append("    AND A.SHIPPER = C.VEND_CD \n ")
							 .append("	  AND A.ORDER_NO = F.ORDER_NO \n ")
							 .append("	  AND A.IN_OUT = '" + str0 + "' ")
							 .append("    AND E.CMTYPE(+) ='0030' AND A.PROJECT = E.CDCODE(+)               \n ")
							 .append("    AND F.ORDER_NO = K.ORDER_NO(+) AND F.ORDER_SEQ = K.ORDER_SEQ(+)   \n ")
							 .append("    AND K.ORDER_NO = D.ORDER_NO(+)  AND K.CAR_SEQ_NO=D.CAR_SEQ_NO(+)  \n ")
							 .append("    AND D.CARTYPENO = P.CAR_TYPE(+)                                  \n ");
						
						//추가 2007.08.22 추가  전송전 취소건은 조회 안함.
						sql.append("    AND (F.ING_STS <>'X' OR  F.ING_STS is null) ") ;  

						if(str1 != null && str2 != null)   	sql.append(" AND A.ETD_DT BETWEEN '" +str1 + "' AND  '" + str2 + "'" ) ;  
						if(str3 != null )       sql.append( " AND A.LINE_PART = '" + str3 + "'" ) ; 
						if(str4 != null )       sql.append( " AND A.ORDER_NO = '" + str4 + "'" ) ; 
						if(str5 != null && !str5.equals("0004"))  sql.append( " AND A.ORDER_STS = '" + str5 + "'" ) ; 
						if(str5 != null &&  str5.equals("0004"))  sql.append( " AND A.ORDER_STS = '0002' AND ( F.ORDER_STS <> '0002'  OR  F.ORDER_STS is null )" ) ; 

						sql.append(" ORDER BY A.ORDER_NO,D.CAR_SEQ_NO,TO_NUMBER(F.ORDER_SEQ)  \n ") ;

						stmt = conn.createStatement();
						System.out.println("sql.toString()::"+sql.toString());
				        rs=stmt.executeQuery(sql.toString());		    
							
				        gos.write(SuperServlet.getDataSet(rs, dSet));
				        gos.close();
				        
			            rs.close();
			            stmt.close();
						 
					}
				
/*********************************************************************************************/

			} catch(Exception e) {
			//GauceRes.writeException("Sql",":",e.toString());	
		  	//logger.err.println(this,e);
		    } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
			}

		  //dSet.flush();
		  //GauceRes.commit();
		  //GauceRes.close();

		} catch (Exception e) {
		//	logger.err.println(this,e);
		//	logger.dbg.println(this,e.toString());
		} finally {
		//	loader.restoreService(service);
  	}
	}

	


}