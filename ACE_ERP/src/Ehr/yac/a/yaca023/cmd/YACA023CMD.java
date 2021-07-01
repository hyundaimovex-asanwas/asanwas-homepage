package Ehr.yac.a.yaca023.cmd;

import Ehr.yac.a.yaca023.wrk.YACA023WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA023CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		//System.out.println("p_box14 = "+p_box);
        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        YACA023WRK wrk = new YACA023WRK();
		
        // S_MODE�� ��ȸ�� ���
        if (p_box.get("S_MODE").equals("SHR")) {
            wrk.YACA023_SHR_PLA(p_box, p_tr);
        } 
        // S_MODE�� ��ȸ�� ���
        else if (p_box.get("S_MODE").equals("SHR_14")) {
            wrk.YACA023_SHR_PLA_14(p_box, p_tr);
        }	  
        
     // S_MODE�� ��ȸ�� ���
        else if (p_box.get("S_MODE").equals("SHR_15")) {
            wrk.YACA023_SHR_PLA_15(p_box, p_tr);
        }	  
        
        // S_MODE�� ������ ���
        else if (p_box.get("S_MODE").equals("SAV")) {
            wrk.YACA023_SAV(p_box, p_tr);
        }		
        // S_MODE�� ������ ���
        else if (p_box.get("S_MODE").equals("SAV_14")) {
			//System.out.println("p_box14 = "+p_box);		
            wrk.YACA023_DEL_PLA_14(p_box, p_tr);        	
            wrk.YACA023_SAV_14(p_box, p_tr);
        }		
        
        else if (p_box.get("S_MODE").equals("SAV_15")) {
			//System.out.println("p_box14 = "+p_box);		
            wrk.YACA023_DEL_PLA_15(p_box, p_tr);        	
            wrk.YACA023_SAV_15(p_box, p_tr);
        }		
		
		//EjbProxy.controlTxn(new YACA023EJB(p_box, p_tr));
	}
}