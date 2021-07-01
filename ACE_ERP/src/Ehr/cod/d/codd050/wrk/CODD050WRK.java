package Ehr.cod.d.codd050.wrk;

import Ehr.cod.d.codd050.dao.CODD050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODD050WRK {

    /**
     * 미확인 메세지 정보 조회 WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
	public void CODD050_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 미확인 메세지 DAO CLASS 메서드 호출 * */
		CODD050DAO dao = new CODD050DAO("default", p_tr);

		dao.CODD050_SHR(p_box);

	}

	/**
	 * 미확인 메세지 확인처리 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODD050_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AA_MESSAGE");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		CODD050DAO dao = new CODD050DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			switch (vo.getInt("TX_MODE")) {
				case 2:
					// 확인처리하기 위한 DAO메소드 호출
					this.CODD050_UPT(vo, p_box, p_tr);					
					break;
				case 3:
					break;
			}
		}
	}	
	
	
	public void CODD050_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		CODD050DAO dao = new CODD050DAO("default", p_tr);

		dao.CODD050_UPT(vo, p_box);

	}	
	
	
}
