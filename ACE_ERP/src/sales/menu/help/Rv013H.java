package sales.menu.help;

import java.sql.CallableStatement;
import java.sql.ResultSet;
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

import sales.common.*;

public class Rv013H extends SuperServlet {

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++) {
            arr_sql[i] = new StringBuffer();
        }
		// TODO Auto-generated method stub
		arr_sql[0].append("SELECT 						\n")
					.append("			R3.CARD_SID                                AS CARD_SID 			\n")         
					.append("			,R3.PAY_MANAGE_NO                           AS PAY_MANAGE_NO   	\n")  
					.append("			,R3.CARD_NO                                 AS CARD_NO           \n")
					.append("			,R3.ISSUE_COMPANY_NM                        AS ISSUE_COMPANY_NM  \n")
					.append("			,R3.AGREE_NO                                AS AGREE_NO          \n")
					.append("			,R3.PAY_DATE                                AS PAY_DATE          \n")
					.append("			,R3.PAY_AMT									AS PAY_AMT           \n")
					.append("FROM  						\n")
					.append("		SALES.TRV020 R1 JOIN SALES.TRV200 R2 ON R2.RSV_SID = R1.RSV_SID		\n")
					.append("		JOIN SALES.TRV220 R3 ON R3.PAY_MANAGE_NO = R2.PAY_MANAGE_NO 		\n")
					.append("WHERE 1 = 1 						\n");
	}

	public void init(GauceDBConnection conn, GauceRequest req, GauceResponse res)
			throws ServletException, Exception {
		// TODO Auto-generated method stub
	
	}

	public void select(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
		// TODO Auto-generated method stub
		GauceDataSet ds1 = null;
		GauceStatement stmt = null; 
		ResultSet rs = null;
		CallableStatement cstmt;
		
		String sAcceptSid 		= HDUtil.nullCheckStr(req.getParameter("sAcceptSid"));
		String sAcceptDate 		= HDUtil.nullCheckStr(req.getParameter("sAcceptDate"));
		String sAcceptTime 		= HDUtil.nullCheckStr(req.getParameter("sAcceptTime"));		

		//StringUtil.printMsg("sAcceptSid", sAcceptSid,this);
		try{
			Iterator it = req.getGauceDataSetKeys();
			while(it.hasNext()){
				String gauceName = (String)it.next();
				ds1 = req.getGauceDataSet(gauceName);
				
				if(ds1!=null){
					int cnt=1;
					res.enableFirstRow(ds1);
					if(gauceName.equals("DS1")){
						if ( !sAcceptSid.equals("") && !sAcceptSid.equals("0") ) 
							arr_sql[0].append("AND R1.ACCEPT_SID = ? 	\n");

						arr_sql[0].append("GROUP BY R3.CARD_SID, R3.PAY_MANAGE_NO, R3.CARD_NO, R3.ISSUE_COMPANY_NM, R3.AGREE_NO, R3.PAY_DATE, R3.PAY_AMT \n");
						//StringUtil.printMsg("arr_sql[0]",arr_sql[0].toString(),this);
						cstmt = conn.prepareCall(arr_sql[0].toString());
						
						if ( !sAcceptSid.equals("") && !sAcceptSid.equals("0") ) 
							cstmt.setString(cnt++, sAcceptSid);
						
						rs = cstmt.executeQuery();							
						getDataSet(rs, ds1).flush();
					} 
				}
			}
		} catch (SQLException sqle){
			sqle.printStackTrace();
			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			e.printStackTrace();
			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(stmt!=null) stmt.close();
		}
	}

	public void apply(GauceDBConnection conn, GauceRequest req,
			GauceResponse res) throws ServletException, Exception {
	}
}
