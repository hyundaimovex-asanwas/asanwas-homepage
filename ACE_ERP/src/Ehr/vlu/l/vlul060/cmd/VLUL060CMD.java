package Ehr.vlu.l.vlul060.cmd;

import Ehr.vlu.l.vlul060.wrk.VLUL060WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUL060CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUL060WRK wrk = new VLUL060WRK();

		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUL060_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_PJT")) {
            wrk.VLUL060_SHR_PJT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_DPT")) {
            wrk.VLUL060_SHR_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_CON")) {
            wrk.VLUL060_SHR_CON(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUL060_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02")) {
            wrk.VLUL060_SHR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02_PJT")) {
            wrk.VLUL060_SHR_02_PJT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02_DPT")) {
            wrk.VLUL060_SHR_02_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02_CON")) {
            wrk.VLUL060_SHR_02_CON(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_03")) {
            wrk.VLUL060_SHR_03(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_04")) {
            wrk.VLUL060_SHR_04(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_04_PJT")) {
            wrk.VLUL060_SHR_04_PJT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_04_DPT")) {
            wrk.VLUL060_SHR_04_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_04_CON")) {
            wrk.VLUL060_SHR_04_CON(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_05")) {
            wrk.VLUL060_SHR_05(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_06")) {
            wrk.VLUL060_SHR_06(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_06_PJT")) {
            wrk.VLUL060_SHR_06_PJT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_06_DPT")) {
            wrk.VLUL060_SHR_06_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_06_CON")) {
            wrk.VLUL060_SHR_06_CON(p_box, p_tr);    
		}else  if (p_box.get("S_MODE").equals("SHR_07")) {
            wrk.VLUL060_SHR_07(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV")) {
            wrk.VLUL060_SAV(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_EXE")) {
            wrk.VLUL060_SAV_EXE(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_GRD")) {
            wrk.VLUL060_SAV_GRD(p_box, p_tr);
		}        
        
        //EjbProxy.controlTxn(new VLUL060EJB(p_box, p_tr));

	}

}
