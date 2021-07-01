package Ehr.acq.a.acqa030.wrk;

import Ehr.acq.a.acqa030.dao.ACQA030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class ACQA030WRK {
	
	/**
	 * 현황 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA030_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA030DAO dao = new ACQA030DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_PLANLIST",     dao.ACQA030_SHR_01(p_box));
	

	}
	
	
	/**
	 * 결재 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA030_SHR_APP(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA030DAO dao = new ACQA030DAO("default", p_tr);

	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao.ACQA030_SHR_APP(p_box));			

	}
	


	
	

	
}

