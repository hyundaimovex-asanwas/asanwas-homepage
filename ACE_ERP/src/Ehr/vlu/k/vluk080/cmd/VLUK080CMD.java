package Ehr.vlu.k.vluk080.cmd;

import Ehr.vlu.k.vluk080.wrk.VLUK080WRK;

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

public class VLUK080CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUK080WRK wrk = new VLUK080WRK();

		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUK080_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUK080_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_PJT")) {
            wrk.VLUK080_SHR_PJT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_DPT")) {
            wrk.VLUK080_SHR_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_CON")) {
            wrk.VLUK080_SHR_CON(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02")) {
            wrk.VLUK080_SHR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_03")) {
            wrk.VLUK080_SHR_03(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02_PJT")) {
            wrk.VLUK080_SHR_02_PJT(p_box, p_tr);   
		}else  if (p_box.get("S_MODE").equals("SHR_02_DPT")) {
            wrk.VLUK080_SHR_02_DPT(p_box, p_tr);   
		}else  if (p_box.get("S_MODE").equals("SHR_02_CON")) {
            wrk.VLUK080_SHR_02_CON(p_box, p_tr);   
		}else  if (p_box.get("S_MODE").equals("SHR_04")) {
            wrk.VLUK080_SHR_04(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_05")) {
            wrk.VLUK080_SHR_05(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_04_PJT")) {
            wrk.VLUK080_SHR_04_PJT(p_box, p_tr);    
		}else  if (p_box.get("S_MODE").equals("SHR_04_DPT")) {
            wrk.VLUK080_SHR_04_DPT(p_box, p_tr);    
		}else  if (p_box.get("S_MODE").equals("SHR_04_CON")) {
            wrk.VLUK080_SHR_04_CON(p_box, p_tr);    
		}else  if (p_box.get("S_MODE").equals("SHR_06")) {
            wrk.VLUK080_SHR_06(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_07")) {
            wrk.VLUK080_SHR_07(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_06_PJT")) {
            wrk.VLUK080_SHR_06_PJT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_06_DPT")) {
            wrk.VLUK080_SHR_06_DPT(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_06_CON")) {
            wrk.VLUK080_SHR_06_CON(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV")) {
            wrk.VLUK080_SAV(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_EXE")) {
            wrk.VLUK080_SAV_EXE(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_GRD")) {
            wrk.VLUK080_SAV_GRD(p_box, p_tr);
		}
        
        
        
        //EjbProxy.controlTxn(new VLUK080EJB(p_box, p_tr));

	}

}
