package Ehr.vlu.l.vlul015.wrk;


import Ehr.vlu.l.vlul010.dao.VLUL010DAO;
import Ehr.vlu.l.vlul015.dao.VLUL015DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUL015WRK {

	public void VLUL015_SHR(CBox p_box, TrBox p_tr) throws CException {

		VLUL015DAO dao = new VLUL015DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUL015_SHR(p_box);

	}

	public void VLUL015_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		VLUL015DAO dao = new VLUL015DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUL015_SHR_01(p_box);

	}
	
	
	public void VLUL015_SHR_SUB(CBox p_box, TrBox p_tr) throws CException {

		VLUL015DAO dao = new VLUL015DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		//dao.VLUL015_SHR_SUB(p_box);
		p_tr.setOutDataSet( "dsT_EV_JOBSPEC",       dao.VLUL015_SHR_SUB(p_box) );
		
	}
	
	
	public void VLUL015_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_JOBSPEC");
		GauceValueObject voList1 = p_tr.getInGauceValueObject("dsT_EV_JOBTASK");

		VLUL015DAO dao = new VLUL015DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			GauceValueObject vo = voList.get(i);

			dao.VLUL015_UPT_MST(vo, p_box);

		}


		for (int i=0; i<voList1.size(); i++) {

			GauceValueObject vo1 = voList1.get(i);

			switch (vo1.getInt("TX_MODE")) {
			
			case 2:
				
				this.VLUL015_SAV_DTL(vo1, p_box, p_tr);
				break;
				
			case 3:
				
				this.VLUL015_UPT_DTL(vo1, p_box, p_tr);
				break;
				
			case 4:
				
				this.VLUL015_DEL_DTL(vo1, p_box, p_tr);
				break;
				
			}

		}

	}
	
	public void VLUL015_SAV_DTL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL015DAO dao = new VLUL015DAO("default", p_tr);

		dao.VLUL015_SAV_DTL(vo, p_box);

	}			
	
	public void VLUL015_UPT_DTL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL015DAO dao = new VLUL015DAO("default", p_tr);

		dao.VLUL015_UPT_DTL(vo, p_box);

	}		
	
	public void VLUL015_DEL_DTL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL015DAO dao = new VLUL015DAO("default", p_tr);

		dao.VLUL015_DEL_DTL(vo, p_box);

	}			
	
	
	
}
