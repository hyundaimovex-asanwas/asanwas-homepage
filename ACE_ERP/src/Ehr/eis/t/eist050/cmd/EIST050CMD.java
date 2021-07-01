package Ehr.eis.t.eist050.cmd;

import Ehr.eis.t.eist050.wrk.EIST050WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class EIST050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);
			
		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
		
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EIST050WRK wrk = new EIST050WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //��ȸ�ؿ´�. 
			wrk.EIST050_SHR(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SHR_TEAM")) {
			 //���� ��ȸ�ؿ´�. 
			wrk.EIST050_SHR_TEAM(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV")) {
			 //�����Ѵ�. 
			wrk.EIST050_SAV(p_box, p_tr);
			
		}else if (p_box.get("S_MODE").equals("SAV_01")) {
			 //�ΰǺ� ��� ����Ѵ�. 
			wrk.EIST050_SAV_01(p_box, p_tr);			
			
		}else if (p_box.get("S_MODE").equals("ULD")) {
			 //���ε� �Ѵ�. 
			wrk.EIST050_ULD(p_box, p_tr);				
			
		}else if (p_box.get("S_MODE").equals("DEL")) {
			 //������ �����Ѵ�. 
			wrk.EIST050_DEL(p_box, p_tr);
			
		}        
        
        //EjbProxy.controlTxn(new EIST050EJB(p_box, p_tr));
		
 	}

}
