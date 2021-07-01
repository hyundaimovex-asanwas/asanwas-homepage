package Ehr.gun.f.gunf070.cmd;

import Ehr.gun.f.gunf070.wrk.GUNF070WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNF070CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNF070WRK wrk = new GUNF070WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF070_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_DTL")) {
			//��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF070_SHR_DTL(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			//��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF070_SAV(p_box, p_tr);	
			
		}
		
	}

}