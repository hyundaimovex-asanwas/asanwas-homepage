package Ehr.sch.a.scha090.cmd;

import Ehr.sch.a.scha090.wrk.SCHA090WRK;

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

public class SCHA090CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SCHA090WRK wrk = new SCHA090WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //���ڱ� ��û�Ⱓ ������ ��ȸ�ؿ´�. 
			wrk.SCHA090_SHR(p_box, p_tr);
		}
		
		else if (p_box.get("S_MODE").equals("SHR2")) {
			 //���ڱ� ��û�Ⱓ ������ �����Ѵ�. 
			wrk.SCHA090_SHR2(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("SAV")) {
			 //���ڱ� ��û�Ⱓ ������ �����Ѵ�. 
			wrk.SCHA090_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("DEL")) {
			 //���ڱ� ��û�Ⱓ ������ �����Ѵ�. 
			wrk.SCHA090_DEL(p_box, p_tr);
		}        
        
        //EjbProxy.controlTxn(new SCHA090EJB(p_box, p_tr));
		
 	}

}
