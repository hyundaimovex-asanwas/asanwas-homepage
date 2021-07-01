package Ehr.sag.d.sagd040.cmd;

import java.rmi.RemoteException;

import Ehr.sag.d.sagd040.wrk.SAGD040WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGD040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGD040WRK wrk = new SAGD040WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//���κ� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.SAGD040_SHR(p_box, p_tr);
		}

		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV")) {
			//���κ� ������ ����, �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SAGD040_SAV(p_box, p_tr);
		}

        // S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("DEL")) {
			//���κ� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SAGD040_DEL(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new SAGD040EJB(p_box, p_tr));
	}

}
