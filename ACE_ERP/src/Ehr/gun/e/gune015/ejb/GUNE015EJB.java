package Ehr.gun.e.gune015.ejb;


import Ehr.gun.e.gune015.wrk.GUNE015WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNE015EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNE015EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNE015WRK wrk = new GUNE015WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE015_SHR(box, tr);
		}

	

		return null;
	}

}
