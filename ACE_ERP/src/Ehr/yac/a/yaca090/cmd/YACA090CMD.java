package Ehr.yac.a.yaca090.cmd;

import Ehr.yac.a.yaca090.wrk.YACA090WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA090CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		
        String mode = p_box.get("S_MODE");

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA090WRK wrk = new YACA090WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("SHR")) {
            wrk.YACA090_SHR(p_box, p_tr);
        }
        // S_MODE가 대상자선정 인 경우
        else if (mode.equals("PROC2")) {
            wrk.YACA090_PROC2(p_box, p_tr);
        }
        // S_MODE가 정산계산작업 인 경우
        else if (mode.equals("PROC3")) {
            wrk.YACA090_PROC3(p_box, p_tr);
        }
        
        // S_MODE가 정산계산작업 인 경우
        else if (mode.equals("PROC3_142")) {
            wrk.YACA090_PROC3_142(p_box, p_tr);
        }        
        
        // S_MODE가 정산계산작업 인 경우
        else if (mode.equals("PROC3_15")) {
            wrk.YACA090_PROC3_15(p_box, p_tr);
        }        
        
        // S_MODE가 작업종료 인 경우
        else if (mode.equals("PROC4")) {
            wrk.YACA090_PROC4(p_box, p_tr);
        }
        // S_MODE가 대상자선정 초기화 인 경우
        else if (mode.equals("PROC5")) {
            wrk.YACA090_PROC5(p_box, p_tr);
        }
        // S_MODE가 정산계산작업 초기화 인 경우
        else if (mode.equals("PROC6")) {
            wrk.YACA090_PROC6(p_box, p_tr);
        }		
        // S_MODE가 정산계산작업 초기화 인 경우
        else if (mode.equals("PROC6_142")) {
            wrk.YACA090_PROC6_142(p_box, p_tr);
            
        }	
        
       
		
		//EjbProxy.controlTxn(new YACA090EJB(p_box, p_tr));
	}
}