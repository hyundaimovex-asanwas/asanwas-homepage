package Ehr.sag.a.saga260.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class SAGA260DAO extends AbstractDAO {

	/**
	 * SAGA260DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGA260DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * �系 ������Ȳ ��ȸ(MASTER)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YYMM_SHR").replaceAll("-", ""),
				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �系 ������Ȳ ��ȸ(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SHR_01");

		//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
		//System.out.print(p_box);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO_SHR")

			//	JSPUtil.rns(vo.get("ENO_NO_SHR"))//pk
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �系 ������Ȳ ��ȸ(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SHR_02(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SHR_02");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO_SHR")

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �系 ������Ȳ ��ȸ(PRINT)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SHR_PRINT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SHR_PRINT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")+"25",
				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * �系 ������Ȳ ����(MASTER)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SAV(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SAV");

		//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
		//System.out.print(vo);


		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APPAMT")),
				JSPUtil.rns(vo.get("APPAMT")),				
				JSPUtil.rns(vo.get("REASON")),
				p_box.get("vusrid")

		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		/** this.selectProcessFirstRow(sql, bind, prop); **/

	}


	/**
	 * �系 ������Ȳ ����(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SAV_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SAV_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APPCNT")),
				JSPUtil.rns(vo.get("APPAMT")),
				JSPUtil.rns(vo.get("APLAMT")),
				JSPUtil.rns(vo.get("APJAMT")),
				JSPUtil.rns(vo.get("APLRAT")),
				JSPUtil.rns(vo.get("REASON")),
				p_box.get("vusrid"),
				p_box.get("vusrid")


		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

	}

	/**
	 * �系 ������Ȳ ������ ���� ����(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SAV_DELAY(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SAV_DELAY");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APPCNT")),
				JSPUtil.rns(vo.get("APPAMT")),
				JSPUtil.rns(vo.get("APLAMT")),
				JSPUtil.rns(vo.get("APJAMT")),
				JSPUtil.rns(vo.get("APLRAT")),
				JSPUtil.rns(vo.get("REASON")),
				p_box.get("vusrid"),
				p_box.get("vusrid")

		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

	}

	/**
	 * �系 ������Ȳ ���� ����Ÿ ����(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SAV_DELAY_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SAV_DELAY_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),

		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

	}

	/**
	 * �系 ������Ȳ ����(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA260_SAV_01_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA260_SAV_01_UPT");

		//System.out.print("---------------------------   %%%SAGA260_SAV_01_UPT%%%   ---------");
		System.out.print(p_box);
		System.out.print(vo);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APPCNT")),
				JSPUtil.rns(vo.get("APPAMT")),
				JSPUtil.rns(vo.get("APLAMT")),
				JSPUtil.rns(vo.get("APJAMT")),
				JSPUtil.rns(vo.get("APLRAT")),
				JSPUtil.rns(vo.get("REASON")),
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", ""))
		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);


	}


}
