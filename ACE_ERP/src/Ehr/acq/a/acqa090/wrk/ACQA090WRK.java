package Ehr.acq.a.acqa090.wrk;

import Ehr.acq.a.acqa010.dao.ACQA010DAO;
import Ehr.acq.a.acqa090.dao.ACQA090DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class ACQA090WRK {
	
	/**
	 * 현황 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA090_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA090DAO dao = new ACQA090DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao.ACQA090_SHR(p_box));
	

	}
	
	
	/**
	 * 결재 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA090_SHR_APP(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA090DAO dao  = new ACQA090DAO("default", p_tr);

			ACQA090DAO dao2 = new ACQA090DAO("default", p_tr);

	        p_tr.setOutDataSet("dsT_ACT_PLANLIST",     dao.ACQA090_SHR_APP(p_box));		
	        
	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao2.ACQA090_SHR_APP2(p_box));			

	}
	


	/**
	 * 확인 하는 WORK메소드.
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void ACQA090_SAV_APP( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		ACQA090DAO dao    = new ACQA090DAO("default", p_tr);
		ACQA090DAO dao2   = new ACQA090DAO("default", p_tr);
		ACQA090DAO dao3   = new ACQA090DAO("default", p_tr);
		
		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);
		
		//	1. 결재정보 수정
		dao.ACQA090_APP_UPT(vo, p_box);


		//2.모두 결재됐는지 Check
		GauceDataSet dsCnt = dao2.ACQA090_APP_CNT(vo);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");

		// 3. 모두 결재돼었으면 T_ACT_PLAN에 Update		
		if("Y".equals(APP_YN)){
			dao3.ACQA090_APP_END(vo, p_box);
		}

	}

}

