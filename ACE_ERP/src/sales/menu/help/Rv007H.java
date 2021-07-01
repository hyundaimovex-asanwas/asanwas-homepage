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

public class Rv007H extends SuperServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void makeSql() {
        for(int i=0; i<arr_sql.length; i++) {
            arr_sql[i] = new StringBuffer();
        }
		// TODO Auto-generated method stub
		arr_sql[0].append("CALL SALES.PR_RV330S_01(?,?,?,?,?, ?)"); // ������ü & �������
		arr_sql[1].append("CALL SALES.PR_RV330S_02(?,?,?,?,?, ?)"); // �ſ�ī��
		arr_sql[2].append("CALL SALES.PR_RV330S_03(?,?, ?)"); // ��ǰ��
		arr_sql[3].append("CALL SALES.PR_RV330S_04(?,?, ?)"); // ��Ÿ��ü
		arr_sql[4].append("CALL SALES.PR_RV330S_05(?,?, ?)"); // �������Ա�
		
	}

	//init method
	public void init(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
	
	}

	//select method
	public void select(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {
		CallableStatement cstmt = null;
		ResultSet rs = null;

        GauceInputStream gis = greq.getGauceInputStream();
        GauceOutputStream gos = gres.getGauceOutputStream();
		
		//��ǰ�� ����Ʈ�� �ʿ��� �Է� �Ķ���� ����
		String sPayCd 		= HDUtil.nullCheckStr(greq.getParameter("pay_cd"));
		String sPayManageNo = HDUtil.nullCheckStr(greq.getParameter("pay_manage_no"));
		String sAcceptNo 	= HDUtil.nullCheckStr(greq.getParameter("accept_no"));
		String sPayDate		= HDUtil.nullCheckStr(greq.getParameter("pay_date"));
		int sRsvSid			= HDUtil.nullCheckNum(greq.getParameter("rsv_sid"));
		
		//StringUtil.printMsg("pay_accept_no",sAcceptNo,this);
		//StringUtil.printMsg("pay_date",sPayDate,this);
		//StringUtil.printMsg("rsv_sid",sRsvSid,this);
		//StringUtil.printMsg("PAY_CD", sPayCd,this);
		//StringUtil.printMsg("PAY_MANAGE_NO",sPayManageNo,this);
        
		try{
			//Component �κ��� ���۵� �Է½�Ʈ���� Output GauceDataSet�� �迭�� ��ȯ
            GauceDataSet[] dSets = gis.readAllOutput();			
			
			/* DS2=ds2	�������	rv007h.jsp
			 * DS3=ds3	������ü	rv008h.jsp
			 * DS4=ds4	�ſ�ī��	rv009h.jsp
			 * DS6=ds6	��ǰ��		rv010h.jsp
			 * DS7=ds7	����		rv014h.jsp
			 * DS8=ds8	��Ÿ��ü	rv015h.jsp
			 * */
            for(int i=0; i<dSets.length;i++){
            	if(dSets[i].getName().equals("ds2")){
            		//StringUtil.printMsg("�������",this);
					GauceDataSet ds1 = gis.read("DS2");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, sAcceptNo);
					cstmt.setInt(2, sRsvSid);
					cstmt.setString(3, sPayManageNo);
					cstmt.setString(4, sPayCd);
					cstmt.setString(5, sPayDate);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds3")){
            		//StringUtil.printMsg("������ü",this);
					GauceDataSet ds1 = gis.read("DS3");
					cstmt = conn.prepareCall(arr_sql[0].toString());
					cstmt.setString(1, sAcceptNo);
					cstmt.setInt(2, sRsvSid);
					cstmt.setString(3, sPayManageNo);
					cstmt.setString(4, sPayCd);
					cstmt.setString(5, sPayDate);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds7")){
            		//StringUtil.printMsg("�������Ա�",this);
					GauceDataSet ds1 = gis.read("DS7");
					cstmt = conn.prepareCall(arr_sql[4].toString());
					cstmt.setString(1, sPayManageNo);
					cstmt.setString(2, sPayCd);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds4")){
            		//StringUtil.printMsg("�ſ�ī��",this);
					GauceDataSet ds1 = gis.read("DS4");
					cstmt = conn.prepareCall(arr_sql[1].toString());
					cstmt.setString(1, sAcceptNo);
					cstmt.setInt(2, sRsvSid);
					cstmt.setString(3, sPayManageNo);
					cstmt.setString(4, sPayCd);
					cstmt.setString(5, sPayDate);
					cstmt.registerOutParameter(6, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(6);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds6")){
            		//StringUtil.printMsg("��ǰ��",this);
					GauceDataSet ds1 = gis.read("DS6");
					cstmt = conn.prepareCall(arr_sql[2].toString());
					cstmt.setString(1, sPayManageNo);
					cstmt.setString(2, sPayCd);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
				}
            	if(dSets[i].getName().equals("ds8")){
            		//StringUtil.printMsg("��ǰ��",this);
					GauceDataSet ds1 = gis.read("DS8");
					cstmt = conn.prepareCall(arr_sql[3].toString());
					cstmt.setString(1, sPayManageNo);
					cstmt.setString(2, sPayCd);
					cstmt.registerOutParameter(3, OracleTypes.CURSOR);	//����� ���� Ŀ��
					cstmt.executeQuery();
					rs = (ResultSet)cstmt.getObject(3);	//Ŀ�� OUT param. 					
					gos.write(getDataSet(rs, ds1));
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

	//apply method
	public void apply(Connection conn, HttpGauceRequest greq, HttpGauceResponse gres)  throws ServletException, Exception {

	}
}
