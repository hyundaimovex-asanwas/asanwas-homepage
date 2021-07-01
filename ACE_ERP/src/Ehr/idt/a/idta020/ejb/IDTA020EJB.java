package hr.idt.a.idta020.ejb;

import hr.idt.a.idta020.wrk.IDTA020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class IDTA020EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public IDTA020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTA020WRK wrk = new IDTA020WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	�����߱���Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA020_SHR(box, tr);
		}
		
		return null;
	}

}
