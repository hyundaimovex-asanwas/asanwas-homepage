package Ehr.vlu.o.vluo060.cmd;

import Ehr.vlu.o.vluo060.wrk.VLUO060WRK;

import java.rmi.RemoteException;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUO060CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 * */
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUO060WRK wrk = new VLUO060WRK();
		

		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.VLUO060_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR2")) {

			wrk.VLUO060_SHR2(p_box, p_tr);					
			
		}else if (p_box.get("S_MODE").equals("SHR_ITEM")) {

			wrk.VLUO060_SHR_ITEM(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.VLUO060_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_COR")) { //보정계산

			wrk.VLUO060_SAV_COR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_COR_01")) { //보정계산

			wrk.VLUO060_SAV_COR_01(p_box, p_tr);			
			
		}			
		
        //GauceDataSet ds = (GauceDataSet)EjbProxy.controlTxn( new VLUL080EJB(p_box, p_tr));

	}

}
