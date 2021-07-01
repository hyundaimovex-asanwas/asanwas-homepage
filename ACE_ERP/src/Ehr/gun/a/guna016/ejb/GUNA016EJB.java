package hr.gun.a.guna016.ejb;

import hr.gun.a.guna016.wrk.GUNA016WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA016EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA016EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA016WRK wrk = new GUNA016WRK();
		// S_MODE�� �����ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	������ ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA016_SHR(box, tr);
		}
		return null;
	}

}
