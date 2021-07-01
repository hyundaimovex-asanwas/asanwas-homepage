package common.popup.worldcity.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.popup.worldcity.wrk.WORLDCITYWRK;

public class WORLDCITYEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public WORLDCITYEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		WORLDCITYWRK wrk = new WORLDCITYWRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("NAT_SHR")) {
			//	�򰡱����������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.NAT_SHR(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("CITY_SHR")) {
			//	�򰡱����������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.CITY_SHR(box, tr);
		}
		return null;
	}

}
