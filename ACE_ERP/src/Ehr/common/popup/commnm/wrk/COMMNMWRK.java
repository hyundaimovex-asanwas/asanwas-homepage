package Ehr.common.popup.commnm.wrk;

import Ehr.common.popup.commnm.dao.COMMNMDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class COMMNMWRK {

	/**
	 * ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void COMMNM_SHR(CBox p_box, TrBox p_tr) throws CException {

		COMMNMDAO dao = new COMMNMDAO("default", p_tr);
		dao.COMMNM_SHR(p_box);

	}

	/**
	 * ���� ������ �����ڵ� gbn2_tag ����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void COMMNM_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		COMMNMDAO dao = new COMMNMDAO("default", p_tr);
		dao.COMMNM_SHR_03(p_box);

	}

}

