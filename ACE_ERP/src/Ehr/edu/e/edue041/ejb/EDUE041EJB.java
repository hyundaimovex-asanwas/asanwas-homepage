package Ehr.edu.e.edue041.ejb;

import Ehr.edu.e.edue041.wrk.EDUE041WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE041EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public EDUE041EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EDUE041WRK wrk = new EDUE041WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//���缼�λ��� ��ȸ(�����û) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.EDUE041_SHR(box, tr);
		}else if (box.get("S_MODE").equals("SAV") ) {
			//���缼�λ��� ��ȸ(���ϱ���) ������ ���� WORK�޼ҵ� ȣ��
			wrk.EDUE041_SAV(box, tr);
		}else if (box.get("S_MODE").equals("SAV01") ) {
			//���缼�λ��� ��ȸ(���ϱ���) ������ ���� WORK�޼ҵ� ȣ��
			wrk.EDUE041_SAV(box, tr);
		}
		return null;
	}

}
