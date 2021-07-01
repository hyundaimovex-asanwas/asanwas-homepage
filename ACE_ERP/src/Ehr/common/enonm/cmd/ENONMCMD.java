package Ehr.common.enonm.cmd;

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
import Ehr.common.enonm.wrk.ENONMWRK;

public class ENONMCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res, TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		ENONMWRK wrk = new ENONMWRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (p_box.get("S_MODE").equals("SHR")) {
			/**
			 * ����� �Է��ϸ� �ش� ������� ��ȸ�ؿ´�.
			 */
			wrk.ENONM_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			/**
			 * ���� �Է��ϸ� �ش� ����� ��ȸ�ؿ´�.
			 */
			wrk.ENONM_SHR_01(p_box, p_tr);
		}        
        
        
        //EjbProxy.controlTxn(new ENONMEJB(p_box, p_tr));
		
 	}

}
