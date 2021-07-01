package Ehr.edu.e.edue021.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE021DAO extends AbstractDAO {
	/**
	 * EDUE032DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE021DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * (개인) 사외강좌요청서 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE021_SHR_00(CBox p_box) throws CException {

		/** 외부 XML에서 사원이 해당 강좌를 신청한 경우 사외강좌요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_SHR_00");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("SESSION_ENONO"),
				p_box.get("ORD_NO")                         // 교육과정코드
		};

        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * (목록) 사외강좌요청서 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE021_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 해당 강좌를 신청한 사원들의 사외강좌요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_SHR_01");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO")                          // SEQ번호
		};

        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * (개인) 결재정보
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE021_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 사원이 해당 강좌를 신청한 경우 사외강좌요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_APP_TEMP_SHR");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO"),
				p_box.get("SESSION_ENONO")
		};

        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * 사외강좌요청서  INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE021_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		
        System.out.println("vo:::::::"+vo);
		
		System.out.println("p_box:::::::"+p_box);

		/** 외부 XML에서 사외강좌요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_INS");

//		ENO_NO, STR_YMD, OCC_CD, 
//		   END_YMD, EDU_CD, SEQ_NO, 
//		   EDU_GBN_CD, PLACE_CD, CPT_PNT, 
//		   EDU_NM, INT_NAM, DPT_CD, 
//		   JOB_CD, EDU_AMT
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                     // 과정코드
				vo.get("ENO_NO"),                                     // 신청자사번 
				p_box.get("DPT_CD"),                                  // 소속
				p_box.get("JOB_CD"),                                  // 직위
				p_box.get("vusrid"),                                  // 입력자
				p_box.get("vusrid")                                   // 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	/**
	 * 결재정보 저장 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUE021_APPROVAL_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE021_APP_TEMP_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(vo.get("PENO_NO")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	
	/**
	 * 사외강좌요청서 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */ 
	public void EDUE021_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 사외강좌요청서 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                     // 순번
				vo.get("ENO_NO")                    // 교육과정코드
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
}
