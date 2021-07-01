package Ehr.pir.a.pira027.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA027DAO extends AbstractDAO {
	/**
	 * PIRA027DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA027DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * ���м��� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA027_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� ���м��� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA027_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PRO_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SBJ_CD", ColumnProp.COLUMN_TYPE_STRING , 3, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���м��� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA027_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���м��� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA027_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("PRO_YMD").replaceAll("-", ""),    // ��������
				vo.get("OCC_CD"),                                 // �����ڵ�
				vo.get("INT_NAM"),                                 // ����ó
				vo.get("SBJ_CD"),                                  // ��������ڵ�
				vo.get("SBJ_LSN"),                                // û��
				vo.get("SBJ_RED"),                                // �ʱ�
				vo.get("SBJ_SPC"),                                // ���ϱ�
				vo.get("SBJ_VOC"),                                // ����
				vo.get("SBJ_IPT"),                                // ����
				vo.get("SBJ_TOT"),                                // ����
				vo.get("SBJ_ETC"),                                // ��Ÿ
				vo.get("TTL_AVR"),                                // �հ�
				vo.get("GRADE"),                                   // �޼�
				vo.get("SBJ_AMT"),                               // �������÷�
				vo.get("REMARK"),                                // ���
				p_box.get("vusrid"),            // �Է���
				p_box.get("vusrid")             // ������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);

	}

	/**
	 * ���м��� UPDATE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA027_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���м��� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA027_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("INT_NAM"),                                 // ����ó
				vo.get("SBJ_CD"),                                  // ��������ڵ�
				vo.get("SBJ_LSN"),                                // û��
				vo.get("SBJ_RED"),                                // �ʱ�
				vo.get("SBJ_SPC"),                                // ���ϱ�
				vo.get("SBJ_VOC"),                                // ����
				vo.get("SBJ_IPT"),                                // ����
				vo.get("SBJ_TOT"),                                // ����
				vo.get("SBJ_ETC"),                                // ��Ÿ
				vo.get("TTL_AVR"),                                // �հ�
				vo.get("GRADE"),                                   // �޼�
				vo.get("SBJ_AMT"),                               // �������÷�
				vo.get("REMARK"),                                // ���
				p_box.get("vusrid"),            // ������
				vo.get("ENO_NO"),                                // ���
				vo.get("PRO_YMD").replaceAll("-", ""),   // ��������
				vo.get("SBJ_CD")                                   // ��������ڵ�
		};

		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);

	}

	/**
	 * ���м��� DELETE�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA027_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� ���м��� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA027_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // ���
				vo.get("PRO_YMD").replaceAll("-", ""),   // ��������
				vo.get("SBJ_CD")                                   // ��������ڵ�
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
}
