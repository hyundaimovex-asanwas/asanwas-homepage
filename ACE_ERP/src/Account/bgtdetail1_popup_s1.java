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
public class bgtdetail1_popup_s1 extends HttpServlet {
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
				str[1] = req.getParameter("v_str2");	//예산년도
				str[2] = req.getParameter("v_str3");	//예산부서
				str[3] = req.getParameter("v_str4");  //계정과목명
				str[4] = req.getParameter("v_str5");	//계정코드
				str[5] = req.getParameter("v_str6");	//예산월
	
				for(int i=0;i<=5;i++) {
					if (str[i]==null) str[i] = "";
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{ 
					"FDCODE","BGTYY","BGTMM","BGTDIV","BGTDPT",
					"ATCODE","FSREFCD","SATCODE","BGTTYPE","BGTMACT",
					"INITMAN","INITBGT","CHGMAN","CHGBGT","BASICBGT",
					"ADDBGT","CHGABGT","CHGTBGT","REALBGT","RESULTS",
					"BRESULTS","APPROVAL","CHGAPPROV","REMARK","DEPTBGT",
					"ATCODE1","SATCODE1","RESULTS1"
				}; 

				int[] intArrCN = new int[] { 
					 2,   4,   2,   4,   4,   
					 7,		4,   2,   1,   2,
					 4,  15,   4,  15,  15,
					15,  15,  15,  15,  15,
					15,   1,   1,  40,  15,
					66,  40,  15
				}; 
			
				int[] intArrCN2 = new int[]{ 
					-1,  -1,  -1,  -1,  -1,
					-1,  -1,  -1,  -1,  -1,
				   0,   0,   0,   0,   0,
					 0,   0,   0,   0,   0,
					 0,  -1,  -1,  -1,   0,
					-1,  -1,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { //set column column 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 
					if (!GauceReq.isBuilderRequest()) {
						StringBuffer sql = new StringBuffer();
						sql.append( " SELECT																										\n");	
						sql.append( " 	RTRIM(A.FDCODE)     FDCODE,        /*지점코드*/					\n");
						sql.append( " 	RTRIM(A.BGTYY)      BGTYY,				 /*예산년도*/					\n");
						sql.append( " 	RTRIM(A.BGTMM)      BGTMM,         /*예산월*/						\n");
						sql.append( " 	RTRIM(A.BGTDIV)     BGTDIV,        /*예산본부*/					\n");
						sql.append( " 	RTRIM(A.BGTDPT)     BGTDPT,        /*예산부서*/					\n");
						sql.append( " 	RTRIM(A.ATCODE)     ATCODE,        /*계정과목*/					\n");
						sql.append( " 	RTRIM(A.FSREFCD)    FSREFCD,       /*관리항목코드*/			\n");
						sql.append( " 	RTRIM(A.SATCODE)    SATCODE,       /*세목*/				      \n");
						sql.append( " 	RTRIM(A.BGTTYPE)    BGTTYPE,       /*관리타입*/					\n");
						sql.append( "	RTRIM(A.BGTMACT)    BGTMACT,       /*예산타입*/         \n");
						sql.append( " 	COALESCE(A.INITMAN,0) INITMAN,     /*당초인원*/					\n");
						sql.append( " 	COALESCE(A.INITBGT,0) INITBGT,			 /*신청액*/		  			\n");
						sql.append( " 	COALESCE(A.CHGMAN,0)  CHGMAN,        /*변동인원*/					\n");
						sql.append( " 	COALESCE(A.CHGBGT,0)  CHGBGT,        /*조정액*/						\n");
						sql.append( " 	COALESCE(A.BASICBGT,0) BASICBGT,      /*배정액*/					\n");
						sql.append( " 	COALESCE(A.ADDBGT,0)  ADDBGT,        /*추가예산*/					\n");
						sql.append( " 	COALESCE(A.CHGABGT,0) CHGABGT,       /*항목전용*/					\n");
						sql.append( " 	COALESCE(A.CHGTBGT,0) CHGTBGT,       /*기간전용*/			    \n");
						sql.append( " 	COALESCE(A.REALBGT,0) REALBGT,       /*실행예산*/					\n");
						sql.append( "	COALESCE(A.RESULTS,0) RESULTS,       /*실적*/						  \n");
						sql.append( " 	COALESCE(A.BRESULTS,0) BRESULTS,      /*결재전실적*/			\n");
						sql.append( " 	RTRIM(A.APPROVAL)   APPROVAL,        /*승인구분*/					\n");
						sql.append( " 	RTRIM(A.CHGAPPROV)  CHGAPPROV,       /*변동예산승인구분*/	\n");
						sql.append( " 	RTRIM(A.REMARK)     REMARK,          /*산출근거*/				  \n");
						sql.append( " 	COALESCE(A.DEPTBGT,0)    DEPTBGT,        /*부서전용*/					\n");
						sql.append( "	RTRIM(B.ATKORNAM)   ATCODE1,         /*계정과목*/         \n");
						sql.append( "   RTRIM(C.CDNAM)      SATCODE1,       /*세목코드명*/       \n");
						sql.append( "	COALESCE(A.REALBGT,0)-COALESCE(A.RESULTS,0)-COALESCE(A.BRESULTS,0)  RESULTS1  /*잔액*/  \n");
						sql.append( " FROM ACCOUNT.BGTDTL A   /*신청DTL1*/									  	\n");
						sql.append( " LEFT JOIN ACCOUNT.ACTCODE B ON A.ATCODE = B.ATCODE      \n");
						sql.append( " LEFT JOIN ACCOUNT.COMMDTIL C ON A.SATCODE = C.CDCODE AND A.FSREFCD = C.CMTYPE	\n");
						sql.append( " WHERE A.FDCODE IS NOT NULL																			\n");
						if(!str[0].equals(""))
							sql.append( " AND A.FDCODE  = '"+str[0]+"'				\n");	//지점코드
						if(!str[1].equals(""))
							sql.append( " AND A.BGTYY = '"+str[1]+"'				\n");	//예산년도
						if(!str[2].equals(""))
							sql.append( " AND A.BGTDPT = '"+str[2]+"'				\n");	//예산부서
						if(!str[3].equals(""))
							sql.append( " AND B.ATKORNAM  LIKE '%"+str[3]+"%'		\n");	//계정명
						if(!str[4].equals(""))
							sql.append( " AND A.ATCODE = '"+str[4]+"'				\n");	//계정과목
						if(!str[5].equals(""))
							sql.append( " AND A.BGTMM  = '"+str[5]+"'				\n");	//예산월

/*********************************************************************************************/
					//logger.dbg.println(this,sql.toString());
                    //System.out.println(sql.toString());   
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