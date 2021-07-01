package Ehr.edu.e.edue040.ejb;

import Ehr.edu.e.edue040.wrk.EDUE040WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE040EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EDUE040EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EDUE040WRK wrk = new EDUE040WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//������Ȳ ����ó�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.EDUE040_SHR(box, tr);
		}
		
		return null;
	}

}
