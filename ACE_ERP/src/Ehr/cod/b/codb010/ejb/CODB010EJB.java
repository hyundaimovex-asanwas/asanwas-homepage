package hr.cod.b.codb010.ejb;

import hr.cod.b.codb010.wrk.CODB010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODB010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public CODB010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODB010WRK wrk = new CODB010WRK();

		/** ��ȸ **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.CODB010_SHR(box, tr);
		}
		/** ������ȸ **/
		else if (box.get("S_MODE").equals("SHR_01")) {
			wrk.CODB010_SHR_01(box, tr);
		}
		/** ���� **/
		else if (box.get("S_MODE").equals("SAV")) {
			wrk.CODB010_SAV(box, tr);
		}
		/** ���� **/
		else if (box.get("S_MODE").equals("DEL")) {
			wrk.CODB010_DEL(box, tr);
		}

		return null;
	}

}
