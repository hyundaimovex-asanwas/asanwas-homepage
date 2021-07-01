package Ehr.acq.a.acqa050.wrk;

import Ehr.acq.a.acqa050.dao.ACQA050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class ACQA050WRK {
	
	/**
	 * ��Ȳ ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA050_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA050DAO dao = new ACQA050DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_PLANLIST",     dao.ACQA050_SHR_01(p_box));
	

	}
	
	
	/**
	 * ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA050_SHR_APP(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA050DAO dao = new ACQA050DAO("default", p_tr);

	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao.ACQA050_SHR_APP(p_box));			

	}
	


	
	

	
}

