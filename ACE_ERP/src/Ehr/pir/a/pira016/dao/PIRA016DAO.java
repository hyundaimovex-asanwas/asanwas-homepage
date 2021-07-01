package Ehr.pir.a.pira016.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA016DAO extends AbstractDAO {
	/**
	 * PIRA016DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA016DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 학력사항 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA016_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 학력사항 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("EDGR_CD", ColumnProp.COLUMN_TYPE_STRING , 1, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("GRD_CD", ColumnProp.COLUMN_TYPE_STRING , 2, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("GURE_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 학력사항 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA016_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 학력사항 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("EDGR_CD"),                               // 학력구분코드
				vo.get("GURS_YMD").replaceAll("-", ""),  // 입학일자
				vo.get("GURE_YMD").replaceAll("-", ""),  // 졸업일자
				vo.get("SCH_CD"),                                // 학교코드
				vo.get("SCH_NAM"),                              // 학교
				vo.get("MAJ_CD"),                                 // 전공코드
				vo.get("MAJ_CD2"),                                 // 복수전공코드
				vo.get("GRD_CD"),                                // 졸업코드
				p_box.get("vusrid"),            					// 입력자
				p_box.get("vusrid")             					// 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 학력사항 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA016_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 학력사항 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("GURS_YMD").replaceAll("-", ""),   // 입학일자
				vo.get("GURE_YMD").replaceAll("-", ""),   // 졸업일자
				vo.get("SCH_CD"),                                // 학교코드
				vo.get("SCH_NAM"),                              // 학교
				vo.get("MAJ_CD"),                                 // 전공코드
				vo.get("MAJ_CD2"),                                 // 복수전공코드
				vo.get("GRD_CD"),                                // 졸업코드
				p_box.get("vusrid"),            					// 수정자
				vo.get("ENO_NO"),                                // 사번
				vo.get("EDGR_CD"),                              // 학력구분코드
				vo.get("GURE_YMD").replaceAll("-", ""),   // 졸업일자
				vo.get("GRD_CD")                                 // 졸업코드
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 인사마스터에 최종학력사항 반영하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA016_UPT_02(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사마스터에 최종학력사항 반영 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_UPT_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // 사번
				p_box.get("vusrid"),            					// 수정자
				vo.get("ENO_NO"),                                // 사번
				p_box.get("vusrid"),            					// 수정자
				vo.get("ENO_NO")                                 // 사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 학력사항 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA016_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 학력사항 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA016_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                // 사번
				vo.get("EDGR_CD"),                              // 학력구분코드
				vo.get("GURE_YMD").replaceAll("-", ""),   // 졸업일자
				vo.get("GRD_CD")                                 // 졸업코드
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
}
