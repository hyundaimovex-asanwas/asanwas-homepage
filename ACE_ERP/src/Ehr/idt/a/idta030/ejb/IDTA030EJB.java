package hr.idt.a.idta030.ejb;

import hr.idt.a.idta030.wrk.IDTA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class IDTA030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public IDTA030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTA030WRK wrk = new IDTA030WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	������û��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_SHR(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//	���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_SHR_01(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_02")) {
			//	������� ��ȸ(�ּ�)�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_SHR_02(box, tr);
		}
		// S_MODE�� ����, ������ ���
		if (box.get("S_MODE").equals("SAV")) {
			//	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_SAV(box, tr);
		}
		// S_MODE�� �������� ���
		if (box.get("S_MODE").equals("DEL")) {
			//	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_DEL(box, tr);
		}
		// S_MODE�� ���� ��� ������Ʈ���� ���
		if (box.get("S_MODE").equals("UPT_PRT")) {
		    //	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.IDTA030_UPT_PRT(box, tr);
		}
		return null;
	}

}
