package Ehr.pir.a.pira032.wrk;

import Ehr.pir.a.pira032.dao.PIRA032DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA032WRK {
	/**
	 * 학력사항 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA032_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA032DAO 객체 생성 후 관련 메소드 호출 */
		PIRA032DAO dao = new PIRA032DAO("default", p_tr);

        /** 학력사항 SELECT하는 DAO 메소드 호출 */
		dao.PIRA032_SHR(p_box);

	}
}
