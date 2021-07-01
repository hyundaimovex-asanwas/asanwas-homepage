package Ehr.cdp.a.book010.ejb;

import Ehr.cdp.a.book010.wrk.BOOK010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BOOK010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BOOK010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BOOK010WRK wrk = new BOOK010WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//���ϱٹ��ް���û�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK010_SHR(box, tr);
		}

		// ������ ��ȸ
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK010_SHR_02(box, tr);
		}

		// ��û��ȣ ��ȸ
		else if (box.get("S_MODE").equals("SHR_03")) {
			wrk.BOOK010_SHR_03(box, tr);
		}

		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//�������Խ�û�� �ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK010_SAV(box, tr);
		}


		// S_MODE�� ������ ��� - ������� ���
		else if (box.get("S_MODE").equals("UPT_APP")) {
		    //������û�� �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.BOOK010_UPT_APP(box, tr);
		}




		// S_MODE�� ����� �˾���ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_11")) {
			//�������Խ�û �˾���ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK010_SHR_11(box, tr);
		}

		// S_MODE�� ���缱 ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_APP")) {
			//�������Խ�û �˾���ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK010_SHR_APP(box, tr);
		}



        // S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("DEL")) {
			//���ϱٹ��ް���û�� �����ϱ� ���� WORK�޼ҵ� ȣ��
			//wrk.BOOK010_DEL(box, tr);
		}

		return null;
	}

}
