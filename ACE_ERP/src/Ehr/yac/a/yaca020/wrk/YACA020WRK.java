package Ehr.yac.a.yaca020.wrk;

//import Ehr.pir.a.pira013.dao.PIRA013DAO;
import Ehr.yac.a.yaca020.dao.YACA020DAO;
import Ehr.yac.a.yaca021.dao.YACA021DAO;
import Ehr.yac.a.yaca021.wrk.YACA021WRK;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class YACA020WRK {
    private YACA020DAO dao = null;
    private String connectionName = "default";

    /**
     * �������곻���� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR(CBox p_box, TrBox p_tr) throws CException {

        dao = new YACA020DAO(connectionName, p_tr);

        p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR(p_box));     //1.�������� ������ �����ͼ� DS �� ���
        p_tr.setOutDataSet("dsT_AC_DUTYPLACE", dao.YACA020_SHR_PLA(p_box)); //2.�����ٹ����ڷ� ������ ������� DS �� ���

    }

    /**
     * �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR_01(p_box);

    }

    /**
     * 2013�⵵ �������곻���� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR_13(CBox p_box, TrBox p_tr) throws CException {

        dao = new YACA020DAO(connectionName, p_tr);

        p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_13(p_box));     //1.�������� ������ �����ͼ� DS �� ���

    }    
    
    /**
     * 2014�⵵ �������곻���� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR_14(CBox p_box, TrBox p_tr) throws CException {

        dao = new YACA020DAO(connectionName, p_tr);

        p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_14(p_box));     //1.�������� ������ �����ͼ� DS �� ���

    }        
    
    /**
     * 2014�⵵ �������곻���� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR_142(CBox p_box, TrBox p_tr) throws CException {

        dao = new YACA020DAO(connectionName, p_tr);

        p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_142(p_box));     //1.�������� ������ �����ͼ� DS �� ���

    }       
    
    
    /**
     * 2015�⵵ �������곻���� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR_15(CBox p_box, TrBox p_tr) throws CException {

        dao = new YACA020DAO(connectionName, p_tr);

        p_tr.setOutDataSet("dsT_AC_RETACC"   , dao.YACA020_SHR_15(p_box));     //1.�������� ������ �����ͼ� DS �� ���

    }       
    
    
    /**
     * �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_14(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR2_14(p_box);

    }    
    
    /**
     * �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_142(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR2_142(p_box);

    }       
    
    /**
     * �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_15(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR2_15(p_box);
 
    }       
    
    /**
     * ������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_PRT_14(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR2_PRT_14(p_box);

    }        
    
    /**
     * ������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_PRT_142(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR2_PRT_142(p_box);

    }       
    
    /**
     * ������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR2_PRT_15(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR2_PRT_15(p_box);

    }      
    
    /**
     * ��� �ξ� �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR3_PRT_14(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR3_PRT_14(p_box);

    }          
    
    /**
     * ��� �ξ� �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR3_PRT_142(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR3_PRT_142(p_box);

    }         
    
    /**
     * ��� �ξ� �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR3_PRT_15(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR3_PRT_15(p_box);

    }         
    
    /**
     * 2,3 ������ ���� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR4_PRT_14(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR4_PRT_14(p_box);

    }       
    
    /**
     * 2,3 ������ ���� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR4_PRT_142(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR4_PRT_142(p_box);

    }    
    
    /**
     * 2,3 ������ ���� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR4_PRT_15(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR4_PRT_15(p_box);

    }    
    
    
    /**
     * 7 ������ �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR5_PRT_14(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR5_PRT_14(p_box);

    }        
    
    /**
     * 7 ������ �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR5_PRT_142(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR5_PRT_142(p_box);

    }       
    
    /**
     * 7 ������ �������� �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR5_PRT_15(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR5_PRT_15(p_box);

    }       
    
    /**
     * ���⵵ �ξ簡������ �����´�.
     * @param p_box
     * @throws CException
     */
    public void YACA020_SHR_OLD(CBox p_box, TrBox p_tr) throws CException {

    	dao = new YACA020DAO(connectionName, p_tr);
    	dao.YACA020_SHR_OLD(p_box);

    }    
    
    /**
     * ���� ���� ������ ����
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void YACA020_SAV(CBox p_box, TrBox p_tr) throws CException {
        GauceValueObject acc_vo = p_tr.getInGauceValueObject("dsT_AC_RETACC").get(0);
        GauceValueObject pla_vo = p_tr.getInGauceValueObject("dsT_AC_DUTYPLACE").get(0);

        GauceValueObject vo = null;

        dao = new YACA020DAO(connectionName, p_tr);

        //1.���� ������ ���� ���� ������ ����
        dao.YACA020_UPT_13(p_box, acc_vo);

        //2.�����ٹ����� �Է��ϱ� �� ��� ������ ����
        dao.YACA020_DEL_PLA(p_box);

        //3.�����ٹ����� ���
        for (int i=1; i<=3; i++) {
            if(pla_vo.getString("TYPE"+i).equals("X")) {
                vo = new GauceValueObject();

                vo.set("SEQ_NO", i);
                vo.set("JAO_NO"  , pla_vo.get("JAO_NO"+i   ));
                vo.set("JAS_NM"  , pla_vo.get("JAS_NM"+i   ));
                vo.set("HIR_YMD" , pla_vo.get("HIR_YMD"+i  ));
                vo.set("RET_YMD" , pla_vo.get("RET_YMD"+i  ));
                vo.set("JAA_AMT" , pla_vo.get("JAA_AMT"+i  ));
                vo.set("JAC_AMT" , pla_vo.get("JAC_AMT"+i  ));
                vo.set("JAG_AMT" , pla_vo.get("JAG_AMT"+i  ));
                vo.set("JAI_AMT" , pla_vo.get("JAI_AMT"+i  ));
                vo.set("JAQ_AMT" , pla_vo.get("JAQ_AMT"+i  ));
                vo.set("JAR_AMT" , pla_vo.get("JAR_AMT"+i  ));
                vo.set("JAH_AMT" , pla_vo.get("JAH_AMT"+i  ));
                vo.set("JAP_AMT" , pla_vo.get("JAP_AMT"+i  ));
                vo.set("JAL_AMT" , pla_vo.get("JAL_AMT"+i  ));
                vo.set("JAN_AMT" , pla_vo.get("JAN_AMT"+i  ));

                dao.YACA020_INS_PLA(p_box, vo);
            }
        }

        //4.PERSON �� ���� ������ ���
        YACA021WRK wrk021 = new YACA021WRK();
        wrk021.YACA021_UPT_PERSON(p_box, p_tr);
    }


	/**
	 * �ּ� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void YACA020_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_PERSON");
        GauceValueObject vo = null;

        dao = new YACA020DAO(connectionName, p_tr);
        //���� .PIRA013DAO dao2 = new PIRA013DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);	// LIST -> ROW

			/**
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
            if(vo.getInt("TX_MODE") == 3) {
            	//�ּҼ���
                dao.YACA020_UPT_01(vo, p_box);
                //ZIP_NO, ADDRESS, ADR_CT�� �λ���ǥ���� �մ�.
                //dao2.PIRA013_INS(p_box);//EM_PHN_NO,E_MAIL,RZI_NO,RADR,RADR_CT�� �ٲ�� EMPLIST�� ������Ʈ
            }
        }
	}
	
	
    public void YACA020_SAV_CLS(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject vo = null;
        
        dao = new YACA020DAO(connectionName, p_tr);

        dao.YACA020_UPT_CLS(vo, p_box);
    }
    
    public void YACA020_SAV_CLS_14(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject vo = null;
        
        dao = new YACA020DAO(connectionName, p_tr);

        dao.YACA020_UPT_CLS_14(vo, p_box);
    }    
    
    public void YACA020_SAV_CLS_142(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject vo = null;
        
        dao = new YACA020DAO(connectionName, p_tr);

        dao.YACA020_UPT_CLS_142(vo, p_box);
    }        
    
    
  
    
    public void YACA020_SAV_CLS_15(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject vo = null;
        
        dao = new YACA020DAO(connectionName, p_tr);

        dao.YACA020_UPT_CLS_15(vo, p_box);
    }        
    
    public void YACA020_SAV_END(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject vo = null;
        
        dao = new YACA020DAO(connectionName, p_tr);

        dao.YACA020_UPT_END(vo, p_box);
    }
    
    public void YACA020_SAV_END_14(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject vo = null;
        
        dao = new YACA020DAO(connectionName, p_tr);

        dao.YACA020_UPT_END_14(vo, p_box);
    }    
    
    public void YACA020_SAV_END_142(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject vo = null;
        
        dao = new YACA020DAO(connectionName, p_tr);

        dao.YACA020_UPT_END_142(vo, p_box);
    }  	
    
    public void YACA020_SAV_END_15(CBox p_box, TrBox p_tr) throws CException {
    	
        GauceValueObject vo = null;
        
        dao = new YACA020DAO(connectionName, p_tr);

        dao.YACA020_UPT_END_15(vo, p_box);
    }  	
    
}

