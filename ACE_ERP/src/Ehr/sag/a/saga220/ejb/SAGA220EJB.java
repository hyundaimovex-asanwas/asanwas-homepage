package hr.sag.a.saga220.ejb;

import hr.sag.a.saga220.wrk.SAGA220WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGA220EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGA220EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGA220WRK wrk = new SAGA220WRK();

		/** ��ȸ **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.SAGA220_SHR(box, tr);
		}
		/** �������� ��ȸ **/
		else if (box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGA220_SHR_01(box, tr);
		}
		/** �������� ���ε� **/
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.SAGA220_SHR_02(box, tr);
		}
		/** ���� **/
		else if (box.get("S_MODE").equals("SAV")) {
			wrk.SAGA220_SAV(box, tr);
		}
		/** ���� **/
		else if (box.get("S_MODE").equals("DEL")) {
			wrk.SAGA220_DEL(box, tr);
		}

		return null;
	}

}
