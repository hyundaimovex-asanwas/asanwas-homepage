package Ehr.pir.a.pira028.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA028DAO extends AbstractDAO {
	/**
	 * PIRA028DAO ������
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA028DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass�� ������ ȣ�� **/
		super(p_dsId, p_tr);

	}

	/**
	 * �������� SELECT�� �����ϴ� DAO �޼ҵ�
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA028_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ������ ��ȸ SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA028_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�˻�����) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // ���
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("EDU_CD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SEQ_NO", ColumnProp.COLUMN_TYPE_STRING , 7, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PLACE_NM", ColumnProp.COLUMN_TYPE_STRING , 20, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �������� INSERT�� �����ϴ� DAO �޼ҵ�.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA028_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ������  �����ϴ� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA028_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (�Է´��) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                         // ���
				vo.get("STR_YMD").replaceAll("-", ""),    // ��������
				vo.get("OCC_CD"),                         // �����ڵ�
				vo.get("END_YMD").replaceAll("-", ""),    // ��������
				vo.get("EDU_CD"),                         // �����ڵ�
				vo.get("SEQ_NO"),                         // ����
				vo.get("EDU_GBN_CD"),                     // ����ó
				vo.get("PLACE_CD"),                       // ��������ڵ�
				vo.get("CPT_PNT"),
				vo.get("EDU_NM"),
				vo.get("INT_NAM"),
				vo.get("EDU_TAG"),
				vo.get("DECISION_CD"),                    // ����ó
				p_box.get("vusrid"),               // �Է���
				p_box.get("vusrid")                // ������

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
	public void PIRA028_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ������ ���� SQL ����  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA028_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (������� �� ����) **/
		Object[] bind = new Object[] {
				vo.get("PLACE_CD"),                       // ��������ڵ�
				vo.get("STR_YMD").replaceAll("-", ""),    // ��������
				vo.get("END_YMD").replaceAll("-", ""),    // ��������
				vo.get("EDU_GBN_CD"),                     // �ʼ�����
				vo.get("EDU_TAG"),                        // ���Ῡ��
				vo.get("EDU_NM"),                         // ������
				vo.get("INT_NAM"),                        // ����ó
				vo.get("REMARK"),                         // ���
				p_box.get("vusrid"),               // ������
				vo.get("ENO_NO"),                         // ���
				vo.get("EDU_CD"),                         // �����ڵ�
				vo.get("SEQ_NO")                          // ����
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
	public void PIRA028_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** �ܺ� XML���� �������� ���̺� ���� SQL ���� **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA028_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� (��������) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // ���
				vo.get("EDU_CD"),                                 // �����ڵ�
				vo.get("SEQ_NO")                                  // ����
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);

	}
}
