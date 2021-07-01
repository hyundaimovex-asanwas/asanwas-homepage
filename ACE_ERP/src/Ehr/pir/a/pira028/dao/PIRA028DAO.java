package Ehr.pir.a.pira028.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA028DAO extends AbstractDAO {
	/**
	 * PIRA028DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA028DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 교육사항 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA028_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 교육사항 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA028_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("EDU_CD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SEQ_NO", ColumnProp.COLUMN_TYPE_STRING , 7, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PLACE_NM", ColumnProp.COLUMN_TYPE_STRING , 20, ColumnProp.CONSTRAINT_TB_NORMAL);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 교육사항 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA028_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 교육사항 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA028_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                         // 사번
				vo.get("STR_YMD").replaceAll("-", ""),    // 시작일자
				vo.get("OCC_CD"),                         // 직종코드
				vo.get("END_YMD").replaceAll("-", ""),    // 종료일자
				vo.get("EDU_CD"),                         // 과정코드
				vo.get("SEQ_NO"),                         // 차수
				vo.get("EDU_GBN_CD"),                     // 시행처
				vo.get("PLACE_CD"),                       // 교육장소코드
				vo.get("CPT_PNT"),
				vo.get("EDU_NM"),
				vo.get("INT_NAM"),
				vo.get("EDU_TAG"),
				vo.get("DECISION_CD"),                    // 시행처
				p_box.get("vusrid"),               // 입력자
				p_box.get("vusrid")                // 수정자

		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 교육사항 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA028_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 교육사항 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA028_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("PLACE_CD"),                       // 교육장소코드
				vo.get("STR_YMD").replaceAll("-", ""),    // 시작일자
				vo.get("END_YMD").replaceAll("-", ""),    // 종료일자
				vo.get("EDU_GBN_CD"),                     // 필수여부
				vo.get("EDU_TAG"),                        // 수료여부
				vo.get("EDU_NM"),                         // 교육명
				vo.get("INT_NAM"),                        // 시행처
				vo.get("REMARK"),                         // 비고
				p_box.get("vusrid"),               // 수정자
				vo.get("ENO_NO"),                         // 사번
				vo.get("EDU_CD"),                         // 과정코드
				vo.get("SEQ_NO")                          // 차수
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 교육사항 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA028_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 교육사항 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA028_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("EDU_CD"),                                 // 과정코드
				vo.get("SEQ_NO")                                  // 차수
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
}
