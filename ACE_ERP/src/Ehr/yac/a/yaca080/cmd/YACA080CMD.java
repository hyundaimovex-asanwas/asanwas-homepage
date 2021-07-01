package Ehr.yac.a.yaca080.cmd;

import Ehr.yac.a.yaca080.wrk.YACA080WRK;

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

public class YACA080CMD implements AbstractGauceCMD {

	/**
	 *데이타유효성체크 command class
	 *조회, 저장, 삭제에 사용
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		YACA080WRK wrk = new YACA080WRK();

		/** 조회 **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.YACA080_SHR(p_box, p_tr);
		}		
		
		if (p_box.get("S_MODE").equals("SHR_15")) {
			wrk.YACA080_SHR_15(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new YACA080EJB(p_box, p_tr));

	}

}
