package Ehr.idt.a.idta030.wrk;

import Ehr.idt.a.idta030.dao.IDTA030DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class IDTA030WRK {
	
	/**
	 * ������û��Ȳ�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA030_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTA030DAO dao = new IDTA030DAO("default", p_tr);
			 dao.IDTA030_SHR(p_box);
	}
	
	/**
	 * ��� ����(HDPS)�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA030_SHR_01(CBox p_box, TrBox p_tr) throws CException {
		
		IDTA030DAO dao = new IDTA030DAO("default", p_tr);
		dao.IDTA030_SHR_01(p_box);
	}	
	
	/**
	 * ��� ����(�ּ�)�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA030_SHR_02(CBox p_box, TrBox p_tr) throws CException {
		
		IDTA030DAO dao = new IDTA030DAO("default", p_tr);
		dao.IDTA030_SHR_02(p_box);
	}	
	
	/**
	 * ������û ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTA030_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ID_CEFBOOK");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		IDTA030DAO dao = new IDTA030DAO("default", p_tr);
		
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
					// ������û ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.IDTA030_INS(vo, p_box);
					break;
				case 3:
					// ������û ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.IDTA030_UPT(vo, p_box);
					break;
				case 4:
					// delete;
					break;					
			}
		}
	}
	
	/**
	 * ������û ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void IDTA030_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		IDTA030DAO dao = new IDTA030DAO("default", p_tr);

		/** �ش� row�� �����Ѵ� **/
		// delete;
		dao.IDTA030_DEL(p_box);

	}
    
    
    /**
     * ���� ������ڸ� �����Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void IDTA030_UPT_PRT( CBox p_box, TrBox p_tr ) throws CException {
	    
	    /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
	    IDTA030DAO dao = new IDTA030DAO("default", p_tr);
	    
	    /** �ش� row�� �����Ѵ� **/
	    // delete;
	    dao.IDTA030_UPT_PRT(p_box);
	    
	}
    
    
}

