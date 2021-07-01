package Ehr.edu.e.edue020.cmd;

import Ehr.edu.e.edue020.ejb.EDUE020EJB;
import Ehr.edu.e.edue020.wrk.EDUE020WRK;

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

public class EDUE020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
        //EjbProxy.controlTxn(new EDUE020EJB(p_box, p_tr));
        
        
        EDUE020WRK wrk = new EDUE020WRK();
		
		/** S_MOD : SHR(조회), SAV(저장) */ 
		if (p_box.get("S_MODE").equals("SHR_00")) {
			/**
			 * 과정개설요청서 화면에서 화면오픈시에
			 * 과정개설요청서 데이터를 조회해온다. 
			 */
			wrk.EDUE020_SHR_00(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			/**
			 * 과정개설요청서 화면에서 저장버튼 클릭할 때
			 * 과정개설요청서 마감여부를 조회해온다. 
			 */
			wrk.EDUE020_SHR_01(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			/**
			 * 과정개설요청서 화면에서 저장버튼을 클릭할 때,
			 * 과정개설요청서 데이터를 저장한다. 
			 */
			wrk.EDUE020_SAV(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("STS")) {
			/**
			 * 과정개설요청서 화면에서 상태를 변경할 때,
			 * 현재 상태를 저장한다. 
			 */
			wrk.EDUE020_UPT_00(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("DEL")) {
			/**
			 * 과정개설요청서 화면에서 삭제버튼을 클릭할 때,
			 * 과정개설요청서 데이터를 삭제한다. 
			 */
			wrk.EDUE020_DEL(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("PROC")) {
			/**
			 * 과정개설요청서 화면에서 승인 할 때,
			 * 과정을 개설한다. 
			 */
			wrk.EDUE020_PROC(p_box, p_tr);
		}
		
 	}

}
