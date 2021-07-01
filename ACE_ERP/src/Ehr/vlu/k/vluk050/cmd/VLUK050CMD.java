package Ehr.vlu.k.vluk050.cmd;

import Ehr.vlu.k.vluk050.wrk.VLUK050WRK;

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

public class VLUK050CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {
		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
		p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		VLUK050WRK wrk = new VLUK050WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {
			wrk.VLUK050_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR2")) {
            wrk.VLUK050_SHR2(p_box, p_tr);			
		}else  if (p_box.get("S_MODE").equals("SHR_01")) {
            wrk.VLUK050_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02")) {
            wrk.VLUK050_SHR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_03")) {
            wrk.VLUK050_SHR_03(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_SCR")) {
            wrk.VLUK050_SHR_SCR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_SCR_01")) {
            wrk.VLUK050_SHR_SCR_01(p_box, p_tr);     
		}else  if (p_box.get("S_MODE").equals("SHR_ITEM")) {
            wrk.VLUK050_SHR_ITEM(p_box, p_tr);     
		}else  if (p_box.get("S_MODE").equals("SHR_ITEM_01")) {
            wrk.VLUK050_SHR_ITEM_01(p_box, p_tr);      
		}else  if (p_box.get("S_MODE").equals("SHR_CMT")) {
            wrk.VLUK050_SHR_CMT(p_box, p_tr);               
		}else  if (p_box.get("S_MODE").equals("SAV")) {	
            wrk.VLUK050_SAV(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_01")) {
            wrk.VLUK050_SAV_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_CMT")) {
            wrk.VLUK050_SAV_CMT(p_box, p_tr);            
		}else  if (p_box.get("S_MODE").equals("SAV_COR")) {
            wrk.VLUK050_SAV_COR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_01")) {
            wrk.VLUK050_SAV_COR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_02")) {
            wrk.VLUK050_SAV_COR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_03")) {
            wrk.VLUK050_SAV_COR_03(p_box, p_tr);
		}		
		
		//EjbProxy.controlTxn(new VLUK050EJB(p_box, p_tr));
	}


}