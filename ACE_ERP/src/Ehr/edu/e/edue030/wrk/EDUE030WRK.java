package Ehr.edu.e.edue030.wrk;

import Ehr.edu.e.edue030.dao.EDUE030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EDUE030WRK {
	/**
	 * 현재모집과정 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE030DAO 객체 생성 후 관련 메소드 호출 */
		EDUE030DAO dao = new EDUE030DAO("default", p_tr);

        /** 현재모집과정 SELECT하는 DAO 메소드 호출 */
		dao.EDUE030_SHR(p_box);

	}
}
