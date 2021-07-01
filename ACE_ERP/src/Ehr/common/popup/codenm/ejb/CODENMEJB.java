package common.popup.codenm.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

import common.popup.codenm.wrk.CODENMWRK;

public class CODENMEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public CODENMEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODENMWRK wrk = new CODENMWRK();
//		 S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	���� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.CODENM_SHR(box, tr);
		}else if (box.get("S_MODE").equals("SHR_SEL")) {
				//	���� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
				wrk.CODENM_SHR_SEL(box, tr);			
		}
		
		return null;
	}

}
