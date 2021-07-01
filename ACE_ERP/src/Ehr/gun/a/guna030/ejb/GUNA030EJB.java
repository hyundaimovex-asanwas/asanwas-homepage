package hr.gun.a.guna030.ejb;

import hr.gun.a.guna030.wrk.GUNA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class GUNA030EJB extends EJB {

    private CBox box = null;
    private TrBox tr = null;

    public GUNA030EJB(CBox p_box, TrBox p_tr ) throws CException {
        this.box = p_box;
        this.tr = p_tr;
    }

    public Object process() throws CException {
        /** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
        GUNA030WRK wrk = new GUNA030WRK();

        // S_MODE�� ��ȸ�� ���
        if (box.get("S_MODE").equals("SHR")) {
            wrk.GUNA030_SHR(box, tr);
        }
        
        // S_MODE�� ����(����)�� ���
        else if (box.get("S_MODE").equals("SAV")) {
            wrk.GUNA030_SAV(box, tr);
        }
        
        //�ϰ�����
        else if (box.get("S_MODE").equals("SAV_01")) {
            wrk.GUNA030_SAV_01(box, tr);
        }
        
        // S_MODE�� ������ ���
//		else if (box.get("S_MODE").equals("DEL")) {
//			wrk.DOCB010_DEL(box, tr);
//		}

        return null;
    }

}
