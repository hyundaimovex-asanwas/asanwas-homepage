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

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
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
