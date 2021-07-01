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
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
    	//System.out.println("p_box============"+p_box);        
        
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
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
