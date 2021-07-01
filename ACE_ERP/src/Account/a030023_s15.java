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
public class a030023_s15 extends HttpServlet {
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
				String strgb="";
				String []  str	= new String [10];
				str[0] = req.getParameter("v_str1");	//지점코드
				str[1] = req.getParameter("v_str2");	//기간 from
				str[2] = req.getParameter("v_str3");	//기간 to
				str[3] = req.getParameter("v_str4");	//거래처
				str[6] = str[1].substring(4,6);  //01
				str[7] = str[1].substring(0,4);  //2006              

				int str7   =  Integer.parseInt(str[6]);
				int str10  =  Integer.parseInt(str[7]);	
        		str7 = str7 - 1; //01
				String str8 = String.valueOf(str7);
                String str9 = "";
				if(0 < str7 && str7 <= 9) { //01
					str8 = "0" + str7;
					str9 = str[7] + str8;
				}else if(str7 == 0){
					str10 = str10 - 1;
					String str11 = String.valueOf(str10);
					str7 = 12;
					str9 = str11 + str7; //기간 from 전달
				}

				for(int i=0;i<=7;i++) {
					if(str[i] == null) str[i] = ""; 
				}

				 //기간 비교
				int ichk = Integer.parseInt(str[1]);
				if(ichk<=200612){
					strgb="Y"; //이 경우는  20070100의 반제 데이터가 실제 데이터로 있어야 함.
				}else{
					strgb="";  //200701 이후에는 전기이월로 들어가야함.
				}

				GauceRes.enableFirstRow(dSet);

				String[] strArrCN = new String[]{  "FSREFVAL", "CDNAM", "VAL1", "VAL2", "VAL3", "VAL4", "VAL5"														
				}; 
				int[] intArrCN = new int[] {  20,  40,   15,   15,  15,  15,  15
				}; 
				int[] intArrCN2 = new int[]{  -1,  -1,    0,    0,   0,   0,   0
				}; 

				for (int i=0; i<strArrCN.length; i++) { 
					switch ( intArrCN2[i] ) { 
						case -1 : dSet.addDataColumn(new GauceDataColumn(strArrCN[i], GauceDataColumn.TB_STRING, intArrCN[i])); break; 
						default : dSet.addDataColumn( new GauceDataColumn( strArrCN[i], GauceDataColumn.TB_DECIMAL, intArrCN[i], intArrCN2[i] ) ); break; 
					} 
				} 

				if (!GauceReq.isBuilderRequest()) {					
					StringBuffer sql = new StringBuffer();

					sql.append( " SELECT   X.FSREFVAL, Y.VEND_NM AS CDNAM,                                                                                                       \n " );
					sql.append( "           SUM(X.VAL1)VAL1,SUM(X.VAL2)VAL2,SUM(X.VAL3)VAL3,SUM(X.VAL4)VAL4,SUM(X.VAL5)VAL5                                                      \n " );
					sql.append( "    FROM(                                                                                                                                       \n " );
					sql.append( "           --발생 금액만 가져옴                                                                                                                 \n " );
					sql.append( "           SELECT A.VENDCD FSREFVAL, C.ATDECR,                                                                                                  \n " );
					sql.append( "                  CASE WHEN A.ATCODE='1110310' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0)                                                   \n " );
					sql.append( "                       WHEN A.ATCODE='1110310' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) ELSE 0 END VAL1,                                  \n " );
					sql.append( "                  CASE WHEN A.ATCODE='1110610' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0)                                                   \n " );
					sql.append( "                       WHEN A.ATCODE='1110610' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) ELSE 0 END VAL2,                                  \n " );
					sql.append( "                  CASE WHEN A.ATCODE='1110620' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0)                                                   \n " );
					sql.append( "                       WHEN A.ATCODE='1110620' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) ELSE 0 END VAL3,                                  \n " );
					sql.append( "                  CASE WHEN A.ATCODE='2100110' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0)                                                   \n " );
					sql.append( "                       WHEN A.ATCODE='2100110' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) ELSE 0 END VAL4,                                  \n " );
					sql.append( "                  CASE WHEN A.ATCODE='2100510' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0)                                                   \n " );
					sql.append( "                       WHEN A.ATCODE='2100510' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) ELSE 0 END VAL5                                   \n " );
					sql.append( "             FROM ACCOUNT.BANJAEMST A,ACCOUNT.ACTCODE C                                                                                         \n " );
					sql.append( "            WHERE 1=1                                                                                                                 \n " );
					if(!str[0].equals(""))sql.append( " AND A.FDCODE ='"+str[0]+"'                                                                                                                 \n " );
					sql.append( "              AND A.ATCODE IN ('1110310','1110610','1110620','2100110','2100510')                                                                                                     \n " );
					sql.append( "              AND ( A.TSDAT<='A20060930' OR A.TSDAT='A20070100')                                                                                                          \n " );
					if(!str[3].equals(""))sql.append( "  AND A.VENDCD BETWEEN '"+str[3]+"' AND '"+str[3]+"'                                                                                        \n " );
					sql.append( "              AND A.ATCODE =C.ATCODE                                                                                                            \n " );
					sql.append( "            GROUP BY A.ATCODE, A.VENDCD,  C.ATDECR                                                                                              \n " );
					sql.append( "            UNION ALL                                                                                                                           \n " );
					sql.append( "           SELECT R1.FSREFVAL, C.ATDECR,                                                                                                        \n " );
					sql.append( "                  CASE WHEN A.ATCODE='1110310' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0) - COALESCE(SUM(A.CRAMT),0)                        \n " );
					sql.append( "                       WHEN A.ATCODE='1110310' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) - COALESCE(SUM(A.DEAMT),0) ELSE 0 END VAL1,       \n " );
					sql.append( "                  CASE WHEN A.ATCODE='1110610' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0) - COALESCE(SUM(A.CRAMT),0)                        \n " );
					sql.append( "                       WHEN A.ATCODE='1110610' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) - COALESCE(SUM(A.DEAMT),0) ELSE 0 END VAL2,       \n " );
					sql.append( "                  CASE WHEN A.ATCODE='1110620' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0) - COALESCE(SUM(A.CRAMT),0)                        \n " );
					sql.append( "                       WHEN A.ATCODE='1110620' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) - COALESCE(SUM(A.DEAMT),0) ELSE 0 END VAL3,       \n " );
					sql.append( "                  CASE WHEN A.ATCODE='2100110' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0) - COALESCE(SUM(A.CRAMT),0)                        \n " );
					sql.append( "                       WHEN A.ATCODE='2100110' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) - COALESCE(SUM(A.DEAMT),0) ELSE 0 END VAL4,       \n " );
					sql.append( "                  CASE WHEN A.ATCODE='2100510' AND C.ATDECR='1' THEN COALESCE(SUM(A.DEAMT),0) - COALESCE(SUM(A.CRAMT),0)                        \n " );
					sql.append( "                       WHEN A.ATCODE='2100510' AND C.ATDECR='2' THEN COALESCE(SUM(A.CRAMT),0) - COALESCE(SUM(A.DEAMT),0) ELSE 0 END VAL5        \n " );
					sql.append( "             FROM ACCOUNT.GENENLED A, ACCOUNT.ACTCODE C,                                                                                        \n " );
					sql.append( "                   (SELECT B.FDCODE, B.FSDAT, B.FSNBR, B.FSSEQ, B.FSREFCD,                                                                      \n " );
					sql.append( "                           B.FSREFVAL, B.SSDAT, B.SSNBR                                                                                         \n " );
					sql.append( "                      FROM ACCOUNT.GENENREF B                                                                                                   \n " );
					sql.append( "                     WHERE 1=1                                                                                                       \n " );
					if(!str[1].equals(""))sql.append( " AND B.FDCODE = '"+str[0]+"'                                                                                                       \n " );
					sql.append( "                       AND B.FSREFCD = '0020'                                                                                                   \n " );
					if(!str[3].equals(""))sql.append( " AND B.FSREFVAL BETWEEN '"+str[3]+"' AND '"+str[3]+"'                                                                             \n " );
					sql.append( "                   )R1                                                                                                                          \n " );
					sql.append( "            WHERE A.FDCODE = '02'                                                                                                               \n " );
					sql.append( "              AND A.ATCODE IN ('1110310','1110610','1110620','2100110','2100510')                                                               \n " );
					sql.append( "              AND A.ACTDAT>='20061001'                                                                                                          \n " );
					sql.append( "              AND A.ACTDAT<='"+str[2]+"31'                                                                                                            \n " );
					sql.append( "              AND A.FDCODE = R1.FDCODE                                                                                                          \n " );
					sql.append( "              AND A.FSDAT = R1.FSDAT                                                                                                            \n " );
					sql.append( "              AND A.FSNBR = R1.FSNBR                                                                                                            \n " );
					sql.append( "              AND A.FSSEQ = R1.FSSEQ                                                                                                            \n " );
					sql.append( "              AND A.ATCODE = C.ATCODE                                                                                                           \n " );
					sql.append( "            GROUP BY A.ATCODE, R1.FSREFVAL,  C.ATDECR                                                                                           \n " );
					sql.append( "    )X LEFT JOIN ACCOUNT.GCZM_VENDER Y ON X.FSREFVAL = Y.VEND_CD                                                                                \n " );
					sql.append( "    GROUP BY X.FSREFVAL,  Y.VEND_NM                                                                                                             \n " );
					sql.append( "    HAVING (SUM(X.VAL1)<>0 OR SUM(X.VAL2)<>0 OR SUM(X.VAL3)<>0 OR SUM(X.VAL4)<>0 OR SUM(X.VAL5)<>0)                                             \n " );
					sql.append( "            AND (SUM(X.VAL1)+SUM(X.VAL2)+SUM(X.VAL3)-SUM(X.VAL4)-SUM(X.VAL5)<>0)                                                                \n " );

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