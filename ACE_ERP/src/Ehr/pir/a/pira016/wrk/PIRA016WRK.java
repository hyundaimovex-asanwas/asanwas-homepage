package Ehr.pir.a.pira016.wrk;

import Ehr.pir.a.pira016.dao.PIRA016DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA016WRK {
	/**
	 * �з»��� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA016_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA016DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA016DAO dao = new PIRA016DAO("default", p_tr);

        /** �з»��� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA016_SHR(p_box);

	}
	
	/**
	 * Ʈ�������� �����Ͽ� �з»��� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA016_SAV( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * �з»��� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA016DAO dao = new PIRA016DAO("default", p_tr);
		PIRA016DAO dao2 = new PIRA016DAO("default", p_tr);
		
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
					/** �з»��� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.PIRA016_INS(vo, p_box);
					
					/** �λ縶���Ϳ� �����з»��� �ݿ��ϴ� DAO �޼ҵ� ȣ�� */
					dao2.PIRA016_UPT_02(vo, p_box);
					break;
						
				case 3:
					/** �з»��� UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA016_UPT(vo, p_box);
					
					/** �λ縶���Ϳ� �����з»��� �ݿ��ϴ� DAO �޼ҵ� ȣ�� */
					dao2.PIRA016_UPT_02(vo, p_box);
					
					break;
						
				case 4:
					//delete
					break;					
			}
		}
	}
	
	/**
	 * Ʈ�������� �����Ͽ� �з»��� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA016_DEL( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * �з»��� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA016DAO dao = new PIRA016DAO("default", p_tr);
			
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
					/** �з»��� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA016_DEL(vo, p_box);
					
					/** �λ縶���Ϳ� �����з»��� �ݿ��ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA016_UPT_02(vo, p_box);
					break;					
			}
		}
	}
}
