package Ehr.gun.e.gune015.cmd;

import Ehr.gun.e.gune015.wrk.GUNE015WRK;

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

public class GUNE015CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNE015WRK wrk = new GUNE015WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE015_SHR(p_box, p_tr);
		}
		// S_MODE�� ������ ���
				if (p_box.get("S_MODE").equals("SAV")) {
					//����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
					wrk.GUNE015_SAV(p_box, p_tr);
				}

		
		//EjbProxy.controlTxn(new BUTA010EJB(p_box, p_tr));
	}

}
