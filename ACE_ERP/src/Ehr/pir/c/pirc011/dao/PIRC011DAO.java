package Ehr.pir.c.pirc011.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRC011DAO extends AbstractDAO {
	/** 
	 * PIRC011DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRC011DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * 개인정보 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRC011_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 개인정보 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRC011_SHR");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO")                       // 사번
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	
	/**
	 * 개인정보 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRC011_UPT(GauceValueObject vo, CBox p_box) throws CException {
		
		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRC011_UPT");
	
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("BCT_CD"),							// 출신도코드
				vo.get("HF_NAM"),							// 호주
				vo.get("HFRE_CD"),                    	// 호주와의관계코드
				vo.get("PER_ADR"),                    	// 본적
				vo.get("ZIP_NO"),                     		// 등본상우편번호
				vo.get("ADDRESS"),                    	// 등본상주소1
				vo.get("ADR_CT"),                     	// 등본상주소2
				vo.get("RZI_NO"),                     		// 실거주지우편번호
				vo.get("RADR"),                       		// 실거주지주소1
				vo.get("RADR_CT"),                    	// 실거주지주소2
				vo.get("PHN_REG"),                    	// 지역번호
				vo.get("PHN_NO"),                     	// 전화번호
				vo.get("EM_PHN_NO"),                 // 휴대폰
				vo.get("E_MAIL"),                     		// 이메일주소
				p_box.get("vusrid"),    // 수정자
				//p_box.get("SESSION_GUBUN"),    // 회계단위
				vo.get("ENO_NO")                         // 사번
		};
		
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
		
	}
}

