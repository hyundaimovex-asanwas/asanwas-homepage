package Ehr.edu.e.edue041.cmd;


import java.rmi.RemoteException;

import Ehr.edu.e.edue041.wrk.EDUE041WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.proxy.EjbProxy;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EDUE041CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		//EjbProxy.controlTxn(new EDUE041EJB(p_box, p_tr));
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EDUE041WRK wrk = new EDUE041WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.EDUE041_SHR(p_box,p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT") ) {

			wrk.EDUE041_SHR_PRINT(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT2") ) {

			wrk.EDUE041_SHR_PRINT2(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SAV") ) {

			wrk.EDUE041_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV01") ) {

			wrk.EDUE041_SAV(p_box, p_tr);
		}
	}

}
