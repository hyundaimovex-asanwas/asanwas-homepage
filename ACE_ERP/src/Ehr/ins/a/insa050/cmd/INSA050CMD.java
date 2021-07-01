package Ehr.ins.a.insa050.cmd;

import Ehr.ins.a.insa050.wrk.INSA050WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class INSA050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		INSA050WRK wrk = new INSA050WRK();

		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	���ο��ݵ���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.INSA050_SAV(p_box, p_tr);
		}
		
        else if (p_box.get("S_MODE").equals("ULD")) {
		    wrk.INSA050_ULD(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new INSA050EJB(p_box, p_tr));
	}


}