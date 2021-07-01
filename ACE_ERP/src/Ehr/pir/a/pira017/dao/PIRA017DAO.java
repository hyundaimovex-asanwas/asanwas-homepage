package Ehr.pir.a.pira017.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA017DAO extends AbstractDAO {
	/** 
	 * PIRA017DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA017DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * 병무사항 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA017_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 병무사항 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA017_SHR");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 병무사항 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA017_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 병무사항 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA017_INS");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("GUB_CD"),                                 // 병무구분코드
				vo.get("MIC_CD"),                                  // 역종코드
				vo.get("LOC_CD"),                                 // 병무청코드
				vo.get("MIL_CD"),                                  // 군별코드
				vo.get("ENL_YMD").replaceAll("-", ""),    // 복무기간(FROM) 
				vo.get("MIL_YMD").replaceAll("-", ""),     // 복무기간(TO)
				vo.get("YSE_CD"),                                 // 전역사유코드
				vo.get("GRADE"),                                   // 계급코드
				vo.get("MIL_NO"),                                 // 군번
				vo.get("MBK_CD"),                                // 병과코드
				vo.get("MIL_DES"),                                // 전역구분
				vo.get("REMARK"),                                // 기타사항
				p_box.get("vusrid"),            					// 입력자
				p_box.get("vusrid")             					// 수정자
		};
		
		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
		
	}
	
	/**
	 * 병무사항 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA017_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 병무사항 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA017_UPT");
	
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("GUB_CD"),                                 // 병무구분코드
				vo.get("MIC_CD"),                                  // 역종코드
				vo.get("LOC_CD"),                                 // 병무청코드
				vo.get("MIL_CD"),                                  // 군별코드
				vo.get("ENL_YMD").replaceAll("-", ""),    // 복무기간(FROM) 
				vo.get("MIL_YMD").replaceAll("-", ""),     // 복무기간(TO)
				vo.get("YSE_CD"),                                 // 전역사유코드
				vo.get("GRADE"),                                   // 계급코드
				vo.get("MIL_NO"),                                 // 군번
				vo.get("MBK_CD"),                                // 병과코드
				vo.get("MIL_DES"),                                // 전역구분
				vo.get("REMARK"),                                // 기타사항
				p_box.get("vusrid"),            					// 수정자
				vo.get("ENO_NO")                                 // 사번
		};
		
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
		
	}
	
	/**
	 * 병무사항 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA017_DEL(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 병무사항 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA017_DEL");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO")                                 // 사번
		};
		
		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
		
	}
}
