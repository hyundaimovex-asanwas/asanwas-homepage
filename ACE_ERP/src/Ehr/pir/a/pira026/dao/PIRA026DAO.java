package Ehr.pir.a.pira026.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA026DAO extends AbstractDAO {
	/**
	 * PIRA026DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA026DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ������� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA026_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA026_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REPU_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REPU_CD", ColumnProp.COLUMN_TYPE_STRING , 1, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REPU_TAG", ColumnProp.COLUMN_TYPE_STRING , 3, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ������� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA026_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ������� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA026_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("REPU_YMD").replaceAll("-", ""),  // �������
				vo.get("OCC_CD"),                                 // �����ڵ�
				vo.get("END_YMD").replaceAll("-", ""),    // ��������
				vo.get("REPU_CD"),                               // ��������ڵ�
				vo.get("REPU_TAG"),                             // ��������ڵ�
				vo.get("SYC_NAM"),                               // ����ó
				vo.get("REPU_RMK"),                             // �������
				vo.get("REMARK1"),                                // �빰
				vo.get("REMARK2"),                                // ����
				vo.get("REMARK3"),                                // ���
				p_box.get("vusrid"),             // �Է���
				p_box.get("vusrid")              // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	/**
	 * ������� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA026_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ������� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA026_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("END_YMD").replaceAll("-", ""),    // ��������
				vo.get("REPU_CD"),                               // ��������ڵ�
				vo.get("SYC_NAM"),                               // ����ó
				vo.get("REPU_RMK"),                             // �������
				vo.get("REMARK1"),                                // �빰
				vo.get("REMARK2"),                                // ����
				vo.get("REMARK3"),                                // ���
				p_box.get("vusrid"),            // ������
				vo.get("ENO_NO"),                                 // ���
				vo.get("REPU_YMD").replaceAll("-", ""),  // �������
				vo.get("REPU_CD"),                               // ��������ڵ�
				vo.get("REPU_TAG")                              // ��������ڵ�
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * ������� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA026_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ������� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA026_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("REPU_YMD").replaceAll("-", ""),  // �������
				vo.get("REPU_CD"),                               // ��������ڵ�
				vo.get("REPU_TAG")                              // ��������ڵ�
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
}
