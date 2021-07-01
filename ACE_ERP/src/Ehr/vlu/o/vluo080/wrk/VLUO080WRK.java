package Ehr.vlu.o.vluo080.wrk;


import Ehr.vlu.o.vluo080.dao.VLUO080DAO;



import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUO080WRK {


	public void VLUO080_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUO080_SHR(p_box);
	}
	
	public void VLUO080_SHR_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        /** SELECT하는 DAO 메소드 호출 */
		dao.VLUO080_SHR_PJT(p_box);
	}
	


	public void VLUO080_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_01(p_box);

	}

	public void VLUO080_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_02(p_box);

	}
	
	public void VLUO080_SHR_02_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_02_PJT(p_box);

	}
	


	public void VLUO080_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_03(p_box);

	}

	public void VLUO080_SHR_04(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_04(p_box);

	}
	
	public void VLUO080_SHR_04_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_04_PJT(p_box);

	}
	


	public void VLUO080_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_05(p_box);

	}

	public void VLUO080_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_06(p_box);

	}
	
	public void VLUO080_SHR_06_PJT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_06_PJT(p_box);

	}
	


	public void VLUO080_SHR_07(CBox p_box, TrBox p_tr) throws CException {

		/** VLUO080DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

	   dao.VLUO080_SHR_07(p_box);

	}

	public void VLUO080_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST");

		/** VLUI060DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

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
					break;

				case 3:
					/** UPDATE하는 DAO 메소드 호출 */
					this.VLUO080_SAV(vo, p_box,p_tr);
					//dao.VLUO080_SAV(vo, p_box);
					break;

				case 4:
					//dao.VLUO080_DEL(vo, p_box);
					break;
			}
		}

	}

	public void VLUO080_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        dao.VLUO080_SAV(vo, p_box);

	}		
	
	
	
	public void VLUO080_SAV_EXE(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_ABLRST2");

		/** VLUI060DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

		//System.out.println(vo);
		System.out.println(p_box);
		
		
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
					break;

				case 3:
					/** UPDATE하는 DAO 메소드 호출 */
					this.VLUO080_SAV_EXE(vo, p_box,p_tr);
					//dao.VLUO080_SAV_EXE(vo, p_box);
					break;

				case 4:
					//dao.VLUO080_DEL(vo, p_box);
					break;
			}
		}

	}

	public void VLUO080_SAV_EXE(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        dao.VLUO080_SAV_EXE(vo, p_box);

	}		
	
	
	
	public void VLUO080_SAV_GRD(CBox p_box, TrBox p_tr) throws CException {


		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_GRADE2");

		/** VLUI060DAO 객체 생성 후 관련 메소드 호출 */
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

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
					break;

				case 3:
					/** UPDATE하는 DAO 메소드 호출 */
					this.VLUO080_SAV_GRD(vo, p_box,p_tr);
					//dao.VLUO080_SAV_GRD(vo, p_box);
					break;

				case 4:
					//dao.VLUO080_DEL(vo, p_box);
					break;
			}
		}

	}
	
	
	public void VLUO080_SAV_GRD(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		VLUO080DAO dao = new VLUO080DAO("default", p_tr);

        dao.VLUO080_SAV_GRD(vo, p_box);

	}		
	
	
	
	
}


