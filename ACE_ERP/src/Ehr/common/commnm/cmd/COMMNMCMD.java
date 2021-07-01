package Ehr.common.commnm.cmd;

import Ehr.common.commnm.wrk.COMMNMWRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;


public class COMMNMCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		COMMNMWRK wrk = new COMMNMWRK();

		/** S_MOD : SHR(조회), SAV(저장) */
		if (p_box.get("S_MODE").equals("SHR")) {
			/**
			 * 공통구분코드와 코드를 입력하면
			 * 해당 공통코드명을 조회해온다.
			 */
			wrk.COMMNM_SHR(p_box, p_tr);
		}

		else if (p_box.get("S_MODE").equals("SHR_06")) {
			/**
			 * 콤보박스 코드 변경(인사평가)
			 */
			wrk.COMMNM_SHR_06(p_box, p_tr);
		}

		else if (p_box.get("S_MODE").equals("SHR_07")) {
			/**
			 * 해당 소속의 부문을 가져온다
			 */
			wrk.COMMNM_SHR_07(p_box, p_tr);
		}

		else if (p_box.get("S_MODE").equals("SHR_00")) {
		    /**
		     * 해당 소속의 부문을 가져온다
		     */        
		    wrk.COMMNM_SHR_00(p_box, p_tr);
		}

		else if (p_box.get("S_MODE").equals("SHR_DPT")) {
		    /**
		     * 해당 소속의 부문을 가져온다
		     */
		    wrk.COMMNM_SHR_DPT(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_DPT2")) {
		    /**
		     * 해당 소속의 부문을 가져온다
		     */
		    wrk.COMMNM_SHR_DPT2(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_DPT3")) {
		    /**
		     * 해당 소속의 부문을 가져온다
		     */
		    wrk.COMMNM_SHR_DPT3(p_box, p_tr);
		}
        //EjbProxy.controlTxn(new COMMNMEJB(p_box, p_tr));

 	}

}