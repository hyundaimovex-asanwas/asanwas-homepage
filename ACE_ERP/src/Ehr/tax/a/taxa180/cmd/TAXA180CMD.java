package Ehr.tax.a.taxa180.cmd;

import Ehr.tax.a.taxa180.wrk.TAXA180WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class TAXA180CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        TAXA180WRK wrk = new TAXA180WRK();

		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.TAXA180_SHR(p_box, p_tr);        
		}else if (p_box.get("S_MODE").equals("SHR2")) {
			wrk.TAXA180_SHR2(p_box, p_tr);  
		}
        
        //EjbProxy.controlTxn(new TAXA180EJB(p_box, p_tr));

	}

}
