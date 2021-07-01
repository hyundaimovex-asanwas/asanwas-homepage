package Ehr.edu.e.edue032.wrk;

import Ehr.edu.e.edue032.dao.EDUE032DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE032WRK {
	/**
	 * 사외강좌요청서 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	
	private EDUE032DAO dao = null;
	private String connectionName = "default"; 
	
	public void EDUE032_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE032DAO 객체 생성 후 관련 메소드 호출 */
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		
		/** 조회한 데이터를 화면에 전송하는 부분 **/
		dao = new EDUE032DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR",  dao.EDUE032_SHR_00(p_box));
		
		
		dao = new EDUE032DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR0", dao.EDUE032_SHR_02(p_box));

	}

	public void EDUE032_SHR_ED(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE032DAO 객체 생성 후 관련 메소드 호출 */
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		
		/** 조회한 데이터를 화면에 전송하는 부분 **/
		dao = new EDUE032DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR2", dao.EDUE032_SHR_01(p_box));
		
		
		System.out.println("p_box:::::::"+p_box);
		dao = new EDUE032DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR_APP", dao.EDUE032_SHR_03(p_box) );

	}

	/**
	 * 트랜젝션을 수행하여 사외강좌신청서 데이터를 입력/수정하는 WRK 메소드
	 * @param p_box		    CBox객체  (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE032_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 사외강좌신청서 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		// 결재선 정보 등록 수정
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");

		String REQ_NO = "";

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		dao = new EDUE032DAO(connectionName, p_tr);
		REQ_NO = dao.EDUE032_SHR_MAX();

		System.out.println("st1");
		
		GauceValueObject vo = null;
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
    		switch (vo.getInt("TX_MODE")) {
				case 2:

					vo.set("REQ_NO", REQ_NO);
    				/** 사외강좌신청서 INSERT하는  DAO 메소드 호출 */
					System.out.println("st2");
					dao = new EDUE032DAO(connectionName, p_tr);
					dao.EDUE032_INS(vo, p_box);
					System.out.println("st3");
					break;

				case 3:

                    //update
					break;

				case 4:

					//delete
					break;
			}
		}
		
		

		System.out.println("---------------------- 결재선 Insert  2010.0406 ---------------------");
		System.out.println("voList2.size = ["+voList2.size()+"]");

		GauceValueObject vo2 = null;
		for(int i = 0; i < voList2.size(); i++){
			vo2 = voList2.get(i);
			vo2.set("REQ_NO", REQ_NO);

			System.out.print("11111"+vo2);
			dao = new EDUE032DAO(connectionName, p_tr);
			dao.EDUE_APPROVAL_INS(vo2, p_box);
		}
	}

	/**
	 * 트랜젝션을 수행하여 사외강좌신청서 데이터를 삭제 처리하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUE032_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 사외강좌신청서 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		dao = new EDUE032DAO(connectionName, p_tr);

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
					//insert
					break;

				case 3:
					//update
					break;

				case 4:

					/** 사외강좌신청서 DELETE하는 DAO 메소드 호출 */
					dao.EDUE032_DEL(vo, p_box);
					break;
			}
		}
	}
	public void EDUE032_APP(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE032DAO 객체 생성 후 관련 메소드 호출 */
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		dao = new EDUE032DAO(connectionName, p_tr);

		/** 조회한 데이터를 화면에 전송하는 부분 **/
		dao.EDUE032_APP(p_box);

	}
}
