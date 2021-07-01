package Ehr.gun.d.gund080.cmd;

import Ehr.gun.d.gund080.wrk.GUND080WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUND080CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUND080WRK wrk = new GUND080WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//���������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUND080_SHR(p_box, p_tr);
		}else if (p_box.get("S_MODE").equals("SHR_DTL")) {
			//���������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUND080_SHR_DTL(p_box, p_tr);
		}
		
		
		//EjbProxy.controlTxn(new GUND060EJB(p_box, p_tr));
	}

}
