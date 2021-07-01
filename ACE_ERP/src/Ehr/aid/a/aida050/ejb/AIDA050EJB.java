package hr.aid.a.aida050.ejb;

import hr.aid.a.aida050.wrk.AIDA050WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class AIDA050EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public AIDA050EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		AIDA050WRK wrk = new AIDA050WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	������� ���ޱ��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA050_SHR(box, tr);
		}
		// S_MODE�� ����, ������ ���
        else if (box.get("S_MODE").equals("SAV")) {
			//	������� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA050_SAV(box, tr);
		}
		
		return null;
	}

}
