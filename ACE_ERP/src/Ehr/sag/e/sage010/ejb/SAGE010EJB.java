package hr.sag.e.sage010.ejb;

import hr.sag.e.sage010.wrk.SAGE010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGE010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public SAGE010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGE010WRK wrk = new SAGE010WRK();

		/** ��ȸ **/
		if (box.get("S_MODE").equals("SHR")) {

			wrk.SAGE010_SHR(box, tr);

		}
		/** �Ҽ� ��ȸ **/
		else if (box.get("S_MODE").equals("SHR_01")) {

			wrk.SAGE010_SHR_01(box, tr);

		}

		/** ���� **/
		else if (box.get("S_MODE").equals("SAV")) {

			wrk.SAGE010_SAV(box, tr);

		}


		return null;
	}

}