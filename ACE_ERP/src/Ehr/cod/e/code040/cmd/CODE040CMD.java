package Ehr.cod.e.code040.cmd;

import Ehr.cod.e.code040.wrk.CODE040WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODE040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODE040WRK wrk = new CODE040WRK();

		//System.out.println("p_box==="+p_box);
		
		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //�λ���ǥ �����͸� ��ȸ�ؿ´�.
			wrk.CODE040_SHR(p_box, p_tr);
		}
		
		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (p_box.get("S_MODE").equals("SAV")) {
			
		    //�λ���ǥ�� �ҵ漼���ڵ� ������Ʈ.
			wrk.CODE040_SAV(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new CODE040EJB(p_box, p_tr));
	}
}

