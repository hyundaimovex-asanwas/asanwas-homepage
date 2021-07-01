package common.popup.commnm.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

import common.popup.commnm.wrk.COMMNMWRK;

public class COMMNMEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public COMMNMEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		COMMNMWRK wrk = new COMMNMWRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	���� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.COMMNM_SHR(box, tr);
		}
		else if (box.get("S_MODE").equals("SHR_03")) {//1~2�� �̹� �����
			//	���� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.COMMNM_SHR_03(box, tr);
		}

		return null;
	}

}
