package Ehr.pir.a.pira010.cmd;

import Ehr.pir.a.pira010.wrk.PIRA010WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class PIRA010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);   
        
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA010WRK wrk = new PIRA010WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.PIRA010_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_02")) {

			wrk.PIRA010_SHR_02(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT")) {

			wrk.PIRA010_SHR_PRINT(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT2")) {

			wrk.PIRA010_SHR_PRINT2(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT3")) {

			wrk.PIRA010_SHR_PRINT3(p_box, p_tr);					
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT4")) {

			wrk.PIRA010_SHR_PRINT4(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT5")) {

			wrk.PIRA010_SHR_PRINT5(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT6")) {

			wrk.PIRA010_SHR_PRINT6(p_box, p_tr);					
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT7")) {

			wrk.PIRA010_SHR_PRINT7(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT8")) {

			wrk.PIRA010_SHR_PRINT8(p_box, p_tr);					
			
		}else if (p_box.get("S_MODE").equals("SAV")) {

			wrk.PIRA010_SAV(p_box, p_tr);
			
		}        
        
        
        //EjbProxy.controlTxn(new PIRA010EJB(p_box, p_tr));
		
 	}

}
