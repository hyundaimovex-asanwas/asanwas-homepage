package Ehr.gun.f.gunf080.cmd;

import Ehr.gun.f.gunf080.wrk.GUNF080WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNF080CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUNF080WRK wrk = new GUNF080WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//조회를 위한 WORK메소드 호출
			wrk.GUNF080_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_01")) {
			//조회를 위한 WORK메소드 호출
			wrk.GUNF080_SHR_01(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_DTL")) {
			//조회를 위한 WORK메소드 호출
			wrk.GUNF080_SHR_DTL(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_APP")) {
			//결재선 조회를 위한 WORK메소드 호출
			wrk.GUNF080_SHR_APP(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_MAX")) {
			//월별 상신 결재 번호 조회를 위한 WORK메소드 호출
			wrk.GUNF080_SHR_MAX(p_box, p_tr);				

		}else if (p_box.get("S_MODE").equals("SHR_MAX2")) {
			//개별 상신 결재 번호 조회를 위한 WORK메소드 호출
			wrk.GUNF080_SHR_MAX2(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SHR_REQ")) {
			//조회를 위한 WORK메소드 호출
			wrk.GUNF080_SHR_REQ(p_box, p_tr);						
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			//조회를 위한 WORK메소드 호출
			wrk.GUNF080_SAV(p_box, p_tr);	
			
		}else if (p_box.get("S_MODE").equals("UPT_APP")) {
			//월별 결재상신을 위한 WORK메소드 호출
			wrk.GUNF080_UPT_APP(p_box, p_tr);		
			
		}else if (p_box.get("S_MODE").equals("UPT_APP_EACH")) {
			//개별 결재상신을 위한 WORK메소드 호출
			wrk.GUNF080_UPT_APP_EACH(p_box, p_tr);					
		}
		
	}

}
