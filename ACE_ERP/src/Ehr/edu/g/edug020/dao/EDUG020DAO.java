package Ehr.edu.g.edug020.dao;

import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUG020DAO extends AbstractDAO {
	/**
	 * EDUG020DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUG020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG020_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				//p_box.get("ENO_NO")                         // 로그인사번
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG020_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         // 피후견인
				p_box.get("TRA_WEEK")                        // SEQ번호
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUG020_SHR_21(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_SHR_21");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         //

		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUG020_SHR_22(CBox p_box) throws CException {

		/** 외부 XML에서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_SHR_22");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                         //

		};

		prop.add("PLAN_TXT", ColumnProp.COLUMN_TYPE_STRING , 4000, ColumnProp.CONSTRAINT_TB_NOTNULL);
		
        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}	
	
	/**
	 *  INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG020_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                            // 사번
				vo.get("CPT_TAG")                            // 수료기준
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	public void EDUG020_INS_OBJT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_INS_OBJT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                        // 과정코드
				vo.get("ENO_NO"),                                        // 순번
				p_box.get("DPT_CD"),                                  // 소속
				p_box.get("JOB_CD"),                                  // 직위
				p_box.get("vusrid"),                                 // 입력자
				p_box.get("vusrid")                                  // 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 *  UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG020_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 데이터  수정하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상) **/
		Object[] bind = new Object[] {
				vo.get("EDU_TXT"),                                       // 교육과정명
				vo.get("ENO_NO")                              // 사번

		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);
	}
	/**
	 * 신청 상태변경.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUG020_UPT_00(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 데이터  수정하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_UPT_00");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상) **/
		Object[] bind = new Object[] {
				vo.get("STS_GBN"),                                         // 환급여부
				p_box.get("vusrid"),                                    // 수정자
				vo.get("ORD_NO")                                       // 일련번호
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
	public void EDUG020_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUG020_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                       // 일련번호
				vo.get("ENO_NO")                                        // 사번
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}

}
