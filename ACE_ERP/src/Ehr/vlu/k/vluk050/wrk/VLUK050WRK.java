package Ehr.vlu.k.vluk050.wrk;

import Ehr.vlu.k.vluk050.dao.VLUK050DAO;
import Ehr.vlu.l.vlul050.dao.VLUL050DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class VLUK050WRK {

	public void VLUK050_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);
		
		//System.out.println(p_box);
		
		dao.VLUK050_SHR(p_box);

	}

	public void VLUK050_SHR2(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);
		
		//System.out.println(p_box);
		
		dao.VLUK050_SHR2(p_box);

	}	
	
	public void VLUK050_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

	    dao.VLUK050_SHR_01(p_box);
	}

	public void VLUK050_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

	    dao.VLUK050_SHR_02(p_box);
	}

	public void VLUK050_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

	    dao.VLUK050_SHR_03(p_box);
	}



	public void VLUK050_SHR_SCR(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

	   dao.VLUK050_SHR_SCR(p_box);

	}

	public void VLUK050_SHR_SCR_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

	   dao.VLUK050_SHR_SCR_01(p_box);

	}

	public void VLUK050_SHR_ITEM(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

	   dao.VLUK050_SHR_ITEM(p_box);

	}	
	
	public void VLUK050_SHR_ITEM_01(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

	   dao.VLUK050_SHR_ITEM_01(p_box);

	}	
	
	public void VLUK050_SHR_CMT(CBox p_box, TrBox p_tr) throws CException {

		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

	    dao.VLUK050_SHR_CMT(p_box);

	}		
	
	public void VLUK050_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSCORE");
		
		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

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
    				/** INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					//dao.VLUK050_SAV(vo, p_box);
					//dao.VLUK050_UPT(vo, p_box);
					this.VLUK050_SAV(vo, p_box,p_tr);
					//this.VLUK050_UPT(vo, p_box,p_tr);					
					//this.VLUK050_CMT(vo, p_box,p_tr);		
					//this.VLUK050_CMT2(vo, p_box,p_tr);						
					break;
				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					//dao.VLUK050_DEL(vo, p_box);
					//dao.VLUK050_SAV(vo, p_box);
					//dao.VLUK050_UPT(vo, p_box);
					this.VLUK050_DEL(vo, p_box,p_tr);
					this.VLUK050_SAV(vo, p_box,p_tr);						
					//this.VLUK050_UPT(vo, p_box,p_tr);	
					//this.VLUK050_CMT2(vo, p_box,p_tr);						
					break;
				case 4:
					break;
			}		

		}
		this.VLUK050_UPT(p_box, p_tr);
	
	}

	public void VLUK050_SAV(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_SAV(vo, p_box);

	}	
	
	public void VLUK050_UPT(CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_UPT(p_box);

	}	
	
	public void VLUK050_CMT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_CMT(vo, p_box);

	}		
	
	public void VLUK050_CMT2(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_CMT2(vo, p_box);

	}			

	public void VLUK050_DEL_CMT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_DEL_CMT(vo, p_box);

	}		
	
	public void VLUK050_DEL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_DEL(vo, p_box);

	}		
	
	
	
	public void VLUK050_SAV_01(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSCORE");

		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

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
    				/** INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					dao.VLUK050_SAV_01(vo, p_box);
					dao.VLUK050_UPT_01(vo, p_box);
					break;
				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */
					dao.VLUK050_DEL_01(vo, p_box);
					dao.VLUK050_SAV_01(vo, p_box);
					dao.VLUK050_UPT_01(vo, p_box);
					break;

				case 4:
					//delete
					break;
			}

		}

	}

	public void VLUK050_SAV_CMT(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_COMMENT");
		
		/** VLUK050DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

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
    				/** INSERT�ϴ�  DAO �޼ҵ� ȣ�� */
					this.VLUK050_DEL_CMT(vo, p_box,p_tr);					
					this.VLUK050_CMT(vo, p_box,p_tr);		
					
					break;
					
				case 3:
					/** UPDATE�ϴ� DAO �޼ҵ� ȣ�� */

					this.VLUK050_CMT2(vo, p_box,p_tr);		
					
					break;
					
				case 4:
					break;
			}
		}

	}	

	public void VLUK050_SAV_COR(CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_SAV_COR(p_box);

	}

	public void VLUK050_SAV_COR_01(CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_SAV_COR_01(p_box);

	}

	public void VLUK050_SAV_COR_02(CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_SAV_COR_02(p_box);

	}
	
	public void VLUK050_SAV_COR_03(CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUK050DAO dao = new VLUK050DAO("default", p_tr);

        dao.VLUK050_SAV_COR_03(p_box);

	}

}
