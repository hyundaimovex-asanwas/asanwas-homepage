package Ehr.gun.a.guna030.cmd;

import Ehr.gun.a.guna030.wrk.GUNA030WRK;

import java.rmi.RemoteException;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.cmd.AbstractGauceCMD;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.collection.CollectionUtility;
import com.shift.gef.support.utility.SessionUtil;

public class GUNA030CMD implements AbstractGauceCMD {

    public void execute(HttpGauceRequest p_req, HttpGauceResponse p_res,
            TrBox p_tr) throws CException, RemoteException, Throwable {
        /** Request�� Parsing�Ͽ� CBox��ü�� ���� **/
        CBox p_box = CollectionUtility.getGauceDataBox(p_req);
        
        /** ���� ���� CBox�� ���� :: ���� Request������ �߰��ϴ� ���� * */
        p_box = SessionUtil.getSession(p_req, p_box);
        
        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        GUNA030WRK wrk = new GUNA030WRK();

        // S_MODE�� ��ȸ�� ���
        if (p_box.get("S_MODE").equals("SHR")) {
            wrk.GUNA030_SHR(p_box, p_tr);
        }
        
        // S_MODE�� ����(����)�� ���
        else if (p_box.get("S_MODE").equals("SAV")) {
            wrk.GUNA030_SAV(p_box, p_tr);
        }
        
        //�ϰ�����
        else if (p_box.get("S_MODE").equals("SAV_01")) {
            wrk.GUNA030_SAV_01(p_box, p_tr);
        }        
        
        
        //EjbProxy.controlTxn(new GUNA030EJB(p_box, p_tr));
    }


}