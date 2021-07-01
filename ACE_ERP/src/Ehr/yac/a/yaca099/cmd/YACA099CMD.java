package Ehr.yac.a.yaca099.cmd;

import Ehr.yac.a.yaca099.wrk.YACA099WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA099CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
        
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
		p_box = SessionUtil.getSession(p_req, p_box);
        
        String mode = p_box.get("S_MODE");

        /** Worker Class 객체 생성후 관련 메소드 호출 **/
        YACA099WRK wrk = new YACA099WRK();

        // S_MODE가 조회인 경우
        if (mode.equals("FILE")) {
        	wrk.YACA099_FILE(p_box, p_tr);
        }else if (mode.equals("SHR")) {
            wrk.YACA099_SHR(p_box, p_tr);
        } // 저장조건 (연말정산 부양가족 등록 되었는지 확인)
        else if (mode.equals("SHR_CHK")) {
            wrk.YACA099_SHR_CHK(p_box, p_tr);
        }
        // 저장
        else if (mode.equals("SAV")) {
        	
            wrk.YACA099_SAV(p_box, p_tr);
           
        }else if (mode.equals("FAM_SHR")) {
        	
            wrk.YACA099_FAM_UPT_SHR(p_box, p_tr);
            
        }else if (mode.equals("FAM_UPT")) {
        
            wrk.YACA099_FAM_CARD_UPT(p_box, p_tr);
          
        }
	}
}