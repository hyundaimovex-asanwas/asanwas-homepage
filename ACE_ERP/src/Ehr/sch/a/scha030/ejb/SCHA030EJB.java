package hr.sch.a.scha030.ejb;

import hr.sch.a.scha030.wrk.SCHA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SCHA030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SCHA030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SCHA030WRK wrk = new SCHA030WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	���ڱ� ��û�� ó�� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA030_SHR(box, tr);
		}
		// S_MODE�� ����, ������ ���
		if (box.get("S_MODE").equals("SAV")) {
			//	���ڱݱ� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA030_SAV(box, tr);
		}
		// S_MODE�� ��ǥó���� ���
		if (box.get("S_MODE").equals("PROC")) {
			//	���ڱݱ� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA030_PROC(box, tr);
		}
		// S_MODE�� ����, ������ ���
		if (box.get("S_MODE").equals("APPROVAL")) {
			//	���ڱݱ� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA030_APPROVAL(box, tr);
		}
		return null;
	}

}
