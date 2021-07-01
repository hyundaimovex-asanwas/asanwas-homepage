package Ehr.pir.g.pirg010.cmd;

import Ehr.pir.g.pirg010.wrk.PIRG010WRK;

import java.rmi.RemoteException;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class PIRG010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRG010WRK wrk = new PIRG010WRK();

		if (p_box.get("S_MODE").equals("SAV")) {
			//	사진화일을 저장하기 위한 WORK메소드 호출
			wrk.PIRG010_SAV(p_box, p_tr);
		}
		if (p_box.get("S_MODE").equals("ULD")) {
		    //	사진화일을 저장하기 위한 WORK메소드 호출
		    wrk.PIRG010_ULD(p_box, p_tr);
		}
	
		//EjbProxy.controlTxn(new PIRG010EJB(p_box, p_tr));
	}


}