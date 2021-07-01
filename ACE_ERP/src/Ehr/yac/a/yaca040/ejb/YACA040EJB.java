package Ehr.yac.a.yaca040.ejb;

import Ehr.yac.a.yaca040.wrk.YACA040WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA040EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public YACA040EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		YACA040WRK wrk = new YACA040WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SHR(box, tr);
		}

//		 S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_05")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SHR_05(box, tr);
		}

		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SAV(box, tr);
		}

        // S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("DEL")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_DEL(box, tr);
		}

//		 S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("ACC")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_UPT_ACC(box, tr);
		}

		return null;
	}
}
