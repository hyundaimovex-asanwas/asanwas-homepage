package Ehr.gun.a.guna012.cmd;

import Ehr.gun.a.guna012.wrk.GUNA012WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNA012CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA012WRK wrk = new GUNA012WRK();

		// S_MODE가 목록조회인 경우
		if (p_box.get("S_MODE").equals("SHR_LST")) {
			//	근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA012_SHR_LST(p_box, p_tr);
		}
		
		// S_MODE가 상세조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//	근태 정보를 조회하기 위한 WORK메소드 호출
			wrk.GUNA012_SHR(p_box, p_tr);
		}
		
		// S_MODE가 연차체크인인 경우
		if (p_box.get("S_MODE").equals("SHR_YRP")) {
			//	장기근태 정보를 삭제하기 위한 WORK메소드 호출
			wrk.GUNA012_YRP(p_box, p_tr);
		}		
		
		// S_MODE가 저장, 수정인 경우
		if (p_box.get("S_MODE").equals("SAV")) {
			//	근태 정보를 저장하기 위한 WORK메소드 호출
			wrk.GUNA012_SAV(p_box, p_tr);
		}
		
		// S_MODE가 삭제인인 경우
		if (p_box.get("S_MODE").equals("DEL")) {
			//	근태 정보를 삭제하기 위한 WORK메소드 호출
			wrk.GUNA012_DEL(p_box, p_tr);
		}

		//EjbProxy.controlTxn(new GUNA012EJB(p_box, p_tr));
	}


}