package Ehr.common.enonm.cmd;

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
import Ehr.common.enonm.wrk.ENONMWRK;

public class ENONMCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res, TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		ENONMWRK wrk = new ENONMWRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (p_box.get("S_MODE").equals("SHR")) {
			/**
			 * 사번를 입력하면 해당 사원명을 조회해온다.
			 */
			wrk.ENONM_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			/**
			 * 성명를 입력하면 해당 사번을 조회해온다.
			 */
			wrk.ENONM_SHR_01(p_box, p_tr);
		}        
        
        
        //EjbProxy.controlTxn(new ENONMEJB(p_box, p_tr));
		
 	}

}
