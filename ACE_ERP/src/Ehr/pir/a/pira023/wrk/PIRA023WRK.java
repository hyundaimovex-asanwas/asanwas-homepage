package Ehr.pir.a.pira023.wrk;

import Ehr.pir.a.pira023.dao.PIRA023DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA023WRK {
	/**
	 * 해외출장 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA023_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA023DAO 객체 생성 후 관련 메소드 호출 */
		PIRA023DAO dao = new PIRA023DAO("default", p_tr);

        /** 해외출장 SELECT하는 DAO 메소드 호출 */
		dao.PIRA023_SHR(p_box);

	}
}
