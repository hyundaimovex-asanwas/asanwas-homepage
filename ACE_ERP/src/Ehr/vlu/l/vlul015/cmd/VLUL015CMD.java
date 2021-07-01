package Ehr.vlu.l.vlul015.cmd;

import Ehr.vlu.l.vlul015.wrk.VLUL015WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUL015CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

        
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUL015WRK wrk = new VLUL015WRK();

		if (p_box.get("S_MODE").equals("SHR")) {
			
			wrk.VLUL015_SHR(p_box, p_tr);
			
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
			
            wrk.VLUL015_SHR_01(p_box, p_tr);			
            
		}else if (p_box.get("S_MODE").equals("SHR_SUB")) {
			
			wrk.VLUL015_SHR_SUB(p_box, p_tr);			            
            
		}else  if (p_box.get("S_MODE").equals("SAV")) {
			
            wrk.VLUL015_SAV(p_box, p_tr);
            
		}
        
        
        //EjbProxy.controlTxn(new VLUL015EJB(p_box, p_tr));

	}

}
