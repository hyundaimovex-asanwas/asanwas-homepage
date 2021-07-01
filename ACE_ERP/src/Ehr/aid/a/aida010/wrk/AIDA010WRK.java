package Ehr.aid.a.aida010.wrk;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.SequenceInputStream;
import java.sql.Connection;

import Ehr.aid.a.aida010.dao.AIDA010DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.CommUtil;
import Ehr.common.util.DbManager;
import Ehr.common.util.HuniBill;
import Ehr.common.util.JSPUtil;

public class AIDA010WRK {

	/**
	 * ������� ���ޱ��� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR(CBox p_box, TrBox p_tr) throws CException {

			AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
			dao.AIDA010_SHR(p_box);
			
	}
	
	/**
	 * ��� �� ���޳����� ���� ������� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		dao.AIDA010_SHR_01(p_box);
		
	}
	/**
	 * ��û���(A2�߽�) 2009.12.24 By KHS.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		dao.AIDA010_SHR_06(p_box);
		
	}

	/**
	 * ���� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		dao.AIDA010_SHR_02(p_box);
		
	}

	/**
	 * ��û�ڰ� �ش��ϴ� ���ޱݾ��� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		dao.AIDA010_SHR_03(p_box);
		
	}

	/**
	 * ��û��ȣ(REQ_NO)�� �ش��ϴ� ��û���� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SHR_04(CBox p_box, TrBox p_tr) throws CException {
		
		AIDA010DAO dao = new AIDA010DAO("default", p_tr);
		
		AIDA010DAO dao2 = new AIDA010DAO("default", p_tr);
		
        p_tr.setOutDataSet("dsT_AD_AIDAPP",     dao.AIDA010_SHR_04(p_box));
        
        p_tr.setOutDataSet("dsT_AD_DECISION",   dao2.AIDA010_SHR_05(p_box));
        
	}

    /**
     * �ټӳ���� ��ȸ�ؿ�
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void AIDA010_SHR_LSE(CBox p_box, TrBox p_tr) throws CException {
		
	    AIDA010DAO dao = new AIDA010DAO("default", p_tr);
	    
	    dao.AIDA010_SHR_LSE(p_box);
	    
	}

    /**
     * ����Ʈ��
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void AIDA010_SHR_PRINT0(CBox p_box, TrBox p_tr) throws CException {
		
	    AIDA010DAO dao = new AIDA010DAO("default", p_tr);
	    
	    dao.AIDA010_SHR_PRINT0(p_box);
	    
	}		
	
    /**
     * ����Ʈ��
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void AIDA010_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {
		
	    AIDA010DAO dao = new AIDA010DAO("default", p_tr);
	    
	    dao.AIDA010_SHR_PRINT(p_box);
	    
	}	
	
	/**
	 * ������� ��û���� ����, ���� �ϴ� WORK�޼ҵ�. (������ ������ ���� ó��)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SAV(CBox p_box, TrBox p_tr) throws CException {
	    //�ʿ��� ���� ����
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao2 = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao3 = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao4 = new AIDA010DAO("default", p_tr);        
        
		GauceValueObject voList = null;
		
        GauceValueObject vo = null;

        String resultMsg = "";


        // ��û ���� ��� �ڷḦ ������
        voList = p_tr.getInGauceValueObject("dsT_AD_AIDAPP");
        
		vo = voList.get(0);	// LIST -> ROW

        // ��û�ǿ� ���� ��ȿ�� ����
         resultMsg = dao.PROC_CHK(p_box, vo); //  ===============>  TEST  ���� ����

        // ��ȿ�� ������ ��� �޼���(resultMsg) �� ��� ������ ������ �����ߴٰ� �����ϰ� ��û���� �����
        if(resultMsg.equals("")) {

            // ����Ÿ�� �̹� ��� �ִ��� ���θ� ������ �� insert, update�� ��
            if(dao2.AIDA010_CHK(vo) == 0)
            	
                dao3.AIDA010_INS(vo, p_box);
            
            else
            	
                dao3.AIDA010_UPT(vo, p_box);

            //������ ���� ����
            chagneDecision(dao4, p_box, p_tr);
            
        }

        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

	/**
	 * ������� ��û���� �����ϰ�, ���������� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void AIDA010_SAV_01(CBox p_box, TrBox p_tr) throws CException {
		
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao2 = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao3 = new AIDA010DAO("default", p_tr);
        
        GauceValueObject vo = null;

        //��û ���� ��� �ڷḦ ������
        vo = p_tr.getInGauceValueObject("dsT_AD_AIDAPP").get(0);


        //���ó���Ҷ� �⺻���� ������Ʈ ��Ŵ
        if(JSPUtil.rns(vo.get("AID_STS")).equals("S")) {
        	
            dao.AIDA010_UPT_01(vo, p_box);

        //�ΰ��϶� ������ ������ ������Ŵ
        }else if(JSPUtil.rns(vo.get("AID_STS")).equals("R")){
        	
        	dao.AIDA010_UPT_01(vo, p_box);
        	
            dao2.AIDA010_UPT_02(vo, p_box);
            
        }
        //�����϶� ������ ������ ������Ŵ
        else if(JSPUtil.rns(vo.get("AID_STS")).equals("O")){
        	
        	dao.AIDA010_UPT_02(vo, p_box);

            // ���� 2�� �� OK ���� ���� ����
        	// 2020.07.21 �λ��� �ο� ��Ȳ�� ���� ������ ���� 2���̸� 2, 3���̸� 3
            if(dao2.AIDA010_CHK_02(vo) == 2)
            	
            	dao3.AIDA010_UPT_OK(vo, p_box);
            
            else{

        		dao3.AIDA010_UPT_02_NEXT(vo, p_box);
        		
           }
        }
	}


    /**
     * ������ ������ �ٲ������ ������ ó���� ����
     * @param dao
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    private void chagneDecision(AIDA010DAO dao, CBox p_box, TrBox p_tr) throws CException {

        GauceValueObject voList = null;
        GauceValueObject vo = null;

        //������ ���� ��� �ڷḦ ������
        voList = p_tr.getInGauceValueObject("dsT_AD_DECISION");

        for(int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);

            this.AIDA010_INS_01(vo, p_box, p_tr);
            
        }
    }

    
	public void AIDA010_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr ) throws CException {

        //�ʿ��� ���� ����
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);

        dao.AIDA010_INS_01(vo, p_box);
        
	}
	
    
    
	/**
	 * ������� ��û���� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void AIDA010_DEL( CBox p_box, TrBox p_tr ) throws CException {

        //�ʿ��� ���� ����
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);
        AIDA010DAO dao2 = new AIDA010DAO("default", p_tr);
        
        GauceValueObject voList = null;
        GauceValueObject vo = null;

        //��û ���� ��� �ڷḦ ������
        voList = p_tr.getInGauceValueObject("dsT_AD_AIDAPP");
        for (int i=0; i<voList.size(); i++) {
            vo = voList.get(i);

            /**
                * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
                *  - 1 : NORMAL
                *  - 2 : INSERT
                *  - 3 : UPDATE
                *  - 4 : DELETE
                */
            switch (vo.getInt("TX_MODE")) {
            
                case 4:
                    /** �ش� row�� �����Ѵ� **/
                    // delete;
                    dao.AIDA010_DEL(vo, p_box);
                    
                    break;
            }
        }

        //������ ���� ��� �ڷḦ ������
        voList = p_tr.getInGauceValueObject("dsT_AD_DECISION");
        
        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);

            /**
                * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
                *  - 1 : NORMAL
                *  - 2 : INSERT
                *  - 3 : UPDATE
                *  - 4 : DELETE
                */
            switch (vo.getInt("TX_MODE")) {
            
                case 4:
                    dao2.AIDA010_DEL_01(vo, p_box);
                    break;
                    
            }
            
        }

	}

	/**
	 * ������� ��ǥó�� ����
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void PROC_D( CBox p_box, TrBox p_tr ) throws CException {
	    /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
	    AIDA010DAO dao = new AIDA010DAO("default", p_tr);

	    //dao.PROC_D(p_box);

		/*
        // 1. �����Ұ���ȸ
        // 2. Huni-Bills �� ����
        // 3. Procedure ȣ��
        // 4. �츮�� Table�� Update�Ѵ�
        // 5. ÷�ι����� ������ش�(html)
         */
        try{
	        // 1. �����Ұ� ��ȸ
	        GauceDataSet ds = dao.AIDA010_PRC_SHR_01(p_box);
	        if(ds.getDataRowCnt() > 0){

	        	String returnValue = "0";

        		if("0".equals(returnValue)){
            		//4.������ǥTable�� Update
            		p_box.set("WRK_NO1", p_box.get("REQ_NO"));
                    dao.AIDA010_PRC_UPT_01(p_box);  //��������ǥ���� Update

            		//5.html�� �����Ѵ�

                    GauceDataSet dsFile = dao.AIDA010_PRC_SHR_02(ds);		// ÷�����ϳ��� ��ȸ
                    GauceDataSet dsDecision = dao.AIDA010_SHR_05(p_box);
            		dao.AIDA010_PRC_MAKE_HTML(p_box, ds, dsDecision, dsFile);
            	}else if("1".equals(returnValue)){
            		throw new CException("SAP�� ȣ���ϴ���  Error�� �߻��߽��ϴ� !!");
            	}else if("2".equals(returnValue)){
            		throw new CException("HUNI-BILLS�� Procedure�� ������ Error�� �߻��߽��ϴ� !!");
            	}else if("3".equals(returnValue)){
            		throw new CException("SAP, HUNI-BILLS�� Procedure�� ������ Error�� �߻��߽��ϴ� !!");
            	}else{

            		//conn.rollback();
            		throw new CException("��ǥ������ Error�� �߻��߽��ϴ� !!");
            	}
        		//conn.commit();

	        }
        }catch(Exception e){
    		throw new CException(e.getMessage());
        }

	}

    /**
     * ������� ����ó�� ����
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void PROC_E( CBox p_box, TrBox p_tr ) throws CException {
        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
        AIDA010DAO dao = new AIDA010DAO("default", p_tr);

        dao.PROC_E(p_box);
    }
}
