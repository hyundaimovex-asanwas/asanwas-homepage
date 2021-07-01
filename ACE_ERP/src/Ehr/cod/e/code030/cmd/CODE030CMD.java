package Ehr.cod.e.code030.cmd;

import Ehr.cod.e.code030.wrk.CODE030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODE030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
			
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
        CODE030WRK wrk = new CODE030WRK();

		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) */
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.CODE030_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_01")) {

			wrk.CODE030_SHR_01(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_02")) {

			wrk.CODE030_SHR_02(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_03")) {

			wrk.CODE030_SHR_03(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_05")) {
		
			wrk.CODE030_SHR_05(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			
			wrk.CODE030_SHR_PRINT(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT2")) {
			
			wrk.CODE030_SHR_PRINT2(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT3")) {
			
			wrk.CODE030_SHR_PRINT3(p_box, p_tr);			
			
		}        
        
        //EjbProxy.controlTxn(new PIRC060EJB(p_box, p_tr));
		
 	}

}
