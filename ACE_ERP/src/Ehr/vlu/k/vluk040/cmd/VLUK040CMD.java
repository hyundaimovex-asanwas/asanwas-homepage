package Ehr.vlu.k.vluk040.cmd;

import Ehr.vlu.k.vluk040.wrk.VLUK040WRK;

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

public class VLUK040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

        
		VLUK040WRK wrk = new VLUK040WRK();

		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUK040_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUK040_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV")) {
            wrk.VLUK040_SAV(p_box, p_tr);
		}
        
        //EjbProxy.controlTxn(new VLUK040EJB(p_box, p_tr));

	}

}
