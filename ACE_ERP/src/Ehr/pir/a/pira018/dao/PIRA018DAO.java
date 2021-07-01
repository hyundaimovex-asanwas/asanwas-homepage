package Ehr.pir.a.pira018.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA018DAO extends AbstractDAO {
	/**
	 * PIRA018DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA018DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �������� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA018_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA018_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REL_CD", ColumnProp.COLUMN_TYPE_STRING , 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NM", ColumnProp.COLUMN_TYPE_STRING , 12, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �������� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA018_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA018_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // ���
				vo.get("REL_CD"),                                 // ���������ڵ�
				vo.get("ENO_NM"),                                // ��������
				vo.get("BIR_YMD"),    							// �������
				vo.get("EDGR_CD"),                              // �з��ڵ�
				vo.get("OCC_NAM"),                              // �ٹ�ó
				vo.get("JOB_CD"),                                 // ����
				vo.get("DPD_TAG"),                              // �ξ翩��
				vo.get("HIU_TAG"),                                // �Ǻ�����
				p_box.get("vusrid"),            					// �Է���
				p_box.get("vusrid")             					// ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	/**
	 * �������� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA018_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA018_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("BIR_YMD"),    							// �������
				vo.get("EDGR_CD"),                              // �з��ڵ�
				vo.get("OCC_NAM"),                              // �ٹ�ó
				vo.get("JOB_CD"),                                 // ����
				vo.get("DPD_TAG"),                              // �ξ翩��
				vo.get("HIU_TAG"),                                // �Ǻ�����
				p_box.get("vusrid"),            					// ������
				vo.get("ENO_NO"),                                // ���
				vo.get("REL_CD"),                                 // ���������ڵ�
				vo.get("ENO_NM")                                 // ��������
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * �������� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA018_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA018_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // ���
				vo.get("REL_CD"),                                 // ���������ڵ�
				vo.get("ENO_NM")                                 // ��������
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
}
