package Ehr.edu.e.edue020.ejb;

import Ehr.edu.e.edue020.wrk.EDUE020WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.ejb.EJB;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE020EJB extends EJB {
	
    public CBox box = null;
    public TrBox trBox = null;
    public EDUE020EJB(CBox p_box, TrBox p_tr) throws CException {
    	box = p_box;
    	trBox = p_tr;
    }

	public Object process() throws CException {
		/** Worker Class ��ü ������ ���� �޼ҵ� ȣ�� **/
		EDUE020WRK wrk = new EDUE020WRK();
		
		/** S_MOD : SHR(��ȸ), SAV(����) */ 
		if (box.get("S_MODE").equals("SHR_00")) {
			/**
			 * ����������û�� ȭ�鿡�� ȭ����½ÿ�
			 * ����������û�� �����͸� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE020_SHR_00(box, trBox);
		}
		else if (box.get("S_MODE").equals("SHR_01")) {
			/**
			 * ����������û�� ȭ�鿡�� �����ư Ŭ���� ��
			 * ����������û�� �������θ� ��ȸ�ؿ´�. 
			 */
			wrk.EDUE020_SHR_01(box, trBox);
		}
		else if (box.get("S_MODE").equals("SAV")) {
			/**
			 * ����������û�� ȭ�鿡�� �����ư�� Ŭ���� ��,
			 * ����������û�� �����͸� �����Ѵ�. 
			 */
			wrk.EDUE020_SAV(box, trBox);
		}
		else if (box.get("S_MODE").equals("STS")) {
			/**
			 * ����������û�� ȭ�鿡�� ���¸� ������ ��,
			 * ���� ���¸� �����Ѵ�. 
			 */
			wrk.EDUE020_UPT_00(box, trBox);
		}
		else if (box.get("S_MODE").equals("DEL")) {
			/**
			 * ����������û�� ȭ�鿡�� ������ư�� Ŭ���� ��,
			 * ����������û�� �����͸� �����Ѵ�. 
			 */
			wrk.EDUE020_DEL(box, trBox);
		}
		else if (box.get("S_MODE").equals("PROC")) {
			/**
			 * ����������û�� ȭ�鿡�� ���� �� ��,
			 * ������ �����Ѵ�. 
			 */
			wrk.EDUE020_PROC(box, trBox);
		}

		return null;
	}

}
