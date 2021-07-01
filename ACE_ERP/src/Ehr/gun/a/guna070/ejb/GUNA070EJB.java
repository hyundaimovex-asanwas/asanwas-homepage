package hr.gun.a.guna070.ejb;

import hr.gun.a.guna070.wrk.GUNA070WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA070EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA070EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA070WRK wrk = new GUNA070WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//������Ȳ ����ó�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA070_SHR(box, tr);
		}
		
		//������ ��ȸ
		else if (box.get("S_MODE").equals("SHR_01")) {
			//������Ȳ ����ó�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA070_SHR_01(box, tr);
		}

		return null;
	}

}
