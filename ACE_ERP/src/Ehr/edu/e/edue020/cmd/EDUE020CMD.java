package Ehr.edu.e.edue020.cmd;

import Ehr.edu.e.edue020.ejb.EDUE020EJB;
import Ehr.edu.e.edue020.wrk.EDUE020WRK;

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

public class EDUE020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
        //EjbProxy.controlTxn(new EDUE020EJB(p_box, p_tr));
        
        
        EDUE020WRK wrk = new EDUE020WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (p_box.get("S_MODE").equals("SHR_00")) {
			/**
			 * ����������û�� ȭ�鿡�� ȭ����½ÿ�
			 * ����������û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE020_SHR_00(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			/**
			 * ����������û�� ȭ�鿡�� �����ư Ŭ���� ��
			 * ����������û�� �������θ� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE020_SHR_01(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			/**
			 * ����������û�� ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * ����������û�� �����͸� �����Ѵ�. 
			 */
			wrk.EDUE020_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("STS")) {
			/**
			 * ����������û�� ȭ�鿡�� ���¸� ������ ��,
			 * ���� ���¸� �����Ѵ�. 
			 */
			wrk.EDUE020_UPT_00(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("DEL")) {
			/**
			 * ����������û�� ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * ����������û�� �����͸� �����Ѵ�. 
			 */
			wrk.EDUE020_DEL(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("PROC")) {
			/**
			 * ����������û�� ȭ�鿡�� ���� �� ��,
			 * ������ �����Ѵ�. 
			 */
			wrk.EDUE020_PROC(p_box, p_tr);
		}
		
 	}

}
