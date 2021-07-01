package Ehr.common.popup.education.cmd;

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
import Ehr.common.popup.education.wrk.EDUCATIONWRK;

public class EDUCATIONCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		//EjbProxy.controlTxn(new EDUCATIONEJB(p_box, p_tr));
		
		EDUCATIONWRK wrk = new EDUCATIONWRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	�����ڵ� ��ȸ
			wrk.EDUCATION_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_01")) {//1~2�� �̹� �����
			//	���� ��ȸ
			wrk.EDUCATION_SHR_01(p_box,p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_C")) {
			//	�����ڵ� ��ȸ
			wrk.EDUCATION_SHR_C(p_box, p_tr);
		}
		
	}
	
}
