package Ehr.vlu.m.vlum010.wrk;

import Ehr.vlu.m.vlum010.dao.VLUM010DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUM010WRK {

	public void VLUM010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUM010DAO 객체 생성 후 관련 메소드 호출 */
		VLUM010DAO dao = new VLUM010DAO("default", p_tr);

		dao.VLUM010_SHR_01(p_box);

	}

	public void VLUM010_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** VLUM010DAO 객체 생성 후 관련 메소드 호출 */
		VLUM010DAO dao = new VLUM010DAO("default", p_tr);

		dao.VLUM010_SHR_02(p_box);

	}
	
	public void VLUM010_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** VLUM010DAO 객체 생성 후 관련 메소드 호출 */
		VLUM010DAO dao = new VLUM010DAO("default", p_tr);

		dao.VLUM010_SHR_03(p_box);

	}	

}
