package hr.sag.d.sagd200.ejb;

import hr.sag.d.sagd200.wrk.SAGD200WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGD200EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGD200EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGD200WRK wrk = new SAGD200WRK();

		/** ��ȸ **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.SAGD200_SHR(box, tr);
		}

		/** �ұ޺� ��ȸ **/
		else if (box.get("S_MODE").equals("SHR_SO")) {
			wrk.SAGD200_SHR_SO(box, tr);
		}

		/** �������� ��ȸ **/
		else if (box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGD200_SHR_01(box, tr);
		}

		/** �������� ��ȸ **/
		else if (box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGD200_SHR_PRINT(box, tr);
		}

		/** �������� ���ε� **/
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.SAGD200_SHR_02(box, tr);
		}
		/** ���� **/
		else if (box.get("S_MODE").equals("SAV")) {
			wrk.SAGD200_SAV(box, tr);
		}
		/** ���� **/
		else if (box.get("S_MODE").equals("DEL")) {
			wrk.SAGD200_DEL(box, tr);
		}

		return null;
	}

}
