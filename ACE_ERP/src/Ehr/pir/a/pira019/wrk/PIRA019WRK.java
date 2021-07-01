package Ehr.pir.a.pira019.wrk;

import Ehr.pir.a.pira019.dao.PIRA019DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA019WRK {
	/**
	 * �ǰ����� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA019_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA019DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA019DAO dao = new PIRA019DAO("default", p_tr);

        /** �ǰ����� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA019_SHR(p_box);

	}
	
	/**
	 * Ʈ�������� �����Ͽ� �ǰ����� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA019_SAV( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * �ǰ����� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA019DAO dao = new PIRA019DAO("default", p_tr);
			
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
					/** �ǰ����� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.PIRA019_INS(vo, p_box);
					break;
						
				case 3:
					/** �ǰ����� UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA019_UPT(vo, p_box);
					break;
						
				case 4:
					//delete
					break;					
			}
		}
	}
	
	/**
	 * Ʈ�������� �����Ͽ� �ǰ����� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA019_DEL( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * �ǰ����� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA019DAO dao = new PIRA019DAO("default", p_tr);
			
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
					/** �ǰ����� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA019_DEL(vo, p_box);
					break;					
			}
		}
	}
}
