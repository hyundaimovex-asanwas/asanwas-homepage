package Ehr.cdp.a.book030.cmd;

import Ehr.cdp.a.book030.ejb.BOOK030EJB;
import Ehr.cdp.a.book030.wrk.BOOK030WRK;

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

public class BOOK030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		//EjbProxy.controlTxn(new BOOK030EJB(p_box, p_tr));
		
		
		BOOK030WRK wrk = new BOOK030WRK();

		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//휴일근무휴가신청을 조회를 위한 WORK메소드 호출
			wrk.BOOK030_SHR(p_box, p_tr);
		}

		// 디테일 조회
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK030_SHR_02(p_box, p_tr);
		}


		// 디테일 조회
		else if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.BOOK030_SHR_PRINT(p_box, p_tr);
		}
		
		// 디테일 조회
		else if (p_box.get("S_MODE").equals("SHR_PRINT2")) {
			wrk.BOOK030_SHR_PRINT2(p_box, p_tr);
		}		
		
		// 도서구입현황조회
		else if (p_box.get("S_MODE").equals("SHR_40")) {
			wrk.BOOK030_SHR_40(p_box, p_tr);
		}

	}

}
