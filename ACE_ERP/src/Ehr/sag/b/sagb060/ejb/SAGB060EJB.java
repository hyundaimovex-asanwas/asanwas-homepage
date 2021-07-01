package hr.sag.b.sagb060.ejb;

import hr.sag.b.sagb060.wrk.SAGB060WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGB060EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGB060EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGB060WRK wrk = new SAGB060WRK();

		//S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//���������� ���� ������ �������� ���� WORK�޼ҵ� ȣ��
			wrk.SAGB060_SHR(box, tr);
		}
		// S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//�������Ұ���File���� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SAGB060_SAV(box, tr);
		}

		return null;
	}
}
