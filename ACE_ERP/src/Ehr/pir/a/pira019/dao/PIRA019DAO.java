package Ehr.pir.a.pira019.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA019DAO extends AbstractDAO {
	/** 
	 * PIRA019DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA019DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * 건강검진 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA019_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 건강검진 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA019_SHR");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PRO_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("EYE_LEF", ColumnProp.COLUMN_TYPE_DECIMAL , 2.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("EYE_RHT", ColumnProp.COLUMN_TYPE_DECIMAL , 2.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HEIGHT", ColumnProp.COLUMN_TYPE_DECIMAL , 4.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("WEIGHT", ColumnProp.COLUMN_TYPE_DECIMAL , 4.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("AB_HGT", ColumnProp.COLUMN_TYPE_DECIMAL , 4.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 건강검진 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA019_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 건강검진 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA019_INS");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("PRO_YMD").replaceAll("-", ""),   // 실시일자 
				vo.get("OCC_CD"),                                // 직종코드
				vo.get("EYE_LEF"),                                // 좌시력 
				vo.get("EYE_RHT"),                               // 우시력
				vo.get("HEIGHT"),                                  // 신장
				vo.get("WEIGHT"),                                 // 체중
				vo.get("AB_HGT"),                                 // 흉위
				vo.get("CBLD_CD"),                               // 색맹코드
				vo.get("BLD_TYP"),                               // 혈액형
				vo.get("XRY_RMK"),                               // X선소견
				vo.get("BLD_PRE"),                               // 혈압
				vo.get("BLD_DAN"),                               // 혈당 
				vo.get("PH"),                                         // pH
				vo.get("EXM_HSP"),                               // 검사병원
				vo.get("DECISION"),                               // 판정
				vo.get("SPEC"),                                     // 비고
				vo.get("CHIT_AMT"),                               // 비용
				p_box.get("vusrid"),            						// 입력자
				p_box.get("vusrid")             						// 수정자
		};
		
		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
		
	}
	
	/**
	 * 건강검진 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA019_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 건강검진 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA019_UPT");
	
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("EYE_LEF"),                                // 좌시력 
				vo.get("EYE_RHT"),                               // 우시력
				vo.get("HEIGHT"),                                  // 신장
				vo.get("WEIGHT"),                                 // 체중
				vo.get("AB_HGT"),                                 // 흉위
				vo.get("CBLD_CD"),                               // 색맹코드
				vo.get("BLD_TYP"),                               // 혈액형
				vo.get("XRY_RMK"),                               // X선소견
				vo.get("BLD_PRE"),                               // 혈압
				vo.get("BLD_DAN"),                               // 혈당 
				vo.get("PH"),                                         // pH
				vo.get("EXM_HSP"),                               // 검사병원
				vo.get("DECISION"),                               // 판정
				vo.get("SPEC"),                                     // 비고
				vo.get("CHIT_AMT"),                               // 비용
				p_box.get("vusrid"),            						// 수정자
				vo.get("ENO_NO"),                                 // 사번
				vo.get("PRO_YMD").replaceAll("-", "")    		// 실시일자 
		};
		
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
		
	}
	
	/**
	 * 건강검진 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA019_DEL(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 건강검진 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA019_DEL");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("PRO_YMD").replaceAll("-", "")    // 실시일자 
		};
		
		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
		
	}
}
