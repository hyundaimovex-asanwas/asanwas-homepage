package Ehr.idt.c.idtc020.cmd;

import Ehr.idt.c.idtc020.wrk.IDTC020WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class IDTC020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		IDTC020WRK wrk = new IDTC020WRK();
		
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR")) {
			//	정보 조회를 위한 WORK메소드 호출
			wrk.IDTC020_SHR(p_box, p_tr);
		}
		
		
		// S_MODE가 조회인 경우
		if (p_box.get("S_MODE").equals("SHR_WEEK")) {
			//	현재 년월 주차 정보 조회를 위한 WORK메소드 호출
			wrk.IDTC020_SHR_WEEK(p_box, p_tr);
		}
		

		if (p_box.get("S_MODE").equals("SAV")) {
			//	저장하기 위한 WORK메소드 호출
			wrk.IDTC020_SAV(p_box, p_tr);
		}
		

		//EjbProxy.controlTxn(new IDTC020EJB(p_box, p_tr));
	}


}