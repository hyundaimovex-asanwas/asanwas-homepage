package hr.pir.a.pira030.ejb;

import hr.pir.a.pira030.wrk.PIRA030WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA030EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA030EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA030WRK wrk = new PIRA030WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �������� �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �������� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA030_SHR(box, trBox);
		}

		return null;
	}

}
