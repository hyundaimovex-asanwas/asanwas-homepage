package Ehr.pir.a.pira013.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA013DAO extends AbstractDAO {
	/**
	 * PIRA013DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA013DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA013_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA013_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO")                       // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 인사기록표 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA013_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA013_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("ZIP_NO").replaceAll("-", ""),      // 등본상우편번호
				vo.get("ADDRESS"),                             // 등본상주소1
				vo.get("ADR_CT"),                                // 등본상주소2
				vo.get("RZI_NO").replaceAll("-", ""),       // 실거주지우편번호
				vo.get("RADR"),                                    // 실거주지주소1
				vo.get("RADR_CT"),                              // 실거주지주소2
				vo.get("PHN_REG"),                             // 지역번호
				vo.get("PHN_NO"),                               // 전화번호
				vo.get("EM_PHN_NO"),                        // 휴대폰
				vo.get("E_MAIL"),                                 // 이메일주소
				vo.get("HOU_CD"),                               // 주거형태코드
				vo.get("ROM_CNT"),                             // 방수
				vo.get("HIU_NO"),                                // 건강보험증번호
				vo.get("LAN_SPA"),                             // 대지(평수)
				vo.get("FLR_SPA"),                              // 건물(평수)
				vo.get("ABA_CD"),                               // 급여계좌은행코드
				vo.get("MOV_AMT"),                            // 동산(만원)
				vo.get("MOVP_AMT"),                          // 부동산(만원)
				vo.get("ACC_NO"),                               // 급여계좌번호
				p_box.get("vusrid"),          					// 수정자
				vo.get("ENO_NO")                               // 사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}


	/**
	 * 로그인사원 정보에 인사마스터 내용을 반영하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA013_INS(CBox p_box) throws CException {

		/** 외부 XML에서 로그인사원 정보를 생성하거나 수정하는 SQL 읽음 **/
		String sql = "{ call ASNHR.PKG_XF_PIRA010_INS.SF_INS_T_CM_EMPLIST(?, ?, ?, ?, ?) }";

		//System.out.println("--->");
		//System.out.println(p_box.get("ENO_NO"));
		//System.out.println(p_box.get("HEAD_CD"));
		//System.out.println(p_box.get("DPT_CD"));

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {
				{"IN", "", "01", ""},                        					// 회계단위
				{"IN", "", p_box.get("ENO_NO"), ""},                     // 사번
				{"IN", "", p_box.get("HEAD_CD"), ""},                   // 본부코드
				{"IN", "", p_box.get("DPT_CD"), ""},                     // 부서코드
				{"IN", "", p_box.get("vusrid"), ""}                         // 사번
		};

		/** EXECUTEPROCEDURE 메소드 호출  **/
		this.executeProcedure(sql, bind, null);

	}
}
