package Ehr.acq.a.acqa090.cmd;

import Ehr.acq.a.acqa090.wrk.ACQA090WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class ACQA090CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res, TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		ACQA090WRK wrk = new ACQA090WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.ACQA090_SHR(p_box, p_tr);
		}
		
		// S_MODE�� ���缱 ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_APP")) {

			wrk.ACQA090_SHR_APP(p_box, p_tr);
		}		
		

		// S_MODE�� ���缱 ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SAV_APP")) {

			wrk.ACQA090_SAV_APP(p_box, p_tr);
		}		
		
		
	}

}