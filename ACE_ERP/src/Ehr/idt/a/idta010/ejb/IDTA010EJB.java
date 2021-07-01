package hr.idt.a.idta010.ejb;

import hr.idt.a.idta010.wrk.IDTA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class IDTA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;
	
	public IDTA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}
	
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTA010WRK wrk = new IDTA010WRK();
		
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	�����߱�ó�� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��(�μ��)
			wrk.IDTA010_SHR(box, tr);
		}

		if (box.get("S_MODE").equals("SAV")) {
			//	�����߱�ó�� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA010_SAV_TEMP(box, tr);
		}
		
		if (box.get("S_MODE").equals("PROC")) {
		    //	�����߱�ó�� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.IDTA010_PROC(box, tr);
		}
		return null;
	}

}
