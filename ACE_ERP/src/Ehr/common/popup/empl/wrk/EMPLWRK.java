package Ehr.common.popup.empl.wrk;

import Ehr.common.popup.empl.dao.EMPLDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EMPLWRK {
	
	/**
	 * �ش� �⵵�� ���� �򰡱��� ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL_SHR(CBox p_box, TrBox p_tr) throws CException {

			EMPLDAO dao = new EMPLDAO("default", p_tr);
			dao.EMPL_SHR(p_box);
			
	}
	
}

