package Ehr.vlu.m.vlum030.wrk;

import Ehr.vlu.m.vlum030.dao.VLUM030DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUM030WRK {

	public void VLUM030_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUM030DAO 객체 생성 후 관련 메소드 호출 */
		VLUM030DAO dao = new VLUM030DAO("default", p_tr);

		dao.VLUM030_SHR_01(p_box);

	}

	public void VLUM030_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** VLUM030DAO 객체 생성 후 관련 메소드 호출 */
		VLUM030DAO dao = new VLUM030DAO("default", p_tr);

		dao.VLUM030_SHR_02(p_box);

	}
	
	public void VLUM030_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** VLUM030DAO 객체 생성 후 관련 메소드 호출 */
		VLUM030DAO dao = new VLUM030DAO("default", p_tr);

		dao.VLUM030_SHR_03(p_box);

	}	

}
