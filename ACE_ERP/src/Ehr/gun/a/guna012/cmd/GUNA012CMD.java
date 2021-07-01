package Ehr.gun.a.guna012.cmd;

import Ehr.gun.a.guna012.wrk.GUNA012WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNA012CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA012WRK wrk = new GUNA012WRK();

		// S_MODE�� �����ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_LST")) {
			//	���� ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_SHR_LST(p_box, p_tr);
		}
		
		// S_MODE�� ����ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	���� ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_SHR(p_box, p_tr);
		}
		
		// S_MODE�� ����üũ���� ���
		if (p_box.get("S_MODE").equals("SHR_YRP")) {
			//	������ ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_YRP(p_box, p_tr);
		}		
		
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	���� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_SAV(p_box, p_tr);
		}
		
		// S_MODE�� �������� ���
		if (p_box.get("S_MODE").equals("DEL")) {
			//	���� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA012_DEL(p_box, p_tr);
		}

		//EjbProxy.controlTxn(new GUNA012EJB(p_box, p_tr));
	}


}