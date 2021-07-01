package hr.aid.a.aida010.ejb;

import hr.aid.a.aida010.wrk.AIDA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class AIDA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public AIDA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		AIDA010WRK wrk = new AIDA010WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	������� ���ޱ��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//	��� �� ���޳����� ���� ������� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR_01(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_02")) {
			//	���� ��ȸ
			wrk.AIDA010_SHR_02(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_03")) {
			//	��û�ڿ� �ش��ϴ� ���ޱݾ�  ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR_03(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_04")) {
			//	��û��ȣ(REQ_NO)�� �ش��ϴ� ��û��  ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR_04(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_06")) {
			//	��� �� ���޳����� ���� ������� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR_06(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_LSE")) {
		    //	�ټӳ���� ��ȸ�� �´�.
		    wrk.AIDA010_SHR_LSE(box, tr);
		}
		// S_MODE�� ����, ������ ���
		if (box.get("S_MODE").equals("SAV")) {
			//	������� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SAV(box, tr);
		}
		// S_MODE�� ����, ������ ���
		if (box.get("S_MODE").equals("SAV_01")) {
			//	������� ��û���� �����ϰ�, ���������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SAV_01(box, tr);
		}
		// S_MODE�� ������ ���
		if (box.get("S_MODE").equals("DEL")) {
			//	������� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_DEL(box, tr);
		}

		// S_MODE�� ��ǥó���� ���
		if (box.get("S_MODE").equals("PROC_D")) {
		    //	������� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.PROC_D(box, tr);
		}
        // S_MODE�� ����ó���� ���
		if (box.get("S_MODE").equals("PROC_E")) {
		    //	������� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.PROC_E(box, tr);
		}

		return null;
	}

}
