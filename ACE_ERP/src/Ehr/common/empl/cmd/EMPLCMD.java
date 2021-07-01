package Ehr.common.empl.cmd;

import Ehr.common.empl.wrk.EMPLWRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;



public class EMPLCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		//System.out.println("p_box000000000000000000000000000000000====" + p_box);	
        
    		/** Worker Class 객체 생성후 관련 메소드 호출 **/
            EMPLWRK wrk = new EMPLWRK();

    		if (p_box.get("S_MODE").equals("SHR")) {
    			wrk.EMPL_SHR(p_box, p_tr);
    		}

    		if (p_box.get("S_MODE").equals("SHR00")) {
    			wrk.EMPL_SHR00(p_box, p_tr);
    		}    	    		
    		
    		if (p_box.get("S_MODE").equals("SHR01")) {
    			wrk.EMPL_SHR01(p_box, p_tr);
    		}    		
    		
    		if (p_box.get("S_MODE").equals("SHR_DH")) {
    			wrk.EMPL_SHR_DH(p_box, p_tr);
    		}    		
    		
    		if (p_box.get("S_MODE").equals("SHR_DPT")) {
    			wrk.EMPL_SHR_DPT(p_box, p_tr);
    		}    		
    		
        //EjbProxy.controlTxn(new EMPLEJB(p_box, p_tr));
		
 	}

}
