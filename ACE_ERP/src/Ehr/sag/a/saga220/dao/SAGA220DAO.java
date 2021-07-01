package Ehr.sag.a.saga220.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SAGA220DAO extends AbstractDAO {

	/**
	 * SAGA220DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGA220DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �޿����̺� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA220_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA220_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("ENO_NO_SHR"),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("SAL_GBN_SHR"),
		};


		prop.add("DESCPT", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA220_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA220_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �޿����̺� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGA220_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA220_INS");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {


				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns3(vo.get("BAS_AMT")),
				JSPUtil.rns3(vo.get("DUTY_AMT")),
				JSPUtil.rns3(vo.get("LAW_AMT")),
				JSPUtil.rns3(vo.get("BNS_AMT")),
				JSPUtil.rns3(vo.get("ETC_AMT")),
				JSPUtil.rns3(vo.get("ETC_AMT2")),

				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),//pk

				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(p_box.get("vusrid"))//������
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	
	
	/**
	 * �޿����̺� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA220_SHR_09(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA220_SHR_09");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("ENO_NO_SHR"),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("SAL_GBN_SHR"),
		};


		prop.add("DESCPT", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	
	
	
	/**
	 * �޿����̺� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGA220_UPT2(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA220_UPT2");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {


				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk

				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}

	/**
	 * �޿����̺� �ű� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGA220_UPT3(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA220_UPT3");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {


				JSPUtil.rns(p_box.get("vusrid")),//�Է���
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};

		/** INSERT�޼ҵ� ȣ��  **/
		insertProcess(sql, bind);
	}
	/**
	 * �޿����̺� ����
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGA220_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA220_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns3(vo.get("BAS_AMT")),
				JSPUtil.rns3(vo.get("DUTY_AMT")),
				JSPUtil.rns3(vo.get("LAW_AMT")),
				JSPUtil.rns3(vo.get("BNS_AMT")),
				JSPUtil.rns3(vo.get("ETC_AMT")),
				JSPUtil.rns3(vo.get("ETC_AMT2")),
				JSPUtil.rns(p_box.get("vusrid")),//������
				JSPUtil.rns(vo.get("HOB_CD")),//pk
		};
		/** UPDATE�޼ҵ� ȣ��  **/
		updateProcess(sql, bind);
	}

	/**
	 * �޿����̺� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGA220_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA220_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("HOB_CD")),//pk
				JSPUtil.rns(vo.get("APY_YMD").replaceAll("-", "")),//pk
		};

		/** DELETE�޼ҵ� ȣ��  **/
		deleteProcess(sql, bind);
	}

	/**
	 * �޿����̺� ����
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGA220_DEL_01(CBox p_box) throws CException {

	    /** �ܺ� XML���� SQL�� �о� �´� **/
	    String sql = XmlSqlUtils.getSQL("sag", "SAGA220_DEL_01");

	    /** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("OCC_CD")),//pk
	            JSPUtil.rns(p_box.get("APY_YMD").replaceAll("-", "")),//pk
	    };

	    /** DELETE�޼ҵ� ȣ��  **/
	    deleteProcess(sql, bind);
	}

}
