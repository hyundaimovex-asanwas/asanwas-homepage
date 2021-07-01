package hr.sch.a.scha010.ejb;

import hr.sch.a.scha010.wrk.SCHA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SCHA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public SCHA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SCHA010WRK wrk = new SCHA010WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	������� ���ޱ��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA010_SHR(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//	��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA010_SHR_01(box, tr);
		}
		// S_MODE�� ����, ������ ���
		if (box.get("S_MODE").equals("SAV")) {
			//	���ڱ� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA010_SAV(box, tr);
		}
		// S_MODE�� ������ ���
		if (box.get("S_MODE").equals("DEL")) {
			//	���ڱ� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA010_DEL(box, tr);
		}
		
		return null;
	}

}
