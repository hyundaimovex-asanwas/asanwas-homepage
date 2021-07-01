package Ehr.idt.c.idtc010.wrk;

import Ehr.idt.c.idtc010.dao.IDTC010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.DateUtil;

public class IDTC010WRK {
	
	/**
	 * 주간업무보고 정보를 조회해 오는 WORK메소드.(인쇄용)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC010_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTC010DAO dao = new IDTC010DAO("default", p_tr);
		
		dao.IDTC010_SHR(p_box);
	}	
    
	/**
	 * 주간업무보고 처리 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTC010_SAV(CBox p_box, TrBox p_tr) throws CException {
		
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_WF_WORKFORM");
        GauceValueObject vo = null;
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		IDTC010DAO dao = new IDTC010DAO("default", p_tr);
        
        //해당 사원의 모든 데이타 삭제
        dao.IDTC010_DEL_TEMP(p_box);
        
        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);    // LIST -> ROW

            //체크박스가 선택되어 있으면 등록
            if(vo.get("IS_CHK").equals("T")) {
                dao.IDTC010_INS_TEMP(vo, p_box);
            }
            
        }
        
	}
	
	

}

