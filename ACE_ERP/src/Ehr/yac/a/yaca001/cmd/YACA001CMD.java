package Ehr.yac.a.yaca001.cmd;

import Ehr.yac.a.yaca001.wrk.YACA001WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA001CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
        String mode = p_box.get("S_MODE");

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA001WRK wrk = new YACA001WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.YACA001_SHR(p_box, p_tr);
            
        } else if (mode.equals("SHR_14")) {
            wrk.YACA001_SHR_14(p_box, p_tr);     
            
        } else if (mode.equals("SHR_MED_14")) {
            wrk.YACA001_SHR_MED_14(p_box, p_tr);            
            
        } else if (mode.equals("SHR_DON_14")) {
            wrk.YACA001_SHR_DON_14(p_box, p_tr);              
    
        } else if (mode.equals("SHR_15")) {
            wrk.YACA001_SHR_15(p_box, p_tr);     
            
        } else if (mode.equals("SHR_MED_15")) {
            wrk.YACA001_SHR_MED_15(p_box, p_tr);            
            
        } else if (mode.equals("SHR_DON_15")) {
            wrk.YACA001_SHR_DON_15(p_box, p_tr);           
            
        } else if (mode.equals("SHR_142")) {
            wrk.YACA001_SHR_142(p_box, p_tr);     
            
        } else if (mode.equals("SHR_MED_142")) {
            wrk.YACA001_SHR_MED_142(p_box, p_tr);            
            
        } else if (mode.equals("SHR_DON_142")) {
            wrk.YACA001_SHR_DON_142(p_box, p_tr);              
            
        } 		
		
		//EjbProxy.controlTxn(new YACA001EJB(p_box, p_tr));
	}
}