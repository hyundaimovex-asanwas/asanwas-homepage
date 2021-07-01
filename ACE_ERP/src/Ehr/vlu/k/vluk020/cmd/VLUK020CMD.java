package Ehr.vlu.k.vluk020.cmd;

import Ehr.vlu.k.vluk020.wrk.VLUK020WRK;

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

public class VLUK020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		System.out.println(p_box);
		
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		VLUK020WRK wrk = new VLUK020WRK();

		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUK020_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV")) {
            wrk.VLUK020_SAV(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("DEL")) {
            wrk.VLUK020_DEL(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_DPT")) {
            wrk.VLUK020_SHR_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_DPT")) {
            wrk.VLUK020_SAV_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("DEL_DPT")) {
            wrk.VLUK020_DEL_DPT(p_box, p_tr);            
		}


        //EjbProxy.controlTxn(new VLUK020EJB(p_box, p_tr));

	}

}
