package Ehr.cdp.a.book020.cmd;

import Ehr.cdp.a.book020.ejb.BOOK020EJB;

import java.rmi.RemoteException;

import Ehr.cdp.a.book020.wrk.BOOK020WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.proxy.EjbProxy;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class BOOK020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);


		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		//EjbProxy.controlTxn(new BOOK020EJB(p_box, p_tr));
		
		BOOK020WRK wrk = new BOOK020WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//도서구입신청을 조회를 위한 WORK메소드 호출
			wrk.BOOK020_SHR(p_box, p_tr);
		}
	}

}
