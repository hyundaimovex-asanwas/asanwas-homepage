package sales.menu.cq;

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

import common.common.SuperServlet;
import sales.common.HDUtil;
import sales.common.StringUtil;

public class Cq510S extends SuperServlet {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql(){
   }

    public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}	
	
	// ��ȸ method
    public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		/*****************************************************************************
		 * Gauce Object ����
		 *****************************************************************************/
		//StringUtil.printMsg("# Command","��ȸ",this);
    	CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			// �˻��� ����
			String 	sSaupSid	= HDUtil.nullCheckStr(greq.getParameter("sSaupSid"));			
			String 	sBgnDate	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));
			String 	sEndDate	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));
			String 	sGoodsSid	= HDUtil.nullCheckStr(greq.getParameter("sGoodsSid"));
			String v_out_gubn	= HDUtil.nullCheckStr(greq.getParameter("v_out_gubn"));
			
			// dataset ���� param
			int dsType = HDUtil.nullCheckNum(greq.getParameter("dsType"));

			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DEFAULT=ds_main, O:DETAIL=ds_detail
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					//cstmt = conn.prepareCall("{call SALES.PR_CQ510S_01(1, 0, '20060412', '20060730') }");
					cstmt = conn.prepareCall("{call SALES.PR_CQ510S_01(?,?,?,?,?	,?) }");
					/*
					StringUtil.printMsg("sSaupSid",sSaupSid,this);
					StringUtil.printMsg("sGoodsSid",sGoodsSid,this);
					StringUtil.printMsg("sBgnDate",sBgnDate,this);
					StringUtil.printMsg("sEndDate",sEndDate,this);
					StringUtil.printMsg("v_out_gubn",v_out_gubn,this);
					*/
					cstmt.setInt(1, Integer.parseInt(sSaupSid));
					cstmt.setInt(2, Integer.parseInt(sGoodsSid));								
					cstmt.setString(3, sBgnDate);
					cstmt.setString(4, sEndDate);
					cstmt.setString(5, v_out_gubn);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
			 }
		} catch (SQLException sqle){
//			res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
//			res.writeException("ERROR", "", e.toString());
			throw e;
		} finally {
			if(rs!=null) rs.close();
			if(cstmt!=null) cstmt.close();
		}
	}

	/**
	 * ��� :
	 * @param req
	 * @param res
	 * @param dsNum = 1
	 *
	 */
    public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	}
}