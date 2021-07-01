package Ehr.acq.a.acqa001.cmd;

import Ehr.acq.a.acqa001.wrk.ACQA001WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class ACQA001CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res, TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		ACQA001WRK wrk = new ACQA001WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.ACQA001_SHR(p_box, p_tr);
		}
		
		// S_MODE가 결재선 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_APP")) {

			wrk.ACQA001_SHR_APP(p_box, p_tr);
		}		
		
		// S_MODE가 저장, 수정인 경우
		if (p_box.get("S_MODE").equals("SAV")) {

			wrk.ACQA001_SAV(p_box, p_tr);
		}

		// S_MODE가 결재선 저장, 수정인 경우
		if (p_box.get("S_MODE").equals("SAV_APP")) {

			wrk.ACQA001_SAV_APP(p_box, p_tr);
		}
		
		// S_MODE가 상신인 경우
		if (p_box.get("S_MODE").equals("SAV_SUBMIT")) {

			wrk.ACQA001_SAV_SUB(p_box, p_tr);
		}		
		
		// S_MODE가 삭제인 경우
		if (p_box.get("S_MODE").equals("DEL")) {

			wrk.ACQA001_DEL(p_box, p_tr);
		}		
		
		
		
	}

}