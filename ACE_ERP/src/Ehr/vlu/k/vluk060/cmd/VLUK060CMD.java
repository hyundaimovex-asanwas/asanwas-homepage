package Ehr.vlu.k.vluk060.cmd;

import Ehr.vlu.k.vluk060.wrk.VLUK060WRK;

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

public class VLUK060CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		VLUK060WRK wrk = new VLUK060WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			//	�򰡱����������� ��ȸ�� ���� WORK�޼ҵ� ȣ��
			wrk.VLUK060_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR02")) {
			//	�򰡱������������� ����, �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.VLUK060_SHR02(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			//	�򰡱������������� ����, �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.VLUK060_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("DEL")) {
			//	�򰡱������������� ����, �����ϱ� ���� WORK�޼ҵ� ȣ��
			wrk.VLUK060_DEL(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new VLUK060EJB(p_box, p_tr));
	}


}