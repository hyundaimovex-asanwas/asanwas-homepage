package Ehr.common.enonm.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.enonm.dao.ENONMDAO;

public class ENONMWRK {
	/**
	 * 성명 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void ENONM_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUH051DAO 객체 생성 후 관련 메소드 호출 */
		ENONMDAO dao = new ENONMDAO("default", p_tr);

        if (p_box.get("GBN").equals("0") || p_box.get("GBN").equals("2")) {
			/** 정규직 또는 파견사원  SELECT하는 DAO 메소드 호출 */
			dao.ENONM_SHR(p_box);
		}
		else {
            /** EMPLIST(전체사원) SELECT하는 DAO 메소드 호출 */
			dao.ENONM_SHR_02(p_box);
		}

	}
	
	/**
	 * 사번 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void ENONM_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** EDUH051DAO 객체 생성 후 관련 메소드 호출 */
		ENONMDAO dao = new ENONMDAO("default", p_tr);

        if (p_box.get("GBN").equals("0") || p_box.get("GBN").equals("2")) {
			/** 정규직 또는 파견사원  SELECT하는 DAO 메소드 호출 */
			dao.ENONM_SHR_03(p_box);
		}
		else {
            /** EMPLIST(전체사원) SELECT하는 DAO 메소드 호출 */
			dao.ENONM_SHR_04(p_box);
		}

	}
}
