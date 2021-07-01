package Ehr.cdp.a.book030.ejb;

import Ehr.cdp.a.book030.wrk.BOOK030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BOOK030EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BOOK030EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BOOK030WRK wrk = new BOOK030WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//���ϱٹ��ް���û�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK030_SHR(box, tr);
		}

		// ������ ��ȸ
		else if (box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK030_SHR_02(box, tr);
		}


		// ����������Ȳ��ȸ
		else if (box.get("S_MODE").equals("SHR_40")) {
			wrk.BOOK030_SHR_40(box, tr);
		}



		return null;
	}

}
