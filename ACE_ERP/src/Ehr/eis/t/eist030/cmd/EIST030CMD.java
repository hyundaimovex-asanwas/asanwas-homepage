package Ehr.eis.t.eist030.cmd;

import Ehr.eis.t.eist030.wrk.EIST030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EIST030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EIST030WRK wrk = new EIST030WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //��ȸ�ؿ´�. 
			wrk.EIST030_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_TEAM")) {
			 //���� ��ȸ�ؿ´�. 
			wrk.EIST030_SHR_TEAM(p_box, p_tr);
		}		
		else if (p_box.get("S_MODE").equals("SAV")) {
			 //������ �����Ѵ�. 
			wrk.EIST030_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("DEL")) {
			 //������ �����Ѵ�. 
			wrk.EIST030_DEL(p_box, p_tr);
		}        
        
        //EjbProxy.controlTxn(new EIST030EJB(p_box, p_tr));
		
 	}

}
