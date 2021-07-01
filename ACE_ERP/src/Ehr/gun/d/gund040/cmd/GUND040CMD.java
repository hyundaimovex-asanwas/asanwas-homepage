package Ehr.gun.d.gund040.cmd;

import Ehr.gun.d.gund040.wrk.GUND040WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUND040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		GUND040WRK wrk = new GUND040WRK();

		/** S_MOD : SHR(조회), SAV(저장) */
		if (p_box.get("S_MODE").equals("SHR")) {

			 //개인별 근태 집계 현황을 조회해온다.
			wrk.GUND040_SHR(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			
			 //개인별 근태 집계 현황 
			wrk.GUND040_SHR_02(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_03")) {

			 //개인별 근태 집계 현황 
			wrk.GUND040_SHR_03(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			
			 //개인별 근태 집계 현황 저장
			wrk.GUND040_SAV(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("UPT_END")) {
			
			 //개인별 근태 집계 현황 저장
			wrk.GUND040_UPT_END(p_box, p_tr);
			
		}        
        
        //EjbProxy.controlTxn(new GUND040EJB(p_box, p_tr));
		
 	}

}
