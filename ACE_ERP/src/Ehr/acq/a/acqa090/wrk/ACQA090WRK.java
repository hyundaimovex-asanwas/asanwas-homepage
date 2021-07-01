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
	 * ��Ȳ ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA090_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA090DAO dao = new ACQA090DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao.ACQA090_SHR(p_box));
	

	}
	
	
	/**
	 * ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
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
	 * Ȯ�� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void ACQA090_SAV_APP( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		ACQA090DAO dao    = new ACQA090DAO("default", p_tr);
		ACQA090DAO dao2   = new ACQA090DAO("default", p_tr);
		ACQA090DAO dao3   = new ACQA090DAO("default", p_tr);
		
		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);
		
		//	1. �������� ����
		dao.ACQA090_APP_UPT(vo, p_box);


		//2.��� ����ƴ��� Check
		GauceDataSet dsCnt = dao2.ACQA090_APP_CNT(vo);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");

		// 3. ��� ����ž����� T_ACT_PLAN�� Update		
		if("Y".equals(APP_YN)){
			dao3.ACQA090_APP_END(vo, p_box);
		}

	}

}

