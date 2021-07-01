package Ehr.cod.b.codb010.cmd;

import Ehr.cod.b.codb010.wrk.CODB010WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODB010CMD implements AbstractGauceCMD {

	/**
	 * �����ڵ��� command class
	 * head��ȸ, sub��ȸ, ���忡 ���
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODB010WRK wrk = new CODB010WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			
			//System.out.println(p_box);
			
			wrk.CODB010_SHR(p_box, p_tr);
		}
		/** ������ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.CODB010_SHR_01(p_box, p_tr);
		}
		/** ���� **/
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.CODB010_SAV(p_box, p_tr);
		}
		/** ���� **/
		else if (p_box.get("S_MODE").equals("DEL")) {
			wrk.CODB010_DEL(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new CODB010EJB(p_box, p_tr));

	}

}
