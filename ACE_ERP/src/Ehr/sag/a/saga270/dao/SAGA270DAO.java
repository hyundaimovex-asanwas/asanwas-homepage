package Ehr.sag.a.saga270.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class SAGA270DAO extends AbstractDAO {

	/**
	 * SAGA270DAO ������ �̸�, FirstRow ����� �����ϱ� ���ؼ��� �Ʒ��� ����
	 * Connection, TrBox��ü�� �̿��ؼ� �����ڸ� ����� �־�� �Ѵ�.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGA270DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass�� ������ ȣ�� **/
		super(p_conn, p_tr);
	}

	/**
	 * ����ȸ ������Ȳ ��ȸ(MASTER)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SHR(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SHR");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")+"25",
				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * ����ȸ ������Ȳ ��ȸ(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SHR_01(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SHR_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO_SHR"),
				p_box.get("EXE"),
				p_box.get("APPDT").replaceAll("-", "")				
		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * ����ȸ ������Ȳ ��ȸ(PRINT)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SHR_PRINT(CBox p_box) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SHR_PRINT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")+"25",
				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")

		};

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * ����ȸ ������Ȳ ����(MASTER)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV");

		//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
		//System.out.print(vo);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APPAMT")),
				JSPUtil.rns(vo.get("REASON")),
				JSPUtil.rns(vo.get("EXE")),
				p_box.get("vusrid")

		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		/** this.selectProcessFirstRow(sql, bind, prop); **/

	}

	/**
	 * ����ȸ ������Ȳ ����(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV_01(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV_01");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLCNT")),
				JSPUtil.rns(vo.get("APPAMT")),
				JSPUtil.rns(vo.get("APBAMT")),
				JSPUtil.rns(vo.get("APLAMT")),
				JSPUtil.rns(vo.get("APJAMT")),
				JSPUtil.rns(vo.get("RATAMT")),
				JSPUtil.rns(vo.get("CALAMT")),
				JSPUtil.rns(vo.get("REASON")),
				JSPUtil.rns(vo.get("EXE")),
				p_box.get("vusrid"),
				p_box.get("vusrid")
		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

	}

	/**
	 * �系 ������Ȳ ����(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV_01_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV_01_UPT");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLCNT")),
				JSPUtil.rns(vo.get("APPAMT")),
				JSPUtil.rns(vo.get("APBAMT")),
				JSPUtil.rns(vo.get("APLAMT")),
				JSPUtil.rns(vo.get("APJAMT")),
				JSPUtil.rns(vo.get("RATAMT")),
				JSPUtil.rns(vo.get("CALAMT")),
				JSPUtil.rns(vo.get("REASON")),
				JSPUtil.rns(vo.get("EXE")),
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", ""))
		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

	}

	/**
	 * ����ȸ ������Ȳ ����(�ߵ���ȯ)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV_REP(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV_REP");

		//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
		//System.out.print(vo);

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("APBAMT")),
				JSPUtil.rns(vo.get("APLAMT")),
				JSPUtil.rns(vo.get("CALAMT")),
				JSPUtil.rns(vo.get("REPDT").replaceAll("-", "")),
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("REPMM").replaceAll("-", ""))

		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

		/**Query  ���� �� �ڷ� ������� Request�� Client Dataset�� ���� ��ȯ(FirstRow���)  **/
		/** this.selectProcessFirstRow(sql, bind, prop); **/

	}

	/**
	 * ����ȸ ������Ȳ ����(�ߵ���ȯ)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** �ܺ� XML���� SQL�� �о� �´� **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV_REP_DEL");

		/** SQL�� ���ε� �� ���� ���������� �־� �ش� **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("REPMM").replaceAll("-", ""))

		};

		/** INSERT�޼ҵ� ȣ�� * */
		insertProcess(sql, bind);

	}

}
