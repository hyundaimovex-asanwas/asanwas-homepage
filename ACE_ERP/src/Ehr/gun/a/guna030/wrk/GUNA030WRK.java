package Ehr.gun.a.guna030.wrk;

import Ehr.gun.a.guna030.dao.GUNA030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUNA030WRK {
    
    /**
     * �������ϳ�¥�� ��ȸ�ؿ��� WORK�޼ҵ�.
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
     * �������ϳ�¥�� �����ϴ� WORK�޼ҵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void GUNA030_SAV( CBox p_box, TrBox p_tr ) throws CException {
        
        /** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_HOLIDAY");
            
        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
        GUNA030DAO dao = new GUNA030DAO("default", p_tr);

        for (int i=0; i<voList.size(); i++) {
                
            /** ValueObjectList���� ValueObject�� ������ �κ� **/
            GauceValueObject vo = voList.get(i);	// LIST -> ROW
            
            /** 
                * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
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
     * 1��ġ �������ϳ�¥ �⺻������ �ϰ�ó���� DB�� �Է��ϴ�  WORK�޼ҵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void GUNA030_SAV_01( CBox p_box, TrBox p_tr ) throws CException {
        
        /** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_HOLIDAY_INPUT");
            
        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
        GUNA030DAO dao = new GUNA030DAO("default", p_tr);

            /** ValueObjectList���� ValueObject�� ������ �κ� **/
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

