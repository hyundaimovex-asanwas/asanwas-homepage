package hr.wel.n.weln040.ejb;

import hr.wel.n.weln040.wrk.WELN040WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class WELN040EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public WELN040EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		WELN040WRK wrk = new WELN040WRK();


		// S_MODE�� ��ȸ, ����, ������ ���
		if (box.get("S_MODE").equals("SHR")) {

			wrk.WELN040_SHR(box, tr);

		}

		return null;
	}

}
