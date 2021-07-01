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
public class tr00101_s8 extends HttpServlet {
 
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
				
				String gorder_no = req.getParameter("gstr1"); //주문번호   
				if (gorder_no==null || gorder_no.trim().length()==0 ) {   gorder_no=null; }
				
                //2008.0214 ; C.ARTC_CNT ==> A.ARTC_CNT  
				StringBuffer sql = new StringBuffer();
				sql.append ( " SELECT A.ARTC_NM, RTRIM(A.STN_SZNM) STN_SZNM, \n ")
			       .append ( "  (SELECT MINORNM FROM TRANSFER.LTLCODE WHERE MAJORCD = '0008' AND  MINORCD = A.ARTC_UNIT ) MINORNM,	\n")
			       .append ( "          A.ARTC_CNT, A.UNIT_PRICE, A.PRICE, \n" )
				   .append ( "          CASE WHEN (A.PUNIT_CNT = 0 OR A.ARTC_CNT IS NULL) THEN 0 ELSE ROUND(ROUND(A.ARTC_CNT/A.PUNIT_CNT,1)*A.PKG_CBM,1) END TOT_CBM, \n" )
				   .append ( "          CASE WHEN (A.PUNIT_CNT = 0 OR A.ARTC_CNT IS NULL) THEN 0 ELSE ROUND(A.ARTC_CNT/A.PUNIT_CNT*A.PUNIT_WGHT,0) END TOT_WGHT,   \n" )
				   .append ( "          NVL(A.CANCLE_STS,'') CANCLE_STS, NVL(A.ENG_ARTCNM,'') ENG_ARTCNM, X.LD_CARGONM, X.OFF_CARGONM, RTRIM(A.ARTC_NM) || '('||RTRIM(NVL(A.ENG_ARTCNM,'')) ||')' ARTC_KENM \n" )
				   .append ( "     FROM TRANSFER.LTORDERDTL A \n" )
     			   //.append ( "          TRANSFER.LTCARGOODS C \n" )
				   //2008.02.13  LTCARGOODS 을 outjoin으로 변경
					 //막음2008.04.14
                     //.append ( "     LEFT OUTER JOIN TRANSFER.LTCARGOODS C ON A.ORDER_NO = C.ORDER_NO AND A.ORDER_SEQ = C.ORDER_SEQ \n" )
					 //.append ( "     LEFT OUTER JOIN TRANSFER.LTORDCAR D ON C.ORDER_NO = D.ORDER_NO AND C.CAR_SEQ_NO = D.CAR_SEQ_NO \n" )

                   //2008.04.14 수정
                   .append ( "  LEFT JOIN( SELECT C.ORDER_NO, C.ORDER_SEQ, MAX(D.LD_CARGONM)LD_CARGONM, MAX(D.OFF_CARGONM)OFF_CARGONM         \n" )
				   .append ( "                    FROM TRANSFER.LTCARGOODS C                                                                  \n" )
				   .append ( "                    LEFT JOIN TRANSFER.LTORDCAR D ON C.ORDER_NO = D.ORDER_NO AND C.CAR_SEQ_NO = D.CAR_SEQ_NO    \n" )
				   .append ( "                   WHERE C.ORDER_NO  = '" + gorder_no + "'                                                     \n" )
                   .append ( "                   GROUP BY  C.ORDER_NO, C.ORDER_SEQ                                                            \n" )
				   .append ( "                )X ON A.ORDER_NO =X.ORDER_NO AND A.ORDER_SEQ = X.ORDER_SEQ                                      \n" )
				   .append ( "    WHERE A.ORDER_NO  = '" + gorder_no + "' \n" )
					 //2008.02.13  LTCARGOODS 을 outjoin으로 변경
					 //.append ( "    AND A.ORDER_NO  = C.ORDER_NO \n" )
					 //.append ( "    AND A.ORDER_SEQ = C.ORDER_SEQ \n" )

                     //.append ( "    AND (A.MIX_OTHERS = 'T' OR ((A.MIX_OTHERS = '' OR A.MIX_OTHERS ='F') AND C.PKG_CBM  != 0)) " )
					 
				     //2013.10.30 JYS 수정 
				     //.append ( "    AND (A.MIX_OTHERS = 'T' OR (A.MIX_OTHERS = '' OR A.MIX_OTHERS ='F')) " )
					 .append ( "    AND (A.MIX_OTHERS = 'T' OR ( TRIM(A.MIX_OTHERS) IS NULL OR A.MIX_OTHERS ='F')) " )
					 .append ( "  ORDER BY A.ORDER_NO, TO_NUMBER(A.ORDER_SEQ) ");

					stmt = conn.createStatement();
					System.out.println("sql.toString()::"+sql.toString());
			        rs=stmt.executeQuery(sql.toString());		    
						
			        gos.write(SuperServlet.getDataSet(rs, dSet));
			        gos.close();
			        
		            rs.close();
		            stmt.close();
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	//logger.err.println(this,e);
			//GauceRes.writeException("Sql",":",e.toString());
		    } finally {
				if (stmt != null) try {stmt.close();} catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
			}

		  //dSet.flush();
		  //GauceRes.commit();
		  //GauceRes.close();

		} catch (Exception e) {
			//logger.err.println(this,e);
			//logger.dbg.println(this,e.toString());
		} finally {
			//loader.restoreService(service);
  	}
	}
}