package Ehr.common.popup.empl2.cmd;

import java.rmi.RemoteException;

import Ehr.common.popup.empl2.wrk.EMPL2WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EMPL2CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		

		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EMPL2WRK wrk = new EMPL2WRK();		
		
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//	사원코드/명에 해당하는 부서와 직책을 조회를 위한 WORK메소드 호출
			wrk.EMPL2_SHR_01(p_box, p_tr);
		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			//	사원코드/명에 해당하는 부서와 직책을 조회(퇴사자포함)를 위한 WORK메소드 호출
			wrk.EMPL2_SHR_02(p_box, p_tr);
		}else if (p_box.get("S_MODE").equals("SHR_03")) {
			//	사원코드/명에 해당하는 부서와 직책을 조회(퇴사자포함)를 위한 WORK메소드 호출
			wrk.EMPL2_SHR_03(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new EMPL2EJB(p_box, p_tr));
		
	}

}
