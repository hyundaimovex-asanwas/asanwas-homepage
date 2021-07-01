package Ehr.common.popup.empl2.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EMPL2DAO extends AbstractDAO {
	/**
	 * EMPL2DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EMPL2DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ�� ����  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EMPL2_SHR_01(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL2_SHR_01");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.getString("ENO_NO"),
				p_box.getString("ENO_NO")
		};

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * ����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ(���������)�� ����  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EMPL2_SHR_02(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL2_SHR_02");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.getString("ENO_NO"),
				p_box.getString("ENO_NO")
		};

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �ӿ� ����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ�� ����  DAO�޼ҵ�
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EMPL2_SHR_03(CBox p_box) throws CException {
		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL2_SHR_03");


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.getString("ENO_NO"),
				p_box.getString("ENO_NO")
		};

		/** SELECT�޼ҵ� ȣ�� **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

}
