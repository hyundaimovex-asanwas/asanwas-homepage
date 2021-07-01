package Ehr.acq.a.acqa070.wrk;

import Ehr.acq.a.acqa070.dao.ACQA070DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class ACQA070WRK {
	
	/**
	 * 현황 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA070_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA070DAO dao = new ACQA070DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_PLANLIST",     dao.ACQA070_SHR_01(p_box));
	

	}
	
	
	/**
	 * 결재 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA070_SHR_APP(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA070DAO dao = new ACQA070DAO("default", p_tr);

	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao.ACQA070_SHR_APP(p_box));			

	}
	


	
	

	
}

