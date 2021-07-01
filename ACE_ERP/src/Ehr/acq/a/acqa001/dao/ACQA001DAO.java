package Ehr.acq.a.acqa001.dao;


import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;


public class ACQA001DAO extends AbstractDAO {
	
	/**
	 * ACQA001DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACQA001DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	/**
	 * ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA001_SHR(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_SHR");

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
	public GauceDataSet ACQA001_SHR_01(CBox p_box) throws CException {
		
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_SHR");

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
				
                JSPUtil.rns(p_box.get("DOC_GB1")),				
                JSPUtil.rns(p_box.get("DOC_GB2")),
                JSPUtil.rns(p_box.get("DOC_GB3"))				
                //JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                
        };
		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);	
		
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	
	/**
	 * ���� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA001_SHR_ACC(CBox p_box) throws CException {
		
		
		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"PC",
				"��ü ���� ��Ȳ",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S",
				""
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);				

	}		
	
	/**
	 * ���� ������ ��ȸ�� ���� DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet ACQA001_SHR_APP(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_SHR_APP");

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
	public void ACQA001_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_INS");

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
	public void ACQA001_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_UPT");

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
	public void ACQA001_INS_APP(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_INS_APP");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),			//
				JSPUtil.rns(vo.get("SEQ_NO")),			//
				"A",
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
	public void ACQA001_SUB(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_SUB");
		
		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("DOC_NO")),
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);	

	}
	
	

	
	/**
	 * ������ �����ϴ�  DAO�޼ҵ�.
     * @param vo
     * @param p_box
	 * @throws CException
	 */
	public void ACQA001_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_DEL");

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
	public void ACQA001_DEL_APP(CBox p_box ) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("acq", "ACQA001_DEL_APP");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))				

		};


		/** DELETE�޼ҵ� ȣ��  **/
		this.deleteProcess(sql, bind);

	}

	
}
