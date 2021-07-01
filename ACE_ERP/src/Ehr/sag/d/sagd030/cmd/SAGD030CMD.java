package Ehr.sag.d.sagd030.cmd;

import Ehr.sag.d.sagd030.wrk.SAGD030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class SAGD030CMD implements AbstractGauceCMD {

	/**
	 *�޿����ó�� command class
	 *��ȸ, ����, ������ ���
	 */
	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		//EjbProxy.controlTxn(new SAGD030EJB(p_box, p_tr));
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		SAGD030WRK wrk = new SAGD030WRK();

		/** ��ȸ **/
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.SAGD030_SHR(p_box, p_tr);
		}

		/** �۾��α� �ű����� (�۾� OPEN) **/
		else if (p_box.get("S_MODE").equals("SAV")) {
			wrk.SAGD030_SAV(p_box, p_tr);
		}

		/** ����� ���� **/
		else if (p_box.get("S_MODE").equals("SAV_01")) {
			wrk.SAGD030_SAV_01(p_box, p_tr);
		}

		/** ����� �ʱ�ȭ **/
		else if (p_box.get("S_MODE").equals("SAV_02")) {
			wrk.SAGD030_SAV_02(p_box, p_tr);
		}

		/** �ݾס����װ�� **/
		else if (p_box.get("S_MODE").equals("SAV_03")) {
			wrk.SAGD030_SAV_03(p_box, p_tr);
		}

		/** ��� �ʱ�ȭ **/
		else if (p_box.get("S_MODE").equals("SAV_04")) {
			wrk.SAGD030_SAV_04(p_box, p_tr);
		}

		/** �۾�CLOSE **/
		else if (p_box.get("S_MODE").equals("SAV_05")) {
			wrk.SAGD030_SAV_05(p_box, p_tr);
		}		
		
		

	}

}
