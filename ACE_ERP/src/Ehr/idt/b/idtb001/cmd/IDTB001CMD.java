package Ehr.idt.b.idtb001.cmd;

import Ehr.idt.b.idtb001.wrk.IDTB001WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;
import Ehr.common.util.JSPUtil;

public class IDTB001CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
	
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

        //System.out.println("p_box111   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());	    

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
		IDTB001WRK wrk = new IDTB001WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//	문서 현황 조회를 위한 WORK메소드 호출
			wrk.IDTB001_SHR(p_box, p_tr);
		}

		
		if (p_box.get("S_MODE").equals("SHR_COD")) {
			//	문서 현황 조회를 위한 WORK메소드 호출
			wrk.IDTB001_SHR_COD(p_box, p_tr);
		}
		
		
		// S_MODE가 저장, 수정인 경우
		if (p_box.get("S_MODE").equals("SAV")) {
			//	문서 정보를 수정하기 위한 WORK메소드 호출
			wrk.IDTB001_SAV(p_box, p_tr);
		}

		// S_MODE가 삭제인 경우
		if (p_box.get("S_MODE").equals("DEL")) {
			//	문서 정보를 삭제하기 위한 WORK메소드 호출
			wrk.IDTB001_DEL(p_box, p_tr);
		}

	}

}