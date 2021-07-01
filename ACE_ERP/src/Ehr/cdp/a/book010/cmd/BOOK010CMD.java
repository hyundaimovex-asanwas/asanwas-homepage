package Ehr.cdp.a.book010.cmd;

import Ehr.cdp.a.book010.ejb.BOOK010EJB;
import Ehr.cdp.a.book010.wrk.BOOK010WRK;

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

public class BOOK010CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);


		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);
		//EjbProxy.controlTxn(new BOOK010EJB(p_box, p_tr));
		
		BOOK010WRK wrk = new BOOK010WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//���ϱٹ��ް���û�� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK010_SHR(p_box, p_tr);
		}

		// ������ ��ȸ
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			wrk.BOOK010_SHR_02(p_box, p_tr);
		}

		// ��û��ȣ ��ȸ
		else if (p_box.get("S_MODE").equals("SHR_03")) {
			wrk.BOOK010_SHR_03(p_box, p_tr);
		}

		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV")) {
			//�������Խ�û�� �ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK010_SAV(p_box, p_tr);
		}


		// S_MODE�� ������ ��� - ������� ���
		else if (p_box.get("S_MODE").equals("UPT_APP")) {
		    //������û�� �����ϱ� ���� WORK�޼ҵ� ȣ��
		    wrk.BOOK010_UPT_APP(p_box, p_tr);
		}




		// S_MODE�� ����� �˾���ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_11")) {
			//�������Խ�û �˾���ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK010_SHR_11(p_box, p_tr);
		}

		// S_MODE�� ���缱 ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_APP")) {
			//�������Խ�û �˾���ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BOOK010_SHR_APP(p_box, p_tr);
		}



        // S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("DEL")) {
			//���ϱٹ��ް���û�� �����ϱ� ���� WORK�޼ҵ� ȣ��
			//wrk.BOOK010_DEL(p_box, p_tr);
		}
		
		
	}

}
