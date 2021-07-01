package Ehr.pir.a.pira027.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA027DAO extends AbstractDAO {
	/**
	 * PIRA027DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA027DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 어학성적 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA027_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 어학성적 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA027_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PRO_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SBJ_CD", ColumnProp.COLUMN_TYPE_STRING , 3, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 어학성적 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA027_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 어학성적 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA027_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("PRO_YMD").replaceAll("-", ""),    // 시행일자
				vo.get("OCC_CD"),                                 // 직종코드
				vo.get("INT_NAM"),                                 // 시행처
				vo.get("SBJ_CD"),                                  // 시험과목코드
				vo.get("SBJ_LSN"),                                // 청취
				vo.get("SBJ_RED"),                                // 필기
				vo.get("SBJ_SPC"),                                // 말하기
				vo.get("SBJ_VOC"),                                // 어휘
				vo.get("SBJ_IPT"),                                // 독해
				vo.get("SBJ_TOT"),                                // 종합
				vo.get("SBJ_ETC"),                                // 기타
				vo.get("TTL_AVR"),                                // 합계
				vo.get("GRADE"),                                   // 급수
				vo.get("SBJ_AMT"),                               // 시험응시료
				vo.get("REMARK"),                                // 비고
				p_box.get("vusrid"),            // 입력자
				p_box.get("vusrid")             // 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 어학성적 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA027_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 어학성적 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA027_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("INT_NAM"),                                 // 시행처
				vo.get("SBJ_CD"),                                  // 시험과목코드
				vo.get("SBJ_LSN"),                                // 청취
				vo.get("SBJ_RED"),                                // 필기
				vo.get("SBJ_SPC"),                                // 말하기
				vo.get("SBJ_VOC"),                                // 어휘
				vo.get("SBJ_IPT"),                                // 독해
				vo.get("SBJ_TOT"),                                // 종합
				vo.get("SBJ_ETC"),                                // 기타
				vo.get("TTL_AVR"),                                // 합계
				vo.get("GRADE"),                                   // 급수
				vo.get("SBJ_AMT"),                               // 시험응시료
				vo.get("REMARK"),                                // 비고
				p_box.get("vusrid"),            // 수정자
				vo.get("ENO_NO"),                                // 사번
				vo.get("PRO_YMD").replaceAll("-", ""),   // 시행일자
				vo.get("SBJ_CD")                                   // 시험과목코드
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 어학성적 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA027_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 어학성적 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA027_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // 사번
				vo.get("PRO_YMD").replaceAll("-", ""),   // 시행일자
				vo.get("SBJ_CD")                                   // 시험과목코드
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
}
