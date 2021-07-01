package Ehr.acq.a.acqa010.dao;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.gauce.GauceDataSet;
import com.hmm.ejb.common.UtilDB;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;


public class ACQA010DAO extends AbstractDAO {
	
	/**
	 * ACQA010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACQA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	/**
	 * ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SHR");

		/** ��ȸ ���ǿ� ���� ó�� **/
		//StringBuffer sb = new StringBuffer();

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		//Object[] sqlParam = new Object[] {
		//		sb.toString()
		//};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		//sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
                //JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                
        };

		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	
	/**
	 * ���� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA010_SHR_01(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SHR");

		/** ��ȸ ���ǿ� ���� ó�� **/
		//StringBuffer sb = new StringBuffer();

		/** DynamicSQL�� �����ϴ� �κ� [1] ~ [xx]�� ���������� �����ϰ� �ȴ� **/
		//Object[] sqlParam = new Object[] {
		//		sb.toString()
		//};

		/** [1] ~ [xx] ������ ���� sqlParam�� �����ؼ� SQL���� ��ȯ�ϰ� �ȴ� **/
		//sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                
        };

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);			
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	/**
	 * ���� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA010_SHR_APP(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SHR_APP");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("REQ_NO"))
		};

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);		
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	
	
	
	
	
	
	
	/**
	 * ���� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
			JSPUtil.rns(vo.get("DOC_GB3")),
			JSPUtil.rns(vo.get("DOC_TITLE")),
			JSPUtil.rns(vo.get("DOC_REMARK")),
			"S",
			"1",
			JSPUtil.rns(vo.get("DOC_STATUS")),
			JSPUtil.rns(vo.get("FILE_KEY")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid")),
			
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	
	
	
	
	
	/**
	 * ���� ������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("DOC_GB3")),
				JSPUtil.rns(vo.get("DOC_TITLE")),
				JSPUtil.rns(vo.get("DOC_REMARK")),
				JSPUtil.rns(vo.get("REQ_NO")),
				JSPUtil.rns(vo.get("APP_STATUS_CD")),
				JSPUtil.rns(vo.get("DOC_SEQ")),
				JSPUtil.rns(vo.get("DOC_STATUS")),
				JSPUtil.rns(vo.get("FILE_KEY")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("DOC_NO")),
				
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}
	
	
	
	
	
	/**
	 * ������������ �����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_INS_APP(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_INS_APP");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),			//
				JSPUtil.rns(vo.get("SEQ_NO")),			//
				"S",
				JSPUtil.rns(p_box.get("vusrid")),		//����ڻ��
				JSPUtil.rns(vo.get("ENO_NO")),			//�����ڻ��
				JSPUtil.rns(vo.get("DPT_CD")),			//�����ڼҼ�
				JSPUtil.rns(vo.get("JOB_CD")),			//����������
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	
	
	
	
	/**
	 * ���������� ����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_SUB(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SUB");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("DOC_NO")),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);	

	}
	
	public void ACQA010_SUB2(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SUB2");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("DOC_NO")),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);	

	}	
	
	
	
	/**
	 * ���������� ����ϴ� DAO�޼ҵ�.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA010_SMS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		//String sql = XmlSqlUtils.getSQL("acq", "ACQA010_SMS");
		
		
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		//Object[] bind = new Object[] {

		//		JSPUtil.rns(vo.get("DOC_TITLE")),				
		//		JSPUtil.rns(vo.get("ENO_NO")),
		//};

		System.out.println("############################################ query ############################################ ");
		
		
		Connection con = null;

        PreparedStatement pstmt = null;		
		
		
        StringBuffer query = new StringBuffer("INSERT INTO EMMADB.DBO.EM_SMT_TRAN( 			\n");
				        query.append("	MT_REFKEY,											\n");
				        query.append("	DATE_CLIENT_REQ,									\n");
				        query.append("	CONTENT,											\n");
				        query.append("	CALLBACK,											\n");
				        query.append("	SERVICE_TYPE,										\n");
				        query.append("	BROADCAST_YN,										\n");
				        query.append("	MSG_STATUS,											\n");
				        query.append("	RECIPIENT_NUM,										\n");
				        query.append("	CARRIER)											\n");
				        query.append("	VALUES(												\n");
				        query.append("	'APS',												\n");
				        query.append(" 	GETDATE(),											\n");
				        query.append(" 	 ?,													\n");
				        query.append("	'0236693753',										\n");
				        query.append("	'0',												\n");
				        query.append("	'N',												\n");
				        query.append("	'1',												\n");
				        query.append("	 ?,													\n");			        
				        query.append("	 10001);											\n");	
																												

        
		System.out.println("###################### query: "+query.toString());
        
        
		/* SMS ������ �κ� Start */

		String  DOC_TITLE		= JSPUtil.rns(vo.get("DOC_TITLE")); 		
		String  PHONE_NO		= JSPUtil.rns(vo.get("PHONE_NO")); 		
		String  Message 		= null;

		Message = "[����ƻ� APS]" + DOC_TITLE + " ������ ��ϵǾ����ϴ�.";					

		
        try {

            con = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");

            pstmt = con.prepareStatement(query.toString());

            pstmt.setString(1, Message);
            pstmt.setString(2, PHONE_NO);

            pstmt.executeUpdate();

            pstmt.close();
            con.close();	

        } catch( SQLException e) {
        	
            e.printStackTrace();

        } finally {
        	
            UtilDB.closeConnection(con, pstmt);
        }
		
		
		
		//con = DriverManager.getConnection("jdbc:sqlserver://203.242.32.128:1433;databaseName=emmadb;username=emmauser;password=dktks4ever;");
		
        //StringUtil.printMsg("Message::",Message,this);								
		
		//cstmt_ms = con_sms.prepareCall(arr_sql[3].toString());

		//cstmt_ms.setString(1, Message);
		//cstmt_ms.setString(2, v_phone);
		
		//rs_ms = cstmt_ms.executeQuery();
		
		//gos.write(getDataSet(rs_ms, ds3));

		//rs_ms.close();
		//cstmt_ms.close();
		//con.close();		
		
		
		
		
		
		
		/** INSERT�޼ҵ� ȣ��  **/
		//insertProcess(sql, bind);		

	}	
	

	
	/**
	 * ������ �����ϴ�  DAO�޼ҵ�.
     * @param vo
     * @param p_box
	 * @throws CException
	 */
	public void ACQA010_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				
				JSPUtil.rns(vo.get("REQ_NO")),
				JSPUtil.rns(p_box.get("vusrid"))
				
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
	
	
	
	/**
     * ���������� ���� DAO �޼���
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void ACQA010_DEL_APP(CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA010_DEL_APP");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))				

		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	
}
