package common.popup.train.wrk;

import common.popup.train.dao.TRAINDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class TRAINWRK {

	/**
	 * 철도빈번노선 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void TRAIN_SHR(CBox p_box, TrBox p_tr) throws CException {

		    TRAINDAO dao = new TRAINDAO("default", p_tr);
     		dao.TRAIN_SHR(p_box);
	}

}

