package Ehr.cod.e.code010.wrk;

import Ehr.cod.e.code010.dao.CODE010DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class CODE010WRK {

	/**
	 * 일련번호를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE010_SHR_ACC(CBox p_box, TrBox p_tr) throws CException {

		/** CODE010DAO 객체 생성 후 관련 메소드 호출 */
		CODE010DAO dao = new CODE010DAO("default", p_tr);

        /** 일련번호 SELECT하는 DAO 메소드 호출 */
		dao.CODE010_SHR_ACC(p_box);

	}

}

