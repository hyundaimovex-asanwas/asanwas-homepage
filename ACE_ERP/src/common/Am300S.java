package common;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sales.common.HDConstant;
import sales.common.HDUtil;
import sales.common.StringUtil;
import sales.common.SuperServlet;
import com.gauce.GauceContext;
import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.GauceService;
import com.gauce.ServiceLoader;
import com.gauce.db.GauceDBConnection;
import com.gauce.db.GauceStatement;
import com.gauce.io.GauceRequest;
import com.gauce.io.GauceResponse;
import com.gauce.log.Logger;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.gauce.io.GauceInputStream;
import com.gauce.io.GauceOutputStream;

import java.sql.Connection; 
import oracle.jdbc.OracleTypes;


public class Am300S extends SuperServlet {

	public void makeSql(){
		/** 
		 * @Todo ��� , ��ǻ�� IP�� ������ ������ �;��Ѵ� 
		 **/
		String iParamEmpno = fParamEmpno;
		String iParamIp = fParamIp;
	}
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}	
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
	}
	// ��ȸ method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres) throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		CallableStatement cstmt = null;		
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
		GauceOutputStream gos = gres.getGauceOutputStream();
		//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
		GauceDataSet[] dSets = gis.readAllOutput(); 
		
		try {
			// �˻��� ����
			String  		sEMPNO				= HDUtil.nullCheckStr(greq.getParameter("sEMPNO"));		
			String 		sEMPNMK			= HDUtil.nullCheckStr(greq.getParameter("sEMPNMK"));
			//StringUtil.printMsg("sEMPNO",sEMPNO,this);
			//StringUtil.printMsg("sEMPNMK",sEMPNMK,this);
				
				
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			for(int i=0; i<dSets.length;i++){
				
				if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
							
							cstmt = conn.prepareCall("{call SALES.PR_AM300S(?,?,?) }");
							cstmt.setString(1, sEMPNO);
							cstmt.setString(2, sEMPNMK);
							cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
							cstmt.executeQuery();
							rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 			
							gos.write(getDataSet(rs, ds1));
				}
			}
			gos.close();
		}catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e){
			//res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}
}