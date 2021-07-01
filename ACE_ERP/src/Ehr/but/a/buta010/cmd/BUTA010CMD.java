package Ehr.but.a.buta010.cmd;

import Ehr.but.a.buta010.wrk.BUTA010WRK;

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

public class BUTA010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BUTA010WRK wrk = new BUTA010WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//����ǰ�� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA010_SHR(p_box, p_tr);
		}

		//S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("DEL")) {
			//����ǰ�� ��Ȳ ������ ���� WORK�޼ҵ� ȣ��
			wrk.BUTA010_DEL(p_box, p_tr);
		}
		
		//EjbProxy.controlTxn(new BUTA010EJB(p_box, p_tr));
	}

}
