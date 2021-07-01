package Ehr.cod.e.code020.cmd;

import Ehr.cod.e.code020.wrk.CODE020WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODE020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        CODE020WRK wrk = new CODE020WRK();

		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR_01")) {
			 //�Ϸù�ȣ�� ��ȸ�ؿ´�.
			wrk.CODE020_SHR_01(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			 //�������� ������û�� ��ȸ�ؿ´�.
			wrk.CODE020_SHR_02(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_03")) {
			 //�Ϸù�ȣ�� ��ȸ�ؿ´�.
			wrk.CODE020_SHR_03(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			 //�������� ������û�� �����Ѵ�.
			wrk.CODE020_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("DEL")) {
			 //�������� ������û�� �����Ѵ�.
			wrk.CODE020_DEL(p_box, p_tr);
		}        
        
        //EjbProxy.controlTxn(new PIRC060EJB(p_box, p_tr));
		
 	}

}
