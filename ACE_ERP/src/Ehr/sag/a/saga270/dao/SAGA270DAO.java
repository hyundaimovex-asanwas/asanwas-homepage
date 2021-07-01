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
	 * SAGA270DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGA270DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 공조회 대출현황 조회(MASTER)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")+"25",
				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 공조회 대출현황 조회(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO_SHR"),
				p_box.get("EXE"),
				p_box.get("APPDT").replaceAll("-", "")				
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 공조회 대출현황 조회(PRINT)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SHR_PRINT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SHR_PRINT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")+"25",
				p_box.get("PIS_YYMM_SHR").replaceAll("-", "")

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 공조회 대출현황 저장(MASTER)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV");

		//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
		//System.out.print(vo);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("APPDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APLDT").replaceAll("-", "")),
				JSPUtil.rns(vo.get("APPAMT")),
				JSPUtil.rns(vo.get("REASON")),
				JSPUtil.rns(vo.get("EXE")),
				p_box.get("vusrid")

		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		/** this.selectProcessFirstRow(sql, bind, prop); **/

	}

	/**
	 * 공조회 대출현황 저장(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
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

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);

	}

	/**
	 * 사내 대출현황 저장(DETAIL)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV_01_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV_01_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
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

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);

	}

	/**
	 * 공조회 대출현황 저장(중도상환)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV_REP(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV_REP");

		//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
		//System.out.print(vo);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("APBAMT")),
				JSPUtil.rns(vo.get("APLAMT")),
				JSPUtil.rns(vo.get("CALAMT")),
				JSPUtil.rns(vo.get("REPDT").replaceAll("-", "")),
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("REPMM").replaceAll("-", ""))

		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		/** this.selectProcessFirstRow(sql, bind, prop); **/

	}

	/**
	 * 공조회 대출현황 저장(중도상환)
	 * @param p_box
	 * @throws CException
	 */
	public void SAGA270_SAV_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGA270_SAV_REP_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("REPMM").replaceAll("-", ""))

		};

		/** INSERT메소드 호출 * */
		insertProcess(sql, bind);

	}

}
