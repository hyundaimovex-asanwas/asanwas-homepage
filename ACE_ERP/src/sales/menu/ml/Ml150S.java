package sales.menu.ml;

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


public class Ml150S extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {   
		// TODO Auto-generated method stub
		//Master
		arr_sql[0].append("{call SALES.PR_ML150S_01(?,?,?,?,?,  ?,?)}");
		arr_sql[1].append("{call SALES.PR_ML150S_02(?,?)}");


	}

	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

		//StringUtil.printMsg("v_orderer_sid",v_orderer_sid,this);
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try{
			int    v_cnt 			= 1;
			int    v_order_sid 	= HDUtil.nullCheckNum(greq.getParameter("v_order_sid"));	//�ֹ� SID
			
			String sBgnDate 	= HDUtil.nullCheckStr(greq.getParameter("sBgnDate"));	//�ֹ�����
			String sEndDate 	= HDUtil.nullCheckStr(greq.getParameter("sEndDate"));	//
			String sTrGu	   	= HDUtil.nullCheckStr(greq.getParameter("sTrGu"));		//�ŷ�����
			String sTr_OrderNm 	= HDUtil.nullCheckStr(greq.getParameter("sTr_OrderNm"));	//�ֹ��ڸ�
			String sOrderNo   	= HDUtil.nullCheckStr(greq.getParameter("sOrderNo"));	//�ֹ���ȣ
			String sEmpno	   	= HDUtil.nullCheckStr(greq.getParameter("sEmpno"));		//��ġ�� ���
			
			
			//StringUtil.printMsg("sBgnDate", sBgnDate+"", this);
			//StringUtil.printMsg("sEndDate", sEndDate+"", this);
			//StringUtil.printMsg("sTrGu", sTrGu+"", this);
			//StringUtil.printMsg("sTr_OrderNm", sTr_OrderNm+"", this);
			//StringUtil.printMsg("sOrderNo", sOrderNo+"", this);
			//StringUtil.printMsg("sEmpno", sEmpno+"", this);

			
            GauceDataSet[] dSets = gis.readAllOutput(); 
			

            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DEFAULT=ds_main, O:DETAIL=ds_detail
            	if(dSets[i].getName().equals("ds_main")){
					GauceDataSet ds1 = gis.read("DEFAULT");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, sBgnDate);
					cstmt.setString(2, sEndDate);
					cstmt.setString(3, sTrGu);
					cstmt.setString(4, sTr_OrderNm);
					cstmt.setString(5, sOrderNo);
					cstmt.setString(6, sEmpno);
					// ���ν����� ���� ���� ���ν�����.. ���� ���� ������.. ���...;;;
					cstmt.registerOutParameter(7, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(7);	//Ŀ�� OUT param. 					
					//GAUCE 5.x���� : OutputStream�� DS�� �Ẹ����.
					//	getDataSet(rs,ds1)�� ȣ���ϸ� SuperServlet���� rs�� ds1�� ��� ds1�� ����~!
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds_detail")){
					GauceDataSet ds1 = gis.read("DETAIL");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1, v_order_sid);
					// ���ν����� ���� ���� ���ν�����.. ���� ���� ������.. ���...;;;
					cstmt.registerOutParameter(2, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(2);	//Ŀ�� OUT param. 					
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

	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub

	}

}
