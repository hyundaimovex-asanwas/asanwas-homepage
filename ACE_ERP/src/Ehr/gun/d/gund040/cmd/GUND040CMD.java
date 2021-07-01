package Ehr.gun.d.gund040.cmd;

import Ehr.gun.d.gund040.wrk.GUND040WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUND040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUND040WRK wrk = new GUND040WRK();

		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (p_box.get("S_MODE").equals("SHR")) {

			 //���κ� ���� ���� ��Ȳ�� ��ȸ�ؿ´�.
			wrk.GUND040_SHR(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			
			 //���κ� ���� ���� ��Ȳ 
			wrk.GUND040_SHR_02(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_03")) {

			 //���κ� ���� ���� ��Ȳ 
			wrk.GUND040_SHR_03(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			
			 //���κ� ���� ���� ��Ȳ ����
			wrk.GUND040_SAV(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("UPT_END")) {
			
			 //���κ� ���� ���� ��Ȳ ����
			wrk.GUND040_UPT_END(p_box, p_tr);
			
		}        
        
        //EjbProxy.controlTxn(new GUND040EJB(p_box, p_tr));
		
 	}

}
