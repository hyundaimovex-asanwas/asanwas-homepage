package Ehr.sag.a.saga270.cmd;

import Ehr.sag.a.saga270.wrk.SAGA270WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGA270CMD implements AbstractGauceCMD {

	/**
	 *�޻�������Ȳ command class
	 *��ȸ, ����, ������ ���
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGA270WRK wrk = new SAGA270WRK();

		/** MASTER ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGA270_SHR(p_box, p_tr);
		}
		/** DETAIL ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR_01")) {
			wrk.SAGA270_SHR_01(p_box, p_tr);
		}

		/** DETAIL ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGA270_SHR_PRINT(p_box, p_tr);
		}

		/** MASTER ���� **/
		if (p_box.get("S_MODE").equals("SAV")) {
			wrk.SAGA270_SAV(p_box, p_tr);
		}

		/** DETAIL ���� **/
		if (p_box.get("S_MODE").equals("SAV_01")) {
			wrk.SAGA270_SAV_01(p_box, p_tr);
		}

		/** �ߵ���ȯ ���� **/
		if (p_box.get("S_MODE").equals("SAV_REP")) {
			wrk.SAGA270_SAV_REP(p_box, p_tr);
		}
		
		
		//EjbProxy.controlTxn(new SAGA270EJB(p_box, p_tr));

	}

}
