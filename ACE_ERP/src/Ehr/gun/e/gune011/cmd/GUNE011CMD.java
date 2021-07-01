package Ehr.gun.e.gune011.cmd;

import Ehr.gun.e.gune011.wrk.GUNE011WRK;

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

public class GUNE011CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNE011WRK wrk = new GUNE011WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE011_SHR(p_box, p_tr);
		}

		//S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("DEL")) {
			//����ٹ� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
			wrk.GUNE011_DEL(p_box, p_tr);
		}
		
		//EjbProxy.controlTxn(new BUTA010EJB(p_box, p_tr));
	}

}
