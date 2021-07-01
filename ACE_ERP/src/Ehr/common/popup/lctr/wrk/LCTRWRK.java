package Ehr.common.popup.lctr.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.popup.lctr.dao.LCTRDAO;

public class LCTRWRK {
	/**
	 *  강사명에 해당하는 주민번호와 강의분야를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void LCTR_SHR(CBox p_box, TrBox p_tr) throws CException {

		    LCTRDAO dao = new LCTRDAO("default", p_tr);
			dao.LCTR_SHR(p_box);
			
	}
}
