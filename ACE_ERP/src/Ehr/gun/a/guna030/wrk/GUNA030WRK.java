package Ehr.gun.a.guna030.wrk;

import Ehr.gun.a.guna030.dao.GUNA030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNA030WRK {
    
    /**
     * 근태휴일날짜를 조회해오는 WORK메소드.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void GUNA030_SHR(CBox p_box, TrBox p_tr) throws CException {

            GUNA030DAO dao = new GUNA030DAO("default", p_tr);
            GUNA030DAO dao2 = new GUNA030DAO("default", p_tr);
            GUNA030DAO dao3 = new GUNA030DAO("default", p_tr);  
            
            dao.GUNA030_SHR(p_box);
            
            p_tr.setOutDataSet( "DS_ONE", dao2.GUNA030_SHR(p_box) );
            
            p_tr.setOutDataSet( "DS_TWO", dao3.GUNA030_SHR_01(p_box) );
           

    }
    
    /**
     * 근태휴일날짜를 수정하는 WORK메소드.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void GUNA030_SAV( CBox p_box, TrBox p_tr ) throws CException {
        
        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_HOLIDAY");
            
        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
        GUNA030DAO dao = new GUNA030DAO("default", p_tr);

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
                    // insert
                    dao.GUNA030_INS(vo, p_box);
                    
                    break;
                    
                case 3:


                    dao.GUNA030_UPT(vo, p_box);
                    
                    break;
                    
                case 4:
                	
                    // delete;
                        
                    break;					
                }
            }
    }
    
    /**
     * 1년치 근태휴일날짜 기본정보를 일괄처리로 DB에 입력하는  WORK메소드.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void GUNA030_SAV_01( CBox p_box, TrBox p_tr ) throws CException {
        
        /** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_HOLIDAY_INPUT");
            
        /** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
        GUNA030DAO dao = new GUNA030DAO("default", p_tr);

            /** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
            GauceValueObject vo = voList.get(1);	// LIST -> ROW

            switch (vo.getInt("TX_MODE")) {
            
                case 2:
                    // insert
                    dao.GUNA030_INS(vo, p_box);
                    
                    break;
                    
                case 3:
                	
                    break;
                    
                case 4:
                	
                    break;		
                    
            }
    }
    
}

