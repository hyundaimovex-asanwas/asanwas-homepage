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
public class tr00101_sd1 extends HttpServlet {

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

				String str1 = req.getParameter("gstr1");   //order No
				if (str1==null || str1.trim().length()==0 ) {   str1=""; }

			
					if (isNotOnlyHeader) {		

						//Statement stmt2 = null;
						//ResultSet rs2 = null;
						StringBuffer sql = new StringBuffer();
						String ls_sts = "";

						sql.append( " SELECT CASE WHEN ORDER_STS = '0002' THEN 'Y' ELSE 'N' END STS FROM TRANSFER.LTORDERMST WHERE ORDER_NO = '" + str1 + "' ");

						stmt = conn.createStatement();
						rs = stmt.executeQuery(sql.toString());

						while(rs.next()) {
							ls_sts = rs.getString(1);
						}	
						
						System.out.println("ls_sts::"+ls_sts);

						stmt = null;
						rs = null;
						sql = null;

						if (ls_sts==null || ls_sts.equals("")) ls_sts = "N";

						sql = new StringBuffer();
						sql.append( " SELECT \n" )
							 .append( "		A.ORDER_NO, A.ORDER_SEQ, A.ARTC_CD, A.ARTC_NM, A.STN_SZ, \n" )
							 .append( "		A.STN_SZNM, A.HSCODE, A.ARTC_CNT, A.ARTC_UNIT, \n" )
							 .append( "		A.UNIT_PRICE, A.PRICE, A.LDCARGO, A.LDCARGONM, \n" )
							 .append( "		A.OFFCARGO, A.OFFCARGONM, A.PUNIT_CNT, A.PUNIT_UNIT, \n" )
							 .append( "		A.PUNIT_WGHT, A.PKG_LNGTH, A.PKG_HEIGHT, A.PKG_WIDTH, \n" )
							 .append( "		A.PKG_CBM, A.PKG_CNT, A.MIX_OTHERS, A.SAMEAS, \n" )
							 .append( "		A.SETTLE_STS, A.CREATE_USR, A.UPDATE_USR, '' AS REGFILE, NVL(A.REGFILENAME,'') AS REGFILENAME, \n" )
							 .append( "		(A.PKG_CNT*A.PKG_CBM) PKG_CBM_T, (A.PUNIT_WGHT*A.PKG_CNT) PUNIT_WGHT_T, NVL(B.MINOR_NM,'') HSCODENM, A.ENG_ARTCNM, A.VIN_CODE, \n" )
							 .append( "   CASE WHEN A.LDCARGO      = C.LDCARGO      THEN 'Y' ELSE 'N' END GBN_LDCARGO     , \n ")
							 .append( "   CASE WHEN A.OFFCARGO     = C.OFFCARGO     THEN 'Y' ELSE 'N' END GBN_OFFCARGO    , \n ")
							 .append( "   CASE WHEN A.ENG_ARTCNM	 = C.ENG_ARTCNM	  THEN 'Y' ELSE 'N' END GBN_ENG_ARTCNM	 , \n ")
							 .append( "   CASE WHEN A.HSCODE		   = C.HSCODE		    THEN 'Y' ELSE 'N' END GBN_HSCODE		   , \n ")
//							 .append( "   CASE WHEN A.HSCODENM     = C.HSCODENM     THEN 'Y' ELSE 'N' END GBN_HSCODENM    , \n ")
							 .append( "   CASE WHEN A.ARTC_NM      = C.ARTC_NM      THEN 'Y' ELSE 'N' END GBN_ARTC_NM     , \n ")
							 .append( "   CASE WHEN A.STN_SZNM     = C.STN_SZNM     THEN 'Y' ELSE 'N' END GBN_STN_SZNM    , \n ")
							 .append( "   CASE WHEN A.ARTC_UNIT    = C.ARTC_UNIT    THEN 'Y' ELSE 'N' END GBN_ARTC_UNIT   , \n ")
							 .append( "   CASE WHEN A.ARTC_CNT     = C.ARTC_CNT     THEN 'Y' ELSE 'N' END GBN_ARTC_CNT    , \n ")
							 .append( "   CASE WHEN A.UNIT_PRICE   = C.UNIT_PRICE   THEN 'Y' ELSE 'N' END GBN_UNIT_PRICE  , \n ")
							 .append( "   CASE WHEN A.PRICE        = C.PRICE        THEN 'Y' ELSE 'N' END GBN_PRICE       , \n ")
							 .append( "   CASE WHEN A.CUR_CODE     = C.CUR_CODE     THEN 'Y' ELSE 'N' END GBN_CUR_CODE    , \n ")
							 .append( "   CASE WHEN A.FR_UNTPRCE   = C.FR_UNTPRCE   THEN 'Y' ELSE 'N' END GBN_FR_UNTPRCE , \n ")
							 .append( "   CASE WHEN A.FR_PRICE     = C.FR_PRICE     THEN 'Y' ELSE 'N' END GBN_FR_PRICE    , \n ")
							 .append( "   CASE WHEN A.PUNIT_CNT	   = C.PUNIT_CNT	  THEN 'Y' ELSE 'N' END GBN_PUNIT_CNT	 , \n ")
							 .append( "   CASE WHEN A.PUNIT_WGHT   = C.PUNIT_WGHT   THEN 'Y' ELSE 'N' END GBN_PUNIT_WGHT  , \n ")
							 .append( "   CASE WHEN A.PKG_LNGTH    = C.PKG_LNGTH    THEN 'Y' ELSE 'N' END GBN_PKG_LNGTH   , \n ")
							 .append( "   CASE WHEN A.PKG_WIDTH    = C.PKG_WIDTH    THEN 'Y' ELSE 'N' END GBN_PKG_WIDTH   , \n ")
							 .append( "   CASE WHEN A.PKG_HEIGHT   = C.PKG_HEIGHT   THEN 'Y' ELSE 'N' END GBN_PKG_HEIGHT  , \n ")
							 .append( "   CASE WHEN A.PKG_CBM      = C.PKG_CBM      THEN 'Y' ELSE 'N' END GBN_PKG_CBM     , \n ")
							 .append( "   CASE WHEN A.PKG_CNT      = C.PKG_CNT      THEN 'Y' ELSE 'N' END GBN_PKG_CNT     , \n ")
//							 .append( "   CASE WHEN A.PKG_CBM_T    = C.PKG_CBM_T    THEN 'Y' ELSE 'N' END GBN_PKG_CBM_T   , \n ")
//							 .append( "   CASE WHEN A.PUNIT_WGHT_T = C.PUNIT_WGHT_T THEN 'Y' ELSE 'N' END GBN_PUNIT_WGHT_T, \n ")
							 .append( "   CASE WHEN A.LDCARGONM    = C.LDCARGONM    THEN 'Y' ELSE 'N' END GBN_LDCARGONM   , \n ")
							 .append( "   CASE WHEN A.OFFCARGONM   = C.OFFCARGONM   THEN 'Y' ELSE 'N' END GBN_OFFCARGONM  , \n ")
							 .append( "   CASE WHEN A.MIX_OTHERS   = C.MIX_OTHERS   THEN 'Y' ELSE 'N' END GBN_MIX_OTHERS  , \n ")
							 .append( "   CASE WHEN A.SAMEAS       = C.SAMEAS       THEN 'Y' ELSE 'N' END GBN_SAMEAS,      \n ")
							 .append( "   '" + ls_sts + "' AS GBN_JEBSU, A.CANCLE_STS,      \n ")
							 .append( "   'Y' DARM1,  'Y' DARM2,  'Y' DARM3,  'Y' DARM4,  'Y' DARM5,       \n ")
							 .append( "   'Y' DARM6,  'Y' DARM7,  'Y' DARM8,  'Y' DARM9,  'Y' DARM10,       \n ")
							 .append( "   'Y' DARM11, 'Y' DARM12, 'Y' DARM13, 'Y' DARM14, 'Y' DARM15,       \n ")
							 .append( "   'Y' DARM16, 'Y' DARM17, 'Y' DARM18, 'Y' DARM19, 'Y' DARM20,       \n ")
							 .append( "   'Y' DARM21, 'Y' DARM22, 'Y' DARM23, 'Y' DARM24, NVL(A.FR_UNTPRCE,0) FR_UNTPRCE, NVL(A.FR_PRICE,0) FR_PRICE, D.MINORNM CUR_CODE, A.ETD_DT,  \n ")
							 .append( "   A.ING_STS  \n ")
							 .append( "		FROM TRANSFER.LTORDERDTL A \n" )
							 .append( "				 LEFT OUTER JOIN TRANSFER.LTHSCODE B ON A.HSCODE = B.MINOR_CD AND STS_CD = '1' \n ")
							 .append( "				 LEFT OUTER JOIN TRANSFER.BTORDERDTL C ON A.ORDER_NO = C.ORDER_NO AND A.ORDER_SEQ = C.ORDER_SEQ \n ")
							 .append( "        LEFT OUTER JOIN TRANSFER.LTLCODE D ON A.CUR_CODE = D.MINORCD AND D.MAJORCD = '0022' \n ")
							 .append( "  WHERE A.ORDER_NO IS NOT NULL \n" );

						if(!str1.equals("")) sql.append( " AND A.ORDER_NO= '" + str1 + "'"   ) ;

						sql.append( "	 ORDER BY A.ORDER_NO, TO_NUMBER(A.ORDER_SEQ) ");
						
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
		  	//logger.err.println(this,e);
		  } finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
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