package Ehr.gun.a.guna013.cmd;

import Ehr.gun.a.guna013.wrk.GUNA013WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNA013CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNA013WRK wrk = new GUNA013WRK();
		
		// S_MODE�� �����ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_LST")) {

			wrk.GUNA013_SHR_LST(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_CD")) {
			
			wrk.GUNA013_SHR_CD(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR")) {

			wrk.GUNA013_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_04")) {

			wrk.GUNA013_SHR_04(p_box, p_tr);
				
		}else if (p_box.get("S_MODE").equals("SHR_05")) {

			wrk.GUNA013_SHR_05(p_box, p_tr);

		}else if (p_box.get("S_MODE").equals("SHR_06")) {

			wrk.GUNA013_SHR_06(p_box, p_tr);		
		
		// S_MODE�� ����, ������ ���
		}else if (p_box.get("S_MODE").equals("SAV")) {
			
			//	���º����û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA013_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("DEL")) {
			
			//	���º����û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNA013_DEL(p_box, p_tr);

		}		
		
		//EjbProxy.controlTxn(new GUNA013EJB(p_box, p_tr));
	}


}