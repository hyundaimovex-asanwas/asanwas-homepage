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
public class tr00101_s2 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
	
		//System.out.println("tr00101_s2::시작");
		
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement stmt =null;
		GauceDataSet dSet = null;
		
		/**
		Connection conn = null;
        ResultSet rs = null;
        Statement stmt = null;
		GauceDataSet dSet = null;
		**/
		try {
			
			
			service = loader.newService();
			context = service.getContext();
			logger = context.getLogger();

			GauceRequest GauceReq = service.getGauceRequest();
			GauceResponse GauceRes = service.getGauceResponse();
			
			
			/**
			GauceInputStream gis  = ((HttpGauceRequest) req).getGauceInputStream();
            GauceOutputStream gos = ((HttpGauceResponse)res).getGauceOutputStream();
            			
            HDConnJndi JndiConn = new HDConnJndi();
            conn  = JndiConn.getHdConnection(req, res);
         
            dSet = new GauceDataSet();
            gos.fragment(dSet);
			**/
			try {
				
				conn = service.getDBConnection();
				dSet = new GauceDataSet();

			
/**********************************************************************************************
	실제 업무에서 적용하실 부분
**********************************************************************************************/
				// 웹페이지에서 조건값을 넘겨받음
				
				boolean isNotOnlyHeader = false;
				if ( GauceReq.getParameter("NOH")!=null && GauceReq.getParameter("NOH").equals("Y") ) { isNotOnlyHeader = true; }
				
				
				String str1 = GauceReq.getParameter("gstr1"); //주문번호   
					if (str1==null || str1.trim().length()==0 ) {   str1=null; }
				String str2 = GauceReq.getParameter("gstr2");  //차량번호
					if (str2==null || str2.trim().length()==0 ) {   str2=null; }
				
				
					GauceRes.enableFirstRow(dSet);

								String[] strArrCN = new String[]{ "ORDER_NO","CAR_SEQ_NO","CARTYPENO","CAR_CNT","LD_CARGO","LD_CARGONM","OFF_CARGO","OFF_CARGONM","CUST_CD","CUST_NAME","CUST_PS","CUST_TEL","LD_DATE","PERSON_NO","CAR_TYPE","REMARK","CTN_STDRD","EDT_DATE","LCT_URL" ,"CREATE_USR" ,"UPDATE_USR","LINE_PART" ,"IN_OUT" }; 

								int[] intArrCN = new int[] {10,10,10,3,10,150,10,150,13,50,50,13,8,10,4,400,60,8,150,10,10,10,11 }; 
							
								int[] intArrCN2 = new int[]{-1,-1,-1,0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1 }; 

								for (int i=0; i<strArrCN.length; i++) { // set column column 
									switch ( intArrCN2[i] ) { 
										case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
										default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
									} 
								} 
	
								
					if (isNotOnlyHeader) {					
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT ORDER_NO,CAR_SEQ_NO,CARTYPENO, \n" )
						   .append( "		 CAR_CNT,LD_CARGO,LD_CARGONM, \n" )
						   .append( "		 OFF_CARGO,OFF_CARGONM,CUST_CD, \n" )
						   .append( "		 CUST_NAME,CUST_PS,CUST_TEL,LD_DATE, \n" )
						   .append( "		 PERSON_NO,CAR_TYPE,REMARK,CTN_STDRD,EDT_DATE, \n" )
						   .append( "		 LCT_URL,CREATE_DT,CREATE_USR,UPDATE_DT,UPDATE_USR, \n" )
						   .append( "		 NVL(LINE_PART,'') AS LINE_PART , NVL(IN_OUT,'') AS IN_OUT \n") 
						   .append( "   FROM TRANSFER.LTORDCAR \n")
						   .append( "  WHERE ORDER_NO IS NOT NULL \n" );

						if( str1 !=null )	{	sql.append( " AND ORDER_NO = '" + str1 + "' \n" );}
						if( str2 !=null )	{	sql.append( " AND CAR_SEQ_NO = '" + str2 + "' \n" );}

						sql.append( " ORDER BY CAR_SEQ_NO ASC ");
						//System.out.println("tr00101_s2::4"+sql.toString());
						stmt = conn.getGauceStatement(sql.toString());
						stmt.executeQuery(dSet);
						
						//System.out.println("tr00101_s2::성공");
						/**
						stmt = conn.createStatement();
				        rs=stmt.executeQuery(sql.toString());		    
							
				        gos.write(SuperServlet.getDataSet(rs, dSet));
				        gos.close();
				        
			            rs.close();
			            stmt.close();
                        **/  
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