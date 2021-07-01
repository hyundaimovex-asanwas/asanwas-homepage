package Ehr.cdp.a.book010.cmd;

import Ehr.cdp.a.book010.ejb.BOOK010EJB;
import Ehr.cdp.a.book010.wrk.BOOK010WRK;

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

public class BOOK010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);


		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		//EjbProxy.controlTxn(new BOOK010EJB(p_box, p_tr));
		
		BOOK010WRK wrk = new BOOK010WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//휴일근무휴가신청을 조회를 위한 WORK메소드 호출
			wrk.BOOK010_SHR(p_box, p_tr);
		}

		// 디테일 조회
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK010_SHR_02(p_box, p_tr);
		}

		// 신청번호 조회
		else if (p_box.get("S_MODE").equals("SHR_03")) {
			wrk.BOOK010_SHR_03(p_box, p_tr);
		}

		// S_MODE가 저장인 경우
		else if (p_box.get("S_MODE").equals("SAV")) {
			//도서구입신청을 하기 위한 WORK메소드 호출
			wrk.BOOK010_SAV(p_box, p_tr);
		}


		// S_MODE가 저장인 경우 - 상신했을 경우
		else if (p_box.get("S_MODE").equals("UPT_APP")) {
		    //도서신청을 수정하기 위한 WORK메소드 호출
		    wrk.BOOK010_UPT_APP(p_box, p_tr);
		}




		// S_MODE가 결재시 팝업조회인 경우
		else if (p_box.get("S_MODE").equals("SHR_11")) {
			//도서구입신청 팝업조회를 위한 WORK메소드 호출
			wrk.BOOK010_SHR_11(p_box, p_tr);
		}

		// S_MODE가 결재선 조회인 경우
		else if (p_box.get("S_MODE").equals("SHR_APP")) {
			//도서구입신청 팝업조회를 위한 WORK메소드 호출
			wrk.BOOK010_SHR_APP(p_box, p_tr);
		}



        // S_MODE가 삭제인 경우
		else if (p_box.get("S_MODE").equals("DEL")) {
			//휴일근무휴가신청을 삭제하기 위한 WORK메소드 호출
			//wrk.BOOK010_DEL(p_box, p_tr);
		}
		
		
	}

}
