package sales.menu.help;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;
import com.gauce.db.GauceStatement;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;

import sales.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Rv007H_01 extends SuperServlet{


    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql()
    {
        for(int i = 0; i < arr_sql.length; i++)
            arr_sql[i] = new StringBuffer();

        arr_sql[0].append("CALL SALES.PR_RV330S_01_01(?,?,?)");
    }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
    	
	}

    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
    	CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
        
        String sPayManageNo = HDUtil.nullCheckStr(greq.getParameter("pay_manage_no"));
        int sBlockSid = HDUtil.nullCheckNum(greq.getParameter("block_sid"));
        try{
        	GauceDataSet[] dSets = gis.readAllOutput();
        	
        	for(int i=0; i<dSets.length;i++){
            	if(dSets[i].getName().equals("ds1")){
            		//StringUtil.printMsg("가상계좌",this);
					GauceDataSet ds1 = gis.read("DS2");
                    {
                    	cstmt = conn.prepareCall(arr_sql[0].toString());
                        cstmt.setInt(1, sBlockSid);
                        cstmt.setString(2, sPayManageNo);
                        cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//결과를 받을 커서
    					cstmt.executeQuery();
    					rs = (ResultSet)cstmt.getObject(3);	//커서 OUT param. 					
    					gos.write(getDataSet(rs, ds1));
                    } 
                }
        	}
		} catch (SQLException sqle){
			sqle.printStackTrace();
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			e.printStackTrace();
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}


    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
    }
}