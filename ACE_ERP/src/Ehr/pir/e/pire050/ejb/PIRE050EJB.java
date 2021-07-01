package hr.pir.e.pire050.ejb;

import hr.pir.e.pire050.wrk.PIRE050WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRE050EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public PIRE050EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRE050WRK wrk = new PIRE050WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//���ϱٹ��ް���û�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.PIRE050_SHR(box, tr);
		}


		return null;
	}

}
