package Ehr.pir.a.pira025.cmd;

import Ehr.pir.a.pira025.wrk.PIRA025WRK;

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

public class PIRA025CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA025WRK wrk = new PIRA025WRK();

		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.PIRA025_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.PIRA025_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("DEL")) {

			wrk.PIRA025_DEL(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_01")) {

			wrk.PIRA025_SHR_01(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_01")) {

			wrk.PIRA025_SAV_01(p_box, p_tr);
		}        
        
        //EjbProxy.controlTxn(new PIRA025EJB(p_box, p_tr));
		
 	}

}
