package hr.but.a.buta021.ejb;

import hr.but.a.buta021.wrk.BUTA021WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BUTA021EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BUTA021EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BUTA021WRK wrk = new BUTA021WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//�������ޱ��� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA021_SHR_01(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_02")) {
				//���޿� ���� �ܰ��� ��ȸ�� ���� WORK�޼ҵ� ȣ��
				wrk.BUTA021_SHR_02(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_03")) {
				//���޿� ���� �ܰ��� ��ȸ�� ���� WORK�޼ҵ� ȣ��
				wrk.BUTA021_SHR_03(box, tr);
		}
		//S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR")) {
				//���޿� ���� �ܰ��� ��ȸ�� ���� WORK�޼ҵ� ȣ��
				wrk.BUTA021_SHR(box, tr);
		}
		//S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//����ǰ�� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
			wrk.BUTA021_SAV(box, tr);
			//S_MODE�� ������ ���
		}else if (box.get("S_MODE").equals("SHR_04")) {
				//����ǰ�� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
				wrk.BUTA021_SHR_04(box, tr);
		}
		return null;
	}

}
