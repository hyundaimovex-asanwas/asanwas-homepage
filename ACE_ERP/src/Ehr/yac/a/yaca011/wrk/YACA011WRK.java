package Ehr.yac.a.yaca011.wrk;

import Ehr.yac.a.yaca011.dao.YACA011DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA011WRK {
    private YACA011DAO dao = null;
    private String connectionName = "default";   
    
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA011_SHR(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA011DAO dao = new YACA011DAO("default", p_tr);
		dao.YACA011_SHR(p_box);
		
}    
	
    /**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA011_SHR_14(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA011DAO dao = new YACA011DAO("default", p_tr);
		dao.YACA011_SHR_14(p_box);
		
    }   	
	
	/**
     * 연말정산결과조회를 가져온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void YACA011_SHR_15(CBox p_box, TrBox p_tr) throws CException {
    	
		YACA011DAO dao = new YACA011DAO("default", p_tr);
		dao.YACA011_SHR_15(p_box);
		
    }   	

	public void YACA011_SAV( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_RETACC");
        GauceValueObject vo = null;

        dao = new YACA011DAO(connectionName, p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);	// LIST -> ROW

            if(vo.getInt("TX_MODE") == 3) {
            	//수정
                dao.YACA011_UPT(vo, p_box);

            }
        }
	}
	
	public void YACA011_SAV_14( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_AC_RETACC");
        GauceValueObject vo = null;

        dao = new YACA011DAO(connectionName, p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);	// LIST -> ROW

            if(vo.getInt("TX_MODE") == 3) {
            	//수정
                dao.YACA011_UPT_14(vo, p_box);

            }
        }
	}	
	
    
}

