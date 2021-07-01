package common.popup.empl2.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.popup.empl2.wrk.EMPL2WRK;

public class EMPL2EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EMPL2EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EMPL2WRK wrk = new EMPL2WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//	����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.EMPL2_SHR_01(box, tr);
		}else if (box.get("S_MODE").equals("SHR_02")) {
			//	����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ(���������)�� ���� WORK�޼ҵ� ȣ��
			wrk.EMPL2_SHR_02(box, tr);
		}else if (box.get("S_MODE").equals("SHR_03")) {
			//	����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ(���������)�� ���� WORK�޼ҵ� ȣ��
			wrk.EMPL2_SHR_03(box, tr);
		}

		return null;
	}

}
