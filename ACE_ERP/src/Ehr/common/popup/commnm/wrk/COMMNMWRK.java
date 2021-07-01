package Ehr.common.popup.commnm.wrk;

import Ehr.common.popup.commnm.dao.COMMNMDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class COMMNMWRK {

	/**
	 * 공통 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void COMMNM_SHR(CBox p_box, TrBox p_tr) throws CException {

		COMMNMDAO dao = new COMMNMDAO("default", p_tr);
		dao.COMMNM_SHR(p_box);

	}

	/**
	 * 공통 정보의 기준코드 gbn2_tag 사용해 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void COMMNM_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		COMMNMDAO dao = new COMMNMDAO("default", p_tr);
		dao.COMMNM_SHR_03(p_box);

	}

}

