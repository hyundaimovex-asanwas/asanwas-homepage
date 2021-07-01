package Ehr.ada.a.aday030.cmd;

import Ehr.ada.a.aday030.wrk.ADAY030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class ADAY030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		/** System.out.println(p_box); **/
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		ADAY030WRK wrk = new ADAY030WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.ADAY030_SHR(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//	��� �� ���޳����� ���� ������� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.ADAY030_SHR_01(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_02")) {
			//	���� ��ȸ
			wrk.ADAY030_SHR_02(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_03")) {
			//	��û�ڿ� �ش��ϴ� ���ޱݾ�  ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.ADAY030_SHR_03(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_04")) {
			//	��û��ȣ(REQ_NO)�� �ش��ϴ� ��û��  ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.ADAY030_SHR_04(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_06")) {
			//	��� �� ���޳����� ���� ������� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.ADAY030_SHR_06(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_LSE")) {
		    //	�ټӳ���� ��ȸ�� �´�.
		    wrk.ADAY030_SHR_LSE(p_box, p_tr);
		}
		
		// S_MODE�� ����Ʈ�� ���
		if (p_box.get("S_MODE").equals("SHR_PRINT0")) {
		    //	
		    wrk.ADAY030_SHR_PRINT0(p_box, p_tr);
		}				
		
		// S_MODE�� ����Ʈ�� ���
		if (p_box.get("S_MODE").equals("SHR_PRINT")) {
		    //	
		    wrk.ADAY030_SHR_PRINT(p_box, p_tr);
		}		
		
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	������� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.ADAY030_SAV(p_box, p_tr);
		}
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV_01")) {
			//	������� ��û���� �����ϰ�, ���������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.ADAY030_SAV_01(p_box, p_tr);
		}
		// S_MODE�� ������ ���
		if (p_box.get("S_MODE").equals("DEL")) {
			//	������� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.ADAY030_DEL(p_box, p_tr);
		}

		// S_MODE�� ��ǥó���� ���
		if (p_box.get("S_MODE").equals("PROC_D")) {
		    //	������� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.PROC_D(p_box, p_tr);
		}
        // S_MODE�� ����ó���� ���
		if (p_box.get("S_MODE").equals("PROC_E")) {
		    //	������� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.PROC_E(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new ADAY030EJB(p_box, p_tr));
	}


}