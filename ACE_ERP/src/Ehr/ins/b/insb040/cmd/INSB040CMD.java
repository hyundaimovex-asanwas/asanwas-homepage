package Ehr.ins.b.insb040.cmd;

import Ehr.ins.b.insb040.wrk.INSB040WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class INSB040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		INSB040WRK wrk = new INSB040WRK();

		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	���ο��ݵ���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.INSB040_SAV(p_box, p_tr);
		}
		
        else if (p_box.get("S_MODE").equals("ULD")) {
		    wrk.INSB040_ULD(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new INSB040EJB(p_box, p_tr));
	}


}