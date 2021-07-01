package Ehr.cdp.a.book020.ejb;

import Ehr.cdp.a.book020.wrk.BOOK020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BOOK020EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BOOK020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BOOK020WRK wrk = new BOOK020WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//�������Խ�û�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK020_SHR(box, tr);
		}

		// ������ ��ȸ
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK020_SHR_02(box, tr);
		}

		// S_MODE�� ���ϱٹ��ް���û ���缱��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_01")) {
			//���ϱٹ��ް���û ���缱��ȸ�� ���� WORK�޼ҵ� ȣ�� ==> ����ó��  ���ϼ��� ���꿡�� ���
			wrk.BOOK020_SHR_01(box, tr);
		}

		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//�������Խ�û�� �ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK020_SAV(box, tr);
		}

		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("UPT_APP")) {
		    //���ϱٹ��ް���û�� �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.BOOK020_UPT_APP(box, tr);
		}

        // S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("DEL")) {
			//���ϱٹ��ް���û�� �����ϱ� ���� WORK�޼ҵ� ȣ��
			//wrk.BOOK020_DEL(box, tr);
		}



		// �κ� �ִ� 5��/�� ���� ��ȸ
		else if (box.get("S_MODE").equals("SHR_03")) {
			wrk.BOOK020_SHR_03(box, tr);
		}
		return null;
	}

}
