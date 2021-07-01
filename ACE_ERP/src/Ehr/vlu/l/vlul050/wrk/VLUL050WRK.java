package Ehr.vlu.l.vlul050.wrk;

import Ehr.vlu.l.vlul050.dao.VLUL050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUL050WRK {

	public void VLUL050_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUL050DAO 객체 생성 후 관련 메소드 호출 */
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUL050_SHR(p_box);
	}

	public void VLUL050_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUL050DAO 객체 생성 후 관련 메소드 호출 */
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

	   dao.VLUL050_SHR_01(p_box);
	}

	public void VLUL050_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUL050DAO 객체 생성 후 관련 메소드 호출 */
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

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
					//dao.VLUL050_SAV(vo, p_box);
					this.VLUL050_SAV(vo, p_box,p_tr);
					break;
				case 3:
					/** UPDATE하는 DAO 메소드 호출 */
					break;

				case 4:
					//dao.VLUL050_DEL(vo, p_box);
					this.VLUL050_DEL(vo, p_box,p_tr);					
					break;
			}
		}
	}
	
	public void VLUL050_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

        dao.VLUL050_SAV(vo, p_box);

	}		
	
	public void VLUL050_DEL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL050DAO dao = new VLUL050DAO("default", p_tr);

        dao.VLUL050_DEL(vo, p_box);

	}		
	
	
}
