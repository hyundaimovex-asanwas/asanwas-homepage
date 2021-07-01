package Ehr.yac.a.yaca011.cmd;

import Ehr.yac.a.yaca011.wrk.YACA011WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.proxy.EjbProxy;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA011CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
        String mode = p_box.get("S_MODE");

        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        YACA011WRK wrk = new YACA011WRK();

        // S_MODE�� ��ȸ�� ���
        if (mode.equals("SHR")) {
            wrk.YACA011_SHR(p_box, p_tr);
            
        } else if (mode.equals("SHR_14")) {
            wrk.YACA011_SHR_14(p_box, p_tr);            
        } else if (mode.equals("SHR_15")) {
            wrk.YACA011_SHR_15(p_box, p_tr);         
        } else if (mode.equals("SAV")) {
            wrk.YACA011_SAV(p_box, p_tr);
            
        } else if (mode.equals("SAV_14")) {
            wrk.YACA011_SAV_14(p_box, p_tr);            
            
        } 		
		
		//EjbProxy.controlTxn(new YACA011EJB(p_box, p_tr));
	}
}