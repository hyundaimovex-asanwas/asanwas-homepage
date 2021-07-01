package Ehr.wel.n.weln030.cmd;


import Ehr.wel.n.weln030.wrk.WELN030WRK;

import java.rmi.RemoteException;


import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class WELN030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		WELN030WRK wrk = new WELN030WRK();


		// S_MODE가 조회, 저장, 수정인 경우
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.WELN030_SHR(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.WELN030_SAV(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV_01")) {

			wrk.WELN030_SAV_01(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV_END")) {

			wrk.WELN030_SAV_END(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("ULD")) {

		    wrk.WELN030_ULD(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("DEL")) {

		    wrk.WELN030_DEL(p_box, p_tr);

		}        
        
        //EjbProxy.controlTxn(new WELN030EJB(p_box, p_tr));

 	}

}
