package Ehr.common.popup.empl2.cmd;

import java.rmi.RemoteException;

import Ehr.common.popup.empl2.wrk.EMPL2WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EMPL2CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		

		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EMPL2WRK wrk = new EMPL2WRK();		
		
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//	����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.EMPL2_SHR_01(p_box, p_tr);
		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			//	����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ(���������)�� ���� WORK�޼ҵ� ȣ��
			wrk.EMPL2_SHR_02(p_box, p_tr);
		}else if (p_box.get("S_MODE").equals("SHR_03")) {
			//	����ڵ�/�� �ش��ϴ� �μ��� ��å�� ��ȸ(���������)�� ���� WORK�޼ҵ� ȣ��
			wrk.EMPL2_SHR_03(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new EMPL2EJB(p_box, p_tr));
		
	}

}
