package Ehr.idt.b.idtb001.wrk;

import Ehr.idt.b.idtb001.dao.IDTB001DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class IDTB001WRK {
	
	
	/**
	 * ������û��Ȳ�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB001_SHR(CBox p_box, TrBox p_tr) throws CException {

		IDTB001DAO dao = new IDTB001DAO("default", p_tr);
		
			 dao.IDTB001_SHR(p_box);
	}
	

	
	/**
	 * �ڵ� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB001_SHR_COD(CBox p_box, TrBox p_tr) throws CException {

		IDTB001DAO dao = new IDTB001DAO("default", p_tr);
		
			 dao.IDTB001_SHR_COD(p_box);
	}
	
	
	
	/**
	 * ������û ������ ����, ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void IDTB001_SAV(CBox p_box, TrBox p_tr) throws CException {
	
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_CONTRACT");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		IDTB001DAO dao = new IDTB001DAO("default", p_tr);
		
		//System.out.println("p_box3   =========================================== " + p_box);	
		//System.out.println("p_box"+p_box.toString());	   
		
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
					// ���� ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
			    	//this.IDTB001_DEL(p_box, p_tr);					
					dao.IDTB001_INS(vo, p_box);
					break;
					
				case 3:
					// ���� ������ �����ϱ� ���� DAO�޼ҵ� ȣ��
					dao.IDTB001_UPT(vo, p_box);
					break;
					
				case 4:
					// delete;
					break;		
					
			}
			
		}
		
	}
	

	/**
	 * ���� ������ ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void IDTB001_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		IDTB001DAO dao = new IDTB001DAO("default", p_tr);

		/** �ش� row�� �����Ѵ� **/
		// delete;
		dao.IDTB001_DEL(p_box);

	}
    

}

