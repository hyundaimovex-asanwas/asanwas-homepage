package Ehr.cod.f.codf010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODF010DAO extends AbstractDAO {

	/**
	 * CODF010DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODF010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * Ʈ�������� ���� ���� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODF010_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("cod", "CODF010_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				//p_box.get("SESSION_GUBUN")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���� �����ڵ忡 ���� ���� �����ڵ� �� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void CODF010_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("SESSION_GUBUN"),
				p_box.get("COUNT_REM"),
				p_box.get("COUNT_REM")+"%"
		};
		
		prop.add("DUTY_CD", ColumnProp.COLUMN_TYPE_STRING, 6,  ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * ���������� �ϳ��� ������ ȸ�������� �ִ´�.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODF010_INS(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//�Է���
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//������
				JSPUtil.rns(p_box.get("SESSION_GUBUN"))//pk
		};
		
		prop.add("DUTY_CD", ColumnProp.COLUMN_TYPE_STRING, 6,  ColumnProp.CONSTRAINT_TB_KEY);

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �������� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODF010_INS_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_INS_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/

		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("DUTY_CD")),//pk
				JSPUtil.rns(vo.get("DUTY_NM")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns(vo.get("UPDUTY_CD")),
				JSPUtil.rns("1"),//�������� ����(1:����,2:�ִ�);
				JSPUtil.rns(vo.get("DUTY_LBL")),
				JSPUtil.rns(vo.get("COUNT_REM")),
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//�Է���
				JSPUtil.rns(vo.get("IPT_YMD")),//������ڴ� ����ڷκ��� �޴´�
				JSPUtil.rns(p_box.get("SESSION_ENONO"))//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �������� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODF010_UPT_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_UPT_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("DUTY_NM")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns(vo.get("UPDUTY_CD")),
				JSPUtil.rns("1"),//�������� ����(1:����,2:�ִ�);
				JSPUtil.rns(vo.get("DUTY_LBL")),
				JSPUtil.rns(vo.get("COUNT_REM")),
				JSPUtil.rns(vo.get("IPT_YMD")),//������ڴ� ����ڷκ��� �޴´�
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//������
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("DUTY_CD"))//pk
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���������� ������������ update�Ѵ�.(���������� �������� �ִٰ� update)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODF010_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_UPT_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(Integer.toString(Integer.parseInt(vo.get("DUTY_LBL"))-1)),//��������
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)),//���� countremark
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * ���������� ������������ update�Ѵ�.(���������� �������� ���ٰ� update)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODF010_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_UPT_03");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)),//���� countremark
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)+"%"),//���� countremark
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		//updateProcess(sql, bind);
		deleteProcess(sql, bind);//������Ʈ�Ǵ� row�� 0�̾ ������ �ǰ� �ϱ����� deleteProcess�� ���
	}

	/**
	 * �������� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODF010_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_DEL_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("DUTY_CD")),//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

}
