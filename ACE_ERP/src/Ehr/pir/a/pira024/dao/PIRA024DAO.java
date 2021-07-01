package Ehr.pir.a.pira024.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA024DAO extends AbstractDAO {
	/** 
	 * PIRA024DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA024DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * 입사전경력 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA024_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 입사전경력 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA024_SHR");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("REMARK", ColumnProp.COLUMN_TYPE_STRING , 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 입사전경력 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA024_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 입사전경력 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA024_INS");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("STR_YMD").replaceAll("-", ""),    // 시작일자 
				vo.get("END_YMD").replaceAll("-", ""),    // 종료일자 
				vo.get("CMP_NAM"),                              // 회사명
				vo.get("GRP_CD"),                                // 그룹사코드
				vo.get("DPT_NAM"),                              // 소속
				vo.get("JOB_CD"),                                // 직위
				vo.get("CHG_JOB"),                              // 담당업무
				vo.get("CAR_PCT"),                              // 경력인정비율
				vo.get("CAR_YY"),                                // 경력인정년수
				vo.get("CAR_MM"),                                // 경력인정개월
				vo.get("SAL_AMT"),                                // 급여 
				vo.get("REMARK"),                                // 비고
				p_box.get("vusrid"),            // 입력자
				p_box.get("vusrid")             // 수정자
		};
		
		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
		
	}
	
	/**
	 * 입사전경력 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA024_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 입사전경력 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA024_UPT");
	
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("END_YMD").replaceAll("-", ""),    // 종료일자 
				vo.get("CMP_NAM"),                              // 회사명
				vo.get("GRP_CD"),                                // 그룹사코드
				vo.get("DPT_NAM"),                              // 소속
				vo.get("JOB_CD"),                                // 직위
				vo.get("CHG_JOB"),                              // 담당업무
				vo.get("CAR_PCT"),                              // 경력인정비율
				vo.get("CAR_YY"),                                // 경력인정년수
				vo.get("CAR_MM"),                                // 경력인정개월
				vo.get("SAL_AMT"),                                // 급여 
				vo.get("REMARK"),                                // 비고
				p_box.get("vusrid"),            // 수정자
				vo.get("ENO_NO"),                                 // 사번
				vo.get("STR_YMD").replaceAll("-", "")     // 시작일자 
		};
		
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
		
	}
	
	/**
	 * 입사전경력 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA024_DEL(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 입사전경력 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA024_DEL");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("STR_YMD").replaceAll("-", "")     // 시작일자 
		};
		
		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
		
	}
}
