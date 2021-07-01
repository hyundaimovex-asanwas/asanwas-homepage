package Ehr.vlu.k.vluk070.cmd;

import Ehr.vlu.k.vluk070.wrk.VLUK070WRK;

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

public class VLUK070CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		VLUK070WRK wrk = new VLUK070WRK();

		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUK070_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUK070_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV")) {
            wrk.VLUK070_SAV(p_box, p_tr);
		}        
        
        
        //EjbProxy.controlTxn(new VLUK070EJB(p_box, p_tr));

	}

}
