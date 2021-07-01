package hr.gun.d.gund030.ejb;


import hr.gun.d.gund030.wrk.GUND030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUND030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUND030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUND030WRK wrk = new GUND030WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//�����߻������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUND030_SHR(box, tr);
		}
		// S_MODE�� �ϰ������� ���
		else if (box.get("S_MODE").equals("INS")) {
			//�����߻������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUND030_INS(box, tr);
		}

		// S_MODE�� ������� ���
		else if (box.get("S_MODE").equals("UPT")) {
			//�����߻������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUND030_UPT(box, tr);
		}

		//���� �̻��
		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//�����߻������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUND030_SAV(box, tr);
		}

        // S_MODE�� ������ ���
//		else if (box.get("S_MODE").equals("DEL")) {
			//�����߻������� �����ϱ� ���� WORK�޼ҵ� ȣ��
//			wrk.GUND030_DEL(box, tr);
//		}

		return null;
	}
}
