package Ehr.yac.a.yaca030.ejb;

import Ehr.yac.a.yaca030.wrk.YACA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public YACA030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		YACA030WRK wrk = new YACA030WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//�Ƿ��������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SHR(box, tr);
		}
		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SHR_FAM")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SHR_FAM(box, tr);
		}
		
		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SAV(box, tr);
		}

        // S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("DEL")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_DEL(box, tr);
		}
		
		else if (box.get("S_MODE").equals("ACC")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_UPT_ACC(box, tr);
		}
		
		return null;
	}
}
