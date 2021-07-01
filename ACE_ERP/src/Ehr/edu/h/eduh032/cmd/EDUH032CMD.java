package Ehr.edu.h.eduh032.cmd;

import Ehr.edu.h.eduh032.wrk.EDUH032WRK;

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

public class EDUH032CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
        //EjbProxy.controlTxn(new EDUH032EJB(p_box, p_tr));
        
        EDUH032WRK wrk = new EDUH032WRK();

		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.EDUH032_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.EDUH032_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_CHASU")) {
		    wrk.EDUH032_SHR_CHASU(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("NEW")){
			wrk.EDUH032_SHR_NEW(p_box, p_tr);

		}
		
 	}

}
