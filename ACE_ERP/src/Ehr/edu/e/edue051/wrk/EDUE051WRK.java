package Ehr.edu.e.edue051.wrk;

import Ehr.edu.e.edue051.dao.EDUE051DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE051WRK {
	/**
	 * 과정정보 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE051_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE051DAO 객체 생성 후 관련 메소드 호출 */
		EDUE051DAO dao = new EDUE051DAO("default", p_tr);

        /** 과정정보 SELECT하는 DAO 메소드 호출 */
		dao.EDUE051_SHR(p_box);

	}
}
