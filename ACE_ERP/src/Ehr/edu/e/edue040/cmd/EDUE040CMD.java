package Ehr.edu.e.edue040.cmd;

import Ehr.edu.e.edue040.wrk.EDUE040WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EDUE040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		EDUE040WRK wrk = new EDUE040WRK();
		
		if (p_box.get("S_MODE").equals("SHR")) {
			
			//근태현황 결재처리 조회를 위한 WORK메소드 호출
			wrk.EDUE040_SHR(p_box, p_tr);
			
		}
		
		//EjbProxy.controlTxn(new EDUE040EJB(p_box, p_tr));
		
	}

}
