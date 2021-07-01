package Ehr.cod.a.coda010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class CODA010DAO extends AbstractDAO {

	/**
	 * CODA010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 본사정보 데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public void CODA010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODA010_SHR");
			
		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, null, prop);
	}

	/**
	 * 본사정보 신규 저장
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void CODA010_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODA010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUBUN")),//pk
				JSPUtil.rns(vo.get("GUBUN_NM")),
				JSPUtil.rns(vo.get("COMP_NM")),
				JSPUtil.rns(vo.get("COMP_ENM")),
				JSPUtil.rns(vo.get("PRESIDENT_NM")),
				JSPUtil.rns(vo.get("PRESIDENT_ENM")),
				JSPUtil.rns(vo.get("TAX_NO")).replaceAll("-", ""),// 하이픈은 빼고 넣는다.
				JSPUtil.rns(vo.get("CORP_NO")).replaceAll("-", ""),// 하이픈은 빼고 넣는다.
				JSPUtil.rns(vo.get("BUSI_COND")),
				JSPUtil.rns(vo.get("BUSI_ITEM")),
				JSPUtil.rns(vo.get("POST_NO")),
				JSPUtil.rns(vo.get("ADDRESS_HD")),
				JSPUtil.rns(vo.get("ADDRESS_DT")),
				JSPUtil.rns(vo.get("TEL_NO")),
				JSPUtil.rns(vo.get("FAX_NO")),
				JSPUtil.rns(vo.get("COMP_URL")),
				JSPUtil.rns(vo.get("HOMETAX_ID")),
				JSPUtil.rns3(vo.get("CORP_KIND")),
				JSPUtil.rns3(vo.get("CORP_GBN")),
				JSPUtil.rns3(vo.get("LOCATION_GBN")),
				JSPUtil.rns(vo.get("TAX_OFFICE")),
				JSPUtil.rns(vo.get("WARD_OFFICE")),
				JSPUtil.rns3(vo.get("CAPITAL_TOT")),
				JSPUtil.rns3(vo.get("EMPLOYEE_TOT")),
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("ACF_QUT")),
				JSPUtil.rns(vo.get("ACC_STDT")),
				JSPUtil.rns(vo.get("ACC_ENDT")),
				JSPUtil.rns3(vo.get("PAY_DAY")),
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(p_box.get("vusrid"))//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 본사정보 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void CODA010_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODA010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUBUN_NM")),
				JSPUtil.rns(vo.get("COMP_NM")),
				JSPUtil.rns(vo.get("COMP_ENM")),
				JSPUtil.rns(vo.get("PRESIDENT_NM")),
				JSPUtil.rns(vo.get("PRESIDENT_ENM")),
				JSPUtil.rns(vo.get("TAX_NO")).replaceAll("-", ""),// 하이픈은 빼고 넣는다.
				JSPUtil.rns(vo.get("CORP_NO")).replaceAll("-", ""),// 하이픈은 빼고 넣는다.
				JSPUtil.rns(vo.get("BUSI_COND")),
				JSPUtil.rns(vo.get("BUSI_ITEM")),
				JSPUtil.rns(vo.get("POST_NO")),
				JSPUtil.rns(vo.get("ADDRESS_HD")),
				JSPUtil.rns(vo.get("ADDRESS_DT")),
				JSPUtil.rns(vo.get("TEL_NO")),
				JSPUtil.rns(vo.get("FAX_NO")),
				JSPUtil.rns(vo.get("COMP_URL")),
				JSPUtil.rns(vo.get("HOMETAX_ID")),
				JSPUtil.rns3(vo.get("CORP_KIND")),
				JSPUtil.rns3(vo.get("CORP_GBN")),
				JSPUtil.rns3(vo.get("LOCATION_GBN")),
				JSPUtil.rns(vo.get("TAX_OFFICE")),
				JSPUtil.rns(vo.get("WARD_OFFICE")),
				JSPUtil.rns3(vo.get("CAPITAL_TOT")),
				JSPUtil.rns3(vo.get("EMPLOYEE_TOT")),
				JSPUtil.rns(vo.get("STR_YMD")),
				JSPUtil.rns(vo.get("ACF_QUT")),
				JSPUtil.rns(vo.get("ACC_STDT")),
				JSPUtil.rns(vo.get("ACC_ENDT")),
				JSPUtil.rns3(vo.get("PAY_DAY")),
				JSPUtil.rns(p_box.get("vusrid")),//수정자
				JSPUtil.rns(vo.get("GUBUN"))//pk
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

}
