package Ehr.common.popup.education.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.popup.education.dao.EDUCATIONDAO;

public class EDUCATIONWRK {

	/**
	 * 과정코드 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EDUCATION_SHR(CBox p_box, TrBox p_tr) throws CException {

		EDUCATIONDAO dao = new EDUCATIONDAO("default", p_tr);
		dao.EDUCATION_SHR(p_box);

	}
	
	/**
	 * 차수 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EDUCATION_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		EDUCATIONDAO dao = new EDUCATIONDAO("default", p_tr);
		dao.EDUCATION_SHR_01(p_box);

	}
	
	/**
	 * 과정코드 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void EDUCATION_SHR_C(CBox p_box, TrBox p_tr) throws CException {

		EDUCATIONDAO dao = new EDUCATIONDAO("default", p_tr);
		dao.EDUCATION_SHR_C(p_box);

	}
}
