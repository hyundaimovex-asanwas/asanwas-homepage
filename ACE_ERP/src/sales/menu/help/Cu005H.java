package sales.menu.help;
/**********************************************************************************
 * ����ó �˾� 
 **********************************************************************************/

import javax.servlet.ServletException;
import sales.common.*;

import java.sql.*;

import com.gauce.GauceDataSet;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;

public class Cu005H extends SuperServlet {
	public void makeSql() {
		// TODO Auto-generated method stub
		arr_sql[0].append ("SELECT GROUP_SID, GROUP_CD, GROUP_NM	\n")
				  .append ("  FROM SALES.TCU020                     \n")
				  .append (" WHERE USE_YN='Y'                       \n");
	}
	
	// ��ȸ method
	public void select(GauceDBConnection conn, GauceRequest req, GauceResponse res)
		throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceStatement stmt = null;
		ResultSet rs = null;
		
		/* DataSet */
		GauceDataSet ds1 = null;
		
		try {
			// DataSet ���� 			
			ds1 = new GauceDataSet(); 

			String keyWord		= HDUtil.nullCheckStr(req.getParameter("keyWord"));			
			String gubun 		= HDUtil.nullCheckStr(req.getParameter("gubun"));
			
			int dsType = HDUtil.nullCheckNum(req.getParameter("dsType"));

			switch(dsType) {
				case 1: //detail�� ������ �ƴ� �����ڵ� �˻�
					res.enableFirstRow(ds1);
//StringUtil.printMsg("gubun", gubun, this);
//StringUtil.printMsg("keyWord", keyWord, this);
//					if (!"".equals(gubun)) 
//						arr_sql[0].append (" AND client_gu = '" +  gubun  + "'");
//����ڵ� ��ҿ�û������ ���� �븮�� �������� �����ϵ��� ���� 2007-02-09					
					if (!"".equals(keyWord)){
						arr_sql[0].append (" AND (GROUP_CD LIKE '%"+keyWord.trim()+"%' " + "  OR GROUP_NM LIKE '%"+keyWord.trim() + "%') ");}
					
						arr_sql[0].append("order by GROUP_NM");
					
					
					// ���� ����
//					StringUtil.printMsg("����",arr_sql[0].toString(),this);
					stmt = conn.getGauceStatement(arr_sql[0].toString()); 
					
					rs = stmt.executeQuery(); // DataSet set
					
					getDataSet(rs, ds1).flush();
					if(rs!=null) rs.close();
					if(stmt!=null) stmt.close();
					break;
			}
		} catch (Exception e) {
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
	}
	
	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
	}

}
