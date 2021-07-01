package Ehr.gun.a.guna100.cmd;

import Ehr.gun.a.guna100.wrk.GUNA100WRK;

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

public class GUNA100CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA100WRK wrk = new GUNA100WRK();

		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (p_box.get("S_MODE").equals("SHR")) {

			 //���κ� ���� ���� ��Ȳ�� ��ȸ�ؿ´�.
			wrk.GUNA100_SHR(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			 //���κ� ���� ���� ��Ȳ 
			wrk.GUNA100_SHR_02(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV")) {
			 //���κ� ���� ���� ��Ȳ ����
			wrk.GUNA100_SAV(p_box, p_tr);

		}        
        
        //EjbProxy.controlTxn(new GUNA100EJB(p_box, p_tr));
		
 	}

}
