package Ehr.common.popup.commnm.cmd;

import Ehr.common.popup.commnm.wrk.COMMNMWRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class COMMNMCMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/	
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		//System.out.println("p_box2=================="+p_box);
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		COMMNMWRK wrk = new COMMNMWRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	���� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.COMMNM_SHR(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_03")) {//1~2�� �̹� �����
			//	���� ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.COMMNM_SHR_03(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new COMMNMEJB(p_box, p_tr));
	}


}