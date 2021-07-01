package hr.but.a.buta010.ejb;

import hr.but.a.buta010.wrk.BUTA010WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BUTA010EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BUTA010EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BUTA010WRK wrk = new BUTA010WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//����ǰ�� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA010_SHR(box, tr);
		}

		//S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("DEL")) {
			//����ǰ�� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
			wrk.BUTA010_DEL(box, tr);
		}

		//S_MODE�� ���ͼ����� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SAP_SHR")) {
		    //����ǰ�� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
		    wrk.BUTA010_SAP_SHR(box, tr);
		}
		//S_MODE�� ��ǥ�� ���
		else if (box.get("S_MODE").equals("PROC")) {
		    //����ǰ�� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
		    wrk.BUTA010_PROC(box, tr);
		}
		//S_MODE�� �λ���Ȯ���� ���
		else if (box.get("S_MODE").equals("UPT_01")) {
		    //����ǰ�� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
		    wrk.BUTA010_UPT_01(box, tr);
		}
		return null;
	}

}
