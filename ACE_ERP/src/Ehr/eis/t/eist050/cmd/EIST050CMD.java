package Ehr.eis.t.eist050.cmd;

import Ehr.eis.t.eist050.wrk.EIST050WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EIST050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		EIST050WRK wrk = new EIST050WRK();
		
		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //조회해온다. 
			wrk.EIST050_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_TEAM")) {
			 //팀을 조회해온다. 
			wrk.EIST050_SHR_TEAM(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			 //저장한다. 
			wrk.EIST050_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_01")) {
			 //인건비 배부 계산한다. 
			wrk.EIST050_SAV_01(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("ULD")) {
			 //업로드 한다. 
			wrk.EIST050_ULD(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("DEL")) {
			 //설정을 삭제한다. 
			wrk.EIST050_DEL(p_box, p_tr);
			
		}        
        
        //EjbProxy.controlTxn(new EIST050EJB(p_box, p_tr));
		
 	}

}
