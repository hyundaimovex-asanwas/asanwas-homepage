package Ehr.eis.t.eist020.cmd;

import Ehr.eis.t.eist020.wrk.EIST020WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EIST020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EIST020WRK wrk = new EIST020WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //
			wrk.EIST020_SHR(p_box, p_tr);
		}
		
		else if (p_box.get("S_MODE").equals("SHR_TEAM")) {
			 //
			wrk.EIST020_SHR_TEAM(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("SHR_DAY")) {
			 //
			wrk.EIST020_SHR_DAY(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("SHR_PJT")) {
			 //
			wrk.EIST020_SHR_PJT(p_box, p_tr);
		}
		
		else if (p_box.get("S_MODE").equals("SHR_PER")) {
			 // 
			wrk.EIST020_SHR_PER(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("SAV")) {
			 //
			wrk.EIST020_SAV(p_box, p_tr);
		}
		
		else if (p_box.get("S_MODE").equals("UPT_DAY")) {
			 //
			wrk.EIST020_UPT_DAY(p_box, p_tr);
		}
		
		else if (p_box.get("S_MODE").equals("UPT_PJT")) {
			 //
			wrk.EIST020_UPT_PJT(p_box, p_tr);
		}
		
		else if (p_box.get("S_MODE").equals("UPT_PER")) {
			 //
			wrk.EIST020_UPT_PER(p_box, p_tr);
		}		
		
		
		else if (p_box.get("S_MODE").equals("DEL")) {
			 //
			wrk.EIST020_DEL(p_box, p_tr);
		}        
        
        //EjbProxy.controlTxn(new EIST020EJB(p_box, p_tr));
		
 	}

}
