package sales.menu.rv;

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

public class Rv830S extends SuperServlet {
	
	private static final long serialVersionUID = 1L;


	public void makeSql() {
		// TODO Auto-generated method stub
		for(int i=0; i<arr_sql.length; i++) {
			arr_sql[i] = new StringBuffer();
		}
		
		// �����, ������, ��������, ����
		arr_sql[1].append("CALL SALES.PR_RV830S_01(?,?,?,?,?,?,?, ?)");
	}

	
	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		// TODO Auto-generated method stub
		StringUtil.printMsg("DS TYPE","����ȸ",this);
	}

	
	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();

		try {
			/* �˻��� �ʿ��� ����		 */
			int sSaup_sid 		= HDUtil.nullCheckNum(greq.getParameter("sSaup_sid"));	// �����
			int sUpjang_sid		= HDUtil.nullCheckNum(greq.getParameter("sUpjang_sid")); // ������ SID
			String sJob_date 	= HDUtil.nullCheckStr(greq.getParameter("sJob_date")); 	// �۾����
			String sCust_name	= HDUtil.nullCheckStr(greq.getParameter("sCust_name"));	// ����
			int sGoods_sid		= HDUtil.nullCheckNum(greq.getParameter("sGoods_sid")); // ��ǰ
			String  sDateSel	= HDUtil.nullCheckStr(greq.getParameter("sDateSel")); //��¥�ɼ�
			String  v_prt_seq	= HDUtil.nullCheckStr(greq.getParameter("v_prt_seq")); //��¼���
			
			//StringUtil.printMsg("���",sSaup_sid+"",this);
			//StringUtil.printMsg("�۾����11",sJob_date,this);
			//StringUtil.printMsg("������",sUpjang_sid+"",this);
			//StringUtil.printMsg("�۾�����",sDateSel+"",this);
			//StringUtil.printMsg("��¼���",v_prt_seq,this);
			
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput(); 
			
            for(int i=0; i<dSets.length;i++){
				//StringUtil.printMsg(" ������Ʈ�� �����ͼ� ���� ",dSets[i].getName(),this);		
				//O:DS1=ds1,O:DS2=ds2,O:DS3=ds3)
            	if(dSets[i].getName().equals("ds1")){
					GauceDataSet ds1 = gis.read("DS1");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setInt(1,sSaup_sid);
					cstmt.setInt(2, sUpjang_sid);
					cstmt.setString(3, sJob_date);
					cstmt.setString(4, sCust_name);
					cstmt.setInt(5, sGoods_sid);
					cstmt.setString(6,sDateSel);
					cstmt.setString(7,v_prt_seq);
					cstmt.registerOutParameter(8, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(8);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            }
				
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

	
	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}

}
