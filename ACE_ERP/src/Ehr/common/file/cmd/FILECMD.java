package Ehr.common.file.cmd;

import Ehr.common.file.wrk.FILEWRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;


public class FILECMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request를 Parsing하여 CBox객체에 저장 **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** 세션 값을 CBox에 저장 :: 기존 Request정보에 추가하는 형태 * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
    	//System.out.println("p_box============"+p_box);        
        
		/** Worker Class 객체 생성후 관련 메소드 호출 **/
		FILEWRK wrk = new FILEWRK();
		
        String mode = p_box.get("S_MODE");
		
		if (mode.equals("SHR"))
			wrk.FILE_SHR(p_box, p_tr);
		
        else if (mode.equals("INS"))
            wrk.FILE_INS(p_box, p_tr);
		
        else if (mode.equals("DEL"))
            wrk.FILE_DEL(p_box, p_tr);        
        
        //EjbProxy.controlTxn(new FILEEJB(p_box, p_tr));
		
 	}
}
