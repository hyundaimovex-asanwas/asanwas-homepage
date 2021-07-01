package Ehr.gun.d.gund020.cmd;

import Ehr.gun.d.gund020.wrk.GUND020WRK;

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

public class GUND020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		GUND020WRK wrk = new GUND020WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//�����ް���������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.GUND020_SHR(p_box, p_tr);
		}
		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SHR_01")) {
			//�����ް������������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUND020_SHR_01(p_box, p_tr);
		}
		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV")) {
			//�����ް������������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.GUND020_SAV(p_box, p_tr);
		}
        // S_MODE��  ����� ���
        else if (p_box.get("S_MODE").equals("REP")) {
           //�����Է� flag���� Ȯ�����ֱ����� WORK�޼ҵ� ȣ��
           wrk.GUND020_REP(p_box, p_tr);
       }		
		
		//EjbProxy.controlTxn(new GUND020EJB(p_box, p_tr));
	}

}
