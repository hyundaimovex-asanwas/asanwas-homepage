package Ehr.sag.d.sagd040.cmd;

import java.rmi.RemoteException;

import Ehr.sag.d.sagd040.wrk.SAGD040WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGD040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGD040WRK wrk = new SAGD040WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//개인별 수당 조회를 위한 WORK메소드 호출
			wrk.SAGD040_SHR(p_box, p_tr);
		}

		// S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV")) {
			//개인별 수당을 저장, 수정하기 위한 WORK메소드 호출
			wrk.SAGD040_SAV(p_box, p_tr);
		}

        // S_MODE가 삭제인 경우
		else if (p_box.get("S_MODE").equals("DEL")) {
			//개인별 수당을 삭제하기 위한 WORK메소드 호출
			wrk.SAGD040_DEL(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new SAGD040EJB(p_box, p_tr));
	}

}
