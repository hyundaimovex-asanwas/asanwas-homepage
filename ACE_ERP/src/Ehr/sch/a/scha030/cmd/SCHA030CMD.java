package Ehr.sch.a.scha030.cmd;

import Ehr.sch.a.scha030.wrk.SCHA030WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SCHA030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SCHA030WRK wrk = new SCHA030WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	���ڱ� ��û�� ó�� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA030_SHR(p_box, p_tr);
		}
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	���ڱݱ� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA030_SAV(p_box, p_tr);
		}

		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("APPROVAL")) {
			//	���ڱݱ� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA030_APPROVAL(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new SCHA030EJB(p_box, p_tr));
	}


}