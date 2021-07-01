package common.popup.dptsel.wrk;

import common.popup.dptsel.dao.DPTSELDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class DPTSELWRK {
	
	/**
	 * 부서트리 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void DPTSEL_SHR(CBox p_box, TrBox p_tr) throws CException {
		
			DPTSELDAO dao = new DPTSELDAO("default", p_tr);
			dao.DPTSEL_SHR(p_box);
			
	}
	
}

