package Ehr.yac.a.yaca040.cmd;

import Ehr.yac.a.yaca040.wrk.YACA040WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class YACA040CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		YACA040WRK wrk = new YACA040WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SHR(p_box, p_tr);
		}

		//	S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_05")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SHR_05(p_box, p_tr);
		}
		
		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_14")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SHR_14(p_box, p_tr);
		}
		
        //		S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR_15")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SHR_15(p_box, p_tr);
		}		

		//	S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR2_14")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SHR2_14(p_box, p_tr);
		}	
		
		//	S_MODE�� ��ȸ�� ���
		else if (p_box.get("S_MODE").equals("SHR2_15")) {
			//��αݰ������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SHR2_15(p_box, p_tr);
		}	
		
		

		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SAV(p_box, p_tr);
		}

		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV_14")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SAV1_14(p_box, p_tr);
			wrk.YACA040_SAV2_14(p_box, p_tr);
			wrk.YACA040_SAV3_14(p_box, p_tr);	
			wrk.YACA040_SAV4_14(p_box, p_tr);			
		}		
		
		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("SAV_15")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_SAV1_15(p_box, p_tr);
			wrk.YACA040_SAV2_15(p_box, p_tr);
			wrk.YACA040_SAV3_15(p_box, p_tr);	
			wrk.YACA040_SAV4_15(p_box, p_tr);			
		}		
		
        // S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("DEL")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_DEL(p_box, p_tr);
		}
		
        // S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("DEL_14")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_DEL_14(p_box, p_tr);
		}	
		
		// S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("DEL_15")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_DEL_15(p_box, p_tr);
		}	

		//	S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("ACC")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_UPT_ACC(p_box, p_tr);
		}		
		
		//	S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("ACC_14")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_UPT_FAM_14(p_box, p_tr);
			wrk.YACA040_UPT_ACC_14(p_box, p_tr);			
		}			
		
//		S_MODE�� ������ ���
		else if (p_box.get("S_MODE").equals("ACC_15")) {
			//��αݰ��������� �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.YACA040_UPT_FAM_15(p_box, p_tr);
			wrk.YACA040_UPT_ACC_15(p_box, p_tr);			
		}			
		
		//EjbProxy.controlTxn(new YACA040EJB(p_box, p_tr));
	}

}
