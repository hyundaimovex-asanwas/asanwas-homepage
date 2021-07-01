package Ehr.common.popup.empl2.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.popup.empl2.dao.EMPL2DAO;

public class EMPL2WRK {

	/**
	 * ����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL2_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			EMPL2DAO dao = new EMPL2DAO("default", p_tr);
			dao.EMPL2_SHR_01(p_box);

	}

	/**
	 * ����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ(���������)�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL2_SHR_02(CBox p_box, TrBox p_tr) throws CException {

			EMPL2DAO dao = new EMPL2DAO("default", p_tr);
			dao.EMPL2_SHR_02(p_box);

	}

	/**
	 * �ӿ��߿��� ����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EMPL2_SHR_03(CBox p_box, TrBox p_tr) throws CException {

			EMPL2DAO dao = new EMPL2DAO("default", p_tr);
			dao.EMPL2_SHR_03(p_box);

	}
}
