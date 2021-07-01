package Ehr.but.a.buta021.cmd;

import Ehr.but.a.buta021.wrk.BUTA021WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;

import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class BUTA021CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		BUTA021WRK wrk = new BUTA021WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {

				wrk.BUTA021_SHR(p_box, p_tr);		
		
		}else if (p_box.get("S_MODE").equals("SHR_01")) {

				wrk.BUTA021_SHR_01(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			
				wrk.BUTA021_SHR_02(p_box, p_tr);
				
		}else if (p_box.get("S_MODE").equals("SHR_03")) {

				wrk.BUTA021_SHR_03(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_04")) {

				wrk.BUTA021_SHR_04(p_box, p_tr);		

		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.BUTA021_SAV(p_box, p_tr);

		}		
		
		//EjbProxy.controlTxn(new BUTA021EJB(p_box, p_tr));
	}

}
