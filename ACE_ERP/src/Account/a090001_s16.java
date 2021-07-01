package Account;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class a090001_s16 extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
	
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		CallableStatement stmt =null;
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

				String  str1 = req.getParameter("v_str1");          //지점코드  FDCODE    VARCHAR(2)       
				String  str2 = req.getParameter("v_str2");  		//자산명   ASTNAME VARCHAR(30)             
				String  str3 = req.getParameter("v_str3");         //자산중분류  필수   AST2ND  VARCHAR(2)      
				String  str4 = req.getParameter("v_str4");        //자산소분류  필수  AST3RD   VARCHAR(2)        
				String  str5 = req.getParameter("v_str5");          //계정코드   필수    ATCODE   VARCHAR(7)  
				String  str6 = req.getParameter("v_str6");           //취득일자 	 ASAQSDAT   VARCHAR(8)         
				String  str7 = req.getParameter("v_str7");  		//계산서번호    TAXNBR    VARCHAR(10)     
				String  str8 = req.getParameter("v_str8");  	//회계접수번호   FSNBR     VARCHAR(6)          
				String  str9 = req.getParameter("v_str9");        //담당부서         DEPTCD  VARCHAR(4)       
				String  str10 = req.getParameter("v_str10");           //담당자      EMPNO    VARCHAR(7)      
				String  str11 = req.getParameter("v_str11");   //관리구분      MNGTYPE      VARCHAR(1)         
				String  str12 = req.getParameter("v_str12");   //상태코드        ASTSTAT   VARCHAR(1)          
				String  str13 = req.getParameter("v_str13");  //매출원가구분 ASCOSDIV	VARCHAR(1)   
				String  str14 = req.getParameter("v_str14");   //원가코드    COSTCD	VARCHAR(6)           
				String  str15 = req.getParameter("v_str15");   //취득구분 	ASAQSDIV	VARCHAR(1)                                  
				String  str16 = req.getParameter("v_str16");    //자산구분   GODDIV	VARCHAR(1)   
				String  str17 = req.getParameter("v_str17");    //자산등급   ASTCLASS	VARCHAR(1)   
				String  str18 = req.getParameter("v_str18");    //리스유무   ASTRIS	VARCHAR(1)           
				String  str19 = req.getParameter("v_str19");     //단위      ASTUNIT	VARCHAR(2)           
				String  str20 = req.getParameter("v_str20");     //수량  	ASTQTY	DECIMAL(10,0)    
				String  str21 = req.getParameter("v_str21");      //규격	ASTSTD	VARCHAR(30)          
				String  str22 = req.getParameter("v_str22");   //취득금액    ASTAQAMT	DECIMAL(13,0)
				String  str23 = req.getParameter("v_str23");      //내용년수 ASTYUSE	DECIMAL(3,0)         
				String  str24 = req.getParameter("v_str24");    //재평가일자 ASTVALYMD	VARCHAR(8)   
				String  str25 = req.getParameter("v_str25");     //관리부서 	MNGDPT	VARCHAR(4)   
				String  str26 = req.getParameter("v_str26");    //사용부서   USEDPT	VARCHAR(4)           
				String  str27 = req.getParameter("v_str27");      //설치장소 USELOC	VARCHAR(30)          
				String  str28 = req.getParameter("v_str28");        //구입처 BUYFROM	VARCHAR(13)          
				String  str29 = req.getParameter("v_str29");     //제작처    MAKER	VARCHAR(30)          
				String  str30 = req.getParameter("v_str30");       //비고    ASTNOTE	VARCHAR(50)      	 
				String  str31 = req.getParameter("v_str31");       //total  

				if (str1 == null) str1 = "";
				if (str2 == null) str2 = "";
				if (str3 == null) str3 = "";
				if (str4 == null) str4 = "";
				if (str5 == null) str5 = "";
				if (str6  == null) str6 = "";
				if (str7  == null) str7 = "";
				if (str8  == null) str8 = "";
				if (str9  == null) str9 = "";
				if (str10 == null) str10= "";
				if (str11 == null) str11= "";
				if (str12 == null) str12= "";
				if (str13 == null) str13= "";
				if (str14 == null) str14= "";
				if (str15 == null) str15= "";
				if (str16 == null) str16= "";
				if (str17 == null) str17= "";
				if (str18 == null) str18= "";
				if (str19 == null) str19= "";
				if (str20 == null) str20= "";
				if (str21 == null) str21= "";
				if (str22 == null) str22= "";
				if (str23 == null) str23= "";
				if (str24 == null) str24= "";
				if (str25 == null) str25= "";
				if (str26 == null) str26= "";
				if (str27 == null) str27= "";
				if (str28 == null) str28= "";
				if (str29 == null) str29= "";
				if (str30 == null) str30= "";
	            if (str31 == null) str31= "";

				
				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FDCODE",	    "ASTNAME",   "AST2ND",	    "AST3RD",        "ATCODE",	
		
                                                   "ASAQSDAT",	     "TAXNBR",	  "FSNBR",	     "DEPTCD",	    "EMPNO",		
		
                                                  "MNGTYPE",         "ASTSTAT",	  "ASCOSDIV",	  "COSTCD",   	 "ASAQSDIV",	

                                                  "GODDIV",		    "ASTCLASS",	   "ASTRIS",	  "ASTUNIT",	 "ASTQTY",		
                
                                                   "ASTSTD",	  "ASTAQAMT",	  "ASTYUSE",	  "ASTVALYMD",	 "MNGDPT",		
                
                                                  "USEDPT",		  "USELOC",		  "BUYFROM",	  "MAKER",		  "ASTNOTE", "total"  };  

				int[] intArrCN = new int[]{ 2,    30,     2,    2,     7,    	       
                                            8,    10,     6,     4,    7,     	       
                                            1,     1,     1,     6,     1,     
                                            1,     1,     1,     2,     10,                
                                            30,    13 ,   3,      8,     4,                   
                                            4,     30,    13,    30,  	50,	 4}; 
					
				int[] intArrCN2 = new int[]{ -1,   -1,   -1,   -1,    -1, 
                                             -1,   -1,   -1,   -1,   -1,  
                                             -1,   -1,   -1,   -1,   -1,  
                                             -1,   -1,   -1,   -1,    -1,		
                                             -1,    -1,    -1,   -1,    -1,  
                                            -1,    -1,  -1,    -1,   -1, -1	}; 

				for (int i=0; i<strArrCN.length; i++) { // set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
				
                  

				if (!GauceReq.isBuilderRequest()) {	
					
					StringBuffer sql = new StringBuffer();
					sql.append( " CALL ACCOUNT.SP_ALL_PRO(?,?,?,?,?,   ?,?,?,?,?,  ?,?,?,?,?,   ?,?,?,?,?,   ?,?,?,?,?,  ?,?,?,?,?, ?   ) ");

					stmt = conn.prepareCall(sql.toString());
					
					stmt.setString(1,str1);
					stmt.setString(2,str2);
					stmt.setString(3,str3);
					stmt.setString(4,str4);
					stmt.setString(5,str5);
					stmt.setString(6,str6);
					stmt.setString(7,str7);
					stmt.setString(8,str8);
					stmt.setString(9,str9);
					stmt.setString(10,str10);
					stmt.setString(11,str11);
					stmt.setString(12,str12);
					stmt.setString(13,str13);
					stmt.setString(14,str14);
					stmt.setString(15,str15);
					stmt.setString(16,str16);
					stmt.setString(17,str17);
					stmt.setString(18,str18);
					stmt.setString(19,str19);
					stmt.setString(20,str20);
					stmt.setString(21,str21);
					stmt.setString(22,str22);
					stmt.setString(23,str23);
					stmt.setString(24,str24);
					stmt.setString(25,str25);
					stmt.setString(26,str26);
					stmt.setString(27,str27);
					stmt.setString(28,str28);
					stmt.setString(29,str29);
					stmt.setString(30,str30);
			        stmt.setString(31,str31);

					stmt.execute();

					//logger.dbg.println( this, sql.toString() );
					
/*********************************************************************************************/
				}
			} catch(Exception e) {
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