package Ehr.idt.b.idtb002.cmd;

import Ehr.idt.b.idtb002.wrk.IDTB002WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;
import Ehr.common.util.JSPUtil;

public class IDTB002CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
	
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

        //System.out.println("p_box111   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());	    

        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		IDTB002WRK wrk = new IDTB002WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	���� ��Ȳ ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB002_SHR(p_box, p_tr);
		}

		// S_MODE�� ����, ������ ���
		if (p_box.get("S_MODE").equals("SAV")) {
			//	���� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB002_SAV(p_box, p_tr);
		}

		// S_MODE�� ������ ���
		if (p_box.get("S_MODE").equals("DEL")) {
			//	���� ������ �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.IDTB002_DEL(p_box, p_tr);
		}

	}

}