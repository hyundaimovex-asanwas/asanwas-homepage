package Ehr.idt.a.idta030.cmd;

import Ehr.idt.a.idta030.wrk.IDTA030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class IDTA030CMD implements AbstractGauceCMD {

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
		IDTA030WRK wrk = new IDTA030WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	������û��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_SHR(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//	���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_SHR_01(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_02")) {
			//	������� ��ȸ(�ּ�)�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_SHR_02(p_box, p_tr);
		}
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_SAV(p_box, p_tr);
		}
		// S_MODE�� �������� ���
		if (p_box.get("S_MODE").equals("DEL")) {
			//	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTA030_DEL(p_box, p_tr);
		}
		// S_MODE�� ���� ��� ������Ʈ���� ���
		if (p_box.get("S_MODE").equals("UPT_PRT")) {
		    //	������û ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.IDTA030_UPT_PRT(p_box, p_tr);
		}
		
		
		//EjbProxy.controlTxn(new IDTA030EJB(p_box, p_tr));
		
		
		
	}


}