package Ehr.but.a.buta025.cmd;

import Ehr.but.a.buta025.wrk.BUTA025WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class BUTA025CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BUTA025WRK wrk = new BUTA025WRK();


		if (p_box.get("S_MODE").equals("SHR_01")) {

			wrk.BUTA025_SHR_01(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_02")) {

			wrk.BUTA025_SHR_02(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_03")) {

			wrk.BUTA025_SHR_03(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_05")) {		
			
			wrk.BUTA025_SHR_05(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT")) {		
			
			wrk.BUTA025_SHR_PRINT(p_box, p_tr);					
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT2")) {		
			
			wrk.BUTA025_SHR_PRINT2(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT3")) {		
			
			wrk.BUTA025_SHR_PRINT3(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT4")) {		
			
			wrk.BUTA025_SHR_PRINT4(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SAV_01")) {

			wrk.BUTA025_SAV_01(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_01_APP")) {

			wrk.BUTA025_SAV_01_APP(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_02")) {

			wrk.BUTA025_SAV_02(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_03")) {

			wrk.BUTA025_SAV_03(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_DATE")) {

			wrk.BUTA025_SAV_DATE(p_box, p_tr);
			
		}		

		//EjbProxy.controlTxn(new BUTA025EJB(p_box, p_tr));
	}

}
