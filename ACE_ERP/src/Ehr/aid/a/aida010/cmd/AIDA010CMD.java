package Ehr.aid.a.aida010.cmd;

import Ehr.aid.a.aida010.wrk.AIDA010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.proxy.EjbProxy;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class AIDA010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/

		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		/** System.out.println(p_box); **/
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		AIDA010WRK wrk = new AIDA010WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	������� ���ޱ��� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//	��� �� ���޳����� ���� ������� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR_01(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_02")) {
			//	���� ��ȸ
			wrk.AIDA010_SHR_02(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_03")) {
			//	��û�ڿ� �ش��ϴ� ���ޱݾ�  ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR_03(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_04")) {
			//	��û��ȣ(REQ_NO)�� �ش��ϴ� ��û��  ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR_04(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_06")) {
			//	��� �� ���޳����� ���� ������� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SHR_06(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_LSE")) {
		    //	�ټӳ���� ��ȸ�� �´�.
		    wrk.AIDA010_SHR_LSE(p_box, p_tr);
		}
		
		// S_MODE�� ����Ʈ�� ���
		if (p_box.get("S_MODE").equals("SHR_PRINT0")) {
		    //	
		    wrk.AIDA010_SHR_PRINT0(p_box, p_tr);
		}				
		
		// S_MODE�� ����Ʈ�� ���
		if (p_box.get("S_MODE").equals("SHR_PRINT")) {
		    //	
		    wrk.AIDA010_SHR_PRINT(p_box, p_tr);
		}		
		
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	������� ��û���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SAV(p_box, p_tr);
		}
		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV_01")) {
			//	������� ��û���� �����ϰ�, ���������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_SAV_01(p_box, p_tr);
		}
		// S_MODE�� ������ ���
		if (p_box.get("S_MODE").equals("DEL")) {
			//	������� ���ޱ��� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.AIDA010_DEL(p_box, p_tr);
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
		
		//EjbProxy.controlTxn(new AIDA010EJB(p_box, p_tr));
	}


}