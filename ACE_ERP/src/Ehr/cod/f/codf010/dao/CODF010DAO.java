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
	 * CODF010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODF010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 트리구성을 위한 직무 조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODF010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODF010_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				//p_box.get("SESSION_GUBUN")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 상위 직무코드에 따른 하위 직무코드 상세 조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODF010_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("SESSION_GUBUN"),
				p_box.get("COUNT_REM"),
				p_box.get("COUNT_REM")+"%"
		};
		
		prop.add("DUTY_CD", ColumnProp.COLUMN_TYPE_STRING, 6,  ColumnProp.CONSTRAINT_TB_KEY);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 직무정보가 하나도 없으면 회사정보를 넣는다.
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODF010_INS(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//입력자
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//수정자
				JSPUtil.rns(p_box.get("SESSION_GUBUN"))//pk
		};
		
		prop.add("DUTY_CD", ColumnProp.COLUMN_TYPE_STRING, 6,  ColumnProp.CONSTRAINT_TB_KEY);

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 직무정보 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODF010_INS_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_INS_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("DUTY_CD")),//pk
				JSPUtil.rns(vo.get("DUTY_NM")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns(vo.get("UPDUTY_CD")),
				JSPUtil.rns("1"),//하위직무 유무(1:없다,2:있다);
				JSPUtil.rns(vo.get("DUTY_LBL")),
				JSPUtil.rns(vo.get("COUNT_REM")),
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//입력자
				JSPUtil.rns(vo.get("IPT_YMD")),//등록일자는 사용자로부터 받는다
				JSPUtil.rns(p_box.get("SESSION_ENONO"))//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 직무정보 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODF010_UPT_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_UPT_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("DUTY_NM")),
				JSPUtil.rns(vo.get("END_YMD")),
				JSPUtil.rns(vo.get("UPDUTY_CD")),
				JSPUtil.rns("1"),//하위직무 유무(1:없다,2:있다);
				JSPUtil.rns(vo.get("DUTY_LBL")),
				JSPUtil.rns(vo.get("COUNT_REM")),
				JSPUtil.rns(vo.get("IPT_YMD")),//등록일자는 사용자로부터 받는다
				JSPUtil.rns(p_box.get("SESSION_ENONO")),//수정자
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("DUTY_CD"))//pk
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 상위직무의 하위직무유무 update한다.(상위직무에 하위직무 있다고 update)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODF010_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_UPT_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(Integer.toString(Integer.parseInt(vo.get("DUTY_LBL"))-1)),//상위레벨
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)),//상위 countremark
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 상위직무의 하위직무유무 update한다.(상위직무에 하위직무 없다고 update)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODF010_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_UPT_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)),//상위 countremark
				JSPUtil.rns(vo.get("COUNT_REM").substring(0,vo.get("COUNT_REM").length()-3)+"%"),//상위 countremark
		};
		/** UPDATE메소드 호출  **/
		//updateProcess(sql, bind);
		deleteProcess(sql, bind);//업데이트되는 row가 0이어도 저장이 되게 하기위해 deleteProcess을 사용
	}

	/**
	 * 직무정보 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODF010_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("vlu", "CODF010_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("SESSION_GUBUN")),//pk
				JSPUtil.rns(vo.get("DUTY_CD")),//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

}
