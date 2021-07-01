package Ehr.pir.a.pira030.wrk;

import Ehr.pir.a.pira030.dao.PIRA030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA030WRK {
	/**
	 * 공조부조 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA030DAO 객체 생성 후 관련 메소드 호출 */
		PIRA030DAO dao = new PIRA030DAO("default", p_tr);

        /** 공조부조 SELECT하는 DAO 메소드 호출 */
		dao.PIRA030_SHR(p_box);

	}
}
