package Ehr.pir.i.piri010.wrk;

import Ehr.pir.i.piri010.dao.PIRI010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRI010WRK {


	/**
	 * �μ� ���� ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void PIRI010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		PIRI010DAO dao = new PIRI010DAO("default", p_tr);
		
		dao.PIRI010_SHR_01(p_box);
			
	}

	/**
	 * ��� ���� ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void PIRI010_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		//System.out.print(p_box);
		PIRI010DAO dao = new PIRI010DAO("default", p_tr);
		PIRI010DAO dao2 = new PIRI010DAO("default", p_tr);
		
		dao.PIRI010_SHR_02(p_box);
			
		/** ��������ó�� ���� ���  **/
		dao2.PIRI010_SHR_ACC(p_box);
		
	}
	
	public void PIRI010_SHR_DUTY(CBox p_box, TrBox p_tr) throws CException {

		PIRI010DAO dao = new PIRI010DAO("default", p_tr);
		
		dao.PIRI010_SHR_DUTY(p_box);
			
	}	
	

}

