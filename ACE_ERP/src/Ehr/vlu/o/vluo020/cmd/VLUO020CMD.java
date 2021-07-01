package Ehr.vlu.o.vluo020.cmd;

import Ehr.vlu.o.vluo020.wrk.VLUO020WRK;

import java.rmi.RemoteException;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUO020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� * */
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		VLUO020WRK wrk = new VLUO020WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.VLUO020_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_01")) {			
			
			wrk.VLUO020_SHR_01(p_box, p_tr);			
		
			
		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.VLUO020_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_01")) {
			
			//���ó��
			wrk.VLUO020_SAV_01(p_box, p_tr);
			wrk.VLUO020_SAV_011(p_box, p_tr);			
				
		}else if (p_box.get("S_MODE").equals("UPT")) {

			wrk.VLUO020_UPT(p_box, p_tr);
			
		}			
		
        //GauceDataSet ds = (GauceDataSet)EjbProxy.controlTxn( new VLUL080EJB(p_box, p_tr));

	}

}
