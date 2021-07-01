package Ehr.vlu.m.vlum020.wrk;

import Ehr.vlu.m.vlum020.dao.VLUM020DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUM020WRK {

	public void VLUM020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUM020DAO 객체 생성 후 관련 메소드 호출 */
		VLUM020DAO dao = new VLUM020DAO("default", p_tr);

		dao.VLUM020_SHR(p_box);

	}



}
