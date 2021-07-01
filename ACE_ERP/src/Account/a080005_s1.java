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
public class a080005_s1 extends HttpServlet {
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
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드 
				str[1] = req.getParameter("v_str2");	//승인구분 
				str[2] = req.getParameter("v_str3");	//예산년도
				str[3] = req.getParameter("v_str4");	//예산월fr  
				str[4] = req.getParameter("v_str5");	//예산월fr
				str[5] = req.getParameter("v_str6");	//신청구분 
				str[6] = req.getParameter("v_str7");	//신청부서

				for(int i=0;i<=6;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"CHK","BGTRQNO","FDCODE","BGTYY","BGTMM",
					"BGTDIV","BGTDPT","ATCODE","FSREFCD","SATCODE",
					"BGTRQST","ATKORNAM","SATNAM","DEPTNM",//"BGTRQSEQ",
					//"BASICBGT","BGTRQAMT","APPAMT","BRESULTS","RESULTS",
					//"JANAMT",
					"BGTRQDIV","BGTRQAMT","M_ATCODE","M_FSREFCD","M_SATCODE",
					"BGTFRMON","P_BGTDEPT","P_BGTDIV","DEPTNM2","EMPNMK",
					"BGTRQSEQ"
				}; 

				int[] intArrCN = new int[] { 
				   1,  12,   2,   4,   2,
				   4,   4,   7,   4,   2,
				   1,  66,  40,  40,  // 2,
				   //15, 15,  15,  15,  15,
					 //15,  
					 2,  15,   7,   4,   2,
					 2,   4,  4,40,7,
					 2
				}; 
			
				int[] intArrCN2 = new int[]{ 
				  -1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  //-1,
					 //0,   0,   0,   0,   0,
					 //0,  
				  -1,   0,  -1,  -1,  -1,
					-1,  -1 , -1,-1,-1,
					-1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

	          if (!GauceReq.isBuilderRequest()) {					
	            StringBuffer sql = new StringBuffer();
		            sql.append( " SELECT                                                                         						\n");
		            sql.append( "    'F' AS CHK,                                 /*구분*/                        					\n");
		            sql.append( "    RTRIM(B.BGTRQNO)  BGTRQNO,                  /*신청서번호*/                  \n");
		            sql.append( "    RTRIM(B.FDCODE)   FDCODE,                   /*지점*/                        		\n");
		            sql.append( "    RTRIM(B.BGTYY)    BGTYY,                    /*예산년도*/                    			\n");
		            sql.append( "    RTRIM(C.BGTTOMON) BGTMM,                    /*예산월*/                      	\n");
		            sql.append( "    RTRIM(B.BGTDIV)   BGTDIV,                   /*신청본부*/                    			\n");
		            sql.append( "    RTRIM(B.BGTDPT)   BGTDPT,                   /*신청부서*/                    		\n");
		            sql.append( "    RTRIM(B.ATCODE)   ATCODE,                   /*계정코드*/                    		\n");
		            sql.append( "    RTRIM(B.FSREFCD)  FSREFCD,                  /*관리항목*/                    		\n");
		            sql.append( "    RTRIM(B.SATCODE)  SATCODE,                  /*세목*/                        		\n");
		            sql.append( "    RTRIM(C.BGTRQST)  BGTRQST,                  /*승인구분*/                    	\n");
		            sql.append( "    RTRIM(F.ATKORNAM) ATKORNAM,                 /*계정과목명*/                  \n");
		            sql.append( "    RTRIM(E.CDNAM)    SATNAM,                   /*세목명*/                      			\n");
		            sql.append( "    RTRIM(G.CDNAM)    DEPTNM,                   /*부서명*/                      			\n");
		            sql.append( "    RTRIM(C.BGTRQDIV) BGTRQDIV,                 /*예산구분*/                    		\n");  
		            sql.append( "    C.BGTRQAMT         BGTRQAMT,                /*예산변경금액*/                		\n");  
		            sql.append( "    RTRIM(C.DVTFRACT)   M_ATCODE,               /*MST 계정코드*/                	\n");  
		            sql.append( "    RTRIM(H.CDCODE)     M_FSREFCD,              /*MST 관리항목*/                	\n");  
		            sql.append( "    RTRIM(C.DVTFRSATCD) M_SATCODE,              /*MST 세목*/                    	\n");  
		            sql.append( "    RTRIM(C.BGTFRMON)   BGTFRMON,               /*피전용월*/                    		\n");  
		            sql.append( "    RTRIM(C.BGTFRDEPT)  P_BGTDEPT,              /*피전용부서*/                  	\n");  
		            sql.append( "    RTRIM(J.GBCD)       P_BGTDIV,               /*피전용본부*/                  			\n");  
		            sql.append( "    ASNHR.SF_GET_DPTNAME0('01','A6',B.DEPTCD ) AS DEPTNM2,                    \n");
		            sql.append( "    ASNHR.SF_GET_ENONAME('01',B.EMPNO ) AS EMPNMK,                          	\n");
		            sql.append( "    RTRIM(C.BGTRQSEQ)   BGTRQSEQ                /*순번*/                        		\n");
		            sql.append( "  FROM ACCOUNT.BGTRQMST B            														\n");
		            sql.append( "  LEFT JOIN ACCOUNT.ACTCODE F ON B.ATCODE=F.ATCODE    						\n");
		            sql.append( "  LEFT JOIN ACCOUNT.BGTRQDTL1 C ON B.FDCODE=C.FDCODE   AND B.BGTRQNO=C.BGTRQNO    \n");
		            sql.append( "  LEFT JOIN ACCOUNT.ACTREFCODE H ON C.DVTFRACT=H.ATCODE AND H.TYPE='B'            \n");
		            sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL  E ON B.SATCODE=E.CDCODE  AND E.CMTYPE=B.FSREFCD      \n");
		            sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL  G ON B.BGTDPT=G.CDCODE   AND G.CMTYPE='0003'        \n");
		            sql.append( "  LEFT JOIN ACCOUNT.COMMDTIL  J ON C.BGTFRDEPT=J.CDCODE  AND J.CMTYPE='0003'        \n");
		            //if(!str[3].equals("")){
		            //  sql.append( "  LEFT JOIN PAYROLL.HCDEPT    K ON B.DEPTCD=K.DEPTCD AND K.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT WHERE CHGYM <='"+str[3]+"') \n");
		            //}else{
		            //  sql.append( "  LEFT JOIN PAYROLL.HCDEPT    K ON B.DEPTCD=K.DEPTCD AND K.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT) \n");
		            //}
		            //sql.append( "  LEFT JOIN PAYROLL.PERSON1    L ON B.EMPNO=L.EMPNO            							\n");
		            sql.append( "  WHERE B.FDCODE IS NOT NULL                                      										\n");
		            sql.append( "    AND C.BGTRQST <>'N'   AND C.BGTRQDIV IS NOT NULL                                        \n");
		            if(!str[0].equals("")) sql.append( " AND B.FDCODE   = '"+str[0]+"'                            						\n");  //지점코드     
		            if(!str[1].equals("")) sql.append( " AND C.BGTRQST  = '"+str[1]+"'                            						\n");  //승인구분     
		            if(!str[2].equals("")) sql.append( " AND B.BGTYY    = '"+str[2]+"'                            							\n");  //예산년도
		            if(!str[3].equals("")) sql.append( " AND C.BGTTOMON BETWEEN '"+str[3]+"' AND '"+str[4]+"'              	\n");  //예산월fr~to
		            if(!str[5].equals("")) sql.append( " AND C.BGTRQDIV = '"+str[5]+"'                            						\n");  //신청구분 
		            if(!str[6].equals("")) sql.append( " AND B.BGTDPT   = '"+str[6]+"'                            							\n");  //신청부서     
		            sql.append( " ORDER BY BGTMM,BGTRQDIV,BGTRQNO,BGTDPT,ATKORNAM,SATNAM,BGTRQST        \n");
		
		            //System.out.println("# Query : \n" + sql);
		            //logger.dbg.println(this, sql.toString());

/*********************************************************************************************/
        	stmt = conn.getGauceStatement(sql.toString());
		 			stmt.executeQuery(dSet);
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