package Ehr.edu.e.edue040.cmd;

import Ehr.edu.e.edue040.wrk.EDUE040WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EDUE040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		EDUE040WRK wrk = new EDUE040WRK();
		
		if (p_box.get("S_MODE").equals("SHR")) {
			
			//������Ȳ ����ó�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.EDUE040_SHR(p_box, p_tr);
			
		}
		
		//EjbProxy.controlTxn(new EDUE040EJB(p_box, p_tr));
		
	}

}
