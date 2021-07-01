package Ehr.idt.c.idtc070.cmd;

import Ehr.idt.c.idtc070.wrk.IDTC070WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class IDTC070CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTC070WRK wrk = new IDTC070WRK();
		
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTC070_SHR(p_box, p_tr);
		}

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_DTL")) {
			//	���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTC070_SHR_DTL(p_box, p_tr);
		}		
		
		if (p_box.get("S_MODE").equals("SAV")) {
			//	�����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTC070_SAV(p_box, p_tr);
		}
		

		//EjbProxy.controlTxn(new IDTC070EJB(p_box, p_tr));
	}


}