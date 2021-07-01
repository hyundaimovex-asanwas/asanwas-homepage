package Ehr.sag.a.saga260.wrk;

import Ehr.sag.a.saga260.dao.SAGA260DAO;
import Ehr.vlu.l.vlul020.dao.VLUL020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGA260WRK {

	/**
	 * 사내 대출현황 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		dao.SAGA260_SHR(p_box);

	}


	/**
	 * 사내 대출현황 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		dao.SAGA260_SHR_01(p_box);

	}


	/**
	 * 사내 대출현황 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		dao.SAGA260_SHR_02(p_box);

	}

	/**
	 * 사내 대출현황 PRINT 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		dao.SAGA260_SHR_PRINT(p_box);

	}

	/**
	 * 사내 대출현황 저장
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SAV(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;


		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);

        /**
         * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
         *  - 1 : NORMAL
         *  - 2 : INSERT
         *  - 3 : UPDATE
         *  - 4 : DELETE
         */
        int tx_mode = 0;

        //voList = p_tr.getInGauceValueObject("dsT_Loan_Temp");

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);
            tx_mode = vo.getInt("TX_MODE");

            if(tx_mode == 2)
                dao.SAGA260_SAV(p_box, vo);

		}

	}


	/**
	 * 사내 대출현황 저장(상환 유보)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SAV_01(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);

        /**
         * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
         *  - 1 : NORMAL
         *  - 2 : INSERT
         *  - 3 : UPDATE
         *  - 4 : DELETE
         */
        int tx_mode = 0;

		for (int i=0; i<voList.size(); i++) {

			vo = voList.get(i);

            tx_mode = vo.getInt("APPCNT");

            if(tx_mode == 1)
                dao.SAGA260_SAV_01_UPT(p_box, vo);

            else
                dao.SAGA260_SAV_01(p_box, vo);

		}

	}

	/**
	 * 사내 대출 상환 유보(DETAIL)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA260_SAV_DELAY(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);
		SAGA260DAO dao2 = new SAGA260DAO("default", p_tr);
		
		for (int i=0; i<voList.size(); i++) {

			vo = voList.get(i);


	        int tx_mode = 0;

            tx_mode = vo.getInt("APPCNT");

            if(tx_mode == 1){	     //처음에 한번만 지우장~

            dao.SAGA260_SAV_DELAY_DEL(p_box, vo);

            }

            //dao2.SAGA260_SAV_DELAY(p_box, vo);
            this.SAGA260_SAV_DELAY(vo, p_box,p_tr);

		}

	}
	
	
	public void SAGA260_SAV_DELAY(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGA260DAO dao = new SAGA260DAO("default", p_tr);

        dao.SAGA260_SAV_DELAY(p_box, vo);

	}		

}
