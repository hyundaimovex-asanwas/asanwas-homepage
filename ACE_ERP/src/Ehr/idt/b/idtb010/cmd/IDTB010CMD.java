package Ehr.idt.b.idtb010.cmd;

import Ehr.idt.b.idtb010.wrk.IDTB010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class IDTB010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		//System.out.println("p_box   =========================================== ");	
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		
		//String mode = p_box.get("S_MODE");
        
        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());	    
    	
        //Log.debug.println("S_MODE:"+mode);
        
        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTB010WRK wrk = new IDTB010WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	��û��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB010_SHR(p_box, p_tr);
		}
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	��û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB010_SAV(p_box, p_tr);
		}
		// S_MODE�� �������� ���
		if (p_box.get("S_MODE").equals("DEL")) {
			//	������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB010_DEL(p_box, p_tr);
		}
		// S_MODE�� ������Ʈ���� ���
		if (p_box.get("S_MODE").equals("UPT_PRT")) {
		    //	������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.IDTB010_UPT_PRT(p_box, p_tr);
		}
		
		
		//EjbProxy.controlTxn(new IDTA030EJB(p_box, p_tr));
		
		
		
	}


}