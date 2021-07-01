package Ehr.edu.g.edug010.dao;

import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUG010DAO extends AbstractDAO {
	/**
	 * EDUG010DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUG010DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG010_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                         // 로그인사번
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}



	/**
	 * INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 데이터 생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                            // 사번
				vo.get("EFFECT_TAG"),                        // 효과
				vo.get("CPT_TAG")                            // 수료기준
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}


	/**
	 * UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  수정하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상) **/
		Object[] bind = new Object[] {
				vo.get("EDU_TXT"),                                       // 교육과정명
				vo.get("CHASU_TXT"),                                  // 차수명
				vo.get("EDU_GBN_CD"),                                // 교육구분코드
				vo.get("EDU_STR_YMD").replaceAll("-",""),    // 교육시작일자
				vo.get("EDU_END_YMD").replaceAll("-",""),    // 교육종료일자
				vo.get("GOAL_TXT"),                                     // 교육목적
				vo.get("EDU_GBN_TXT"),                              // 교육기관
				vo.get("PLACE_TXT"),                                   // 교육장소
				vo.get("CONTENT_TXT"),                              // 교육내용
				vo.get("COST_AMT"),                                    // 교육비용
				vo.get("FIX_NO"),                                          // 교육인원
				vo.get("INS_YN"),                                         // 환급여부
				vo.get("RTN_AMT"),                                     // 환급예상액
				p_box.get("vusrid"),                         // 수정자
				vo.get("OBJ_TAG"),                           // 대상
				vo.get("SITE_TAG"),                          // 참고사이트
				vo.get("EFFECT_TAG"),                        // 효과
				vo.get("CPT_TAG"),                            // 수료기준
				vo.get("ORD_NO"),                              // 일련번호
				vo.get("ENO_NO")                              // 사번

		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);
	}
	
	

	/**
	 * DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG010_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG010_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                       // 일련번호
				vo.get("ENO_NO")                                        // 사번
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}

}
