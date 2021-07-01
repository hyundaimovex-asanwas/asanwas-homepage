package Ehr.edu.c.educ012.cmd;

import Ehr.edu.c.educ012.wrk.EDUC012WRK;

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

public class EDUC012CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
        
        //추가
        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        EDUC012WRK wrk = new EDUC012WRK();

		//ejb 막음
        //EjbProxy.controlTxn(new EDUC012EJB(p_box, p_tr));
        
        //추가
        /** S_MOD : SHR(조회), SAV(저장) */ 
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.EDUC012_SHR(p_box, p_tr);
		}
 	}
}
