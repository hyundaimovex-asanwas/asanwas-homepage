package Ehr.sag.d.sagd200.cmd;


import java.rmi.RemoteException;

import Ehr.sag.d.sagd200.wrk.SAGD200WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGD200CMD implements AbstractGauceCMD {

	/**
	 *�޿����̺� command class
	 *��ȸ, ����, ������ ���
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGD200WRK wrk = new SAGD200WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGD200_SHR(p_box, p_tr);
		}

		/** �ұ޺� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_SO")) {
			wrk.SAGD200_SHR_SO(p_box, p_tr);
		}

		/** �������� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGD200_SHR_01(p_box, p_tr);
		}

		/** �������� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGD200_SHR_PRINT(p_box, p_tr);
		}

		//EjbProxy.controlTxn(new SAGD200EJB(p_box, p_tr));

	}

}
