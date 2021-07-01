package Ehr.gun.e.gune010.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class GUNE010DAO extends AbstractDAO {
	/**
	 * GUNA012DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNE010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �ڵ����缱 ��ȸ
	 * @param p_box CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_APP(CBox p_box) throws CException {

		/** �ܺ� XML���� �ڵ����缱 ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_APP");

		
		/** ��ȸ ����(����2)�� ���� ó�� #2  ����**/
		StringBuffer sb1 = new StringBuffer();
		//String dptcd = JSPUtil.rns(p_box.get("DPT_CD"));

		if (p_box.get("DPT_CD").equals("II25")) {
			sb1.append("AND B.DPT_CD = 'II20'\n");
			sb1.append("AND B.DUTY_CD = '41'");
		}
		else if (p_box.get("DPT_CD").equals("II35")) {
			sb1.append("AND B.DPT_CD = 'II33'\n");
			sb1.append("AND B.DUTY_CD = '04'");
		}
		else if (p_box.get("DPT_CD").equals("II55")) {
			sb1.append("AND B.DPT_CD = 'II45'\n");	
			sb1.append("AND B.DUTY_CD = '41'");
		}
		else {
			sb1.append("AND A.DPT_CD = B.DPT_CD\n");
			sb1.append("AND B.DUTY_CD = '41'");
		}
		
		Object[] sqlParam = new Object[] {
				sb1.toString(),
		
		};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),				
				JSPUtil.rns(p_box.get("ENO_NO")),
				
				JSPUtil.rns(p_box.get("ENO_NO")),				
				JSPUtil.rns(p_box.get("ENO_NO")),				
				
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),				
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("ENO_NO")),	
		};

		 this.selectProcessFirstRow(sql, bind, prop);

	}
	
	/**
	 * ���� ��ȸ
	 * @param p_box CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_WK(CBox p_box) throws CException {

		/** �ܺ� XML���� �ڵ����缱 ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_WK");
		
		String REG_YMD  = JSPUtil.rns(p_box.get("REG_YMD").replaceAll("-", ""));
		
		String PIS_YM  = JSPUtil.rns(p_box.get("REG_YMD").replaceAll("-", "").substring(0, 4));		

		
		
		//System.out.println(REG_YMD);
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				REG_YMD,
				PIS_YM
		};

		 this.selectProcessFirstRow(sql, bind, prop);

	}	
	/**
	 * ��� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * ��� ����ٹ� �����ð��� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_ACC(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_ACC");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("WEEK_NO")),
				JSPUtil.rns(p_box.get("ENO_NO"))
		};
        
		prop.add("WEEK_TOT_TIME",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HOL_TOT_TIME",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ALL_TOT_TIME",ColumnProp.COLUMN_TYPE_DECIMAL ,3.1 ,ColumnProp.CONSTRAINT_TB_NORMAL);
        
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ��� ����ٹ� ��ϰ������ڸ� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNE010_SHR_OTD(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_OTD");
		
		String REG_YMD  = JSPUtil.rns(p_box.get("REG_YMD").replaceAll("-", ""));
				
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				REG_YMD
		};

		//return this.selectProcessFirstRow(sql, bind, prop);
		return this.selectProcess(sql, bind, prop);
		
		
	}
	
	/**
	 * ��� ����ٹ� �����ð��� ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_SHR_MAX(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_SHR_MAX");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				//JSPUtil.rns(p_box.get("WEEK_NO")),
				//JSPUtil.rns(p_box.get("ENO_NO"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * ����ٹ� ������ ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_UPT_APP(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_UPT_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("STR_REG_YMD")),
				JSPUtil.rns(vo.get("STR_OVR_TIME")),
				JSPUtil.rns(vo.get("END_REG_YMD")),
				JSPUtil.rns(vo.get("END_OVR_TIME")),
				JSPUtil.rns(vo.get("REMARK")),
				JSPUtil.rns(vo.get("PENO_NO")),
				JSPUtil.rns(vo.get("GUBN")),
				JSPUtil.rns(vo.get("WEEK_TOT_TIME")),
				JSPUtil.rns(vo.get("HOL_TOT_TIME")),
				JSPUtil.rns(vo.get("ALL_TOT_TIME")),
				JSPUtil.rns(vo.get("WEEK_OF_YEAR")),
				JSPUtil.rns(vo.get("OVR_TIME")),
				JSPUtil.rns(p_box.get("APP_YN")),
				JSPUtil.rns(vo.get("JOB_CD")),
				
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
		
	/**
	 * ���缱�� ���� �ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNE010_UPT_APP_01(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNE010_UPT_APP_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(p_box.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				//JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("HENO_NO")),
				JSPUtil.rns(vo.get("HJOB_CD")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("REQ_NO"))
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}	
	
	
	/**
	 * SMS �����ϴ� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 * @throws SQLException 
	 */
	public void GUNE010_SMS(CBox p_box) throws CException, SQLException {

        PreparedStatement pstmt = null;
        
        StringBuffer query = new StringBuffer();
        
		Connection conn;
		//System.out.print("---------------------------   444444444444444444   ---------");
		//System.out.print(p_box);	
		try{
			
			conn = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");

				// SMS �߼�
				query.append ("	INSERT INTO EMMADB.DBO.EM_SMT_TRAN( 			\n");
				query.append ("		MT_REFKEY,                               	\n");
				query.append ("		DATE_CLIENT_REQ,                            \n");
				query.append ("		CONTENT,                             		\n");
				query.append ("		CALLBACK, 									\n");
				query.append ("		SERVICE_TYPE,                               \n");
				query.append ("		BROADCAST_YN,                               \n");
				query.append ("		MSG_STATUS,                             	\n");
				query.append ("		RECIPIENT_NUM, 								\n");				
				query.append ("		CARRIER )									\n");				
				query.append ("	VALUES (										\n");
				query.append ("		'FAM',  									\n");
				query.append ("		GETDATE(),  								\n");
				query.append ("		'TEST',                                     \n");				
				query.append ("		'0236693900', 								\n");
				query.append ("		'0',  										\n");
				query.append ("		'N',  										\n");
				query.append ("		'1',  										\n");		
				query.append ("		'01095001915',								\n");					
				query.append ("		10001 ); 									\n");		
				
				//Log.main.println(query.toString());
				pstmt = conn.prepareStatement(query.toString());
				
				//pstmt.setString(++colCnt, ENO_NO);		//�����ȣ
				
				ResultSet rs = pstmt.executeQuery();



		}finally {

			
			
		}		
		
		
		pstmt.close();
		conn.close();
		
		
	}	
	
	
	

}
