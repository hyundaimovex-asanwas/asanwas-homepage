package Ehr.edu.e.edue033.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE033DAO extends AbstractDAO {
	/**
	 * EDUE032DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE033DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
     * 교육차수관리 SELECT를 수행하는 DAO 메소드
     * @param p_box
     * @throws CException
     */
    public void EDUE033_SHR(CBox p_box) throws CException {
        String sql      = XmlSqlUtils.getSQL("edu", "EDUE033_SHR");

        Object[] bind = new Object[] {
                p_box.get("EDU_CD")                                        // 과정코드
        };

        this.selectProcessFirstRow(sql, bind, prop);
    }

    /**
     * 마스터 정보를 가지고 온다.
     * @param p_box
     * @throws CException
     */

    public void EDUE033_SHR_NEW(CBox p_box) throws CException {
    	String sql     = XmlSqlUtils.getSQL("edu", "EDUE033_SHR_NEW");

    	Object[] bind = new Object[] {
    			p_box.get("EDU_CD")

        };

    	this.selectProcessFirstRow(sql, bind, prop);
    }

	/**
	 * 교육차수관리 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE033_INS(GauceValueObject vo, CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUE033_INS");


        Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("EDU_CD")),                                  // 과정코드
                JSPUtil.rns(vo.get("EDU_CD")),                                  // 차수(자동계산)
                JSPUtil.rns(vo.get("EDU_NM")),                                 // 과정명
                JSPUtil.rns(vo.get("CET_NO")),                                  // 강사주민번호
                JSPUtil.rns(vo.get("INS_YN")),                                  // 고용보험
                JSPUtil.rns(vo.get("PLACE_TAG")),                               // 교육장소
                JSPUtil.rns(vo.get("ENT_STR_YMD")).replaceAll("-", ""),         // 신청시작일자
                JSPUtil.rns(vo.get("ENT_END_YMD")).replaceAll("-", ""),         // 신청종료일자
                JSPUtil.rns(vo.get("EDU_STR_YMD")).replaceAll("-", ""),         // 학습시작일자
                JSPUtil.rns(vo.get("EDU_END_YMD")).replaceAll("-", ""),         // 학습종료일자

                JSPUtil.rns(vo.get("EDU_GBN_CD")),                              // 교육구분
                JSPUtil.rns(vo.get("MNGER_CD")),                                // 교육주관
                JSPUtil.rns(vo.get("FIELD_CD")),                                // 교육분야
                JSPUtil.rns(vo.get("SHAPE_CD")),                                // 교육형태
                JSPUtil.rns(vo.get("GOAL_TAG")),                                // 교육목표

                JSPUtil.rns(vo.get("CONTENT_TXT")),                             // 교육내용
                JSPUtil.rns(vo.get("EFFECT_TAG")),                              // 기대효과
                JSPUtil.rns(vo.get("OBJ_TAG")),                                 // 교육대상
                JSPUtil.rns(vo.get("CPT_TAG")),                                 // 수료기준

                JSPUtil.rns(vo.get("INT_NAM")),                                 // 교육기관
                JSPUtil.rns(vo.get("FIX_NO")),                                  // 교육정원
                JSPUtil.rns(vo.get("DAY_NO")),                                  // 교육일수
                JSPUtil.rns(vo.get("TIME_NO")),                                 // 교육시간
                JSPUtil.rns(vo.get("COST_AMT")),                                // 교육비용
                JSPUtil.rns(vo.get("COST_CD")),                                 // 비용부담
                JSPUtil.rns(vo.get("RTN_AMT")),                                 // 환급금액
                JSPUtil.rns(vo.get("PLACE_CD")),                                // 교육장소
                JSPUtil.rns(vo.get("CPT_PNT")),                                 // 이수점수
                JSPUtil.rns(vo.get("SITE_TAG")),                                // 참고사이트

                //p_box.get("SESSION_ENONO"),                                     // 입력자
                //p_box.get("SESSION_ENONO"),                                     // 수정자
                p_box.get("vusrid"), //입력자
                p_box.get("vusrid")  //수정자
		};

        insertProcess(sql, bind);
	}

	/**
	 * 교육차수관리 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void EDUE033_UPT(GauceValueObject vo, CBox p_box) throws CException {
		String sql = XmlSqlUtils.getSQL("edu", "EDUH032_UPT");

		Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("EDU_NM")),                                 // 과정명
                JSPUtil.rns(vo.get("CET_NO")),                                  // 강사주민번호
                JSPUtil.rns(vo.get("INS_YN")),                                  // 고용보험
                JSPUtil.rns(vo.get("PLACE_TAG")),                               // 교육장소
                JSPUtil.rns(vo.get("ENT_STR_YMD")).replaceAll("-", ""),         // 신청시작일자
                JSPUtil.rns(vo.get("ENT_END_YMD")).replaceAll("-", ""),         // 신청종료일자
                JSPUtil.rns(vo.get("EDU_STR_YMD")).replaceAll("-", ""),         // 학습시작일자
                JSPUtil.rns(vo.get("EDU_END_YMD")).replaceAll("-", ""),         // 학습종료일자

                JSPUtil.rns(vo.get("EDU_GBN_CD")),                              // 교육구분
                JSPUtil.rns(vo.get("MNGER_CD")),                                // 교육주관
                JSPUtil.rns(vo.get("FIELD_CD")),                                // 교육분야
                JSPUtil.rns(vo.get("SHAPE_CD")),                                // 교육형태
                JSPUtil.rns(vo.get("GOAL_TAG")),                                // 교육목표

                JSPUtil.rns(vo.get("CONTENT_TXT")),                             // 교육내용
                JSPUtil.rns(vo.get("EFFECT_TAG")),                              // 기대효과
                JSPUtil.rns(vo.get("OBJ_TAG")),                                 // 교육대상
                JSPUtil.rns(vo.get("CPT_TAG")),                                 // 수료기준

                JSPUtil.rns(vo.get("INT_NAM")),                                 // 교육기관
                JSPUtil.rns(vo.get("FIX_NO")),                                  // 교육정원
                JSPUtil.rns(vo.get("DAY_NO")),                                  // 교육일수
                JSPUtil.rns(vo.get("TIME_NO")),                                 // 교육시간
                JSPUtil.rns(vo.get("COST_AMT")),                                // 교육비용
                JSPUtil.rns(vo.get("COST_CD")),                                 // 비용부담
                JSPUtil.rns(vo.get("RTN_AMT")),                                 // 환급금액
                JSPUtil.rns(vo.get("PLACE_CD")),                                // 교육장소
                JSPUtil.rns(vo.get("CPT_PNT")),                                 // 이수점수
                JSPUtil.rns(vo.get("SITE_TAG")),                                // 참고사이트

				p_box.get("SESSION_ENONO"),                                     // 수정자
                JSPUtil.rns(vo.get("EDU_CD")),                                  // 과정코드
                JSPUtil.rns(vo.get("SEQ_NO")),                                  // 과정 SEQ
              //  vo.get("COMM_NO")                                               // 구분번호
		};

		updateProcess(sql, bind);
	}
}
