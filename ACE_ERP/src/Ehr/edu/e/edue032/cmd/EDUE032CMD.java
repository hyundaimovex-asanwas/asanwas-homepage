package Ehr.edu.e.edue032.cmd;

import Ehr.edu.e.edue032.wrk.EDUE032WRK;

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

public class EDUE032CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
        //EjbProxy.controlTxn(new EDUE032EJB(p_box, p_tr));
		
        EDUE032WRK wrk = new EDUE032WRK();
        
        if (p_box.get("S_MODE").equals("SHR")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_ED")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_SHR_ED(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("DEL")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_DEL(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("APP")) {
			/**
			 * 사외강좌요청서 화면에서 조회버튼을 클릭할 때,
			 * 사외강좌요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE032_APP(p_box, p_tr);
		}
        
        
        
 	}

}
