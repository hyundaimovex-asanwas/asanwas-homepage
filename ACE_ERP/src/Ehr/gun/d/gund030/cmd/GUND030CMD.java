package Ehr.gun.d.gund030.cmd;

import Ehr.gun.d.gund030.wrk.GUND030WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUND030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUND030WRK wrk = new GUND030WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//�����߻������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUND030_SHR(p_box, p_tr);
		}
		// S_MODE�� �ϰ������� ���
		else if (p_box.get("S_MODE").equals("INS")) {
			//�����߻������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUND030_INS(p_box, p_tr);
		}

		// S_MODE�� ������� ���
		else if (p_box.get("S_MODE").equals("UPT")) {
			//�����߻������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUND030_UPT(p_box, p_tr);
		}

		//���� �̻��
		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV")) {
			//�����߻������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUND030_SAV(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new GUND030EJB(p_box, p_tr));
	}

}
