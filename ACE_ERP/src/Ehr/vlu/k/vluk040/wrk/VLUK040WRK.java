package Ehr.vlu.k.vluk040.wrk;

import Ehr.vlu.k.vluk030.dao.VLUK030DAO;
import Ehr.vlu.k.vluk040.dao.VLUK040DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK040WRK {

	public void VLUK040_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK040DAO 객체 생성 후 관련 메소드 호출 */
		VLUK040DAO dao = new VLUK040DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUK040_SHR(p_box);
	}

	public void VLUK040_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK040DAO 객체 생성 후 관련 메소드 호출 */
		VLUK040DAO dao = new VLUK040DAO("default", p_tr);

	   dao.VLUK040_SHR_01(p_box);
	}

	public void VLUK040_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUK040DAO 객체 생성 후 관련 메소드 호출 */
		VLUK040DAO dao = new VLUK040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
    				/** INSERT하는  DAO 메소드 호출 */
					this.VLUK040_SAV(vo, p_box, p_tr);
					break;
					
				case 3:
					/** UPDATE하는 DAO 메소드 호출 */
					break;

				case 4:
					dao.VLUK040_DEL(vo, p_box);
					break;
			}
		}
	}
	
	public void VLUK040_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {	
		
        //필요한 변수 선언
		VLUK040DAO dao = new VLUK040DAO("default", p_tr);

        dao.VLUK040_SAV(vo, p_box);		
		
	}	
	
	
	
}
