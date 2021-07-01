package Ehr.vlu.l.vlul020.cmd;

import Ehr.vlu.l.vlul020.wrk.VLUL020WRK;

import java.rmi.RemoteException;

import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class VLUL020CMD implements AbstractGauceCMD {

	public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
			TrBox p_tr) throws CException, RemoteException, Throwable {

		/** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
		CBox p_box = CollectionUtility.getGauceDataBox(p_req);

		/** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);

		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		VLUL020WRK wrk = new VLUL020WRK();

		// S_MODE�� ��ȸ�� ���
		if (p_box.get("S_MODE").equals("SHR")) {  //����
			wrk.VLUL020_SHR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_01")) { //����
            wrk.VLUL020_SHR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_02")) { //�μ��庻��
            wrk.VLUL020_SHR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_03")) { //�μ��庻���
            wrk.VLUL020_SHR_03(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_ITEM")) { //���� �����
            wrk.VLUL020_SHR_ITEM(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SHR_ITEM_01")) { //�μ��� ��� ��
            wrk.VLUL020_SHR_ITEM_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV")) { //��������
            wrk.VLUL020_SAV(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_01")) { //�μ�������
            wrk.VLUL020_SAV_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR")) { //���Ժ���
            wrk.VLUL020_SAV_COR(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("VLUL020_UPT")) { //��ຸ��
            wrk.VLUL020_SAV_COR_01(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_02")) { //�μ��庸��
            wrk.VLUL020_SAV_COR_02(p_box, p_tr);
		}else  if (p_box.get("S_MODE").equals("SAV_COR_PJT")) { //PJT����
            wrk.VLUL020_SAV_COR_PJT(p_box, p_tr);
		}  
        
        
        //EjbProxy.controlTxn(new VLUL010EJB(p_box, p_tr));

	}

}
