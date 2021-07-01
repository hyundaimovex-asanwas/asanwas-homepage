package hr.pir.i.piri010.ejb;

import hr.pir.i.piri010.wrk.PIRI010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRI010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public PIRI010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRI010WRK wrk = new PIRI010WRK();

		// S_MODE�� ��ȸ�� ���(�μ� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��)
		if (box.get("S_MODE").equals("SHR_01")) {
			wrk.PIRI010_SHR_01(box, tr);
		}
		/// S_MODE�� ��ȸ�� ���(��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��)
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.PIRI010_SHR_02(box, tr);
		}

		return null;
	}

}
