package common.popup.post.wrk;

import common.popup.post.dao.POSTDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class POSTWRK {
	
	/**
	 * �����ȣ ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void POST_SHR(CBox p_box, TrBox p_tr) throws CException {
		
			POSTDAO dao = new POSTDAO("default", p_tr);
			dao.POST_SHR(p_box);
			
	}
	
}

