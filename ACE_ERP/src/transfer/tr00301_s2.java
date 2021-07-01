package transfer;

import com.gauce.*;
import com.gauce.io.*;
import com.gauce.common.*;
import com.gauce.log.*;
import com.gauce.db.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

// class 이름은 화일명과 항상 동일해야 함.
public class tr00301_s2 extends HttpServlet {
 
	// 웹페이지의 폼의 전송방식이 Post 타입일 경우
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		res.setContentType("text/html;charset=ksc5601");
		ServiceLoader loader = new ServiceLoader(req, res);
		GauceService service = null;
		GauceContext context = null;
		Logger logger = null;
		GauceDBConnection conn = null;
		GauceStatement gstmt =null;
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
				String gstr1 = GauceReq.getParameter("v_str1");

				GauceRes.enableFirstRow(dSet);

				Statement stmt = null;
				ResultSet rs = null;
				ResultSet rst = null;
				StringBuffer sql = new StringBuffer();
				StringBuffer query = null;
				int cnt = 0;
				int seq_no = 1;
				sql.append( " SELECT CAR_SEQ_NO, PERSON_NO, ACCESS_NO, CAR_NO, ACCSECTION, 'O' ACCSECTION1 \n")
					 .append( "	  FROM TRANSFER.LTCARACC \n")
					 .append( "  WHERE ACCESS_NO = '" + gstr1 + "' \n")
					 .append( "    AND ACCSECTION = 'O' ");

				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql.toString());

				while(rs.next()) {
					query = new StringBuffer();

					//출입계획 차량정보
					query.append( " INSERT INTO TRANSFER.LTACCPLCAR ( \n ")
						 .append( "		CAR_SEQ_NO ,ACCSECTION ,CAR_NO ,CAR_TYPE ,PERSON_NO, \n")
						 .append( "		LD_CARGO ,LD_CARGONM ,OFF_CARGO ,OFF_CARGONM ,PURPOSE, \n")
						 .append( "		LEAD_FEE ,PERSON_CNT ,START_DATE ,START_TIME ,RTRN_DATE, \n")
						 .append( "		RTRN_TIME ,BAECHA_NO ,ACCESS_NO ,RDS_GOODS ,REMARK, \n")
						 .append( "		CREATE_DT ,CREATE_USR ,UPDATE_DT ,UPDATE_UST, SEQ_NO \n")
						 .append( "	) \n")
						 .append( " SELECT CAR_SEQ_NO ,ACCSECTION ,CAR_NO ,CAR_TYPE ,PERSON_NO, \n")
						 .append( "		LD_CARGO ,LD_CARGONM ,OFF_CARGO ,OFF_CARGONM ,PURPOSE, \n")
						 .append( "		LEAD_FEE ,PERSON_CNT ,START_DATE ,START_TIME ,RTRN_DATE, \n")
						 .append( "		RTRN_TIME ,BAECHA_NO ,ACCESS_NO ,RDS_GOODS ,REMARK, \n")
						 .append( "		CREATE_DT ,CREATE_USR ,UPDATE_DT ,UPDATE_UST, " + seq_no + " \n")
						 .append( "	  FROM TRANSFER.LTCARACC \n")
						 .append( "  WHERE ACCESS_NO = '" + gstr1 + "' \n")
						 .append( "   AND CAR_SEQ_NO = '" + rs.getString(1) + "' ");

					gstmt = conn.getGauceStatement(query.toString());
					gstmt.executeUpdate(); 

					query = null;
					gstmt = null;

					query = new StringBuffer();

					//차량마스터 검색
					query.append( " SELECT PERSON_NO, PSN_KNAME, IFNULL(COMPANY,''), IFNULL(POSITION,''), IFNULL(GENDER,''),  \n" )
							 .append(	"				 IFNULL(REG_NO,''), IFNULL(ADDRESS1,'') || IFNULL(ADDRESS2,''), IFNULL(PURPOSE,''), 'Y' DRV \n" )
							 .append(	"		FROM TRANSFER.LTPERSON \n" )
							 .append(	"  WHERE PERSON_NO = '" + rs.getString(2) + "'");

					stmt = conn.createStatement();
					rst = stmt.executeQuery(query.toString());
					String acar[] = new String[9];

					while(rst.next()) {
						for (int k=0; k<9; k++) {
							acar[k] = rst.getString(k+1);
						}
					}

					gstmt = null;
					rst = null;
					String InsertSql = "";

					//출입계획 방문인원
					InsertSql  = " INSERT INTO TRANSFER.LTPSRNACC \n" +
											 " ( " +
											 "		PERSON_NO, PRSN_NAME, PRSN_CMPY, JOB_DUTY, GENDER,  \n" +
											 "		PRSN_REGNO, ADDRESS1, PURPOSE, DRIVE_DIV,  \n" +
											 "		ACCESSNO, ACCSECTION, START_DATE, START_TIME, RTRN_DATE,   \n" +
											 "		RTRN_TIME, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_UST, \n" +
											 "		SEQ_NO, CAR_NO \n" +
											 " ) SELECT  " +
											 "				'" + acar[0] + "', '" + acar[1] +"', '" + acar[2] + "', '" + acar[3] + "', '" + acar[4] + "', \n" +
											 "				'" + acar[5] + "', '" + acar[6] +"', '" + acar[7] + "', '" + acar[8] + "', \n" +
											 "				'" + rs.getString(3) + "',ACCSECTION , START_DATE, START_TIME, RTRN_DATE, \n" +
											 "				RTRN_TIME, CREATE_DT, CREATE_USR, UPDATE_DT, UPDATE_UST, \n" +
											 "				" + seq_no + ", CAR_NO \n"+
											 "	  FROM TRANSFER.LTCARACC \n" +
											 "  WHERE ACCESS_NO = '" + gstr1 + "' \n" +
											 "    AND CAR_SEQ_NO = '" + rs.getString(1) + "' ";

					gstmt = conn.getGauceStatement(InsertSql);
					gstmt.executeUpdate(); 
					gstmt = null;

					cnt++;
					seq_no++;

				}

				stmt.close();
				rs.close();
				
/*********************************************************************************************/

			} catch(Exception e) {
		  	logger.err.println(this,e);
				GauceRes.writeException("Sql",":",e.toString());
		  } finally {
				if (gstmt != null) try { gstmt.close(); } catch (Exception e) {}
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