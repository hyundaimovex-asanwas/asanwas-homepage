package Ehr.pir.i.piri010.cmd;

import Ehr.pir.i.piri010.wrk.PIRI010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class PIRI010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRI010WRK wrk = new PIRI010WRK();

		// S_MODE�� ��ȸ�� ���(�μ� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��)
		if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.PIRI010_SHR_01(p_box, p_tr);
		}
		/// S_MODE�� ��ȸ�� ���(��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��)
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.PIRI010_SHR_02(p_box, p_tr);
		}		
		else if (p_box.get("S_MODE").equals("SHR_DUTY")) {
			wrk.PIRI010_SHR_DUTY(p_box, p_tr);
		}				
		
		//EjbProxy.controlTxn(new PIRI010EJB(p_box, p_tr));
	}


}