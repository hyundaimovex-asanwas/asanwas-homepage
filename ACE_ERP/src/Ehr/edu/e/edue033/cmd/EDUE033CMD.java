package Ehr.edu.e.edue033.cmd;

import Ehr.edu.e.edue033.ejb.EDUE033EJB;
import Ehr.edu.e.edue033.wrk.EDUE033WRK;

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

public class EDUE033CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
        //EjbProxy.controlTxn(new EDUE033EJB(p_box, p_tr));
        
        
        EDUE033WRK wrk = new EDUE033WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.EDUE033_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.EDUE033_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("NEW")){
			wrk.EDUE033_SHR_NEW(p_box, p_tr);
		}
        
		
 	}

}