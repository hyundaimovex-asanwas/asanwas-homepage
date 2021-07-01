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

import java.sql.*;


// class 이름은 화일명과 항상 동일해야 함.
public class dsGetSeqNo extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceStatement pstmt =null;
		GauceDataSet dSet = null;
		ResultSet rs = null;
		
		/*
		Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;
        PreparedStatement pstmt = null;
		GauceDataSet dSet = null;
		*/
		try {

			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();
			/*
			GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
            GauceOutputStream gos = ((HttpGauceResponse)res).getGauceOutputStream();
            			
            HDConnJndi JndiConn = new HDConnJndi();
            conn  = JndiConn.getHdConnection(req, res);
         
            dSet = new GauceDataSet();
            gos.fragment(dSet);
            */
			
			try {
				
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
				boolean isNotOnlyHeader = false;
				boolean isDebug = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				if ( GauceReq.getParameter("DBG")!=null && GauceReq.getParameter("DBG").equals("Y") ) { isDebug = true; }
				 
				String str1 = GauceReq.getParameter("gstr1");   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				 
				String str2 = GauceReq.getParameter("gstr2");   
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				
				String str3 = "";
				String str4 = "";
				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ "TYPE","YYMM","SEQ_NO","RETURN_STS"}; 

				int[] intArrCN = new int[] {4,4,20,10 }; 

				int[] intArrCN2 = new int[]{-1,-1,-1,-1}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				}  
				

				if (isNotOnlyHeader) {	
					
					//RPG 대신 다시 작성함  2013-11-04 . jy
					
					
					StringBuffer sql = new StringBuffer();
					String XSEQNO = "00000";

					sql.append( " SELECT LPAD(NVL(MAX(SEQ_NO),0)+1,5,'0') AS SEQNO  FROM TRANSFER.LTSEQUENCE  \n");
					sql.append( "  WHERE SEQ_NAME = '" + str1 + "'\n");
					sql.append( "    AND SEQ_YYMM = '" + str2 + "'\n");

					stmt = conn.getGauceStatement(sql.toString());
					rs = stmt.executeQuery();

					while(rs.next()) {
						XSEQNO = rs.getString(1);
					}	
					
					//System.out.println("XSEQNO::"+XSEQNO);

					
					sql = null;
					sql = new StringBuffer();
					
				    if(XSEQNO.equals("00001")){ //INSERT
				    	sql.append( " INSERT INTO TRANSFER.LTSEQUENCE ( SEQ_NAME, SEQ_YYMM, SEQ_NO )  \n");
				    	sql.append( " VALUES ('"+str1+"','"+str2+"','"+XSEQNO+"') \n");
				    	
				    	System.out.println("insert::"+sql.toString());
				    	pstmt = conn.getGauceStatement(sql.toString());
						pstmt.executeUpdate();
						pstmt.close();
				    			    
				    }else{ //UPDATE
				    	sql.append( " UPDATE TRANSFER.LTSEQUENCE SET SEQ_NO ='"+XSEQNO+"' \n");
				    	sql.append( "  WHERE SEQ_NAME = '" + str1 + "'\n");
						sql.append( "    AND SEQ_YYMM = '" + str2 + "'\n");
						
						System.out.println("update::"+sql.toString());
						pstmt = conn.getGauceStatement(sql.toString());
						pstmt.executeUpdate();
						pstmt.close();
				    }
					
					
					/*
					StringBuffer sql = new StringBuffer();				
					sql.append( "CALL TRANSFER.SP_AUTOSEQ(?,?,?,?) ") ;
						
					stmt = conn.prepareCall(sql.toString());
                    
					stmt.setString(1, str1 );
 					stmt.setString(2, str2 );
					stmt.setString(3, str3 );
					stmt.setString(4, str4 );
   					
				    stmt.registerOutParameter (1, Types.CHAR );
				    stmt.registerOutParameter (2, Types.CHAR );
				    stmt.registerOutParameter (3, Types.CHAR ); 
					stmt.registerOutParameter (4, Types.CHAR ); 

					stmt.execute();
					*/ 

					GauceDataRow row = dSet.newDataRow();
					row.addColumnValue(str1);
					row.addColumnValue(str2);
					row.addColumnValue(XSEQNO);
					row.addColumnValue("C");
					 
					dSet.addDataRow(row);

					stmt.close();
					rs.close(); 
				    
				    //gos.write(SuperServlet.getDataSet(rs, dSet));
				    
				    //stmt.close();
					//rs.close();
					//gos.close();	
					
					
				}
					
/*********************************************************************************************/
			 
			} catch(Exception e) {
			
			  conn.rollback();	
			  e.printStackTrace();	 
		  	//logger.err.println(this,e);
			//GauceRes.writeException("Sql",":",e.toString());
			} finally {
				if (stmt != null) try { stmt.close(); } catch (Exception e) {}
				if (conn != null) try {conn.close();} catch (Exception e) {}
			}

			conn.commit();
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