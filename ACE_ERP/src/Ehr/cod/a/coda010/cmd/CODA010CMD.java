package Ehr.cod.a.coda010.cmd;

import Ehr.cod.a.coda010.wrk.CODA010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODA010CMD implements AbstractGauceCMD {

	/**
	 *ȸ�������Է� command class
	 *��ȸ, ���忡 ���
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODA010WRK wrk = new CODA010WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.CODA010_SHR(p_box, p_tr);
		}
		/** ���� **/
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.CODA010_SAV(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new CODA010EJB(p_box, p_tr));
	}

}
