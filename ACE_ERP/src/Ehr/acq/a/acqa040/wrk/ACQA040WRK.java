package Ehr.acq.a.acqa040.wrk;

import Ehr.acq.a.acqa040.dao.ACQA040DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class ACQA040WRK {
	
	/**
	 * ��Ȳ ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA040_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA040DAO dao = new ACQA040DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_PLANLIST",     dao.ACQA040_SHR_01(p_box));
	

	}
	
	
	/**
	 * ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA040_SHR_APP(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA040DAO dao = new ACQA040DAO("default", p_tr);

	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao.ACQA040_SHR_APP(p_box));			

	}
	


	
	

	
}

