package Ehr.cdp.a.book011.cmd;

import Ehr.cdp.a.book011.ejb.BOOK011EJB;
import Ehr.cdp.a.book011.wrk.BOOK011WRK;

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

public class BOOK011CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,

			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		//EjbProxy.controlTxn(new BOOK011EJB(p_box, p_tr));
		
		BOOK011WRK wrk = new BOOK011WRK();

		if(p_box.get("S_MODE").equals("UPT_APP")) {

			wrk.BOOK011_UPT_APP(p_box, p_tr);

		} else if(p_box.get("S_MODE").equals("UPT_REJ")) {

			wrk.BOOK011_UPT_REJ(p_box, p_tr);

		} else if(p_box.get("S_MODE").equals("UPT_DETAIL")) {

			wrk.BOOK011_UPT_DETAIL(p_box, p_tr);

		} else if(p_box.get("S_MODE").equals("SAV_APP")) {

			wrk.BOOK011_SAV_APP(p_box, p_tr);

		}
		
	}

}
