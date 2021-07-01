package hr.pir.c.pirc011.ejb;

import hr.pir.c.pirc011.wrk.PIRC011WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRC011EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRC011EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRC011WRK wrk = new PIRC011WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �λ�⺻2 �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �λ���ǥ �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRC011_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �λ�⺻2 �ǿ��� �����ư�� Ŭ���� ��,
			 * �λ���ǥ �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRC011_SAV(box, trBox);
		}

		return null;
	}

}
