package Ehr.idt.b.idtb010.ejb;

import Ehr.idt.b.idtb010.wrk.IDTB010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class IDTB010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public IDTB010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTB010WRK wrk = new IDTB010WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	������û��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB010_SHR(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//	���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB010_SHR_01(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_02")) {
			//	������� ��ȸ(�ּ�)�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB010_SHR_02(box, tr);
		}
		// S_MODE�� ����, ������ ���
		if (box.get("S_MODE").equals("SAV")) {
			//	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB010_SAV(box, tr);
		}
		// S_MODE�� �������� ���
		if (box.get("S_MODE").equals("DEL")) {
			//	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB010_DEL(box, tr);
		}
		// S_MODE�� ���� ��� ������Ʈ���� ���
		if (box.get("S_MODE").equals("UPT_PRT")) {
		    //	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.IDTB010_UPT_PRT(box, tr);
		}
		return null;
	}

}
