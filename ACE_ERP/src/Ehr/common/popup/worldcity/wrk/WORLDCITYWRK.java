package common.popup.worldcity.wrk;

import common.popup.worldcity.dao.WORLDCITYDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class WORLDCITYWRK {

	/**
	 * 국가 내용을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void NAT_SHR(CBox p_box, TrBox p_tr) throws CException {

		WORLDCITYDAO dao = new WORLDCITYDAO("default", p_tr);
		dao.NAT_SHR(p_box);

	}
	/**
	 * 도시 내용을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CITY_SHR(CBox p_box, TrBox p_tr) throws CException {

		WORLDCITYDAO dao = new WORLDCITYDAO("default", p_tr);
		dao.CITY_SHR(p_box);

	}
}

