package Ehr.edu.e.edue032.cmd;

import Ehr.edu.e.edue032.wrk.EDUE032WRK;

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

public class EDUE032CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
        //EjbProxy.controlTxn(new EDUE032EJB(p_box, p_tr));
		
        EDUE032WRK wrk = new EDUE032WRK();
        
        if (p_box.get("S_MODE").equals("SHR")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_ED")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_SHR_ED(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("DEL")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_DEL(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("APP")) {
			/**
			 * ��ܰ��¿�û�� ȭ�鿡�� ��ȸ��ư�� Ŭ���� ��,
			 * ��ܰ��¿�û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE032_APP(p_box, p_tr);
		}
        
        
        
 	}

}
