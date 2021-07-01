package Ehr.vlu.k.vluk090.cmd;

import Ehr.vlu.k.vluk090.wrk.VLUK090WRK;

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

public class VLUK090CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUK090WRK wrk = new VLUK090WRK();

		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUK090_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUK090_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02")) {
            wrk.VLUK090_SHR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_03")) {
            wrk.VLUK090_SHR_03(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_04")) {
            wrk.VLUK090_SHR_04(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_05")) {
            wrk.VLUK090_SHR_05(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_06")) {
            wrk.VLUK090_SHR_06(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_07")) {
            wrk.VLUK090_SHR_07(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV")) {
            wrk.VLUK090_SAV(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_EXE")) {
            wrk.VLUK090_SAV_EXE(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_GRD")) {
            wrk.VLUK090_SAV_GRD(p_box, p_tr);
		}
        
        
        //EjbProxy.controlTxn(new VLUK090EJB(p_box, p_tr));

	}

}
