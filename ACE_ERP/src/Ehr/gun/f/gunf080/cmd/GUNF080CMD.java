package Ehr.gun.f.gunf080.cmd;

import Ehr.gun.f.gunf080.wrk.GUNF080WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNF080CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNF080WRK wrk = new GUNF080WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_01")) {
			//��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_SHR_01(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_DTL")) {
			//��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_SHR_DTL(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_APP")) {
			//���缱 ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_SHR_APP(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("SHR_MAX")) {
			//���� ��� ���� ��ȣ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_SHR_MAX(p_box, p_tr);				

		}else if (p_box.get("S_MODE").equals("SHR_MAX2")) {
			//���� ��� ���� ��ȣ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_SHR_MAX2(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("SHR_REQ")) {
			//��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_SHR_REQ(p_box, p_tr);						
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			//��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_SAV(p_box, p_tr);	
			
		}else if (p_box.get("S_MODE").equals("UPT_APP")) {
			//���� �������� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_UPT_APP(p_box, p_tr);		
			
		}else if (p_box.get("S_MODE").equals("UPT_APP_EACH")) {
			//���� �������� ���� WORK�޼ҵ� ȣ��
			wrk.GUNF080_UPT_APP_EACH(p_box, p_tr);					
		}
		
	}

}
