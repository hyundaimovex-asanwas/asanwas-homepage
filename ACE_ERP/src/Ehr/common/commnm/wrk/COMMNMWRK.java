package Ehr.common.commnm.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.commnm.dao.COMMNMDAO;

public class COMMNMWRK {
	/**
	 * 공통코드명 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void COMMNM_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUH051DAO 객체 생성 후 관련 메소드 호출 */
		COMMNMDAO dao = new COMMNMDAO("default", p_tr);

		if (p_box.get("CD_GBN").equals("A4") || p_box.get("CD_GBN").equals("A6") || p_box.get("CD_GBN").equals("B2")) {
			/** 부서/팀/본부명 SELECT하는 DAO 메소드 호출 */
			dao.COMMNM_SHR_02(p_box);
		}
		else if (p_box.get("CD_GBN").equals("DUTY")) {
        	/** 직무코드 SELECT DAO 메소드 호출 */
        	dao.COMMNM_SHR_03(p_box);
        }
        else if (p_box.get("CD_GBN").equals("DUTY2")) {
        	/** 직무코드 SELECT DAO 메소드 호출 */
        	dao.COMMNM_SHR_04(p_box);
        }
		else {
            /** 공통코드명 SELECT하는 DAO 메소드 호출 */
			dao.COMMNM_SHR(p_box);
		}

	}

	//콤보박스 코드 변경(인사평가)
	public void COMMNM_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		COMMNMDAO dao = new COMMNMDAO("default", p_tr);

		//p_box.get("CD_GBN") == B2
		dao.COMMNM_SHR_06(p_box);
	}

	//해당 소속의 부문을 가져온다
	public void COMMNM_SHR_07(CBox p_box, TrBox p_tr) throws CException {

		COMMNMDAO dao = new COMMNMDAO("default", p_tr);

		//p_box.get("CD_GBN") == A4
		dao.COMMNM_SHR_07(p_box);
	}

	/**
     * 공통코드를 가지고 온다.
     * @param p_box
     * @param p_tr
     * @throws CException
	 */
	public void COMMNM_SHR_00(CBox p_box, TrBox p_tr) throws CException {

	    COMMNMDAO dao = new COMMNMDAO("default", p_tr);

	    //p_box.get("CD_GBN") == A4
	    dao.COMMNM_SHR_00(p_box);
	}

	/**
     * 부서코드를 가지고 온다.
     * @param p_box
     * @param p_tr
     * @throws CException
	 */
	public void COMMNM_SHR_DPT(CBox p_box, TrBox p_tr) throws CException {

	    COMMNMDAO dao = new COMMNMDAO("default", p_tr);

	    dao.COMMNM_SHR_DPT(p_box);
	}
	public void COMMNM_SHR_DPT2(CBox p_box, TrBox p_tr) throws CException {

	    COMMNMDAO dao = new COMMNMDAO("default", p_tr);

	    dao.COMMNM_SHR_DPT2(p_box);
	}
	public void COMMNM_SHR_DPT3(CBox p_box, TrBox p_tr) throws CException {

	    COMMNMDAO dao = new COMMNMDAO("default", p_tr);

	    dao.COMMNM_SHR_DPT3(p_box);
	}
}
