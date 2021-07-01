package Ehr.edu.h.eduh032.wrk;

import Ehr.edu.h.eduh032.dao.EDUH032DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUH032WRK {
	/**
	 * 교육차수관리 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUH032_SHR(CBox p_box, TrBox p_tr) throws CException {
		EDUH032DAO dao = new EDUH032DAO("default", p_tr);
		dao.EDUH032_SHR(p_box);
	}

    /**
     * 새로운 차수를 가지고 온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void EDUH032_SHR_CHASU(CBox p_box, TrBox p_tr) throws CException {
	    EDUH032DAO dao = new EDUH032DAO("default", p_tr);
	    //System.out.print(p_box);
	    dao.EDUH032_SHR_CHASU(p_box);
	}


	/**
     * 신규버튼 클릭시 마스터 정보를 가지고 온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void EDUH032_SHR_NEW(CBox p_box, TrBox p_tr) throws CException {
		EDUH032DAO dao = new EDUH032DAO("default", p_tr);
		dao.EDUH032_SHR_NEW(p_box);
	}

	/**
	 * 트랜젝션을 수행하여 교육차수관리 데이터를 입력/수정하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void EDUH032_SAV( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

		EDUH032DAO dao = new EDUH032DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
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
					dao.EDUH032_INS(vo, p_box);
					break;

				case 3:
					dao.EDUH032_UPT(vo, p_box);
					break;
                case 4:
                    dao.EDUH032_DEL(vo, p_box);
                    break;
			}
		}
	}
}
