package Ehr.idt.a.idta010.wrk;

import Ehr.idt.a.idta010.dao.IDTA010DAO;
import Ehr.idt.a.idta030.dao.IDTA030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.DateUtil;

public class IDTA010WRK {
	
	/**
	 * 증명서발급처리 정보를 조회해 오는 WORK메소드.(인쇄용)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA010_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTA010DAO dao = new IDTA010DAO("default", p_tr);
		dao.IDTA010_SHR(p_box);
	}	
    
	/**
	 * 증명서발급 처리 정보를 저장, 수정 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA010_SAV_TEMP(CBox p_box, TrBox p_tr) throws CException {
		
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ID_CEFBOOK");
        GauceValueObject vo = null;
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		IDTA010DAO dao = new IDTA010DAO("default", p_tr);
        
        //해당 사원의 모든 데이타 삭제
        dao.IDTA010_DEL_TEMP(p_box);
        
        for (int i=0; i<voList.size(); i++) {
            vo = voList.get(i);    // LIST -> ROW
            
            //체크박스가 선택되어 있으면 등록
            if(vo.get("IS_CHK").equals("T")) {
                dao.IDTA010_INS_TEMP(vo, p_box);
            }
        }
	}
	
	/**
	 * 신청상태인 증명서발급처리 정보를 모두 발급상태로 변경시킨다.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA010_PROC(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ID_CEFBOOK");
        GauceValueObject vo = null;
            
        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
        IDTA030DAO dao = new IDTA030DAO("default", p_tr);
        
        for (int i=0; i<voList.size(); i++) {
            vo = voList.get(i);    // LIST -> ROW
            
            //체크박스가 선택되어 있으면 등록
            if(vo.get("IS_CHK").equals("T")) {
                
                vo.set("CEF_STS", "E");                             //발급
                vo.set("SPL_YMD", DateUtil.getCurrentDateStr());    //신청날짜
                
                dao.IDTA030_UPT(vo, p_box);
            }
        }
	}
}

