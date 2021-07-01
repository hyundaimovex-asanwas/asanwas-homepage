package hr.gun.a.guna012.ejb;

import hr.gun.a.guna012.wrk.GUNA012WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA012EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA012EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA012WRK wrk = new GUNA012WRK();

		// S_MODE�� �����ȸ�� ���
		if (box.get("S_MODE").equals("SHR_LST")) {
			//	���� ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_SHR_LST(box, tr);
		}
		// S_MODE�� ����ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	���� ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_SHR(box, tr);
		}
		// S_MODE�� ����, ������ ���
		if (box.get("S_MODE").equals("SAV")) {
			//	���� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_SAV(box, tr);
		}
		// S_MODE�� �������� ���
		if (box.get("S_MODE").equals("DEL")) {
			//	���� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_DEL(box, tr);
		}
		// S_MODE�� ����üũ���� ���
		if (box.get("S_MODE").equals("SHR_YRP")) {
			//	������ ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_YRP(box, tr);
		}
		return null;
	}

}
