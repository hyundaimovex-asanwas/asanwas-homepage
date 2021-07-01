package Ehr.sag.a.saga220.cmd;

import Ehr.sag.a.saga220.wrk.SAGA220WRK;

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

public class SAGA220CMD implements AbstractGauceCMD {

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
		SAGA220WRK wrk = new SAGA220WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGA220_SHR(p_box, p_tr);
		}
		/** �������� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGA220_SHR_01(p_box, p_tr);
		}
		/** �������� ���ε� **/
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.SAGA220_SHR_02(p_box, p_tr);
		}
		
		/** ����� �߰� 2018.07.12 �̵��� **/
		else if (p_box.get("S_MODE").equals("SHR_09")) {
			wrk.SAGA220_SHR_09(p_box, p_tr);
		}		
		
		/** ���� **/
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.SAGA220_SAV(p_box, p_tr);
		}
		/** ���� **/
		else if (p_box.get("S_MODE").equals("DEL")) {
			wrk.SAGA220_DEL(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new SAGA220EJB(p_box, p_tr));

	}

}
