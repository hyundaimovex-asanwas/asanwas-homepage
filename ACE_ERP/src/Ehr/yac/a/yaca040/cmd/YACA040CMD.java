package Ehr.yac.a.yaca040.cmd;

import Ehr.yac.a.yaca040.wrk.YACA040WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		YACA040WRK wrk = new YACA040WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//기부금공제내역 조회를 위한 WORK메소드 호출
			wrk.YACA040_SHR(p_box, p_tr);
		}

		//	S_MODE가 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR_05")) {
			//기부금공제내역 조회를 위한 WORK메소드 호출
			wrk.YACA040_SHR_05(p_box, p_tr);
		}
		
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_14")) {
			//기부금공제내역 조회를 위한 WORK메소드 호출
			wrk.YACA040_SHR_14(p_box, p_tr);
		}
		
        //		S_MODE가 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR_15")) {
			//기부금공제내역 조회를 위한 WORK메소드 호출
			wrk.YACA040_SHR_15(p_box, p_tr);
		}		

		//	S_MODE가 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR2_14")) {
			//기부금공제내역 조회를 위한 WORK메소드 호출
			wrk.YACA040_SHR2_14(p_box, p_tr);
		}	
		
		//	S_MODE가 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR2_15")) {
			//기부금공제내역 조회를 위한 WORK메소드 호출
			wrk.YACA040_SHR2_15(p_box, p_tr);
		}	
		
		

		// S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV")) {
			//기부금공제내역을 저장하기 위한 WORK메소드 호출
			wrk.YACA040_SAV(p_box, p_tr);
		}

		// S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV_14")) {
			//기부금공제내역을 저장하기 위한 WORK메소드 호출
			wrk.YACA040_SAV1_14(p_box, p_tr);
			wrk.YACA040_SAV2_14(p_box, p_tr);
			wrk.YACA040_SAV3_14(p_box, p_tr);	
			wrk.YACA040_SAV4_14(p_box, p_tr);			
		}		
		
		// S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV_15")) {
			//기부금공제내역을 저장하기 위한 WORK메소드 호출
			wrk.YACA040_SAV1_15(p_box, p_tr);
			wrk.YACA040_SAV2_15(p_box, p_tr);
			wrk.YACA040_SAV3_15(p_box, p_tr);	
			wrk.YACA040_SAV4_15(p_box, p_tr);			
		}		
		
        // S_MODE가 삭제인 경우
		else if (p_box.get("S_MODE").equals("DEL")) {
			//기부금공제내역을 삭제하기 위한 WORK메소드 호출
			wrk.YACA040_DEL(p_box, p_tr);
		}
		
        // S_MODE가 삭제인 경우
		else if (p_box.get("S_MODE").equals("DEL_14")) {
			//기부금공제내역을 삭제하기 위한 WORK메소드 호출
			wrk.YACA040_DEL_14(p_box, p_tr);
		}	
		
		// S_MODE가 삭제인 경우
		else if (p_box.get("S_MODE").equals("DEL_15")) {
			//기부금공제내역을 삭제하기 위한 WORK메소드 호출
			wrk.YACA040_DEL_15(p_box, p_tr);
		}	

		//	S_MODE가 삭제인 경우
		else if (p_box.get("S_MODE").equals("ACC")) {
			//기부금공제내역을 삭제하기 위한 WORK메소드 호출
			wrk.YACA040_UPT_ACC(p_box, p_tr);
		}		
		
		//	S_MODE가 삭제인 경우
		else if (p_box.get("S_MODE").equals("ACC_14")) {
			//기부금공제내역을 삭제하기 위한 WORK메소드 호출
			wrk.YACA040_UPT_FAM_14(p_box, p_tr);
			wrk.YACA040_UPT_ACC_14(p_box, p_tr);			
		}			
		
//		S_MODE가 삭제인 경우
		else if (p_box.get("S_MODE").equals("ACC_15")) {
			//기부금공제내역을 삭제하기 위한 WORK메소드 호출
			wrk.YACA040_UPT_FAM_15(p_box, p_tr);
			wrk.YACA040_UPT_ACC_15(p_box, p_tr);			
		}			
		
		//EjbProxy.controlTxn(new YACA040EJB(p_box, p_tr));
	}

}
