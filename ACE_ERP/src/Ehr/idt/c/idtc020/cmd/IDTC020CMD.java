package Ehr.idt.c.idtc020.cmd;

import Ehr.idt.c.idtc020.wrk.IDTC020WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class IDTC020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTC020WRK wrk = new IDTC020WRK();
		
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTC020_SHR(p_box, p_tr);
		}
		
		
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_WEEK")) {
			//	���� ��� ���� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTC020_SHR_WEEK(p_box, p_tr);
		}
		

		if (p_box.get("S_MODE").equals("SAV")) {
			//	�����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTC020_SAV(p_box, p_tr);
		}
		

		//EjbProxy.controlTxn(new IDTC020EJB(p_box, p_tr));
	}


}