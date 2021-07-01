package Ehr.cod.f.codf010.cmd;

import Ehr.cod.f.codf010.wrk.CODF010WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class CODF010CMD implements AbstractGauceCMD {

	/**
	 * �����ڵ���� command class
	 * �ű�Ʈ�� ����, head��ȸ, sub��ȸ, ���忡 ���
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		CODF010WRK wrk = new CODF010WRK();

		/** Ʈ����ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.CODF010_SHR(p_box, p_tr);
		}
		/** �����ڵ� �� ��ȸ **/
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.CODF010_SHR_01(p_box, p_tr);
		}
		/** ���������� �ϳ��� ������ ȸ�������� �ִ´�. **/
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.CODF010_SAV(p_box, p_tr);
		}
		/** ������ ���� **/
		else if (p_box.get("S_MODE").equals("SAV_01")) {
			wrk.CODF010_SAV_01(p_box, p_tr);
		}
		/** ������ ���� **/
		else if (p_box.get("S_MODE").equals("DEL_01")) {
			wrk.CODF010_DEL_01(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new CODF010EJB(p_box, p_tr));

	}
}
