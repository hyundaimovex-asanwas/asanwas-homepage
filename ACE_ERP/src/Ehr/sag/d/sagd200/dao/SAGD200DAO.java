package Ehr.sag.d.sagd200.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SAGD200DAO extends AbstractDAO {

	/**
	 * SAGD200DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGD200DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	
	/**
	 * ��������ó�� ���� ��� �λ���ǥ SELECT�� �����ϴ� DAO �޼ҵ�
	 */
	public void SAGD200_SHR_ACC(CBox p_box) throws CException {

		/** ���α׷� ��� �α� ������ ����Ѵ� **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** �˻� ���� Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"sagd200",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT�޼ҵ� ȣ��  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	
	/**
	 * �޿����̺� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD200_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD200_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PAY_YMD").replaceAll("-", ""),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("ENO_NO_SHR"),
				p_box.get("JOB_CD_SHR"),

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}


	/**
	 * �޿����̺� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD200_SHR_SO(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD200_SHR_SO");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PAY_YMD").replaceAll("-", ""),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("ENO_NO_SHR"),
				p_box.get("JOB_CD_SHR"),

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �������� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD200_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD200_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * ��¹� ��ȸ
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD200_SHR_PRINT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD200_SHR_PRINT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PAY_YMD").replaceAll("-", ""),
				p_box.get("APY_YMD_SHR").replaceAll("-", ""),
				p_box.get("ENO_NO_SHR"),
				p_box.get("JOB_CD_SHR"),
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}




}
