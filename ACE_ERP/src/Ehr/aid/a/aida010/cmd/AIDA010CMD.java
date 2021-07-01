package Ehr.aid.a.aida010.cmd;

import Ehr.aid.a.aida010.wrk.AIDA010WRK;

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

public class AIDA010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		/** System.out.println(p_box); **/
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		AIDA010WRK wrk = new AIDA010WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//	경공조금 지급기준 정보 조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//	사원 및 지급내역에 따른 경공조금 정보 조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR_01(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_02")) {
			//	권한 조회
			wrk.AIDA010_SHR_02(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_03")) {
			//	신청자에 해당하는 지급금액  조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR_03(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_04")) {
			//	신청번호(REQ_NO)에 해당하는 신청서  조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR_04(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_06")) {
			//	사원 및 지급내역에 따른 경공조금 정보 조회를 위한 WORK메소드 호출
			wrk.AIDA010_SHR_06(p_box, p_tr);
		}
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_LSE")) {
		    //	근속년수를 조회해 온다.
		    wrk.AIDA010_SHR_LSE(p_box, p_tr);
		}
		
		// S_MODE가 프린트인 경우
		if (p_box.get("S_MODE").equals("SHR_PRINT0")) {
		    //	
		    wrk.AIDA010_SHR_PRINT0(p_box, p_tr);
		}				
		
		// S_MODE가 프린트인 경우
		if (p_box.get("S_MODE").equals("SHR_PRINT")) {
		    //	
		    wrk.AIDA010_SHR_PRINT(p_box, p_tr);
		}		
		
		// S_MODE가 저장, 수정인 경우
		if (p_box.get("S_MODE").equals("SAV")) {
			//	경공조금 신청서를 저장하기 위한 WORK메소드 호출
			wrk.AIDA010_SAV(p_box, p_tr);
		}
		// S_MODE가 저장, 수정인 경우
		if (p_box.get("S_MODE").equals("SAV_01")) {
			//	경공조금 신청서를 수정하고, 결재정보를 저장하기 위한 WORK메소드 호출
			wrk.AIDA010_SAV_01(p_box, p_tr);
		}
		// S_MODE가 삭제인 경우
		if (p_box.get("S_MODE").equals("DEL")) {
			//	경공조금 지급기준 정보를 저장하기 위한 WORK메소드 호출
			wrk.AIDA010_DEL(p_box, p_tr);
		}

		// S_MODE가 전표처리인 경우
		if (p_box.get("S_MODE").equals("PROC_D")) {
		    //	경공조금 지급기준 정보를 저장하기 위한 WORK메소드 호출
		    wrk.PROC_D(p_box, p_tr);
		}
        // S_MODE가 지급처리인 경우
		if (p_box.get("S_MODE").equals("PROC_E")) {
		    //	경공조금 지급기준 정보를 저장하기 위한 WORK메소드 호출
		    wrk.PROC_E(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new AIDA010EJB(p_box, p_tr));
	}


}