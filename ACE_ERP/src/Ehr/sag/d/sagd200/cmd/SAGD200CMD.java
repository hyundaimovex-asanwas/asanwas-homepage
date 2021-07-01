package Ehr.sag.d.sagd200.cmd;


import java.rmi.RemoteException;

import Ehr.sag.d.sagd200.wrk.SAGD200WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGD200CMD implements AbstractGauceCMD {

	/**
	 *급여테이블 command class
	 *조회, 저장, 삭제에 사용
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGD200WRK wrk = new SAGD200WRK();

		/** 조회 **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGD200_SHR(p_box, p_tr);
		}

		/** 소급분 조회 **/
		else if (p_box.get("S_MODE").equals("SHR_SO")) {
			wrk.SAGD200_SHR_SO(p_box, p_tr);
		}

		/** 적용일자 조회 **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGD200_SHR_01(p_box, p_tr);
		}

		/** 적용일자 조회 **/
		else if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGD200_SHR_PRINT(p_box, p_tr);
		}

		//EjbProxy.controlTxn(new SAGD200EJB(p_box, p_tr));

	}

}
