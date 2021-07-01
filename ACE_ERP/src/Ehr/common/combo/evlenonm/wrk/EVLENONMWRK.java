package common.combo.evlenonm.wrk;

import common.combo.evlenonm.dao.EVLENONMDAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EVLENONMWRK {

    /**
     * 피평가자에 대한 평가자 조회 (조회) WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void EVLENONM_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 피평가자에 대한 평가자 조회 (조회) DAO CLASS 메서드 호출 * */
		EVLENONMDAO dao = new EVLENONMDAO("default", p_tr);
		dao.EVLENONM_SHR(p_box);

	}

}
