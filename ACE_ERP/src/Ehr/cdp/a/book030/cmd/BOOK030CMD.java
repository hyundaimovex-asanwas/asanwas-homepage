package Ehr.cdp.a.book030.cmd;

import Ehr.cdp.a.book030.ejb.BOOK030EJB;
import Ehr.cdp.a.book030.wrk.BOOK030WRK;

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

public class BOOK030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		//EjbProxy.controlTxn(new BOOK030EJB(p_box, p_tr));
		
		
		BOOK030WRK wrk = new BOOK030WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//���ϱٹ��ް���û�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK030_SHR(p_box, p_tr);
		}

		// ������ ��ȸ
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK030_SHR_02(p_box, p_tr);
		}


		// ������ ��ȸ
		else if (p_box.get("S_MODE").equals("SHR_PRINT")) {
			wrk.BOOK030_SHR_PRINT(p_box, p_tr);
		}
		
		// ������ ��ȸ
		else if (p_box.get("S_MODE").equals("SHR_PRINT2")) {
			wrk.BOOK030_SHR_PRINT2(p_box, p_tr);
		}		
		
		// ����������Ȳ��ȸ
		else if (p_box.get("S_MODE").equals("SHR_40")) {
			wrk.BOOK030_SHR_40(p_box, p_tr);
		}

	}

}
