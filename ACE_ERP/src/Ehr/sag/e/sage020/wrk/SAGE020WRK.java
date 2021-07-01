package Ehr.sag.e.sage020.wrk;

import Ehr.sag.e.sage020.dao.SAGE020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.CommUtil;


public class SAGE020WRK {

	/**
	 * 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGE020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGE020DAO dao = new SAGE020DAO("default", p_tr);

		dao.SAGE020_SHR(p_box);

	}

	/**
	 * 일자 조회 [FirstRow 방식]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGE020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class 객체 생성후 관련 메소드 호출 * */
		SAGE020DAO dao = new SAGE020DAO("default", p_tr);

		dao.SAGE020_SHR_01(p_box);

	}

	/**
	 * 저장, 수정
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void SAGE020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		SAGE020DAO dao = new SAGE020DAO("default", p_tr);

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

        String resultMsg = "";

        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i); // LIST -> ROW

            try {
            	
                if(vo.getInt("TX_MODE") == 2) {

                    dao.SAGE020_INS(p_box, vo);		//신규 저장

                } else if(vo.getInt("TX_MODE") == 3) {

                    dao.SAGE020_UPT(p_box, vo);		// 수정
                }

            } catch (Exception e) {
                resultMsg += e.getMessage();
            }
        }
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

}
