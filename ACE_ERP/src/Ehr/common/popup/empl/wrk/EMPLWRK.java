package Ehr.common.popup.empl.wrk;

import Ehr.common.popup.empl.dao.EMPLDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EMPLWRK {
	
	/**
	 * 해당 년도에 대한 평가구조 설정 내용을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL_SHR(CBox p_box, TrBox p_tr) throws CException {

			EMPLDAO dao = new EMPLDAO("default", p_tr);
			dao.EMPL_SHR(p_box);
			
	}
	
}

