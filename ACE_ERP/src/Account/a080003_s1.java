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
public class a080003_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//신청서번호
				str[2] = req.getParameter("v_str3");	//예산년도
				str[3] = req.getParameter("v_str4");	//담당부서
				str[4] = req.getParameter("v_str5");	//관리항목코드

				for(int i=0;i<=4;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE", "BGTRQNO",  "BGTYY",    "BGTDIV",  "BGTDPT",
					"DEPTCD", "EMPNO",    "WRDT",     "COSTCD",  "BGTRQST",
					"ATCODE", "FSREFCD",  "SATCODE",  "BGTGBCD", "BGTTYPE",
					"BGTMACT","BGTRQNOTE","WHYRQNOTE","ATKORNAM","DEPTNM",
					"EMPNMK", "CDNAM",    "CHK"
				}; 

				int[] intArrCN = new int[] { 
					 2,  12,   4,   4,   4,   
					 4,		7,   8,   6,   1,   
					 7,	  4,   2,	  4,   1,
					 2,  30,  60,  66,  50,
					20,  40,   1
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

					if (!GauceReq.isBuilderRequest()) {					
						StringBuffer sql = new StringBuffer();

						sql.append( " SELECT																			\n");	
						sql.append( " 	RTRIM(A.FDCODE)    FDCODE,        /*지점코드*/					\n");
						sql.append( " 	RTRIM(A.BGTRQNO)   BGTRQNO,       /*신청서번호*/			\n");
						sql.append( " 	RTRIM(A.BGTYY)     BGTYY,         /*예산년도*/					\n");
						sql.append( " 	RTRIM(A.BGTDIV)    BGTDIV,        /*예산본부*/					\n");
						sql.append( " 	RTRIM(A.BGTDPT)    BGTDPT,        /*예산부서*/					\n");
						sql.append( " 	RTRIM(A.DEPTCD)    DEPTCD,        /*담당부서*/					\n");
						sql.append( " 	RTRIM(A.EMPNO)     EMPNO,         /*담당자*/						\n");
						sql.append( " 	RTRIM(A.WRDT)      WRDT,          /*작성일자*/					\n");
						sql.append( " 	RTRIM(A.COSTCD)    COSTCD,        /*원가코드*/				\n");
						sql.append( " 	RTRIM(K.BGTRQST)   BGTRQST,       /*신청서상태*/			\n");
						sql.append( " 	RTRIM(A.ATCODE)    ATCODE,        /*계정과목*/					\n");
						sql.append( " 	RTRIM(A.FSREFCD)   FSREFCD,       /*관리항목코드*/			\n");
						sql.append( " 	RTRIM(A.SATCODE)   SATCODE,       /*세목*/						\n");
						sql.append( " 	RTRIM(A.BGTGBCD)   BGTGBCD,       /*예산분류*/				\n");
						sql.append( " 	RTRIM(A.BGTTYPE)   BGTTYPE,       /*관리타입*/					\n");
						sql.append( " 	RTRIM(A.BGTMACT)   BGTMACT,       /*예산타입*/				\n");
						sql.append( " 	RTRIM(A.BGTRQNOTE) BGTRQNOTE,     /*적요*/					\n");
						sql.append( " 	RTRIM(A.WHYRQNOTE) WHYRQNOTE,     /*신청사유*/			\n");
						sql.append( " 	RTRIM(F.ATKORNAM)  ATKORNAM,      /*계정과목명*/			\n");
						sql.append( " 	ASNHR.SF_GET_DPTNAME0('01','A6',A.DEPTCD )  DEPTNM,   \n");
						sql.append( " 	ASNHR.SF_GET_ENONAME('01',A.EMPNO) AS EMPNMK, 		\n");
						sql.append( " 	RTRIM(E.CDNAM)     CDNAM,         /*세세목명*/					\n");
						sql.append( " 	'F' AS CHK												/*SAVE구분*/		\n");
						sql.append( " FROM ACCOUNT.BGTRQMST A											\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE F ON A.ATCODE  = F.ATCODE \n");
						sql.append( " LEFT JOIN ACCOUNT.BGTRQDTL1 K ON A.FDCODE=K.FDCODE AND A.BGTRQNO=K.BGTRQNO 	\n");

					/*	
						if(!str[2].equals("")){
							sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD  = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT WHERE CHGYM <='"+str[2]+"')	\n");
						}else{
							sql.append( " LEFT JOIN PAYROLL.HCDEPT C ON A.DEPTCD  = C.DEPTCD AND C.CHGYM = (SELECT MAX(CHGYM) FROM PAYROLL.HCDEPT)	\n");
						}
					*/	
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL E ON A.SATCODE = E.CDCODE AND A.FSREFCD=E.CMTYPE \n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																\n");
						if(!str[0].equals("")) sql.append( " AND A.FDCODE  = '"+str[0]+"'										\n");	//지점코드
						if(!str[1].equals("")) sql.append( " AND A.BGTRQNO = '"+str[1]+"'									\n");	//신청서번호
						if(!str[2].equals("")) sql.append( " AND A.BGTYY   = '"+str[2]+"'										\n");	//예산년도
						if(!str[3].equals("")) sql.append( " AND A.BGTDPT  = '"+str[3]+"'										\n");	//예산부서
						sql.append( " ORDER BY FDCODE,BGTRQNO DESC														\n");
            
						//System.out.println("a080003_s1 : \n" + sql.toString());
						//logger.dbg.println(this,sql.toString());
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