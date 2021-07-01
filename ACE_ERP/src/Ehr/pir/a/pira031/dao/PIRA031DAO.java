package Ehr.pir.a.pira031.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class PIRA031DAO extends AbstractDAO {
	/**
	 * PIRA031DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA031DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 급여변경 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA031_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 급여변경 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};


		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 호봉테이블 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA031_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 호봉테이블  데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("OCC_CD"),                                     // 직종
				p_box.get("JOB_CD"),                                      // 직위
				p_box.get("HOB_CD"),                                     // 호봉
				p_box.get("APY_YMD").replaceAll("-", "")         // 호봉표일자
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 급여변경 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 급여변경 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("JOB_CD")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("STR_YMD").substring(0, 4)),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("ENO_NO")),//pk

				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns3(vo.get("BAS_AMT")),
				JSPUtil.rns3(vo.get("DUTY_AMT")),
				JSPUtil.rns3(vo.get("LAW_AMT")),
				JSPUtil.rns3(vo.get("BNS_AMT")),
				JSPUtil.rns3(vo.get("ETC_AMT")),
				JSPUtil.rns3(vo.get("ETC_AMT3")),
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(vo.get("END_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(p_box.get("vusrid"))//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 급여변경 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 급여변경 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("BAS_AMT"),                               // 기본급
				vo.get("OSE_AMT"),                               // 자기개발/직무
				vo.get("APP_CD"),                                 // 발령구분코드
				vo.get("DUT_AMT"),                               // 직책수당
				vo.get("RUN_AMT"),                               // 야근수당
				vo.get("JOB_CD"),                                  // 직위코드
				vo.get("OT_AMT"),                                  // 시간외수당
				vo.get("MH_AMT"),                                 // 전산수당
				vo.get("HOB_CD"),                                 // 호봉코드
				vo.get("WEL_AMT"),                               // 복지수당
				vo.get("LSEV_AMT"),                             // 근속수당
				vo.get("BNS_AMT"),                             // 상여수당
				p_box.get("vusrid"),            // 수정자
				vo.get("ENO_NO"),                                 // 사번
				vo.get("CHN_YMD").replaceAll("-", ""),    // 변경일자
				vo.get("SEQ_NO")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	/**
	 * 급여변경 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT_ETC(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 급여변경 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_UPT_ETC");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("ETC_AMT"),                               // 기타수당(교통비)
				vo.get("ETC_AMT3"),                               // 기타수당(식대)
				p_box.get("vusrid"),            // 수정자
				vo.get("OCC_CD"),                                 // 직종구분
				vo.get("JOB_CD"),                                 // 직위
				vo.get("HOB_CD"),                                 // 연봉코드
				vo.get("APY_YMD").replaceAll("-", "")    // 적용일자
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 급여테이블 최종일자 업데이트를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT2(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 급여변경 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_UPT2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", "")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("ENO_NO"))//pk

		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 급여테이블 최종일자 업데이트를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public int PIRA031_SHR_COUNT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 급여변경 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_SHR_COUNT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ENO_NO"))//pk

		};

		/** UPDATE메소드 호출  **/
		GauceDataSet ds = this.selectProcess(sql, bind, prop);
		return ds.getDataRowCnt();

	}


	/**
	 * 기본급, 직무수당, 시간외수당, 상여금 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT0(GauceValueObject vo, CBox p_box) throws CException {


		/** 외부 XML에서 급여변경 데이터 수정 SQL 읽음  **/
		String sql0 = XmlSqlUtils.getSQL("pir", "PIRA031_UPT0");
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind0 = new Object[] {
				JSPUtil.rns(vo.get("BAS_AMT")),//pk
				JSPUtil.rns(vo.get("DUTY_AMT")),//pk
				JSPUtil.rns(vo.get("LAW_AMT")),//pk
				JSPUtil.rns(vo.get("BNS_AMT")),//pk
				JSPUtil.rns(p_box.get("vusrid")),//입력자
				JSPUtil.rns(vo.get("ENO_NO")),//pk
				JSPUtil.rns(vo.get("STR_YMD")).replaceAll("-", "")

		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql0, bind0);

	}

	/**
	 * 국민연금, 의료보험 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_UPT3(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 급여변경 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_UPT3");
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("HINU_AMT")),//pk
				JSPUtil.rns(vo.get("OLD_AMT")),//pk
				JSPUtil.rns(vo.get("NPEN_AMT")),//pk
				JSPUtil.rns(vo.get("HINS_AMT")),//pk
				JSPUtil.rns(vo.get("ENO_NO"))//pk
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}




	/**
	 * 급여변경 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA031_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 급여변경 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA031_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("CHN_YMD").replaceAll("-", ""),    // 변경일자
				vo.get("SEQ_NO")
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
}