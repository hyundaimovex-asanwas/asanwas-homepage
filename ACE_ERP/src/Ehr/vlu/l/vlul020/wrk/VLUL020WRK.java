package Ehr.vlu.l.vlul020.wrk;

import Ehr.vlu.l.vlul020.dao.VLUL020DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUL020WRK {

	public void VLUL020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUL020DAO 객체 생성 후 관련 메소드 호출 */
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

		dao.VLUL020_SHR(p_box);

	}

	public void VLUL020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

	    dao.VLUL020_SHR_01(p_box);
	}

	public void VLUL020_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

	    dao.VLUL020_SHR_02(p_box);
	}

	public void VLUL020_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

	    dao.VLUL020_SHR_03(p_box);
	}


/**
	public void VLUL020_SHR_SCR(CBox p_box, TrBox p_tr) throws CException {


		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

	   dao.VLUL020_SHR_SCR(p_box);

	}

	public void VLUL020_SHR_SCR_01(CBox p_box, TrBox p_tr) throws CException {


		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

	   dao.VLUL020_SHR_SCR_01(p_box);

	}
**/
	public void VLUL020_SHR_ITEM(CBox p_box, TrBox p_tr) throws CException {

		/** VLUL020DAO 객체 생성 후 관련 메소드 호출 */
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

	   dao.VLUL020_SHR_ITEM(p_box);

	}

	public void VLUL020_SHR_ITEM_01(CBox p_box, TrBox p_tr) throws CException { //부서장

		/** VLUL020DAO 객체 생성 후 관련 메소드 호출 */
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

	   dao.VLUL020_SHR_ITEM_01(p_box);

	}

	public void VLUL020_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSCORE");

		/** VLUL020DAO 객체 생성 후 관련 메소드 호출 */
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

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
					this.VLUL020_SAV(vo, p_box,p_tr);	
					//this.VLUL020_UPT(vo, p_box,p_tr);					
					
					//dao.VLUL020_SAV(vo, p_box);
					//dao.VLUL020_UPT(vo, p_box);
					break;
				case 3:
					/** UPDATE하는 DAO 메소드 호출 */
					this.VLUL020_DEL(vo, p_box,p_tr);	
					this.VLUL020_SAV(vo, p_box,p_tr);						
					//this.VLUL020_UPT(vo, p_box,p_tr);						
					//dao.VLUL020_DEL(vo, p_box);
					//dao.VLUL020_SAV(vo, p_box);
					//dao.VLUL020_UPT(vo, p_box);
					break;
				case 4:
					break;
			}
		}
		
		this.VLUL020_UPT(p_box,p_tr);	
		
	}

	
	public void VLUL020_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_SAV(vo, p_box);

	}	
	
	public void VLUL020_UPT(CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_UPT(p_box);

	}		

	public void VLUL020_DEL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_DEL(vo, p_box);

	}		
	
	
	public void VLUL020_SAV_01(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSCORE");

		/** VLUL020DAO 객체 생성 후 관련 메소드 호출 */
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

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
					this.VLUL020_SAV_01(vo, p_box,p_tr);	
					this.VLUL020_UPT_01(vo, p_box,p_tr);	
				
					//dao.VLUL020_SAV_01(vo, p_box);
					//dao.VLUL020_UPT_01(vo, p_box);
					break;
				case 3:
					/** UPDATE하는 DAO 메소드 호출 */
					this.VLUL020_DEL_01(vo, p_box,p_tr);	
					this.VLUL020_SAV_01(vo, p_box,p_tr);						
					this.VLUL020_UPT_01(vo, p_box,p_tr);	
					
					//dao.VLUL020_DEL_01(vo, p_box);
					//dao.VLUL020_SAV_01(vo, p_box);
					//dao.VLUL020_UPT_01(vo, p_box);
					break;

				case 4:
					//delete
					break;
			}

		}

	}

	public void VLUL020_SAV_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_SAV_01(vo, p_box);

	}	
	
	public void VLUL020_UPT_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_UPT_01(vo, p_box);

	}		

	public void VLUL020_DEL_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_DEL_01(vo, p_box);

	}	
	
	
	

	public void VLUL020_SAV_COR(CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_SAV_COR(p_box);

	}

	public void VLUL020_SAV_COR_01(CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_SAV_COR_01(p_box);

	}

	public void VLUL020_SAV_COR_02(CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_SAV_COR_02(p_box);

	}
	
	public void VLUL020_SAV_COR_PJT(CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUL020DAO dao = new VLUL020DAO("default", p_tr);

        dao.VLUL020_SAV_COR_PJT(p_box);

	}

}
