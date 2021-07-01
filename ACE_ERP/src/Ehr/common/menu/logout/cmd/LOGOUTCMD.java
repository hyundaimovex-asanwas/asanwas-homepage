package common.menu.logout.cmd;

import java.rmi.RemoteException;

import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;

public class LOGOUTCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		p_req.getSession().invalidate();
		GauceDataSet ds = new GauceDataSet();
		ds.put("LOG_STATUS", "out", 10);
		p_tr.sendDataSet(ds);

	}

}
