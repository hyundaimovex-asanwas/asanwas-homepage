package Ehr.common.popup.codenm.cmd;

import Ehr.common.popup.codenm.wrk.CODENMWRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODENMCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODENMWRK wrk = new CODENMWRK();

		if (p_box.get("S_MODE").equals("SHR")) {

				wrk.CODENM_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_SEL")) {

				wrk.CODENM_SHR_SEL(p_box, p_tr);		
				
		}else if (p_box.get("S_MODE").equals("SHR_DOC")) {

			wrk.CODENM_SHR_DOC(p_box, p_tr);					
				
		}		
		
		//EjbProxy.controlTxn(new CODENMEJB(p_box, p_tr));
		
	}


}