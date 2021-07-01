package Ehr.common.popup.lctr.cmd;

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
import Ehr.common.popup.lctr.ejb.LCTREJB;
import Ehr.common.popup.lctr.wrk.LCTRWRK;

public class LCTRCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		//EjbProxy.controlTxn(new LCTREJB(p_box, p_tr));
		LCTRWRK wrk = new LCTRWRK();
		if (p_box.get("S_MODE").equals("SHR")) {
			//	�򰡱����������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.LCTR_SHR(p_box, p_tr);
		}
		
	}

}