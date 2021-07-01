package Ehr.gun.e.gune011.ejb;


import Ehr.gun.e.gune011.wrk.GUNE011WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNE011EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNE011EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNE011WRK wrk = new GUNE011WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE011_SHR(box, tr);
		}

		//S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("DEL")) {
			//����ٹ� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
			wrk.GUNE011_DEL(box, tr);
		}

		return null;
	}

}
