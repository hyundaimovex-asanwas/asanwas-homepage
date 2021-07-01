package Ehr.pir.g.pirg010.cmd;

import Ehr.pir.g.pirg010.wrk.PIRG010WRK;

import java.rmi.RemoteException;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class PIRG010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRG010WRK wrk = new PIRG010WRK();

		if (p_box.get("S_MODE").equals("SAV")) {
			//	����ȭ���� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.PIRG010_SAV(p_box, p_tr);
		}
		if (p_box.get("S_MODE").equals("ULD")) {
		    //	����ȭ���� �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.PIRG010_ULD(p_box, p_tr);
		}
	
		//EjbProxy.controlTxn(new PIRG010EJB(p_box, p_tr));
	}


}