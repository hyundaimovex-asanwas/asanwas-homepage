package Ehr.sag.a.saga260.cmd;

import Ehr.sag.a.saga260.wrk.SAGA260WRK;

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

public class SAGA260CMD implements AbstractGauceCMD {

	/**
	 *급상여지급현황 command class
	 *조회, 저장, 삭제에 사용
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		SAGA260WRK wrk = new SAGA260WRK();

		/** MASTER 조회 **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGA260_SHR(p_box, p_tr);
		}
		/** DETAIL 조회 **/
		if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGA260_SHR_01(p_box, p_tr);
		}

		/** DETAIL 조회 **/
		if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.SAGA260_SHR_02(p_box, p_tr);
		}

		/** DETAIL 조회 **/
		if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGA260_SHR_PRINT(p_box, p_tr);
		}

		/** MASTER 저장 **/
		if (p_box.get("S_MODE").equals("SAV")) {
			wrk.SAGA260_SAV(p_box, p_tr);
		}

		/** DETAIL 저장 **/
		if (p_box.get("S_MODE").equals("SAV_01")) {
			wrk.SAGA260_SAV_01(p_box, p_tr);
		}
		/** DELAY 저장 **/
		if (p_box.get("S_MODE").equals("SAV_DELAY")) {
			wrk.SAGA260_SAV_DELAY(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new SAGA260EJB(p_box, p_tr));

	}

}
