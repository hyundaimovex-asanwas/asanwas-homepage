package Ehr.pir.a.pira034.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA034DAO extends AbstractDAO {
	/**
	 * PIRA034DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA034DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 행사참여 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA034_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 행사참여 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA034_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("ATT_NM", ColumnProp.COLUMN_TYPE_STRING , 30, ColumnProp.CONSTRAINT_TB_KEY);


		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 행사참여 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA034_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 행사참여 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA034_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("STR_YMD").replaceAll("-", ""),    // 행사일자
				vo.get("ATT_OFFICE"),
				vo.get("ATT_SBJ"),
				vo.get("ATT_HOUR"),
				p_box.get("vusrid"),            // 입력자
				p_box.get("vusrid")             // 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 행사참여 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA034_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 행사참여 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA034_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("ATT_OFFICE"),
				vo.get("ATT_SBJ"),
				vo.get("ATT_HOUR"),
				p_box.get("vusrid"),            // 수정자
				p_box.get("vusrid"),            // 수정자
				vo.get("ENO_NO"),
				vo.get("STR_YMD").replaceAll("-", ""),
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 행사참여 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA034_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 행사참여 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA034_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                        // 사번
				vo.get("STR_YMD").replaceAll("-", "") ,  // 행사일자
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
}
