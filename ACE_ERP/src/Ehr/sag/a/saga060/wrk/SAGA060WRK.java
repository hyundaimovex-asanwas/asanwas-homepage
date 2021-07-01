package Ehr.sag.a.saga060.wrk;

import Ehr.sag.a.saga060.dao.SAGA060DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class SAGA060WRK {

	/**
	 * 급상여지급현황 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA060_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA060DAO dao = new SAGA060DAO("default", p_tr);

		dao.SAGA060_SHR(p_box);


	}


	/**
	 * 출력물 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA060_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {
		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA060DAO dao = new SAGA060DAO("default", p_tr);
			dao.SAGA060_SHR_PRINT(p_box);
	}

	public void SAGA060_SHR_PRINT_02(CBox p_box, TrBox p_tr) throws CException {
		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA060DAO dao = new SAGA060DAO("default", p_tr);
			dao.SAGA060_SHR_PRINT_02(p_box);
	}
	public void SAGA060_SHR_PRINT_03(CBox p_box, TrBox p_tr) throws CException {
		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA060DAO dao = new SAGA060DAO("default", p_tr);
			dao.SAGA060_SHR_PRINT_03(p_box);
	}
}
