package Ehr.edu.g.edug010.cmd;

import Ehr.edu.g.edug010.wrk.EDUG010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EDUG010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);


        EDUG010WRK wrk = new EDUG010WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.EDUG010_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.EDUG010_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("DEL")) {

			wrk.EDUG010_DEL(p_box, p_tr);
			
		}
		
 	}

}
