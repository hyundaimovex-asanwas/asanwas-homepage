package Ehr.sag.e.sage010.cmd;

import Ehr.sag.e.sage010.wrk.SAGE010WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGE010CMD implements AbstractGauceCMD {

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
		SAGE010WRK wrk = new SAGE010WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.SAGE010_SHR(p_box, p_tr);

		}
		/** �Ҽ� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {

			wrk.SAGE010_SHR_01(p_box, p_tr);

		}

		/** ���� **/
		else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.SAGE010_SAV(p_box, p_tr);

		}		
		
		
		//EjbProxy.controlTxn(new SAGE010EJB(p_box, p_tr));

	}

}
