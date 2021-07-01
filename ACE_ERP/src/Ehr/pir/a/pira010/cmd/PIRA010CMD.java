package Ehr.pir.a.pira010.cmd;

import Ehr.pir.a.pira010.wrk.PIRA010WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class PIRA010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);   
        
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		PIRA010WRK wrk = new PIRA010WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.PIRA010_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_02")) {

			wrk.PIRA010_SHR_02(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT")) {

			wrk.PIRA010_SHR_PRINT(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT2")) {

			wrk.PIRA010_SHR_PRINT2(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT3")) {

			wrk.PIRA010_SHR_PRINT3(p_box, p_tr);					
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT4")) {

			wrk.PIRA010_SHR_PRINT4(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT5")) {

			wrk.PIRA010_SHR_PRINT5(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT6")) {

			wrk.PIRA010_SHR_PRINT6(p_box, p_tr);					
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT7")) {

			wrk.PIRA010_SHR_PRINT7(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT8")) {

			wrk.PIRA010_SHR_PRINT8(p_box, p_tr);					
			
		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.PIRA010_SAV(p_box, p_tr);
			
		}        
        
        
        //EjbProxy.controlTxn(new PIRA010EJB(p_box, p_tr));
		
 	}

}
