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

public class Cq730S extends SuperServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		arr_sql[1].append("CALL SALES.PR_CQ730S_01(?,?,?,?)");
		arr_sql[2].append("CALL SALES.PR_CQ730S_02(?,?,?,?)");
		arr_sql[3].append("CALL SALES.PR_CQ730S_03(?,?,?,?)");
		
	}
 
	
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		//StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		int v_rowcnt = 0;

		/*
		 * �˻��� �ʿ��� ����
		 */
		
		int 	sSaup_sid 	= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// �����
		String 	sSDate 		= HDUtil.nullCheckStr(greq.getParameter("sSDate")); 	// �԰�����
		String 	sSTime		= HDUtil.nullCheckStr(greq.getParameter("sSTime")); 	// �԰�ð�
		/*
		StringUtil.printMsg("�����",sSaup_sid+"",this);
		StringUtil.printMsg("�԰�����",sSDate,this);
		StringUtil.printMsg("�԰�ð�",sSTime,this);
		*/
		try {
			int sCnt1 = 1;
			GauceDataSet[] dSets = gis.readAllOutput(); 
			for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DEFAULT=ds_main, O:DETAIL=ds_detail
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					//res.enableFirstRow(ds1);
				
					//StringUtil.printMsg("1",this);
					cstmt = conn.prepareCall(arr_sql[1].toString()); // �Ѱ�
					cstmt.setInt(1,sSaup_sid);
					cstmt.setString(2, sSDate);
					cstmt.setString(3, sSTime);
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
					
				} else if(dSets[i].getName().equals("ds2")){
					GauceDataSet ds1 = gis.read("DS2");
					
					cstmt = conn.prepareCall(arr_sql[2].toString());	// ���԰��� ���
					cstmt.setInt(1,sSaup_sid);
					cstmt.setString(2, sSDate);
					cstmt.setString(3, sSTime);
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
					
					//StringUtil.printMsg("2",this);
				} else if(dSets[i].getName().equals("ds3")){
					GauceDataSet ds1 = gis.read("DS3");
					
					cstmt = conn.prepareCall(arr_sql[3].toString()); // ��ž���� 
					cstmt.setInt(1,sSaup_sid);
					cstmt.setString(2, sSDate);
					cstmt.setString(3, sSTime);
					cstmt.registerOutParameter(4, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(4);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
					
					//StringUtil.printMsg("3",this);
				}
			}
		} catch (SQLException sqle){
			//res.writeException("ERROR", sqle.getErrorCode()+"", sqle.getMessage());
			throw sqle;
		} catch (Exception e) {
			//res.writeException("ERROR", "", e.toString());
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