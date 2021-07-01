package common.popup.train.ejb;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.popup.train.wrk.TRAINWRK;

public class TRAINEJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public TRAINEJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		TRAINWRK wrk = new TRAINWRK();

//		 S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	����뼱 ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.TRAIN_SHR(box, tr);
		}

		return null;
	}

}
