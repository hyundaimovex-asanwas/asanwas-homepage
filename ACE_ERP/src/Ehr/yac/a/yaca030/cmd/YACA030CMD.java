package Ehr.yac.a.yaca030.cmd;

import Ehr.yac.a.yaca030.wrk.YACA030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		YACA030WRK wrk = new YACA030WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//�Ƿ��������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SHR(p_box, p_tr);
		}
		
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_14")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SHR_14(p_box, p_tr);
		}		
		
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_15")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SHR_15(p_box, p_tr);
		}		
		
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_FAM")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SHR_FAM(p_box, p_tr);
		}
		
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_FAM_14")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SHR_FAM_14(p_box, p_tr);
		}		
		
		// S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_FAM_15")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SHR_FAM_15(p_box, p_tr);
		}		
		
		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SAV(p_box, p_tr);
		}

		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV_14")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SAV_14(p_box, p_tr);
		
		}		
		
		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV_15")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_SAV_15(p_box, p_tr);
		
		}		
		
        // S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("DEL")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_DEL(p_box, p_tr);
		}
		
        // S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("DEL_14")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_DEL_14(p_box, p_tr);
		}
		
		 // S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("DEL_15")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_DEL_15(p_box, p_tr);
		}
		
		else if (p_box.get("S_MODE").equals("ACC")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_UPT_ACC(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("ACC_14")) {
			//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA030_UPT_FAM_14(p_box, p_tr);			
			wrk.YACA030_UPT_ACC_14(p_box, p_tr);
		}
		
		else if (p_box.get("S_MODE").equals("ACC_15")) {
				//�Ƿ����������� �����ϱ� ���� WORK�޼ҵ� ȣ��
				wrk.YACA030_UPT_FAM_15(p_box, p_tr);			
				wrk.YACA030_UPT_ACC_15(p_box, p_tr);
		}			
		
		//EjbProxy.controlTxn(new YACA030EJB(p_box, p_tr));
	}

}
