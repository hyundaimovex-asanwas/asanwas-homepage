package Ehr.sag.a.saga200.wrk;

import Ehr.sag.a.saga200.dao.SAGA200DAO;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class SAGA200WRK {

	/**
	 * 급여테이블 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA200_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA200DAO dao = new SAGA200DAO("default", p_tr);
		
		dao.SAGA200_SHR(p_box);

	}

	/**
	 * 급여테이블 적용일자 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA200_SHR_ALL(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA200DAO dao = new SAGA200DAO("default", p_tr);
		
		dao.SAGA200_SHR_ALL(p_box);

	}


}
