package Ehr.vlu.k.vluk030.cmd;

import Ehr.vlu.k.vluk030.wrk.VLUK030WRK;

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

public class VLUK030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUK030WRK wrk = new VLUK030WRK();

		/** S_MOD : SHR(조회), SAV(저장) */
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUK030_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUK030_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02")) {
            wrk.VLUK030_SHR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_12")) {
            wrk.VLUK030_SHR_12(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_13")) {
            wrk.VLUK030_SHR_13(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_01")) {
            wrk.VLUK030_SAV_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_02")) {
            wrk.VLUK030_SAV_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("DEL")) {
            wrk.VLUK030_DEL(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("DEL_DPT")) {
            wrk.VLUK030_DEL_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("DEL_01")) {
            wrk.VLUK030_DEL_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("DEL_02")) {
            wrk.VLUK030_DEL_02(p_box, p_tr);
		}        
        
        
        //EjbProxy.controlTxn(new VLUK030EJB(p_box, p_tr));

	}

}
