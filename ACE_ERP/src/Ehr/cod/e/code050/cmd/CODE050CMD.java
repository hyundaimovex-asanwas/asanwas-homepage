package Ehr.cod.e.code050.cmd;

import Ehr.cod.e.code050.wrk.CODE050WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODE050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        CODE050WRK wrk = new CODE050WRK();

		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //��ȸ�ؿ´�.
			wrk.CODE050_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SAV")) {
			 //�����Ѵ�.
			wrk.CODE050_SAV(p_box, p_tr);
		}

        //EjbProxy.controlTxn(new PIRC060EJB(p_box, p_tr));
		
 	}

}
