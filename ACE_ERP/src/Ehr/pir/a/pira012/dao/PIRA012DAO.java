package Ehr.pir.a.pira012.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA012DAO extends AbstractDAO {
	/**
	 * PIRA012DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA012DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA012_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA012_SHR");

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
	public void PIRA012_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA012_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
                vo.get("HIR_CD"),                      // 채용구분
                vo.get("RHI_YMD"),                     // 재입사일
                vo.get("NAT_CD"),                      // 국적코드
                vo.get("GROUP_CD"),                    // 그룹사코드
                vo.get("OK_ENO"),                      // 추천인사번
                vo.get("OK_MAN"),                      // 추천인성명
                vo.get("EDGR_CD"),                     // 학력구분코드
                vo.get("SCH_CD"),                      // 학교코드
                vo.get("MAJ_CD"),                      // 학과코드
                vo.get("GRD_CD"),                      // 졸업구분코드
                vo.get("GUR_YMD"),                     // 졸업일
                vo.get("BCT_CD"),                      // 출신도
                vo.get("HF_NAM"),                      // 호주
                vo.get("HFRE_CD"),                     // 호주와의관계코드
                vo.get("PER_ADR"),                     // 본적
                vo.get("JAJ_YMD"),                     // 최종재직발령일
                vo.get("FINJ_CD"),                     // 재직구분코드
                vo.get("TMR_YMD"),                     // 휴직일
                vo.get("TMR_DD"),                      // 휴직일수
                vo.get("PAS_NO"),                      // 여권번호
                vo.get("PER_JOB"),                     // 담당업무
                vo.get("PISS_YMD"),                    // 발급일
                vo.get("PCHG_YMD"),                    // 갱신일
                vo.get("PDUE_YMD"),                    // 만기일
				p_box.get("vusrid"),            			// 수정자
				vo.get("ENO_NO")                       // 사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
}

