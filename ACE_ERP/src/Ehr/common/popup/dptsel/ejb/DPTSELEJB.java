package common.popup.dptsel.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.popup.dptsel.wrk.DPTSELWRK;

public class DPTSELEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public DPTSELEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		DPTSELWRK wrk = new DPTSELWRK();
		
//		 S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	�μ�Ʈ�� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.DPTSEL_SHR(box, tr);
		}
		
		return null;
	}

}
