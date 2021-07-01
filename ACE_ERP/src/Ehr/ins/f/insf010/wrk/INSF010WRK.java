package Ehr.ins.f.insf010.wrk;

import Ehr.ins.f.insf010.dao.INSF010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class INSF010WRK {
    private INSF010DAO dao = null;
    private String connectionName = "default";
    
    /**
     * ���� ������ ��ȸ�Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void INSF010_SHR_EMP(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new INSF010DAO(connectionName, p_tr);
        
        dao.INSF010_SHR_EMP(p_box);
        
    }

    /**
     * ���ο��ݰ��� ����Ʈ�� ��ȸ�Ѵ�.
     * @param p_box
     * @param p_tr
     */
    public void INSF010_SHR(CBox p_box, TrBox p_tr) throws CException {
    	
        dao = new INSF010DAO(connectionName, p_tr);
        
        dao.INSF010_SHR(p_box);
        
    }
    

    /**
     * ���ο��ݰ��� ����Ʈ���� �� �׸��� ��� �� �����׸��� �����Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void INSF010_SAV(CBox p_box, TrBox p_tr) throws CException {
    	
        //GauceValueObject - composite patten
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SV_SAVELIST");
        GauceValueObject vo = null;
        
        int TX_MODE = 0;

        dao = new INSF010DAO(connectionName, p_tr);

        for (int i=0; i<voList.size(); i++) {
            vo = voList.get(i);   // LIST -> ROW
            
            TX_MODE = vo.getInt("TX_MODE");

            /*
             * TX_MODE��
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
            if(TX_MODE == 2) {
            	
                dao.INSF010_INS(p_box, vo);
                
            }else if(TX_MODE == 3) {
            	
                dao.INSF010_UPT(p_box, vo);
                
            }
            
        }
        
    }

    /**
     * ���ο��� ������ �����Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void INSF010_DEL(CBox p_box, TrBox p_tr) throws CException {
    	
        //GauceValueObject - composite patten
        GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SV_SAVELIST");
        GauceValueObject vo = null;
        
        int TX_MODE = 0;

        dao = new INSF010DAO(connectionName, p_tr);

        for (int i=0; i<voList.size(); i++) {
            vo = voList.get(i);   // LIST -> ROW
            
            TX_MODE = vo.getInt("TX_MODE");

            /*
             * TX_MODE��
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
            if(TX_MODE == 4) {
                dao.INSF010_DEL(p_box, vo);
            }
        }
    }
}

