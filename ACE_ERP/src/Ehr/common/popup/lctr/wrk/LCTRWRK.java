package Ehr.common.popup.lctr.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.popup.lctr.dao.LCTRDAO;

public class LCTRWRK {
	/**
	 *  ����� �ش��ϴ� �ֹι�ȣ�� ���Ǻо߸� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void LCTR_SHR(CBox p_box, TrBox p_tr) throws CException {

		    LCTRDAO dao = new LCTRDAO("default", p_tr);
			dao.LCTR_SHR(p_box);
			
	}
}
