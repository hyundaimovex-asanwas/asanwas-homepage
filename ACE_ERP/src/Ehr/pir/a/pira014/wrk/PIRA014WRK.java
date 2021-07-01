package Ehr.pir.a.pira014.wrk;

import Ehr.pir.a.pira013.dao.PIRA013DAO;
import Ehr.pir.a.pira014.dao.PIRA014DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA014WRK {
	/**
	 * �λ���ǥ �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA014_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA014DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		PIRA014DAO dao = new PIRA014DAO("default", p_tr);

        /** �λ���ǥ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.PIRA014_SHR(p_box);

	}
	
	/**
	 * Ʈ�������� �����Ͽ� �λ���ǥ �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void PIRA014_SAV( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * �λ���ǥ �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		PIRA013DAO dao1 = new PIRA013DAO("default", p_tr);
		PIRA014DAO dao2 = new PIRA014DAO("default", p_tr);
			
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
					break;
						
				case 3:
					/** �λ���ǥ UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao2.PIRA014_UPT(vo, p_box);
					dao1.PIRA013_INS(p_box);//EMPLIST�� ������Ʈ
					break;
						
				case 4:
					//delete
					break;					
			}
		}
	}
}
