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
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		
        String mode = p_box.get("S_MODE");

        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        YACA090WRK wrk = new YACA090WRK();

        // S_MODE�� ��ȸ�� ���
        if (mode.equals("SHR")) {
            wrk.YACA090_SHR(p_box, p_tr);
        }
        // S_MODE�� ����ڼ��� �� ���
        else if (mode.equals("PROC2")) {
            wrk.YACA090_PROC2(p_box, p_tr);
        }
        // S_MODE�� �������۾� �� ���
        else if (mode.equals("PROC3")) {
            wrk.YACA090_PROC3(p_box, p_tr);
        }
        
        // S_MODE�� �������۾� �� ���
        else if (mode.equals("PROC3_142")) {
            wrk.YACA090_PROC3_142(p_box, p_tr);
        }        
        
        // S_MODE�� �������۾� �� ���
        else if (mode.equals("PROC3_15")) {
            wrk.YACA090_PROC3_15(p_box, p_tr);
        }        
        
        // S_MODE�� �۾����� �� ���
        else if (mode.equals("PROC4")) {
            wrk.YACA090_PROC4(p_box, p_tr);
        }
        // S_MODE�� ����ڼ��� �ʱ�ȭ �� ���
        else if (mode.equals("PROC5")) {
            wrk.YACA090_PROC5(p_box, p_tr);
        }
        // S_MODE�� �������۾� �ʱ�ȭ �� ���
        else if (mode.equals("PROC6")) {
            wrk.YACA090_PROC6(p_box, p_tr);
        }		
        // S_MODE�� �������۾� �ʱ�ȭ �� ���
        else if (mode.equals("PROC6_142")) {
            wrk.YACA090_PROC6_142(p_box, p_tr);
            
        }	
        
       
		
		//EjbProxy.controlTxn(new YACA090EJB(p_box, p_tr));
	}
}