package Ehr.sag.b.sagb060.cmd;

import java.rmi.RemoteException;

import Ehr.sag.b.sagb060.wrk.SAGB060WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGB060CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGB060WRK wrk = new SAGB060WRK();

		//S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//���������� ���� ������ �������� ���� WORK�޼ҵ� ȣ��
			wrk.SAGB060_SHR(p_box, p_tr);
		}
		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV")) {
			//�������Ұ���File���� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SAGB060_SAV(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new SAGB060EJB(p_box, p_tr));
	}

}
