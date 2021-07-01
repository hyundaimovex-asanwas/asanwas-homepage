package common.popup.achpnt.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

import common.popup.achpnt.wrk.ACHPNTWRK;

public class ACHPNTEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public ACHPNTEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		ACHPNTWRK wrk = new ACHPNTWRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	�޼����������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.ACHPNT_SHR(box, tr);
		}
		
		return null;
	}

}
