package Ehr.common.popup.codenm.wrk;

import Ehr.common.popup.codenm.dao.CODENMDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODENMWRK {
	
	/**
	 * 공통 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODENM_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			CODENMDAO dao = new CODENMDAO("default", p_tr);

			dao.CODENM_SHR(p_box);
			
	}
	
	public void CODENM_SHR_SEL(CBox p_box, TrBox p_tr) throws CException {
		
		CODENMDAO dao = new CODENMDAO("default", p_tr);
		
		dao.CODENM_SHR_SEL(p_box);
		
	}	
	
	public void CODENM_SHR_DOC(CBox p_box, TrBox p_tr) throws CException {
		
		CODENMDAO dao = new CODENMDAO("default", p_tr);
		
		dao.CODENM_SHR_DOC(p_box);
		
	}		
	
	
}

