package hr.pir.a.pira016.ejb;

import hr.pir.a.pira016.wrk.PIRA016WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA016EJB extends EJB {

    public CBox box = null;
    public TrBox trBox = null;
    public PIRA016EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }
    
	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		PIRA016WRK wrk = new PIRA016WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����), DEL(����) **/ 
		if (box.get("S_MODE").equals("SHR")) {
			/**
			 * �з»��� �ǿ��� ȭ�� ���½� �Ǵ� ��� ����ÿ�
			 * �з»��� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.PIRA016_SHR(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * �з»��� ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * �з»��� �����͸� �Է� �Ǵ� �����Ѵ�. 
			 */
			wrk.PIRA016_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * �з»��� ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * �з»��� �����͸� �����Ѵ�. 
			 */
			wrk.PIRA016_DEL(box, trBox);
		}

		return null;
	}

}
