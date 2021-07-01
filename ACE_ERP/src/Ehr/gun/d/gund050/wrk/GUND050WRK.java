package Ehr.gun.d.gund050.wrk;

import Ehr.gun.d.gund050.dao.GUND050DAO;


import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND050WRK {

	/**
	 * 내역을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND050_SHR(CBox p_box, TrBox p_tr) throws CException {

		//System.out.println("p_box==="+p_box);
		
		/** GUND040DAO 객체 생성 후 관련 메소드 호출 */
		GUND050DAO dao = new GUND050DAO("default", p_tr);

        /** 개인별 근태 집계 현황 SELECT하는 DAO 메소드 호출 */
		//dao.GUND050_SHR(p_box);
		p_tr.setOutDataSet( "dsT_DI_ACCELERATE",       dao.GUND050_SHR(p_box) );
		
		
	}


}
