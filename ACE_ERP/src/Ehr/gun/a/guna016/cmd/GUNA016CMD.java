package Ehr.gun.a.guna016.cmd;

import Ehr.gun.a.guna016.wrk.GUNA016WRK;

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

public class GUNA016CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA016WRK wrk = new GUNA016WRK();
		
		// S_MODE�� �����ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	������ ������ ��ȸ�ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA016_SHR(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new GUNA016EJB(p_box, p_tr));
	}


}