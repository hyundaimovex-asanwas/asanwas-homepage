package Ehr.gun.d.gund020.cmd;

import Ehr.gun.d.gund020.wrk.GUND020WRK;

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

public class GUND020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUND020WRK wrk = new GUND020WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//연차휴가사용촉진제 조회를 위한 WORK메소드 호출
			wrk.GUND020_SHR(p_box, p_tr);
		}
		// S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			//연차휴가사용촉진제를 수정하기 위한 WORK메소드 호출
			wrk.GUND020_SHR_01(p_box, p_tr);
		}
		// S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV")) {
			//연차휴가사용촉진제를 수정하기 위한 WORK메소드 호출
			wrk.GUND020_SAV(p_box, p_tr);
		}
        // S_MODE가  상신인 경우
        else if (p_box.get("S_MODE").equals("REP")) {
           //최종입력 flag값을 확정해주기위한 WORK메소드 호출
           wrk.GUND020_REP(p_box, p_tr);
       }		
		
		//EjbProxy.controlTxn(new GUND020EJB(p_box, p_tr));
	}

}
