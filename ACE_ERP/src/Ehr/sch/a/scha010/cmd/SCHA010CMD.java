package Ehr.sch.a.scha010.cmd;

import Ehr.sch.a.scha010.wrk.SCHA010WRK;

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

public class SCHA010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SCHA010WRK wrk = new SCHA010WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	������� ���ޱ��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA010_SHR(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//	��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA010_SHR_01(p_box, p_tr);
		}
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	���ڱ� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA010_SAV(p_box, p_tr);
		}
		// S_MODE�� ������ ���
		if (p_box.get("S_MODE").equals("DEL")) {
			//	���ڱ� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.SCHA010_DEL(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new SCHA010EJB(p_box, p_tr));
	}


}