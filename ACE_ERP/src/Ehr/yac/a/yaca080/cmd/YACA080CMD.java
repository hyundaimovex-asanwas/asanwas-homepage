package Ehr.yac.a.yaca080.cmd;

import Ehr.yac.a.yaca080.wrk.YACA080WRK;

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

public class YACA080CMD implements AbstractGauceCMD {

	/**
	 *����Ÿ��ȿ��üũ command class
	 *��ȸ, ����, ������ ���
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		YACA080WRK wrk = new YACA080WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.YACA080_SHR(p_box, p_tr);
		}		
		
		if (p_box.get("S_MODE").equals("SHR_15")) {
			wrk.YACA080_SHR_15(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new YACA080EJB(p_box, p_tr));

	}

}
