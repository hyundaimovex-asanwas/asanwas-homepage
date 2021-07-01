package Ehr.yac.a.yaca080.wrk;

import Ehr.yac.a.yaca080.dao.YACA080DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class YACA080WRK {

	/**
	 * 데이타유효성체크 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA080_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		YACA080DAO dao = new YACA080DAO("default", p_tr);
		dao.YACA080_SHR(p_box);

	}
	
	
	/**
	 * 데이타유효성체크 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void YACA080_SHR_15(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		YACA080DAO dao = new YACA080DAO("default", p_tr);
		dao.YACA080_SHR_15(p_box);

	}

}
