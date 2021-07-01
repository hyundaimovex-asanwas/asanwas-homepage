package Ehr.vlu.k.vluk030.wrk;

import Ehr.aid.a.aida010.dao.AIDA010DAO;
import Ehr.common.util.JSPUtil;
import Ehr.vlu.k.vluk030.dao.VLUK030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK030WRK {

	public void VLUK030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK030DAO 객체 생성 후 관련 메소드 호출 */
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUK030_SHR(p_box);

	}

	public void VLUK030_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK030DAO 객체 생성 후 관련 메소드 호출 */
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

	   dao.VLUK030_SHR_01(p_box);

	}

	public void VLUK030_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK030DAO 객체 생성 후 관련 메소드 호출 */
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

	   dao.VLUK030_SHR_02(p_box);

	}

	public void VLUK030_SHR_12(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK030DAO 객체 생성 후 관련 메소드 호출 */
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

	   dao.VLUK030_SHR_12(p_box);

	}

	public void VLUK030_SHR_13(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK030DAO 객체 생성 후 관련 메소드 호출 */
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

	   dao.VLUK030_SHR_13(p_box);

	}

	public void VLUK030_SAV_01(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW
		
			this.VLUK030_SAV_01(vo, p_box, p_tr);
		}

	}

	public void VLUK030_SAV_01(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {	
	
        //필요한 변수 선언
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

        dao.VLUK030_SAV_01(vo, p_box);		
		
	}
	
	public void VLUK030_SAV_02(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		/** VLUK030DAO 객체 생성 후 관련 메소드 호출 */
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			dao.VLUK030_SAV_02(vo, p_box);
		}

	}

	public void VLUK030_DEL(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		/** VLUK030DAO 객체 생성 후 관련 메소드 호출 */
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);
		VLUK030DAO dao2 = new VLUK030DAO("default", p_tr);
		VLUK030DAO dao3 = new VLUK030DAO("default", p_tr);		
		
		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			dao.VLUK030_DEL1(vo, p_box);
			dao2.VLUK030_DEL2(vo, p_box);
			dao3.VLUK030_DEL3(vo, p_box);

		}

	}

	public void VLUK030_DEL_DPT(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		/** VLUK030DAO 객체 생성 후 관련 메소드 호출 */
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);
		VLUK030DAO dao2 = new VLUK030DAO("default", p_tr);
		VLUK030DAO dao3 = new VLUK030DAO("default", p_tr);	
		
		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			dao.VLUK030_DEL4(vo, p_box);
			dao2.VLUK030_DEL5(vo, p_box);
			dao3.VLUK030_DEL6(vo, p_box);

		}

	}

	public void VLUK030_DEL_01(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			this.VLUK030_DEL_01(vo, p_box, p_tr);
		}

	}

	public void VLUK030_DEL_01(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {	
		
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

        dao.VLUK030_DEL_01(vo, p_box);		
		
	}	
	
	

	public void VLUK030_DEL_02(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		for (int i=0; i<voList.size(); i++) {
			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			this.VLUK030_DEL_02(vo, p_box, p_tr);
		}

	}
	
	public void VLUK030_DEL_02(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {	
		
		VLUK030DAO dao = new VLUK030DAO("default", p_tr);

        dao.VLUK030_DEL_02(vo, p_box);		
		
	}	
	
	
}
