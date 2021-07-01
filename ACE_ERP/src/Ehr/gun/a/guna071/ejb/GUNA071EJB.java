package hr.gun.a.guna071.ejb;

import hr.gun.a.guna071.wrk.GUNA071WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA071EJB extends EJB {

	private CBox box = null;
	private TrBox tr = null;

	public GUNA071EJB(CBox p_box, TrBox p_tr ) throws CException {
		this.box = p_box;
		this.tr = p_tr;
	}

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA071WRK wrk = new GUNA071WRK();

		// S_MODE�� ��ȸ�� ���
		if (box.get("S_MODE").equals("SHR_01")) {
			//���缼�λ��� ��ȸ(�����û) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_01(box, tr);

		}else if (box.get("S_MODE").equals("SHR_02")) {
			//���缼�λ��� ��ȸ(���ϱ���) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_02(box, tr);

		}else if (box.get("S_MODE").equals("SHR_PLAN")) {
			//���缼�λ��� ��ȸ(�Ϳ�����) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_PLAN(box, tr);

		}else if (box.get("S_MODE").equals("SHR_ACC")) {
			//���缼�λ��� ��ȸ(�Ϳ�����) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_ACC(box, tr);

		}else if (box.get("S_MODE").equals("SHR_APP")) {
			//���� ������  ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_APP(box, tr);

		}else if (box.get("S_MODE").equals("SAV") && (box.get("GUN_GBN").equals("C")) ) {
			//���缼�λ��� ��ȸ(���ϱ���) ������ ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SAV(box, tr);

		}else if (box.get("S_MODE").equals("SAV") && (box.get("GUN_GBN").equals("U")) ) {
		//���缼�λ��� ��ȸ(�������) ������ ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SAV_01(box, tr);

		}else if (box.get("S_MODE").equals("SAV") && (box.get("GUN_GBN").equals("P")) ) {
		//���缼�λ��� ��ȸ(�Ϳ�����) ���带 ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SAV_02(box, tr);

		}else if (box.get("S_MODE").equals("SAV") && (box.get("GUN_GBN").equals("A")) ) {
			//���缼�λ��� ��ȸ(����������) ���带 ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SAV_03(box, tr);
		}
		return null;
	}

}
