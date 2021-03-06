package Ehr.gun.a.guna018.cmd;

import Ehr.gun.a.guna018.wrk.GUNA018WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNA018CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNA018WRK wrk = new GUNA018WRK();

		/** S_MOD : SHR(조회), SAV(저장) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //개인별 근태 현황을 조회해온다.
			wrk.GUNA018_SHR(p_box, p_tr);
		}

		/** S_MOD : SHR(조회), SAV(저장) */
		if (p_box.get("S_MODE").equals("SAV")) {
			 //개인별 근태 현황을 조회해온다.
			wrk.GUNA018_UPT(p_box, p_tr);
		}        
        
        //EjbProxy.controlTxn(new GUNA018EJB(p_box, p_tr));

 	}

}
