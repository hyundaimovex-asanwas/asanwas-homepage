package Ehr.edu.e.edue021.cmd;

import Ehr.edu.e.edue021.ejb.EDUE021EJB;
import Ehr.edu.e.edue021.wrk.EDUE021WRK;

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

public class EDUE021CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
        //EjbProxy.controlTxn(new EDUE021EJB(p_box, p_tr));
        
        EDUE021WRK wrk = new EDUE021WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (p_box.get("S_MODE").equals("SHR")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE021_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE021_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("DEL")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE021_DEL(p_box, p_tr);
		}

		
 	}

}
