package Ehr.sch.a.scha010.wrk;

import Ehr.sch.a.scha010.dao.SCHA010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.FileUtils;
import com.shift.gef.support.vo.GauceValueObject;

public class SCHA010WRK {
	
	/**
	 * ���ڱ� ���ޱ��� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA010_SHR(CBox p_box, TrBox p_tr) throws CException {

		SCHA010DAO dao = new SCHA010DAO("default", p_tr);
		SCHA010DAO dao2 = new SCHA010DAO("default", p_tr);		
		
		dao.SCHA010_SHR(p_box);
		
		/** ��������ó�� ���� ���  **/
		dao2.SCHA010_SHR_ACC(p_box);    	
		
	}
	
	/**
	 * ��������� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA010_SHR_01(CBox p_box, TrBox p_tr) throws CException {
		
		SCHA010DAO dao = new SCHA010DAO("default", p_tr);
		dao.SCHA010_SHR_01(p_box);
	}
	
	/**
	 * ���ڱ� ��û���� ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SCHA010_SAV(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_SC_SCHLBOOK");
			
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		SCHA010DAO dao = new SCHA010DAO("default", p_tr);
		SCHA010DAO dao2 = new SCHA010DAO("default", p_tr);
		
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
				
                    // ���ڱ� ��û���� �����ϱ� ���� DAO�޼ҵ� ȣ��
                    dao.SCHA010_INS(vo, p_box);   
                    
        			/** ��������ó�� ���� ���  **/
        			dao2.SCHA010_INS_ACC(p_box);    	                    
                    
					break;
				case 3:

                    // ���ڱ� ��û���� �����ϱ� ���� DAO�޼ҵ� ȣ��
                    dao.SCHA010_UPT(vo, p_box);        
                    
        			/** ��������ó�� ���� ���  **/
        			dao2.SCHA010_UPT_ACC(p_box);    	
        			
					break;
				case 4:
					
					// delete;
					break;					
			}
		}
	}

	/**
	 * ���ڱ� ��û���� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SCHA010_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SCHA010DAO dao = new SCHA010DAO("default", p_tr);

		/** ÷�������� �����Ѵ� **/
		if( p_box.get("FLAG").equals("1")){
			
			// ÷�����ϸ� ����
			dao.SCHA010_UPT_01(p_box);
			
			FileUtils.deleteFile(p_box.get("FILE_URL"));
			
		/** �ش� row�� �����Ѵ� **/
		}else{
			// delete;
			dao.SCHA010_DEL(p_box);
			
			FileUtils.deleteFile(p_box.get("FILE_URL"));
			
		}
		
	}
	
}

