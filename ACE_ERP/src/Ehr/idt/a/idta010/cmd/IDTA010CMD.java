package Ehr.idt.a.idta010.cmd;

import Ehr.idt.a.idta010.wrk.IDTA010WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class IDTA010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTA010WRK wrk = new IDTA010WRK();
		
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	�����߱�ó�� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��(�μ��)
			wrk.IDTA010_SHR(p_box, p_tr);
		}

		if (p_box.get("S_MODE").equals("SAV")) {
			//	�����߱�ó�� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA010_SAV_TEMP(p_box, p_tr);
		}
		
		if (p_box.get("S_MODE").equals("PROC")) {
		    //	�����߱�ó�� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.IDTA010_PROC(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new IDTA010EJB(p_box, p_tr));
	}


}