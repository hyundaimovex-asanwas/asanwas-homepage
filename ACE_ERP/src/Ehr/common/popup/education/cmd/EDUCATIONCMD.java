package Ehr.common.popup.education.cmd;

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
import Ehr.common.popup.education.wrk.EDUCATIONWRK;

public class EDUCATIONCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		//EjbProxy.controlTxn(new EDUCATIONEJB(p_box, p_tr));
		
		EDUCATIONWRK wrk = new EDUCATIONWRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//	과정코드 조회
			wrk.EDUCATION_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_01")) {//1~2는 이미 사용중
			//	차수 조회
			wrk.EDUCATION_SHR_01(p_box,p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_C")) {
			//	과정코드 조회
			wrk.EDUCATION_SHR_C(p_box, p_tr);
		}
		
	}
	
}
