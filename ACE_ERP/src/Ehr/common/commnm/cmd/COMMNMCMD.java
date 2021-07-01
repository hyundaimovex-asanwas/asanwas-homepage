package Ehr.common.commnm.cmd;

import Ehr.common.commnm.wrk.COMMNMWRK;

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

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		COMMNMWRK wrk = new COMMNMWRK();

		/** S_MOD : SHR(��ȸ), SAV(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			/**
			 * ���뱸���ڵ�� �ڵ带 �Է��ϸ�
			 * �ش� �����ڵ���� ��ȸ�ؿ´�.
			 */
			wrk.COMMNM_SHR(p_box, p_tr);
		}

		else if (p_box.get("S_MODE").equals("SHR_06")) {
			/**
			 * �޺��ڽ� �ڵ� ����(�λ���)
			 */
			wrk.COMMNM_SHR_06(p_box, p_tr);
		}

		else if (p_box.get("S_MODE").equals("SHR_07")) {
			/**
			 * �ش� �Ҽ��� �ι��� �����´�
			 */
			wrk.COMMNM_SHR_07(p_box, p_tr);
		}

		else if (p_box.get("S_MODE").equals("SHR_00")) {
		    /**
		     * �ش� �Ҽ��� �ι��� �����´�
		     */        
		    wrk.COMMNM_SHR_00(p_box, p_tr);
		}

		else if (p_box.get("S_MODE").equals("SHR_DPT")) {
		    /**
		     * �ش� �Ҽ��� �ι��� �����´�
		     */
		    wrk.COMMNM_SHR_DPT(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_DPT2")) {
		    /**
		     * �ش� �Ҽ��� �ι��� �����´�
		     */
		    wrk.COMMNM_SHR_DPT2(p_box, p_tr);
		}
		else if (p_box.get("S_MODE").equals("SHR_DPT3")) {
		    /**
		     * �ش� �Ҽ��� �ι��� �����´�
		     */
		    wrk.COMMNM_SHR_DPT3(p_box, p_tr);
		}
        //EjbProxy.controlTxn(new COMMNMEJB(p_box, p_tr));

 	}

}