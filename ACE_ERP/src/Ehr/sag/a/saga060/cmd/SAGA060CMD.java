package Ehr.sag.a.saga060.cmd;

import java.rmi.RemoteException;

import Ehr.sag.a.saga060.wrk.SAGA060WRK;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGA060CMD implements AbstractGauceCMD {

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

		//EjbProxy.controlTxn(new SAGA060EJB(p_box, p_tr));

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGA060WRK wrk = new SAGA060WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGA060_SHR(p_box, p_tr);
		}

		/** ��¿� ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.SAGA060_SHR_PRINT(p_box, p_tr);
		}

		if (p_box.get("S_MODE").equals("SHR_PRINT_02")) {
			wrk.SAGA060_SHR_PRINT_02(p_box, p_tr);
		}

		if (p_box.get("S_MODE").equals("SHR_PRINT_03")) {
			wrk.SAGA060_SHR_PRINT_03(p_box, p_tr);
		}		
		
		
	}

}
