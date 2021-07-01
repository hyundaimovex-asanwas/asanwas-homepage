package Ehr.gun.a.guna016.wrk;

import Ehr.gun.a.guna016.dao.GUNA016DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUNA016WRK {

	/**
	 * 목록을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA016_SHR(CBox p_box, TrBox p_tr) throws CException {

		GUNA016DAO dao = new GUNA016DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_CHANGE",  dao.GUNA016_SHR(p_box) );
		

	}
}