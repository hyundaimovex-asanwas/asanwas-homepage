package Ehr.but.a.buta070.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class BUTA070DAO extends AbstractDAO {

	/**
	 * BUTA070DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BUTA070DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �������ޱ��� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA070_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA070_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
		};

		prop.add("GBN_CD", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * �������ޱ��� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BUTA070_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA070_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("GBN_CD"),//pk
				vo.get("GBN_NAME"),
				vo.get("EXP_AMT1"),
				vo.get("EXP_AMT2"),
				vo.get("EXP_AMT3"),
				vo.get("EXP_AMT4"),
				vo.get("EXP_AMT5"),
				vo.get("EXP_AMT6"),
				p_box.get("vusrid"),//�Է���
				p_box.get("vusrid")//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �������ޱ��� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA070_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA070_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("GBN_NAME"),
				vo.get("EXP_AMT1"),
				vo.get("EXP_AMT2"),
				vo.get("EXP_AMT3"),
				vo.get("EXP_AMT4"),
				vo.get("EXP_AMT5"),
				vo.get("EXP_AMT6"),
				p_box.get("vusrid"),//������
				vo.get("GBN_CD")//pk
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * �������ޱ��� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BUTA070_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA070_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				vo.get("GBN_CD")//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}
}
