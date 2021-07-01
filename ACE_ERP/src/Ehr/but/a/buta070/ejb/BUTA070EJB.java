package hr.but.a.buta070.ejb;

import hr.but.a.buta070.wrk.BUTA070WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BUTA070EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BUTA070EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BUTA070WRK wrk = new BUTA070WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//�������ޱ����� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA070_SHR(box, tr);
		}

		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//�������ޱ����� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA070_SAV(box, tr);
		}

        // S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("DEL")) {
			//�������ޱ����� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA070_DEL(box, tr);
		}

		return null;
	}

}
