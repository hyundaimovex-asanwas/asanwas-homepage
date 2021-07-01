package hr.cod.a.coda010.ejb;

import hr.cod.a.coda010.wrk.CODA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class CODA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public CODA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODA010WRK wrk = new CODA010WRK();

		/** ��ȸ **/
		if (box.get("S_MODE").equals("SHR")) {
			wrk.CODA010_SHR(box, tr);
		}
		/** ���� **/
		else if (box.get("S_MODE").equals("SAV")) {
			wrk.CODA010_SAV(box, tr);
		}

		return null;

	}

}
