package Ehr.sag.d.sagd205.cmd;


import java.rmi.RemoteException;

import Ehr.sag.d.sagd205.wrk.SAGD205WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGD205CMD implements AbstractGauceCMD {

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
		SAGD205WRK wrk = new SAGD205WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGD205_SHR(p_box, p_tr);
		}

		/** �ұ޺� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_SO")) {
			wrk.SAGD205_SHR_SO(p_box, p_tr);
		}

		/** �������� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGD205_SHR_01(p_box, p_tr);
		}

		/** �������� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGD205_SHR_PRINT(p_box, p_tr);
		}

		//EjbProxy.controlTxn(new SAGD205EJB(p_box, p_tr));

	}

}
