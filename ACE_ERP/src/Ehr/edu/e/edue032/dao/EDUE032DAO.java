package Ehr.edu.e.edue032.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE032DAO extends AbstractDAO {
	/**
	 * EDUE032DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE032DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}
	/**
	 * 등록번호의 MaxPlusOne 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public String EDUE032_SHR_MAX() throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "APPROVAL_REGNO_MAX");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

		};

		GauceDataSet ds = selectProcess(sql, bind);
		String reg_no = GauceUtils.nameValue(ds, 1, "REQ_NO");
		return reg_no;
	}
	/**
	 * 결재정보 저장 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EDUE_APPROVAL_INS(GauceValueObject vo, CBox p_box) throws CException {

		System.out.println("vo:::::::"+vo);
		
		System.out.println("p_box:::::::"+p_box);
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "APPROVAL_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(vo.get("PENO_NO")),
				//JSPUtil.rns(p_box.get("SESSION_ENONO")),
				//JSPUtil.rns(p_box.get("SESSION_ENONO")),
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO"),
				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * (개인) 사외강좌요청서 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE032_SHR_00(CBox p_box) throws CException {

		/** 외부 XML에서 사원이 해당 강좌를 신청한 경우 사외강좌요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_SHR_00");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("SESSION_ENONO"),          // 로그인사번
				p_box.get("EDU_CD")                         // 교육과정코드
		};

        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * (목록) 사외강좌요청서 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE032_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 해당 강좌를 신청한 사원들의 사외강좌요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_SHR_01");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("EDU_CD"),                          // 교육과정코드
				p_box.get("SEQ_NO")                          // SEQ번호
		};

        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * (개인) 사외강좌요청서 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE032_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 사원이 해당 강좌를 신청한 경우 사외강좌요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_SHR_02");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("EDU_CD")                         // 교육과정코드
				
		};

        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * (개인) 결재정보
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet EDUE032_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 사원이 해당 강좌를 신청한 경우 사외강좌요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_SHR_03");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				//p_box.get("SESSION_ENONO"),
				p_box.get("vusrid"),
				p_box.get("EDU_CD"),                         // 교육과정코드
				p_box.get("SEQ_NO")
		};

		
		System.out.println("ENO_NO::::"+p_box.get("ENO_NO"));
        /** FirstRow메소드 호출 **/
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * 사외강좌요청서  INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE032_INS(GauceValueObject vo, CBox p_box) throws CException {
		
		System.out.println("st2_1");

		/** 외부 XML에서 사외강좌요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_INS");
		
		System.out.println("st2_2");

//		ENO_NO, STR_YMD, OCC_CD, 
//		   END_YMD, EDU_CD, SEQ_NO, 
//		   EDU_GBN_CD, PLACE_CD, CPT_PNT, 
//		   EDU_NM, INT_NAM, DPT_CD, 
//		   JOB_CD, EDU_AMT
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                                    // 신청자사번
				vo.get("EDU_STR_YMD").replaceAll("-",""),               // 교육시작일자
				p_box.get("ENO_NO"),                                    // 사번
				
				vo.get("EDU_END_YMD").replaceAll("-",""),               // 교육종료일자
				vo.get("EDU_CD"),                                       // 과정코드
				vo.get("SEQ_NO"),                                       // 순번
				vo.get("EDU_GBN_CD"),                                   // 순번
				vo.get("PLACE_CD"),                                     // 교육구분코
				vo.get("CPT_PNT"),                                      // 교육구분코
				vo.get("EDU_NM"),                                       // 교육기관
				vo.get("INT_NAM"),                                      // 교육기관
				p_box.get("DPT_CD"),                                    // 소속
				p_box.get("JOB_CD"),                                    // 직위
				p_box.get("EDU_AMT"),                                   // 직위
				vo.get("REQ_NO"),                                       // 교육기관
				//p_box.get("SESSION_ENONO"),                             // 입력자
				//p_box.get("SESSION_ENONO")                              // 수정자
				p_box.get("ENO_NO"),                                    // 사번
				p_box.get("ENO_NO")                                     // 사번
		};
		
		
		System.out.println("st2_3");
		
		System.out.println("sql::::"+sql);
		
		System.out.println("ENO_NO::::"+p_box.get("ENO_NO"));
		System.out.println("SESSION_ENONO::::"+p_box.get("SESSION_ENONO"));

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
		
		System.out.println("st2_END");
	}
	
	/**
	 * 사외강좌요청서 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */ 
	public void EDUE032_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 사외강좌요청서 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE032_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                    // 사번
				vo.get("EDU_CD"),                    // 교육과정코드
				vo.get("SEQ_NO")                     // 순번
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
	public void EDUE032_APP(CBox p_box) throws CException {
	    String sql      = XmlSqlUtils.getSQL("edu", "EDUE032_APP");
        String ret_cd   = JSPUtil.rns(p_box.get("RET_CD"));
        String gun_cd   = JSPUtil.rns(p_box.get("GBN_CD"));
        String str_ymd  = JSPUtil.rns(p_box.get("STR_YMD"));
        String end_ymd  = JSPUtil.rns(p_box.get("END_YMD"));
        String dpt_cd   = JSPUtil.rns(p_box.get("DPT_CD"));

		StringBuffer sb = new StringBuffer();

        sb.append("AND TO_CHAR(HIR_YMD, 'YYYYMMDD') <= '"+end_ymd+"'");
        //재직자만
        if(ret_cd.equals("1")) {
            sb.append("AND (RET_YMD IS NULL");
            sb.append(" OR  TO_CHAR(RET_YMD, 'YYYYMMDD') >= '"+str_ymd+"')\n");
        }
        //퇴직자만
        else if(ret_cd.equals("2")) {
            sb.append("AND RET_YMD IS NOT NULL");
            sb.append("AND TO_CHAR(RET_YMD, 'YYYYMMDD') BETWEEN '"+str_ymd+"' AND '"+end_ymd+"'\n");
        }
        //입사자만
        else if(ret_cd.equals("3")) {
            sb.append("AND TO_CHAR(HIRD_YMD, 'YYYYMMDD') BETWEEN '"+str_ymd+"' AND '"+end_ymd+"'\n");
        }


		Object[] sqlParam = new Object[] {
				sb.toString(),
				sb.toString(),
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);
		Object[] bind = new Object[] {
				dpt_cd,
				dpt_cd,
				dpt_cd,
				dpt_cd
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}
}
