package hr.gun.a.guna013.ejb;

import hr.gun.a.guna013.wrk.GUNA013WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA013EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA013EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA013WRK wrk = new GUNA013WRK();
		// S_MODE�� �����ȸ�� ���
		if (box.get("S_MODE").equals("SHR_LST")) {
			//	������ ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA013_SHR_LST(box, tr);
		}
		// S_MODE�� �����ȸ�� ���
		if (box.get("S_MODE").equals("SHR_CD")) {
			//	������ ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA013_SHR_CD(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR")) {
			//	�ش�μ��� ���� ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA013_SHR(box, tr);
		}
		// S_MODE�� ����, ������ ���
		else if (box.get("S_MODE").equals("SAV")) {
			//	���º����û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA013_SAV(box, tr);
		}
		// S_MODE�� �������� ���
		else if (box.get("S_MODE").equals("DEL")) {
			//	���º����û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA013_DEL(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_04")) {
			//	�ش�μ��� ���� ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA013_SHR_04(box, tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (box.get("S_MODE").equals("SHR_05")) {
			//	��û��ȣ ��ȸ
			wrk.GUNA013_SHR_05(box, tr);
			// S_MODE�� ��ȸ�� ���
		}else if (box.get("S_MODE").equals("SHR_06")) {
				//	��û��ȣ ��ȸ
				wrk.GUNA013_SHR_06(box, tr);
			}
		return null;
	}

}
