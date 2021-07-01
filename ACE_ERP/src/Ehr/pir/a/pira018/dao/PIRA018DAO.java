package Ehr.pir.a.pira018.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA018DAO extends AbstractDAO {
	/**
	 * PIRA018DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA018DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 가족사항 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA018_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 가족사항 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA018_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REL_CD", ColumnProp.COLUMN_TYPE_STRING , 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ENO_NM", ColumnProp.COLUMN_TYPE_STRING , 12, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 가족사항 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA018_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 가족사항 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA018_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // 사번
				vo.get("REL_CD"),                                 // 가족관계코드
				vo.get("ENO_NM"),                                // 가족성명
				vo.get("BIR_YMD"),    							// 생년월일
				vo.get("EDGR_CD"),                              // 학력코드
				vo.get("OCC_NAM"),                              // 근무처
				vo.get("JOB_CD"),                                 // 직위
				vo.get("DPD_TAG"),                              // 부양여부
				vo.get("HIU_TAG"),                                // 의보여부
				p_box.get("vusrid"),            					// 입력자
				p_box.get("vusrid")             					// 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 가족사항 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA018_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 가족사항 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA018_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("BIR_YMD"),    							// 생년월일
				vo.get("EDGR_CD"),                              // 학력코드
				vo.get("OCC_NAM"),                              // 근무처
				vo.get("JOB_CD"),                                 // 직위
				vo.get("DPD_TAG"),                              // 부양여부
				vo.get("HIU_TAG"),                                // 의보여부
				p_box.get("vusrid"),            					// 수정자
				vo.get("ENO_NO"),                                // 사번
				vo.get("REL_CD"),                                 // 가족관계코드
				vo.get("ENO_NM")                                 // 가족성명
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 가족사항 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA018_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 가족사항 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA018_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // 사번
				vo.get("REL_CD"),                                 // 가족관계코드
				vo.get("ENO_NM")                                 // 가족성명
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
}
