package Ehr.acq.a.acqa010.wrk;

import Ehr.acq.a.acqa010.dao.ACQA010DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class ACQA010WRK {
	
	/**
	 * ��Ȳ ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA010_SHR(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA010DAO dao = new ACQA010DAO("default", p_tr);
			
			//ACQA010DAO dao2 = new ACQA010DAO("default", p_tr);
			
	        p_tr.setOutDataSet("dsT_ACT_PLANLIST",     dao.ACQA010_SHR_01(p_box));

	        //p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao2.ACQA010_SHR_APP(p_box));			

	}
	
	/**
	 * ���� ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void ACQA010_SHR_APP(CBox p_box, TrBox p_tr) throws CException {
			
			ACQA010DAO dao = new ACQA010DAO("default", p_tr);

	        p_tr.setOutDataSet("dsT_ACT_APPROVAL",     dao.ACQA010_SHR_APP(p_box));			

	}
	

	/**
	 * ������ ����, ���� �ϴ� WORK�޼ҵ�. (���� ������ ���� ó��)
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void ACQA010_SAV( CBox p_box, TrBox p_tr ) throws CException {


		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_PLANLIST");

		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList1 = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");

		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		ACQA010DAO dao  = new ACQA010DAO("default", p_tr);
		ACQA010DAO dao2 = new ACQA010DAO("default", p_tr);


		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */

			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					//System.out.print("vo==================" + vo);
					//�ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					dao.ACQA010_INS(vo, p_box);
					break;
					
				case 3:

					//�ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					dao.ACQA010_UPT(vo, p_box);
					break;
					
				case 4:
					//delete
					break;
					
			}

		}

		
		//������ ���� ��ü���� ����
		/*
		if(voList1.size() > 0){
			
			//dao2.ACQA010_DEL_APP(vo, p_box);
			
			for (int i=0; i<voList1.size(); i++) {

				
				GauceValueObject vo1 = voList1.get(i);	// LIST -> ROW

				this.ACQA010_INS_APP(vo1, p_box,p_tr);
				
			}
			
		}
		*/
		//������ ���� ��ü���� ��
		
	}
	
	
	
	
	
	
	public void ACQA010_INS_APP(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		ACQA010DAO dao = new ACQA010DAO("default", p_tr);

		dao.ACQA010_INS_APP(vo, p_box);

	}	
	
	
	/**
	 * ������ ����, ���� �ϴ� WORK�޼ҵ�. (���� ������ ���� ó��)
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void ACQA010_SAV_APP( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		ACQA010DAO dao   = new ACQA010DAO("default", p_tr);

		dao.ACQA010_DEL_APP(p_box);		
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					//�ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					this.ACQA010_INS_APP(vo, p_box,p_tr);
					break;
					
				case 3:
					//�ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					//dao.ACQA010_UPT(vo, p_box);
					break;
					
				case 4:
					//delete
					break;
					
			}

		}

	}
	
	
	/**
	 * ������ ��� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void ACQA010_SAV_SUB( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		ACQA010DAO dao   = new ACQA010DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					//�ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					this.ACQA010_SUB(vo, p_box,p_tr);
					this.ACQA010_SUB2(vo, p_box,p_tr);					
					break;
					
				case 3:
					//�ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					//dao.ACQA010_UPT(vo, p_box);
					break;
					
				case 4:
					//delete
					break;
					
			}

		}

	}	
	
	public void ACQA010_SUB(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		ACQA010DAO dao = new ACQA010DAO("default", p_tr);
		
		dao.ACQA010_SUB(vo, p_box);

	}	
	
	public void ACQA010_SUB2(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		ACQA010DAO dao = new ACQA010DAO("default", p_tr);
		
		dao.ACQA010_SUB2(vo, p_box);

	}		
	
	
	/**
	 * SMS�ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void ACQA010_SAV_SMS( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ACT_SMS");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		ACQA010DAO dao   = new ACQA010DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					//�ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					this.ACQA010_SMS(vo, p_box,p_tr);
					break;
					
				case 3:
					break;
					
				case 4:
					//delete
					break;
					
			}

		}

	}	
	
	public void ACQA010_SMS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		ACQA010DAO dao = new ACQA010DAO("default", p_tr);

		dao.ACQA010_SMS(vo, p_box);

	}

			


	
	/**
	 * �ۼ� ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void ACQA010_DEL( CBox p_box, TrBox p_tr ) throws CException {

        //�ʿ��� ���� ����
		ACQA010DAO dao  = new ACQA010DAO("default", p_tr);
		ACQA010DAO dao2 = new ACQA010DAO("default", p_tr);
        
        GauceValueObject voList = null;
        GauceValueObject vo = null;

        //���� ��� �ڷḦ ������
        voList = p_tr.getInGauceValueObject("dsT_ACT_PLANLIST");
        
        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);

            /**
                * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
                *  - 1 : NORMAL
                *  - 2 : INSERT
                *  - 3 : UPDATE
                *  - 4 : DELETE
                */
            switch (vo.getInt("TX_MODE")) {
            
                case 4:
                    /** �ش� row�� �����Ѵ� **/
                    // delete;
                    dao.ACQA010_DEL(vo, p_box);
                    
                    break;
            }
        }

        //������ ���� ��� �ڷḦ ������
        voList = p_tr.getInGauceValueObject("dsT_ACT_APPROVAL");
        /*
        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i);

            switch (vo.getInt("TX_MODE")) {
            
                case 4:
                    dao2.ACQA010_DEL_APP(p_box);
                    break;
                    
            }
            
        }
        */
	}
	
	
}

