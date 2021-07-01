package Ehr.yac.a.yaca060.ejb;

import Ehr.yac.a.yaca060.wrk.YACA060WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA060EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public YACA060EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		YACA060WRK wrk = new YACA060WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA060_SHR(box, tr);
		}

		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA060_SAV(box, tr);
		}

        // S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("DEL")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA060_DEL(box, tr);
		}
		else if (box.get("S_MODE").equals("ACC")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA060_UPT_ACC(box, tr);
		}

		return null;
	}
}
