package Ehr.aid.a.aida050.wrk;

import Ehr.aid.a.aida050.dao.AIDA050DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class AIDA050WRK {
	
	/**
	 * 경공조금 지급기준 정보를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA050_SHR(CBox p_box, TrBox p_tr) throws CException {

			AIDA050DAO dao = new AIDA050DAO("default", p_tr);
			
			dao.AIDA050_SHR(p_box);
			
	}
	
	/**
	 * 경공조금 지급기준 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA050_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AD_AIDTRF");
			
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		AIDA050DAO dao = new AIDA050DAO("default", p_tr);
		
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
                    //신규로 등록
					dao.AIDA050_INS(vo, p_box);
                    break;
				case 3:
					// 경공조금 지급기준 정보를 수정하기 위한 DAO메소드 호출
					dao.AIDA050_UPT(vo, p_box);
					break;
				case 4:
					// delete;
                    dao.AIDA050_DEL(vo, p_box);
					break;					
			}
		}
	}
}

