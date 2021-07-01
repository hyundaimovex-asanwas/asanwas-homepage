package sales.sample;

import java.sql.*;

import javax.servlet.ServletException;

import com.gauce.db.GauceDBConnection;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

import sales.common.*;

public class Procedure extends SuperServlet {

	public void makeSql() {
		// TODO Auto-generated method stub
		
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
		int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));
System.out.println("init call success!!! dsType : " + dsType);
		CallableStatement cstmt = null;
		
		try{
			/**
			 *  PR_TEST_01 Procedure »£√‚
			 */
			if(dsType == 1){
				cstmt = conn.prepareCall("{call PR_TEST_01(?) }"); 
				cstmt.setString(1, "TEST1");
				int result = cstmt.executeUpdate();
				System.out.println("dsType : " + dsType + " result :  "+ result);
			} else if(dsType == 2){
				cstmt = conn.prepareCall("{call PR_TEST_02(?, ?) }"); 
				cstmt.setString(1, "TEST1");
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.execute();
				
				String retn_value = cstmt.getString(2);
				System.out.println("dsType : " + dsType + " retn_value : " + retn_value);

			} else if(dsType == 3){
				cstmt = conn.prepareCall("{call PR_TEST_03(?, ?, ?) }"); 
				cstmt.setString(1, "TEST1");
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.setString(3, "TEST1");
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.executeUpdate();
				
				String retn_value = cstmt.getString(2);
				String retn_value1 = cstmt.getString(3);
				System.out.println("dsType : " + dsType + " retn_value : " + retn_value + " retn_value1 : " + retn_value1);
			}
		} finally {
			if(cstmt!=null) cstmt.close();
		}
	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
