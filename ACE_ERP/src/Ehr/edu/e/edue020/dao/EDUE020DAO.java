package Ehr.edu.e.edue020.dao;

import oracle.jdbc.OracleTypes;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE020DAO extends AbstractDAO {
	/**
	 * EDUE020DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE020DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 과정개설요청서 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUE020_SHR_00(CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_SHR_00");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                         // 로그인사번
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 과정개설요청서 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void EDUE020_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_SHR_01");

		/** 조회 조건에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

		/** 교육구분이 '사내/사외/인터넷'인 경우
		if (p_box.get("CHK1").equals("1") && p_box.get("CHK2").equals("1") && p_box.get("CHK3").equals("1")) {
			sb.append("AND 1 = 1");
		}
		/** 교육구분이 '사내/사외'인 경우
		else if (p_box.get("CHK1").equals("1") && p_box.get("CHK2").equals("1") && p_box.get("CHK3").equals("0")) {
			sb.append("AND(EDU_GBN_CD = '1'");
			sb.append("OR  EDU_GBN_CD = '2')");
		}
		/** 교육구분이 '사내/인터넷'인 경우
		else if (p_box.get("CHK1").equals("1") && p_box.get("CHK2").equals("0") && p_box.get("CHK3").equals("1")) {
			sb.append("AND(EDU_GBN_CD = '1'");
			sb.append("OR  EDU_GBN_CD = '3')");
		}
		/** 교육구분이 '사내'인 경우
		else if (p_box.get("CHK1").equals("1") && p_box.get("CHK2").equals("0") && p_box.get("CHK3").equals("0")) {
			sb.append("AND(EDU_GBN_CD = '1')");
		}
		/** 교육구분이 '사외/인터넷'인 경우
		else if (p_box.get("CHK1").equals("0") && p_box.get("CHK2").equals("1") && p_box.get("CHK3").equals("1")) {
			sb.append("AND(EDU_GBN_CD = '2'");
			sb.append("OR  EDU_GBN_CD = '3')");
		}
		/** 교육구분이 '사외'인 경우
		else if (p_box.get("CHK1").equals("0") && p_box.get("CHK2").equals("1") && p_box.get("CHK3").equals("0")) {
			sb.append("AND(EDU_GBN_CD = '2')");
		}
		/** 교육구분이 '인터넷'인 경우
		else if (p_box.get("CHK1").equals("0") && p_box.get("CHK2").equals("0") && p_box.get("CHK3").equals("1")) {
			sb.append("AND(EDU_GBN_CD = '3')");
		} */


        if(!JSPUtil.rns(p_box.get("STR_YMD")).equals("")) {
            sb.append("AND A.EDU_STR_YMD >= '"+JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", "")+"'");
        }
        if(!JSPUtil.rns(p_box.get("END_YMD")).equals("")) {
            sb.append("AND A.EDU_STR_YMD <= '"+JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "")+"'");
        }


		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
            //    p_box.get("ENO_NO"),
            //    p_box.get("DPT_CD")
		};

        prop.add("SUM_AMT", ColumnProp.COLUMN_TYPE_DECIMAL , 1000, ColumnProp.CONSTRAINT_TB_NOTNULL);

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 과정개설요청서  INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE020_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                            // 사번
				vo.get("EDU_TXT"),                           // 교육과정명
				vo.get("EDU_GBN_CD"),                        // 교육구분코드
				vo.get("EDU_STR_YMD").replaceAll("-",""),    // 교육시작일자
				vo.get("EDU_END_YMD").replaceAll("-",""),    // 교육종료일자
				vo.get("GOAL_TXT"),                          // 교육목적
				vo.get("EDU_GBN_TXT"),                       // 교육기관
				vo.get("PLACE_TXT"),                         // 교육장소
				vo.get("CONTENT_TXT"),                       // 교육내용
				vo.get("COST_AMT"),                          // 교육비용
				vo.get("FIX_NO"),                            // 교육인원
				vo.get("INS_YN"),                            // 환급여부
				vo.get("RTN_AMT"),                           // 환급예상액
				vo.get("STS_GBN"),                           // 처리상황
				p_box.get("vusrid"),                         // 입력자
				p_box.get("vusrid"),                         // 수정자,		SITE_TAG,	 EFFECT_TAG,  CPT_TAG
				vo.get("OBJ_TAG"),                           // 대상
				vo.get("SITE_TAG").replaceAll("http://",""),                       // 참고사이트
				vo.get("EFFECT_TAG"),                        // 효과
				vo.get("CPT_TAG")                            // 수료기준
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	public void EDUE020_INS_OBJT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_INS_OBJT");

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
	 * 과정개설요청서  UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE020_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  수정하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상) **/
		Object[] bind = new Object[] {
				vo.get("EDU_TXT"),                                       // 교육과정명
				vo.get("CHASU_TXT"),                                  // 차수명
				vo.get("EDU_GBN_CD"),                                // 교육구분코드
				vo.get("EDU_STR_YMD").replaceAll("-",""),    // 교육시작일자
				vo.get("EDU_END_YMD").replaceAll("-",""),    // 교육종료일자
				vo.get("GOAL_TXT"),                                     // 교육목적
				vo.get("EDU_GBN_TXT"),                              // 교육기관
				vo.get("PLACE_TXT"),                                   // 교육장소
				vo.get("CONTENT_TXT"),                              // 교육내용
				vo.get("COST_AMT"),                                    // 교육비용
				vo.get("FIX_NO"),                                          // 교육인원
				vo.get("INS_YN"),                                         // 환급여부
				vo.get("RTN_AMT"),                                     // 환급예상액
				p_box.get("vusrid"),                         // 수정자
				vo.get("OBJ_TAG"),                           // 대상
				vo.get("SITE_TAG"),                          // 참고사이트
				vo.get("EFFECT_TAG"),                        // 효과
				vo.get("CPT_TAG"),                            // 수료기준
				vo.get("ORD_NO"),                              // 일련번호
				vo.get("ENO_NO")                              // 사번

		};

		/** UPDATE 메소드 호출  **/
		updateProcess(sql, bind);
	}
	/**
	 * 과정개설요청서 신청 상태변경.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE020_UPT_00(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 데이터  수정하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_UPT_00");

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
	 * 과정개설요청서 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE020_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 과정개설요청서 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE020_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),                                       // 일련번호
				vo.get("ENO_NO")                                        // 사번
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}
	/**
     * 과정/차수 생성, 수강신청등록
     * @param p_box
     * @throws CException
     */
    public CBox EDUE020_PROC(CBox p_box) throws CException {

        /** 급여 작업로그 실행  **/
        String sql = "{ call PKG_XF_EDUE020.SF_CREATE_EDU_COURSE(?, ?, ?, ?) }";

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {
                {"IN",      "",             JSPUtil.rns(p_box.get("ORD_NO")),           ""                                  },
                {"IN",      "",             JSPUtil.rns(p_box.get("vusrid")),    ""                                  },

                {"IN/OUT",  "TEMP_S1",      "",                                         String.valueOf(OracleTypes.VARCHAR) },
                {"IN/OUT",  "TEMP_S2",      "",                                         String.valueOf(OracleTypes.VARCHAR) }
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        CBox result = (CBox)this.executeProcedure(sql, bind, null);
        Log.debug.println(result);
        return result;
    }
}
