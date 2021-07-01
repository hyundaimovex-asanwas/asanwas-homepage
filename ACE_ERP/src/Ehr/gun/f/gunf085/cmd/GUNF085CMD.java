package Ehr.gun.f.gunf085.cmd;

import Ehr.gun.f.gunf085.wrk.GUNF085WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNF085CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNF085WRK wrk = new GUNF085WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			
			//�Ѵޱٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF085_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR2")) {
			
			//������� ���縦 ���� WORK�޼ҵ� ȣ��
			wrk.GUNF085_SHR2(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			
			//�Ѵޱٹ� ���縦 ���� WORK�޼ҵ� ȣ��
			wrk.GUNF085_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV2")) {
			
			//������� ���縦 ���� WORK�޼ҵ� ȣ��
			wrk.GUNF085_SAV2(p_box, p_tr);			
			
		}

	}

}
