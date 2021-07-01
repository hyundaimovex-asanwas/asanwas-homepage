package Ehr.pir.a.pira015.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA015DAO extends AbstractDAO {
	/**
	 * PIRA015DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA015DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA015_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA015_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                       // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 인사기록표 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA015_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA015_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("GET_RSN"),                       // 취득사유
				vo.get("HIR_PATH"),                       // 채용경로
				vo.get("SAN_YMD"),                       // 산재일자
				vo.get("SAN_NAM"),                       // 상병명
				vo.get("HDC_CD"),                         // 장애유형
				vo.get("HDC_GRA"),                       // 장애등급
				vo.get("SAN_HIS"),                         // 과거병력
				vo.get("SAN_REM"),                       // 발생사유
				vo.get("JAN_YMD"),                        // 장애인정일
				vo.get("TRG_CD"),                         // 장애인정구분
				vo.get("JHDC_CD"),                       // 장애유형
				vo.get("JHDC_GRA"),                     // 장애등급
				vo.get("SER_STS"),                       // 중증여부
				vo.get("JOB_OCC"),                      // 근무직종
				vo.get("MPVA_CD"),                      // 보훈대상
				p_box.get("vusrid"),     					// 수정자
				vo.get("ENO_NO")                          // 사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
}
