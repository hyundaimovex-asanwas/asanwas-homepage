package Ehr.edu.e.edue032.wrk;

import Ehr.edu.e.edue032.dao.EDUE032DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class EDUE032WRK {
	/**
	 * ��ܰ��¿�û�� �����͸� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	
	private EDUE032DAO dao = null;
	private String connectionName = "default"; 
	
	public void EDUE032_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE032DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		
		/** ��ȸ�� �����͸� ȭ�鿡 �����ϴ� �κ� **/
		dao = new EDUE032DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR",  dao.EDUE032_SHR_00(p_box));
		
		
		dao = new EDUE032DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR0", dao.EDUE032_SHR_02(p_box));

	}

	public void EDUE032_SHR_ED(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE032DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		
		/** ��ȸ�� �����͸� ȭ�鿡 �����ϴ� �κ� **/
		dao = new EDUE032DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR2", dao.EDUE032_SHR_01(p_box));
		
		
		System.out.println("p_box:::::::"+p_box);
		dao = new EDUE032DAO(connectionName, p_tr);
		p_tr.setOutDataSet("SHR_APP", dao.EDUE032_SHR_03(p_box) );

	}

	/**
	 * Ʈ�������� �����Ͽ� ��ܰ��½�û�� �����͸� �Է�/�����ϴ� WRK �޼ҵ�
	 * @param p_box		    CBox��ü  (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE032_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * ��ܰ��½�û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
		// ���缱 ���� ��� ����
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");

		String REQ_NO = "";

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		dao = new EDUE032DAO(connectionName, p_tr);
		REQ_NO = dao.EDUE032_SHR_MAX();

		System.out.println("st1");
		
		GauceValueObject vo = null;
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			vo = voList.get(i);	// LIST -> ROW

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
    		switch (vo.getInt("TX_MODE")) {
				case 2:

					vo.set("REQ_NO", REQ_NO);
    				/** ��ܰ��½�û�� INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					System.out.println("st2");
					dao = new EDUE032DAO(connectionName, p_tr);
					dao.EDUE032_INS(vo, p_box);
					System.out.println("st3");
					break;

				case 3:

                    //update
					break;

				case 4:

					//delete
					break;
			}
		}
		
		

		System.out.println("---------------------- ���缱 Insert  2010.0406 ---------------------");
		System.out.println("voList2.size = ["+voList2.size()+"]");

		GauceValueObject vo2 = null;
		for(int i = 0; i < voList2.size(); i++){
			vo2 = voList2.get(i);
			vo2.set("REQ_NO", REQ_NO);

			System.out.print("11111"+vo2);
			dao = new EDUE032DAO(connectionName, p_tr);
			dao.EDUE_APPROVAL_INS(vo2, p_box);
		}
	}

	/**
	 * Ʈ�������� �����Ͽ� ��ܰ��½�û�� �����͸� ���� ó���ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void EDUE032_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * ��ܰ��½�û�� �����͸� ���� DATASET�� VO�� ����
		 * GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó��
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("DEL");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		dao = new EDUE032DAO(connectionName, p_tr);

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
					dao.EDUE032_DEL(vo, p_box);
					break;
			}
		}
	}
	public void EDUE032_APP(CBox p_box, TrBox p_tr) throws CException {

		/** EDUE032DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		//EDUE032DAO dao = new EDUE032DAO("default", p_tr);
		dao = new EDUE032DAO(connectionName, p_tr);

		/** ��ȸ�� �����͸� ȭ�鿡 �����ϴ� �κ� **/
		dao.EDUE032_APP(p_box);

	}
}
