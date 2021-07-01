package Ehr.common.popup.lctr.cmd;

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
import Ehr.common.popup.lctr.ejb.LCTREJB;
import Ehr.common.popup.lctr.wrk.LCTRWRK;

public class LCTRCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		//EjbProxy.controlTxn(new LCTREJB(p_box, p_tr));
		LCTRWRK wrk = new LCTRWRK();
		if (p_box.get("S_MODE").equals("SHR")) {
			//	평가구조설정내용 조회를 위한 WORK메소드 호출
			wrk.LCTR_SHR(p_box, p_tr);
		}
		
	}

}
