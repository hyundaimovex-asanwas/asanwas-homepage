package Ehr.pir.a.pira014.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA014DAO extends AbstractDAO {
	/**
	 * PIRA014DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA014DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA014_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA014_SHR");

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
	public void PIRA014_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA014_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("HOBBY"),                       // 취미
				vo.get("SPEC_CD"),                     // 특기
				vo.get("PART_CD"),                     // 부문
				vo.get("WED_YMD"),                     // 결혼기념일
				vo.get("REL_CD"),                      // 종교
				vo.get("COM_PHN_REG"),                 // 회사전화번호(지역)
				vo.get("COM_PHN_NO"),                  // 회사전화번호
				vo.get("COM_PHN_IN"),                  // 내선번호
				vo.get("RET_CD"),                      // 퇴직사유
				vo.get("RET_YMD"),                     // 퇴사일
				vo.get("RETP_YMD"),                    // 퇴사일
				vo.get("RETM_CD"),                     // 퇴사조치코드
				vo.get("RETM_REM"),                    // 조치자사번
				vo.get("RETM_YMD"),                    // 퇴사조치일
				vo.get("LSE_YY"),                      // 근속년수
				vo.get("LSE_MM"),                      // 근속월수
    			vo.get("HIRR_YMD"),                    // 퇴직금기준일
				vo.get("MID_YMD1"),                    // 퇴직금중도정산일1
				vo.get("MRE_AMT"),                     // 중도정산금액1
				vo.get("RAM_YMD"),                     // 기준일
				vo.get("MID_YMD2"),                    // 퇴직금중도정산일2
				vo.get("MRE_AMT2"),                    // 중도정산금액2
				vo.get("RAM_YMD2"),                    // 기준일2
				vo.get("MID_YMD3"),                    // 퇴직금중도정산일3
				vo.get("MRE_AMT3"),                    // 중도정산금액3
				vo.get("RAM_YMD3"),                    // 기준일3
				vo.get("COC_NAM"),                     // 전직처
				vo.get("REMARK"),                      // 비고
				vo.get("REG_CD"),                      // 근무지역 - 부서코드 연결 끊고  개별관리 2011.05.1
				p_box.get("vusrid"),            			// 수정자
				vo.get("ENO_NO")                       // 사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
}
