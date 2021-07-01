package Ehr.gun.e.gune010.cmd;

import Ehr.gun.e.gune010.wrk.GUNE010WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNE010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNE010WRK wrk = new GUNE010WRK();
		
		// S_MODE가 자동결재선체크인 경우
		if (p_box.get("S_MODE").equals("SHR_APP")) {
			
			//	자동 결재선 체크를 위한 WORK메소드 호출
			//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
			//System.out.print(p_box);				
			
			wrk.GUNE010_SHR_APP(p_box, p_tr);
		}
		
		// S_MODE가 주차확인인 경우
		if (p_box.get("S_MODE").equals("SHR_WK")) {
			//	주차 확인을 위한 WORK메소드 호출
			wrk.GUNE010_SHR_WK(p_box, p_tr);
		}
		
		// S_MODE가 당월 연장근무 누적시간 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_ACC")) {
			//	연장근무 누적시간 조회를 위한 WORK메소드 호출
			wrk.GUNE010_SHR_ACC(p_box, p_tr);
		}
		
		// S_MODE가 당월 연장근무 등록가능일자를 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_OTD")) {
			//	연장근무 누적시간 조회를 위한 WORK메소드 호출
			wrk.GUNE010_SHR_OTD(p_box, p_tr);
		}
		
		// S_MODE가 신청번호 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_MAX")) {
			//	주차 확인을 위한 WORK메소드 호출
			wrk.GUNE010_SHR_MAX(p_box, p_tr);
		}
		
		// S_MODE가 상신인 경우
		if (p_box.get("S_MODE").equals("UPT_APP")) {
			//	연장근무 정보를 상신하기 위한 WORK메소드 호출
			wrk.GUNE010_UPT_APP(p_box, p_tr);
		}
		
		// S_MODE가 SMS인 경우
		if (p_box.get("S_MODE").equals("SMS_TRANS")) {
			//	SMS 보내기 위한 WORK메소드 호출
			//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
			//System.out.print(p_box);			
			
			wrk.GUNE010_SMS(p_box, p_tr);
		}
		
	
		
		//EjbProxy.controlTxn(new GUNA012EJB(p_box, p_tr));
	}


}