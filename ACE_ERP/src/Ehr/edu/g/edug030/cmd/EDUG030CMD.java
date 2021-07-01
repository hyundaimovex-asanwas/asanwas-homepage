package Ehr.edu.g.edug030.cmd;

import Ehr.edu.g.edug030.wrk.EDUG030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EDUG030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);


        EDUG030WRK wrk = new EDUG030WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.EDUG030_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_01")) {

			wrk.EDUG030_SHR_01(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_31")) {

			wrk.EDUG030_SHR_31(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SHR_32")) {

			wrk.EDUG030_SHR_32(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_33")) {

			wrk.EDUG030_SHR_33(p_box, p_tr);	
			
		}else if (p_box.get("S_MODE").equals("SHR_34")) {

			wrk.EDUG030_SHR_34(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_35")) {

			wrk.EDUG030_SHR_35(p_box, p_tr);	
			
		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.EDUG030_SAV(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SAV_01")) {

			wrk.EDUG030_SAV_01(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SAV_32")) {

			wrk.EDUG030_SAV_32(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_33")) {

			wrk.EDUG030_SAV_33(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("DEL")) {

			wrk.EDUG030_DEL(p_box, p_tr);
			
		}
		
 	}

}
