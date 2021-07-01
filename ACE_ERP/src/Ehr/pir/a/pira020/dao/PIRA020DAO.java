package Ehr.pir.a.pira020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA020DAO extends AbstractDAO {
	/** 
	 * PIRA020DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA020DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * 자격면허 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA020_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 자격면허 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA020_SHR");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("QUA_CD", ColumnProp.COLUMN_TYPE_STRING , 3, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("GAN_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 자격면허 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA020_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 자격면허 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA020_INS");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("QUA_CD"),                                 // 자격면허코드
				vo.get("GAN_YMD").replaceAll("-", ""),    		// 취득일자 
				vo.get("QUA_NO"),                                // 증서번호
				vo.get("APP_ADM"),                              	// 발행처
				vo.get("ETG_YN"),                                 	// 수당지급여부
				p_box.get("vusrid"),            						// 입력자
				p_box.get("vusrid"),             					// 수정자
				vo.get("QUA_AMT"),                                // 수당금액			
		};
		
		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
		
	}
	
	/**
	 * 자격면허 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA020_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 자격면허 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA020_UPT");
	
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {

				vo.get("QUA_NO"),                                // 증서번호
				vo.get("APP_ADM"),                               // 발행처
				vo.get("ETG_YN"),                                 // 수당지급여부
				vo.get("QUA_AMT"),                              // 수당금액				
				p_box.get("vusrid"),            					   // 수정자
				vo.get("ENO_NO"),                                 // 사번
				vo.get("QUA_CD"),                                 // 자격면허코드
				vo.get("GAN_YMD").replaceAll("-", "")          // 취득일자 
		};
		
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
		
	}
	
	/**
	 * 자격면허 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA020_DEL(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 자격면허 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA020_DEL");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("QUA_CD"),                                 // 자격면허코드
				vo.get("GAN_YMD").replaceAll("-", "")     // 취득일자 
		};
		
		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
		
	}
}
