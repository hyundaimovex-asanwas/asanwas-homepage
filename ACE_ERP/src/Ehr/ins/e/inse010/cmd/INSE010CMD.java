package Ehr.ins.e.inse010.cmd;

import Ehr.ins.e.inse010.wrk.INSE010WRK;

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

public class INSE010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		INSE010WRK wrk = new INSE010WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.INSE010_SHR(p_box, p_tr);
		}

		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			wrk.INSE010_SAV(p_box, p_tr);
		}
        else if (p_box.get("S_MODE").equals("ULD")) {
		    wrk.INSE010_ULD(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new INSE010EJB(p_box, p_tr));
	}


}