package Ehr.pir.a.pira026.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA026DAO extends AbstractDAO {
	/**
	 * PIRA026DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA026DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 상벌사항 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA026_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 상벌사항 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA026_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REPU_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REPU_CD", ColumnProp.COLUMN_TYPE_STRING , 1, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REPU_TAG", ColumnProp.COLUMN_TYPE_STRING , 3, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 상벌사항 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA026_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 상벌사항 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA026_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("REPU_YMD").replaceAll("-", ""),  // 상벌일자
				vo.get("OCC_CD"),                                 // 직종코드
				vo.get("END_YMD").replaceAll("-", ""),    // 종료일자
				vo.get("REPU_CD"),                               // 상벌구분코드
				vo.get("REPU_TAG"),                             // 상벌종류코드
				vo.get("SYC_NAM"),                               // 수여처
				vo.get("REPU_RMK"),                             // 상벌내역
				vo.get("REMARK1"),                                // 대물
				vo.get("REMARK2"),                                // 대인
				vo.get("REMARK3"),                                // 비고
				p_box.get("vusrid"),             // 입력자
				p_box.get("vusrid")              // 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 상벌사항 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA026_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 상벌사항 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA026_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("END_YMD").replaceAll("-", ""),    // 종료일자
				vo.get("REPU_CD"),                               // 상벌구분코드
				vo.get("SYC_NAM"),                               // 수여처
				vo.get("REPU_RMK"),                             // 상벌내역
				vo.get("REMARK1"),                                // 대물
				vo.get("REMARK2"),                                // 대인
				vo.get("REMARK3"),                                // 비고
				p_box.get("vusrid"),            // 수정자
				vo.get("ENO_NO"),                                 // 사번
				vo.get("REPU_YMD").replaceAll("-", ""),  // 상벌일자
				vo.get("REPU_CD"),                               // 상벌구분코드
				vo.get("REPU_TAG")                              // 상벌종류코드
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 상벌사항 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA026_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 상벌사항 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA026_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("REPU_YMD").replaceAll("-", ""),  // 상벌일자
				vo.get("REPU_CD"),                               // 상벌구분코드
				vo.get("REPU_TAG")                              // 상벌종류코드
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
}
