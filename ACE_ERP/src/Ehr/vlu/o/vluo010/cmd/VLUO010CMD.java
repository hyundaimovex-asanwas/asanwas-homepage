package Ehr.vlu.o.vluo010.cmd;

import Ehr.vlu.o.vluo010.wrk.VLUO010WRK;

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

public class VLUO010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request를 Parsing하여 CBox객체에 저장 * */
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		VLUO010WRK wrk = new VLUO010WRK();
		
		/** S_MOD : SHR(조회), SAV(저장), DEL(삭제) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //조회해온다. 
			wrk.VLUO010_SHR(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("SHR_PRT")) {
			 //조회해온다. 
			wrk.VLUO010_SHR_PRT(p_box, p_tr);
		}				
		
		else if (p_box.get("S_MODE").equals("SAV")) {
			 //저장한다. 
			wrk.VLUO010_SAV(p_box, p_tr);
		}			
		
		else if (p_box.get("S_MODE").equals("SAV_01")) {
			 //상신처리
			wrk.VLUO010_SAV_01(p_box, p_tr);
			wrk.VLUO010_SAV_011(p_box, p_tr);			
		}				
		
		else if (p_box.get("S_MODE").equals("SAV_02")) {
			 //결재 or 부결 처리 
			wrk.VLUO010_SAV_02(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("UPT_02")) {
			 //결재 or 부결 처리 
			wrk.VLUO010_UPT_02(p_box, p_tr);
			wrk.VLUO010_UPT_03(p_box, p_tr);			
		}			
		
        //GauceDataSet ds = (GauceDataSet)EjbProxy.controlTxn( new VLUL080EJB(p_box, p_tr));

	}

}
