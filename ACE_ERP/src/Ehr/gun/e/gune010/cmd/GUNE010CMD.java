package Ehr.gun.e.gune010.cmd;

import Ehr.gun.e.gune010.wrk.GUNE010WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNE010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUNE010WRK wrk = new GUNE010WRK();
		
		// S_MODE�� �ڵ����缱üũ�� ���
		if (p_box.get("S_MODE").equals("SHR_APP")) {
			
			//	�ڵ� ���缱 üũ�� ���� WORK�޼ҵ� ȣ��
			//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
			//System.out.print(p_box);				
			
			wrk.GUNE010_SHR_APP(p_box, p_tr);
		}
		
		// S_MODE�� ����Ȯ���� ���
		if (p_box.get("S_MODE").equals("SHR_WK")) {
			//	���� Ȯ���� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_WK(p_box, p_tr);
		}
		
		// S_MODE�� ��� ����ٹ� �����ð� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_ACC")) {
			//	����ٹ� �����ð� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_ACC(p_box, p_tr);
		}
		
		// S_MODE�� ��� ����ٹ� ��ϰ������ڸ� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_OTD")) {
			//	����ٹ� �����ð� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_OTD(p_box, p_tr);
		}
		
		// S_MODE�� ��û��ȣ ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_MAX")) {
			//	���� Ȯ���� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_SHR_MAX(p_box, p_tr);
		}
		
		// S_MODE�� ����� ���
		if (p_box.get("S_MODE").equals("UPT_APP")) {
			//	����ٹ� ������ ����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUNE010_UPT_APP(p_box, p_tr);
		}
		
		// S_MODE�� SMS�� ���
		if (p_box.get("S_MODE").equals("SMS_TRANS")) {
			//	SMS ������ ���� WORK�޼ҵ� ȣ��
			//System.out.print("---------------------------   %%%%%%%%%%%%%%%%%%   ---------");
			//System.out.print(p_box);			
			
			wrk.GUNE010_SMS(p_box, p_tr);
		}
		
	
		
		//EjbProxy.controlTxn(new GUNA012EJB(p_box, p_tr));
	}


}