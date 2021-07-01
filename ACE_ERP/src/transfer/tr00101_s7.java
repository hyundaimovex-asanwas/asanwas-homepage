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
public class tr00101_s7 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		/*
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
		Statement stmt = null;
		GauceDataSet dSet = null;
		*/
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
			
			/*
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();
            */
            
			try {
				//conn = service.getDBConnection();
				//dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
				String gorder_no = req.getParameter("gstr1"); //주문번호   
				if (gorder_no==null || gorder_no.trim().length()==0 ) {gorder_no=null; }

				
				/**
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "PROJNM", "ETD_DT", "ETD_DT1", "VEND_NM", "SHIPPERPS", 
																					 "SHIPPERTEL", "FAC_PERSON", "FAC_PRSTEL", "RECIPIENT", "RECP_OWN", 
																					 "RECP_TEL", "RECP_ADD", "REMARK","CAR_INFO"
																				 }; 

				int[] intArrCN = new int[] {50,  8,  8, 30, 50,
																		30, 30, 30, 50, 30, 
																		30, 70,100,100}; 
			
				int[] intArrCN2 = new int[]{-1,-1,-1,-1,-1,
																		-1,-1,-1,-1,-1,
																		-1,-1,-1,-1 }; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				**/

				String scar_cnt = "";

				StringBuffer sql = new StringBuffer();
				sql.append( " SELECT A.CARTYPENO, B.CAR_NAME, COUNT(A.CARTYPENO) CAR_CNT \n" )
				   .append( "   FROM TRANSFER.LTORDCAR A, \n" )
				   .append( "        TRANSFER.LTCARTYPE  B \n" )
				   .append( "  WHERE A.ORDER_NO = '" + gorder_no + "' \n" )
				   .append( "    AND A.CARTYPENO = B.CAR_TYPE \n" )
				   .append( "  GROUP BY A.CARTYPENO, B.CAR_NAME  \n" );
	
				System.out.println("sql::"+sql.toString());
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql.toString());
	
				int ichk = 1;
				while(rs.next()) {
					if (ichk==1) scar_cnt	= rs.getString(2) + " " + rs.getInt(3) + "대";
					else scar_cnt	= scar_cnt + " ," + rs.getString(2) + " " + rs.getInt(3) + "대";
					ichk++;
				}

				stmt = null;
				rs = null;
				sql = null;

				sql = new StringBuffer();
				sql.append( " SELECT C.MINORNM PROJNM, NVL(A.ETD_DT,'') ETD_DT, NVL(A.ETD_DT1,'') ETD_DT1,  \n" )
				   .append( "		 NVL(V.VEND_NM,'') VEND_NM, NVL(A.SHIPPERPS,'') SHIPPERPS, NVL(A.SHIPPERTEL,'') SHIPPERTEL, NVL(A.FAC_PERSON,'') FAC_PERSON, NVL(A.FAC_PRSTEL,'') FAC_PRSTEL,  \n" )
				   .append( "		 NVL(A.RECIPIENT,'') RECIPIENT, NVL(A.RECP_OWN,'') RECP_OWN, NVL(A.RECP_TEL,'') RECP_TEL, NVL(A.RECP_ADD,'') RECP_ADD, RTRIM(A.REMARK) REMARK \n" )
				   .append( "   FROM TRANSFER.LTORDERMST A \n" )
				   .append( "	LEFT OUTER JOIN ACCOUNT.GCZM_VENDER V ON A.SHIPPER = V.VEND_CD, \n" )
				   .append( "        TRANSFER.LTLCODE C \n" )
				   .append( "  WHERE A.ORDER_NO = '" + gorder_no + "' \n" )
				   .append( "    AND A.LINE_PART = C.MINORCD \n" )
				   .append( "    AND C.MAJORCD = '0002' \n");
				
				    System.out.println("sql2::"+sql.toString());
				    
				    stmt = conn.createStatement();
			        rs=stmt.executeQuery(sql.toString());		    
						
			        gos.write(SuperServlet.getDataSet(rs, dSet));
			        gos.close();
			        
		            rs.close();
		            stmt.close();
				    
				    /**

					stmt = conn.createStatement();
					rs = stmt.executeQuery(sql.toString());
				
					GauceDataRow row = null;

					while(rs.next()) {
						row = dSet.newDataRow();
						for (int k=1; k<14 ; k++) row.addColumnValue(new String(rs.getString(k).getBytes("KSC5601"),"EUC-KR"));
						row.addColumnValue(new String(scar_cnt.getBytes("KSC5601"),"EUC-KR"));
						dSet.addDataRow(row);
					}
					
					rs.close();
					stmt.close();
					**/
/*********************************************************************************************/

			} catch(Exception e) {
		  	    //logger.err.println(this,e);
				//GauceRes.writeException("Sql",":",e.toString());
		    } finally {
				//if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				//if (conn != null) try {conn.close();} catch (Exception e) {}
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