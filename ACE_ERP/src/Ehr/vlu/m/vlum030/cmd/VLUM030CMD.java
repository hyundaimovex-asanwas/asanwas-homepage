package Ehr.vlu.m.vlum030.cmd;

import Ehr.vlu.m.vlum030.wrk.VLUM030WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUM030CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        VLUM030WRK wrk = new VLUM030WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR_01")) {  //������ ���
			wrk.VLUM030_SHR_01(p_box, p_tr);
		}else if (p_box.get("S_MODE").equals("SHR_02")) {  //������ ���
				wrk.VLUM030_SHR_02(p_box, p_tr);	
		}else if (p_box.get("S_MODE").equals("SHR_03")) {  //���� ���
			wrk.VLUM030_SHR_03(p_box, p_tr);				
		}  
        
        
        //EjbProxy.controlTxn(new VLUL010EJB(p_box, p_tr));

	}

}
