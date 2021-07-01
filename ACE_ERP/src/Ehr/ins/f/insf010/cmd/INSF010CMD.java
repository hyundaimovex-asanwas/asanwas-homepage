package Ehr.ins.f.insf010.cmd;

import Ehr.ins.f.insf010.wrk.INSF010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class INSF010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req
            ,HttpGauceResponse p_res
            ,TrBox p_tr) throws CException, RemoteException, Throwable {
        
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        INSF010WRK wrk = new INSF010WRK();

		// S_MODE�� ������ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_EMP")) {
		    wrk.INSF010_SHR_EMP(p_box, p_tr);
		} 
		// S_MODE�� ��ȸ�� ���
        else if (p_box.get("S_MODE").equals("SHR")) {
            wrk.INSF010_SHR(p_box, p_tr);
        } 
        // S_MODE�� ������ ���        
        else if (p_box.get("S_MODE").equals("SAV")) {
		    wrk.INSF010_SAV(p_box, p_tr);
        }
        // S_MODE�� ������ ���
        else if (p_box.get("S_MODE").equals("DEL")) {
            wrk.INSF010_DEL(p_box, p_tr);
        }    		
		
		//EjbProxy.controlTxn(new INSF010EJB(p_box, p_tr));
	}
	
}