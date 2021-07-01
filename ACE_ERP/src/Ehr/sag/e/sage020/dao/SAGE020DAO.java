package Ehr.sag.e.sage020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SAGE020DAO extends AbstractDAO {

	/**
	 * SAGD010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGE020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGE020_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE020_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("SITE_CD"),
				p_box.get("ENO_NO"),
				p_box.get("PIS_YYMM").substring(0, 4),//pk
				p_box.get("PIS_YYMM").substring(5, 7),//pk
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 휴일 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGE020_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE020_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGE020_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE020_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(p_box.get("vusrid"))//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 급여테이블 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGE020_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGE020_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}


}
