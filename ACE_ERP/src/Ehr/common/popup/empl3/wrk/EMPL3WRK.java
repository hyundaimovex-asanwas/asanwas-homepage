package common.popup.empl3.wrk;

import common.popup.empl3.dao.EMPL3DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EMPL3WRK {
	
	/**
	 * �ش� �⵵�� ���� �򰡱��� ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL3_SHR(CBox p_box, TrBox p_tr) throws CException {

			EMPL3DAO dao = new EMPL3DAO("default", p_tr);
			dao.EMPL3_SHR(p_box);
			
	}
	
}

