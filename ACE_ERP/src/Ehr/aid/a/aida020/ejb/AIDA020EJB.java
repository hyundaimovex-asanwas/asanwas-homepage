package hr.aid.a.aida020.ejb;

import hr.aid.a.aida020.wrk.AIDA020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class AIDA020EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public AIDA020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		AIDA020WRK wrk = new AIDA020WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	������� ����ó��  ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA020_SHR(box, tr);
		}
		
		return null;
	}

}
