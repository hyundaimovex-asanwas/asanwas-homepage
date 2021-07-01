package Ehr.vlu.o.vluo100.cmd;

import Ehr.vlu.o.vluo100.wrk.VLUO100WRK;

import java.rmi.RemoteException;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUO100CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� * */
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		VLUO100WRK wrk = new VLUO100WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) */
		if (p_box.get("S_MODE").equals("SHR")) {
			 //��ȸ�ؿ´�. 
			wrk.VLUO100_SHR(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("SHR_22")) {
			 //��ȸ�ؿ´�. 
			wrk.VLUO100_SHR_22(p_box, p_tr);
		}				
		
		else if (p_box.get("S_MODE").equals("SHR_PRT")) {
			 //��ȸ�ؿ´�. 
			wrk.VLUO100_SHR_PRT(p_box, p_tr);
		}				
		
		else if (p_box.get("S_MODE").equals("SAV")) {
			 //�����Ѵ�. 
			wrk.VLUO100_SAV(p_box, p_tr);
		}			
		
		else if (p_box.get("S_MODE").equals("SAV_01")) {
			 //���ó��
			wrk.VLUO100_SAV_01(p_box, p_tr);
			wrk.VLUO100_SAV_011(p_box, p_tr);			
		}				
		
		else if (p_box.get("S_MODE").equals("SAV_02")) {
			 //���� or �ΰ� ó�� 
			wrk.VLUO100_SAV_02(p_box, p_tr);
		}		
		
		else if (p_box.get("S_MODE").equals("UPT_02")) {
			 //���� or �ΰ� ó�� 
			wrk.VLUO100_UPT_02(p_box, p_tr);
			wrk.VLUO100_UPT_03(p_box, p_tr);			
		}			
		
        //GauceDataSet ds = (GauceDataSet)EjbProxy.controlTxn( new VLUL080EJB(p_box, p_tr));

	}

}