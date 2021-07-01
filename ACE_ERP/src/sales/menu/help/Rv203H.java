package sales.menu.help;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;

import javax.servlet.ServletException;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
import sales.org.common.db.PreparedStatement;
import sales.menu.my.My710DTO;
import sales.common.HDUtil;
import sales.common.PagingHelper;
import sales.org.application.common.CommonDAO;
import sales.org.common.BaseDataClass;
import sales.org.common.db.Connection;
import sales.org.common.db.PreparedStatement;
import sales.org.common.log.LogUtil;



public class Rv203H extends SuperServlet {
	
	public void makeSql() {
		// TODO Auto-generated method stub
	}
	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","선조회",this);
	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
				
					  PreparedStatement pstmt = null;
					  PreparedStatement clopPstmt = null;
					  StringBuffer sql = new StringBuffer();
					  StringBuffer sql2 = new StringBuffer();
					  ResultSet rs = null;
					  long brd_no = 0;
					  long ret = 0;

					  try {
						  sql.append(" INSERT INTO SALES.TMY070 (" +
						   	     "BRD_NO,");
						  sql.append(" BRD_GU, " +
								  "	BRD_SUBJECT, " +
								  "	BRD_CREATOR, " +
								  "	BRD_RECIPIENT, " +
								  "	BRD_CREATOR_NAME, " +
								  "	BRD_RECIPIENT_NAME, " +
								  "	BRD_CDATE, " +
								  "	BRD_CONTENTS, " +
								  "	REAL_FILE, " +
								  "	SYS_FILE, ");
						  sql.append(" BRD_VIEWCNT, " +
								  "	BRD_PASSWD, " +
								  "	REF, " +
								  "	REF_STEP, " +
								  "	REF_LEVEL, " +
								  "	YN_DEL_RECIPIENT, " +
								  "	YN_DEL_KEEP, " +
								  "	YN_KEEP_RECIPIENT, " +
								  "	YN_KEEP_CREATOR, " +
								  "	YN_DEL_CREATOR ");
						  sql.append(" )VALUES(");
						  sql.append(" (SELECT COALESCE(MAX(BRD_NO),0)+1 FROM SALES.TMY070),'01','결제 안내 쪽지','System','6080001','시스템','박경국',CURRENT TIMESTAMP,'결제안내 쪽지 본문','','',");
						  sql.append(" 0,'0',0,0,0,'N','N','N','N','N')");

						  System.out.println("-----" + sql.toString());
						  pstmt = new PreparedStatement(conn, sql.toString());
						  int count = 1;
						  LogUtil.debug(pstmt.toString());
						  ret = pstmt.executeUpdate();
						  pstmt.close();

					  }catch(Exception e){
						  e.printStackTrace();
						  LogUtil.error(e);
					  }finally{
						  if(rs        != null){try{       rs.close();}catch(SQLException e){}}
						  if(pstmt     != null){try{    pstmt.close();}catch(SQLException e){}}
						  if(clopPstmt != null){try{clopPstmt.close();}catch(SQLException e){}}
					  }
	}
}

