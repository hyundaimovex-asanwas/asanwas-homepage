package Ehr.gun.a.guna071.cmd;

import Ehr.gun.a.guna071.wrk.GUNA071WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.proxy.EjbProxy;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNA071CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA071WRK wrk = new GUNA071WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//���缼�λ��� ��ȸ(�����û) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_01(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			//���缼�λ��� ��ȸ(���ϱ���) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_02(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_PLAN")) {
			//���缼�λ��� ��ȸ(�Ϳ�����) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_PLAN(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_ACC")) {
			//���缼�λ��� ��ȸ(����������) ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_ACC(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_APP")) {
			//���� ������  ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SHR_APP(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV") && (p_box.get("GUN_GBN").equals("C")) ) {
			//���缼�λ��� ��ȸ(���ϱ���) ������ ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SAV(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV") && (p_box.get("GUN_GBN").equals("U")) ) {
		//���缼�λ��� ��ȸ(�������) ������ ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SAV_01(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV") && (p_box.get("GUN_GBN").equals("A")) ) {
			//���缼�λ��� ��ȸ(����������) ���带 ���� WORK�޼ҵ� ȣ��
			wrk.GUNA071_SAV_03(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new GUNA071EJB(p_box, p_tr));
	}

}
