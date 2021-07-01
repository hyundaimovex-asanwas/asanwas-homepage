package Ehr.but.a.buta020.cmd;

import Ehr.but.a.buta020.wrk.BUTA020WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class BUTA020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		BUTA020WRK wrk = new BUTA020WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_01")) {
			//ǰ�ǹ�ȣ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_01(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_02")) {
			//������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_02(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_03")) {
			//����ǰ�Ǽ� �ۼ� ���� �� ���� ������ ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_03(p_box, p_tr);
		}
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_05")) {
			//����ǰ�Ǽ� �ۼ� ���� �� ���� ������ ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_05(p_box, p_tr);
		}		
		
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_PER")) {
			//����ǰ�Ǽ� �ۼ� ���� �� ���� ������ ���� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SHR_PER(p_box, p_tr);
		}	
		
		//S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV_01")) {
			//����ǰ�� �ۼ����� �����  ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_01(p_box, p_tr);
		}
		
		//S_MODE�� ����� ���
		else if (p_box.get("S_MODE").equals("SAV_01_APP")) {
			//����ǰ�� �ۼ����� �����  ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_01_APP(p_box, p_tr);
		}
		//S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV_02")) {
			//����ǰ�� ������Ȳ�� ���, ����, ����ó�� ����� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_02(p_box, p_tr);
		}
		//S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV_03")) {
			//����ǰ�� ������Ȳ�� �ΰ�, �ݼ�ó�� ����� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_03(p_box, p_tr);
		}
		//S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV_DATE")) {
			//�λ������� ��¥�� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.BUTA020_SAV_DATE(p_box, p_tr);
		}		
		
		
		//EjbProxy.controlTxn(new BUTA020EJB(p_box, p_tr));
	}

}
