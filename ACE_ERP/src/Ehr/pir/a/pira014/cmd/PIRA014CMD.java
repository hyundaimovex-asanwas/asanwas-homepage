package Ehr.pir.a.pira014.cmd;

import Ehr.pir.a.pira014.wrk.PIRA014WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class PIRA014CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA014WRK wrk = new PIRA014WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (p_box.get("S_MODE").equals("SHR")) {
			
			wrk.PIRA014_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.PIRA014_SAV(p_box, p_tr);
			
		}        
        
        //EjbProxy.controlTxn(new PIRA014EJB(p_box, p_tr));
		
 	}

}
