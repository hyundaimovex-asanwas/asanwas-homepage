package hr.but.a.buta020.ejb;

import hr.but.a.buta020.wrk.BUTA020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class BUTA020EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public BUTA020EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BUTA020WRK wrk = new BUTA020WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//ǰ�ǹ�ȣ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_01(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_02")) {
			//������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_02(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_03")) {
			//����ǰ�Ǽ� �ۼ� ���� �� ���� ������ ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_03(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_05")) {
			//����ǰ�Ǽ� �ۼ� ���� �� ���� ������ ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_05(box, tr);
		}		
		//S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV_01")) {
			//����ǰ�� �ۼ����� �����  ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_01(box, tr);
		}
		//S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV_01_APP")) {
			//����ǰ�� �ۼ����� �����  ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_01_APP(box, tr);
		}
		//S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV_02")) {
			//����ǰ�� ������Ȳ�� ���, ����, ����ó�� ����� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_02(box, tr);
		}
		//S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV_03")) {
			//����ǰ�� ������Ȳ�� �ΰ�, �ݼ�ó�� ����� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_03(box, tr);
		}
		//S_MODE�� ������ ���
		else if (box.get("S_MODE").equals("SAV_DATE")) {
			//�λ������� ��¥�� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_DATE(box, tr);
		}
		return null;
	}

}
