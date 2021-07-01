package Ehr.cod.e.code030.cmd;

import Ehr.cod.e.code030.wrk.CODE030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODE030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
			
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        CODE030WRK wrk = new CODE030WRK();

		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR")) {

			wrk.CODE030_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_01")) {

			wrk.CODE030_SHR_01(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_02")) {

			wrk.CODE030_SHR_02(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_03")) {

			wrk.CODE030_SHR_03(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_05")) {
		
			wrk.CODE030_SHR_05(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			
			wrk.CODE030_SHR_PRINT(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT2")) {
			
			wrk.CODE030_SHR_PRINT2(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_PRINT3")) {
			
			wrk.CODE030_SHR_PRINT3(p_box, p_tr);			
			
		}        
        
        //EjbProxy.controlTxn(new PIRC060EJB(p_box, p_tr));
		
 	}

}
