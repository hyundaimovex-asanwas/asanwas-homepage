package Ehr.sag.a.saga200.cmd;

import Ehr.sag.a.saga200.wrk.SAGA200WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGA200CMD implements AbstractGauceCMD {

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
		SAGA200WRK wrk = new SAGA200WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGA200_SHR(p_box, p_tr);
		}
		/** �������� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_ALL")) {
			wrk.SAGA200_SHR_ALL(p_box, p_tr);

		}		
		
		//EjbProxy.controlTxn(new SAGA220EJB(p_box, p_tr));

	}

}
