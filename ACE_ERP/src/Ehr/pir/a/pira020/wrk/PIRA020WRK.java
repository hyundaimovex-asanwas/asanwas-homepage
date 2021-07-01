package Ehr.pir.a.pira020.wrk;

import Ehr.pir.a.pira020.dao.PIRA020DAO;
import Ehr.vlu.o.vluo020.dao.VLUO020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA020WRK {
	/**
	 * �ڰݸ��� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA020DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA020DAO dao = new PIRA020DAO("default", p_tr);

        /** �ڰݸ��� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA020_SHR(p_box);

	}
	
	/**
	 * Ʈ�������� �����Ͽ� �ڰݸ��� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA020_SAV( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * �ڰݸ��� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/

		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA020DAO dao = new PIRA020DAO("default", p_tr);

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
					/** �ڰݸ��� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					this.PIRA020_INS(vo, p_box, p_tr);
					break;
						
				case 3:
					/** �ڰݸ��� UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					this.PIRA020_UPT(vo, p_box, p_tr);
					break;
						
				case 4:
					//delete
					break;					
			}
		}
	}

	public void PIRA020_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		PIRA020DAO dao = new PIRA020DAO("default", p_tr);

		dao.PIRA020_INS(vo, p_box);

	}	
	
	public void PIRA020_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		PIRA020DAO dao = new PIRA020DAO("default", p_tr);

		dao.PIRA020_UPT(vo, p_box);

	}		
	
	
	
	/**
	 * Ʈ�������� �����Ͽ� �ڰݸ��� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA020_DEL( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * �ڰݸ��� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA020DAO dao = new PIRA020DAO("default", p_tr);
			
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
					/** �ڰݸ��� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.PIRA020_DEL(vo, p_box);
					break;					
			}
		}
	}
}
