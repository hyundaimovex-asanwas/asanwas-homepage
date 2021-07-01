package Ehr.cod.b.codb020.cmd;

import Ehr.cod.b.codb020.wrk.CODB020WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODB020CMD implements AbstractGauceCMD {

	/**
	 * �����ڵ��� command class
	 * head��ȸ, sub��ȸ, ���忡 ���
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODB020WRK wrk = new CODB020WRK();

		/** Ʈ����ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.CODB020_SHR(p_box, p_tr);
		
		
		/** �μ��ڵ� �� ��ȸ **/
		}else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.CODB020_SHR_01(p_box, p_tr);
			
		/** HEAD�ڵ� ��� ��ȸ **/
		}else if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.CODB020_SHR_02(p_box, p_tr);
		
		
		/** �μ������� �ϳ��� ������ ȸ�������� �ִ´�. **/
		}else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.CODB020_SAV(p_box, p_tr);
		
		
		/** ������ ���� **/
		}else if (p_box.get("S_MODE").equals("SAV_01")) {
			wrk.CODB020_SAV_01(p_box, p_tr);
		

		/** ������ ���� **/
		}else if (p_box.get("S_MODE").equals("DEL")) {
			wrk.CODB020_DEL(p_box, p_tr);
		}	
		
		//EjbProxy.controlTxn(new CODB010EJB(p_box, p_tr));

	}

}
