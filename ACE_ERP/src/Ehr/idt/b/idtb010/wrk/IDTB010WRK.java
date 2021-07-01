package Ehr.idt.b.idtb010.wrk;

import Ehr.idt.b.idtb010.dao.IDTB010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class IDTB010WRK {
	
	/**
	 * ������û��Ȳ�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB010_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTB010DAO dao = new IDTB010DAO("default", p_tr);
			 dao.IDTB010_SHR(p_box);
	}
	
	/**
	 * ��� ����(HDPS)�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB010_SHR_01(CBox p_box, TrBox p_tr) throws CException {
		
		IDTB010DAO dao = new IDTB010DAO("default", p_tr);
		dao.IDTB010_SHR_01(p_box);
	}	
	
	/**
	 * ��� ����(�ּ�)�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB010_SHR_02(CBox p_box, TrBox p_tr) throws CException {
		
		IDTB010DAO dao = new IDTB010DAO("default", p_tr);
		dao.IDTB010_SHR_02(p_box);
	}	
	
	/**
	 * ������û ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB010_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ID_CONTRACT");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		IDTB010DAO dao = new IDTB010DAO("default", p_tr);
		
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
					// ��û ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.IDTB010_INS(vo, p_box);
					break;
				case 3:
					// ��û ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.IDTB010_UPT(vo, p_box);
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
	public void IDTB010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		IDTB010DAO dao = new IDTB010DAO("default", p_tr);

		/** �ش� row�� �����Ѵ� **/
		// delete;
		dao.IDTB010_DEL(p_box);

	}
    
    
    /**
     * ���� ������ڸ� �����Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void IDTB010_UPT_PRT( CBox p_box, TrBox p_tr ) throws CException {
	    
	    /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
	    IDTB010DAO dao = new IDTB010DAO("default", p_tr);
	    
	    /** �ش� row�� �����Ѵ� **/
	    // delete;
	    dao.IDTB010_UPT_PRT(p_box);
	    
	}
    
    
}

