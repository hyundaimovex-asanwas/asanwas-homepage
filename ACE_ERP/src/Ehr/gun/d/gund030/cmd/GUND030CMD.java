package Ehr.gun.d.gund030.cmd;

import Ehr.gun.d.gund030.wrk.GUND030WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUND030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUND030WRK wrk = new GUND030WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//연차발생관리를 조회를 위한 WORK메소드 호출
			wrk.GUND030_SHR(p_box, p_tr);
		}
		// S_MODE가 일괄생성인 경우
		else if (p_box.get("S_MODE").equals("INS")) {
			//연차발생관리를 생성하기 위한 WORK메소드 호출
			wrk.GUND030_INS(p_box, p_tr);
		}

		// S_MODE가 재생성인 경우
		else if (p_box.get("S_MODE").equals("UPT")) {
			//연차발생관리를 생성하기 위한 WORK메소드 호출
			wrk.GUND030_UPT(p_box, p_tr);
		}

		//저장 미사용
		// S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV")) {
			//연차발생관리를 수정하기 위한 WORK메소드 호출
			wrk.GUND030_SAV(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new GUND030EJB(p_box, p_tr));
	}

}
