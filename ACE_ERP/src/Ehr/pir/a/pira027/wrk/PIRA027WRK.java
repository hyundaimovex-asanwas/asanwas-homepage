package Ehr.pir.a.pira027.wrk;

import Ehr.pir.a.pira027.dao.PIRA027DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA027WRK {
	/**
	 * ���м��� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA027_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA027DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA027DAO dao = new PIRA027DAO("default", p_tr);

        /** ���м��� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA027_SHR(p_box);

	}
	
	/**
	 * Ʈ�������� �����Ͽ� ���м��� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA027_SAV( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * ���м��� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA027DAO dao = new PIRA027DAO("default", p_tr);
			
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
					/** ���м��� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.PIRA027_INS(vo, p_box);
					break;
						
				case 3:
					/** ���м��� UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA027_UPT(vo, p_box);
					break;
						
				case 4:
					//delete
					break;					
			}
		}
	}
	
	/**
	 * Ʈ�������� �����Ͽ� ���м��� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA027_DEL( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * ���м��� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA027DAO dao = new PIRA027DAO("default", p_tr);
			
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
					//insert
					break;
						
				case 3:
					//update
					break;
						
				case 4:
					/** ���м��� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA027_DEL(vo, p_box);
					break;					
			}
		}
	}
	
}
