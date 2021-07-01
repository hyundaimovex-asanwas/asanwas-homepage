package Ehr.common.popup.empl2.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.popup.empl2.dao.EMPL2DAO;

public class EMPL2WRK {

	/**
	 * 사원코드/명에 해당하는 부서와 직책을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL2_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			EMPL2DAO dao = new EMPL2DAO("default", p_tr);
			dao.EMPL2_SHR_01(p_box);

	}

	/**
	 * 사원코드/명에 해당하는 부서와 직책을 조회(퇴사자포함)해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL2_SHR_02(CBox p_box, TrBox p_tr) throws CException {

			EMPL2DAO dao = new EMPL2DAO("default", p_tr);
			dao.EMPL2_SHR_02(p_box);

	}

	/**
	 * 임원중에서 사원코드/명에 해당하는 부서와 직책을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL2_SHR_03(CBox p_box, TrBox p_tr) throws CException {

			EMPL2DAO dao = new EMPL2DAO("default", p_tr);
			dao.EMPL2_SHR_03(p_box);

	}
}
