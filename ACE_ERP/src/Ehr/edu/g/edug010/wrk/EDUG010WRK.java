package Ehr.edu.g.edug010.wrk;

import Ehr.edu.g.edug010.dao.EDUG010DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUG010WRK {
	
	/**
	 * 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUG010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUG010DAO 객체 생성 후 관련 메소드 호출 */
		EDUG010DAO dao = new EDUG010DAO("default", p_tr);

        /** 과정개설요청서 SELECT하는 DAO 메소드 호출 */
		dao.EDUG010_SHR(p_box);

	}


	/**
	 * 트랜젝션을 수행하여 과정개설요청서 데이터를 입력/수정하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUG010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 과정개설요청서 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EDUG010DAO dao = new EDUG010DAO("default", p_tr);

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
					dao.EDUG010_INS(vo, p_box);
					break;

				case 3:

					/** UPDATE하는  DAO 메소드 호출 */
					dao.EDUG010_UPT(vo, p_box);
					break;

				case 4:

					//delete
					break;
			}
		}
	}


	/**
	 * 트랜젝션을 수행하여 과정개설요청서 데이터를 삭제 처리하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUG010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 과정개설요청서 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		EDUG010DAO dao = new EDUG010DAO("default", p_tr);

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

					/** 과정개설요청서 DELETE하는 DAO 메소드 호출 */
					dao.EDUG010_DEL(vo, p_box);
					break;
			}
		}
	}
	

}
