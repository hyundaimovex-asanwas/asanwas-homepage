package Ehr.gun.e.gune010.ejb;

import Ehr.gun.e.gune010.wrk.GUNE010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNE010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNE010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNE010WRK wrk = new GUNE010WRK();

		// S_MODE�� ���缱��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_APP")) {
			//	���缱 ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_APP(box, tr);
		}
		// S_MODE�� ������ȸ�� ���
		if (box.get("S_MODE").equals("SHR_WK")) {
			//	���缱 ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_WK(box, tr);
		}
		// S_MODE�� ���������ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//	��� ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_01(box, tr);
		}
		// S_MODE�� ��� ����ٹ� �����ð� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_ACC")) {
			//	��� ����ٹ� �����ð��� ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_ACC(box, tr);
		}
		// S_MODE�� ��� ����ٹ� ��ϰ������� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_OTD")) {
			//	��� ����ٹ� ��ϰ������ڸ� ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_OTD(box, tr);
		}	
		// S_MODE�� ��û��ȣ ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_MAX")) {
			//	���� Ȯ���� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_MAX(box, tr);
		}
		// S_MODE�� ����ٹ� ���� ������ ���
		if (box.get("S_MODE").equals("UPT_APP")) {
			//	��� ����ٹ� ��ϰ������ڸ� ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_UPT_APP(box, tr);
		}			
		
		
		
	

		return null;
	}

}
