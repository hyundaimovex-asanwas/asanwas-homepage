package Ehr.sag.a.saga270.wrk;

import Ehr.but.a.buta025.dao.BUTA025DAO;
import Ehr.eis.t.eist020.dao.EIST020DAO;
import Ehr.sag.a.saga270.dao.SAGA270DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGA270WRK {

	/**
	 * 공조회비 대출현황 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA270_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);
		dao.SAGA270_SHR(p_box);

	}


	/**
	 * 공조회비 대출현황 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA270_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);
		dao.SAGA270_SHR_01(p_box);

	}


	/**
	 * 공조회비 대출현황 PRINT 조회
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA270_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);
		dao.SAGA270_SHR_PRINT(p_box);

	}

	/**
	 * 공조회비 대출현황 저장
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA270_SAV(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;


		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);

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
                dao.SAGA270_SAV(p_box, vo);

		}

	}


	/**
	 * 공조회비 대출현황 저장(DETAIL)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA270_SAV_01(CBox p_box, TrBox p_tr) throws CException {


        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);

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

            tx_mode = vo.getInt("APLCNT");

    		//System.out.print("---------------------------   %%%SAGA270_SAV_01_UPT%%%   ---------");
    		//System.out.print(vo);
    		//System.out.print(tx_mode);


            if(tx_mode == 1)
                this.SAGA270_SAV_01_UPT(vo, p_box, p_tr);

            else
            	this.SAGA270_SAV_01(vo, p_box, p_tr);

		}

	}

	
	public void SAGA270_SAV_01_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);

		dao.SAGA270_SAV_01_UPT(p_box, vo);

	}	
	
	public void SAGA270_SAV_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);

		dao.SAGA270_SAV_01(p_box, vo);

	}		
	
	/**
	 * 공조회비 중도상환 저장
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGA270_SAV_REP(CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

        GauceValueObject voList2 = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo2 = null;

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);

            this.SAGA270_SAV_REP(p_box, vo, p_tr);
		}

		for (int i=0; i<voList2.size(); i++) {
			vo2 = voList2.get(i);

			this.SAGA270_SAV_DEL(p_box, vo2, p_tr);
		}

	}

	
	public void SAGA270_SAV_REP(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);

		dao.SAGA270_SAV_REP(p_box, vo);

	}		
	
	public void SAGA270_SAV_DEL(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		SAGA270DAO dao = new SAGA270DAO("default", p_tr);

		dao.SAGA270_SAV_DEL(p_box, vo);

	}		
	
	
	
}
