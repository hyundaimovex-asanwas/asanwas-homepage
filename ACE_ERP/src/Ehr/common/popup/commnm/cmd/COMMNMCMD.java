package Ehr.common.popup.commnm.cmd;

import Ehr.common.popup.commnm.wrk.COMMNMWRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class COMMNMCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/	
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		//System.out.println("p_box2=================="+p_box);
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		COMMNMWRK wrk = new COMMNMWRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//	공통 정보 조회를 위한 WORK메소드 호출
			wrk.COMMNM_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_03")) {//1~2는 이미 사용중
			//	공통 정보 조회를 위한 WORK메소드 호출
			wrk.COMMNM_SHR_03(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new COMMNMEJB(p_box, p_tr));
	}


}