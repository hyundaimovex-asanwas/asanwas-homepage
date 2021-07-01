package Ehr.edu.e.edue021.wrk;

import Ehr.edu.e.edue021.dao.EDUE021DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class EDUE021WRK {
	
	private EDUE021DAO dao = null;
	private String connectionName = "default";   
	
	/**
	 * ��ܰ��¿�û�� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE021_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE032DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		//EDUE021DAO dao = new EDUE021DAO("default", p_tr);
		dao = new EDUE021DAO(connectionName, p_tr);

		/** ��ȸ�� �����͸� ȭ�鿡 �����ϴ� �κ� **/
		p_tr.setOutDataSet("SHR",  dao.EDUE021_SHR_00(p_box));
		dao = new EDUE021DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR2", dao.EDUE021_SHR_01(p_box));
		dao = new EDUE021DAO(connectionName, p_tr);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dao.EDUE021_SHR_02(p_box) );

	}
	
	/**
	 * Ʈ�������� �����Ͽ� ��ܰ��½�û�� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE021_SAV( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * ��ܰ��½�û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		// ���缱 ���� ��� ����
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		//EDUE021DAO dao = new EDUE021DAO("default", p_tr);
		
		dao = new EDUE021DAO(connectionName, p_tr);
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

    				/** ��ܰ��½�û�� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.EDUE021_INS(vo, p_box);
					break;
						
				case 3:
		
                    //update
					break;
						
				case 4:
					
					//delete
					break;					
			}
		}
		
		
		
		
		GauceValueObject vo2 = null;
		
		for(int i = 0; i < voList2.size(); i++){
			vo2 = voList2.get(i);
			vo2.set("REQ_NO", p_box.get("ORD_NO"));
			dao = new EDUE021DAO(connectionName, p_tr);
			dao.EDUE021_APPROVAL_INS(vo2, p_box);
		}
	}
	
	/**
	 * Ʈ�������� �����Ͽ� ��ܰ��½�û�� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE021_DEL( CBox p_box, TrBox p_tr ) throws CException {
		
		/** 
		 * ��ܰ��½�û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		EDUE021DAO dao = new EDUE021DAO("default", p_tr);
			
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
					
					/** ��ܰ��½�û�� DELETE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.EDUE021_DEL(vo, p_box);
					break;					
			}
		}
	}
}
