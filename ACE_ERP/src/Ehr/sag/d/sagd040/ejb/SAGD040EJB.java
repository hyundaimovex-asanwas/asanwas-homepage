package hr.sag.d.sagd040.ejb;

import hr.sag.d.sagd040.wrk.SAGD040WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGD040EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGD040EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGD040WRK wrk = new SAGD040WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//���κ� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.SAGD040_SHR(box, tr);
		}

		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//���κ� ������ ����, �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SAGD040_SAV(box, tr);
		}

        // S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("DEL")) {
			//���κ� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SAGD040_DEL(box, tr);
		}

		return null;
	}
}
