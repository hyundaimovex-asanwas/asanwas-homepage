package Ehr.gun.a.guna013.wrk;

import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.gun.a.guna013.dao.GUNA013DAO;


import java.sql.Connection;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.DbManager;
import Ehr.common.util.JSPUtil;

public class GUNA013WRK {

	/**
	 * ����� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_LST(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_CHANGE",  dao.GUNA013_SHR_LST(p_box) );

	}

	/**
	 * �ش�μ��� ������Ȳ�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		GUNA013DAO dao2 = new GUNA013DAO("default", p_tr);		
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE",   dao.GUNA013_SHR(p_box) );
		p_tr.setOutDataSet( "dsT_DI_APPROVAL",   dao2.GUNA013_SHR_01(p_box) );
		
	}
	
	/**
	 * ��¥�� �����ڵ带 ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_CD(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE_CD",   dao.GUNA013_SHR_CD(p_box) );
		
	}
	
	
	/**
	 * ��ȸ�� ���缱�� �����Ǿ� ���� ������ �ֱ� ���缱 �������� ������ �μ��� �ڵ�����
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_04(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		dao.GUNA013_SHR_04(p_box);
		
	}

	/**
	 * ��û��ȣ ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		dao.GUNA013_SHR_05(p_box);
		
	}

	/**
	 * ��û��ȣ ��ȸ
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsT_DI_DILIGENCE_BEFORE",   dao.GUNA013_SHR_06(p_box) );
		
	}
	
	
	/**
	 * ���º����û���� ����,���� �ϴ� WORK�޼ҵ�._
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA013_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");


		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);
		GUNA013DAO dao2 = new GUNA013DAO("default", p_tr);		
		GUNA013DAO dao3 = new GUNA013DAO("default", p_tr);		
		GUNA013DAO dao4 = new GUNA013DAO("default", p_tr);	
		GUNA013DAO dao5 = new GUNA013DAO("default", p_tr);	
		
		String REQ_NO = "";


		if("".equals(JSPUtil.rns(p_box.get("REQ_NO")))){
			
			REQ_NO = dao.GUNA013_SHR_MAX();
			
		}else{
			
			REQ_NO = JSPUtil.rns(p_box.get("REQ_NO"));
			
		}


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
			vo.set("REQ_NO", REQ_NO);
			
			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					this.GUNA013_INS(vo, p_box, p_tr);
					break;
					
				case 3:
					this.GUNA013_UPT(vo, p_box, p_tr);

				case 4:
					// delete;
					break;
			}
		}
		

		if(voList2.size() > 0){
			
			GauceValueObject vo2 = voList2.get(0);
			
			vo2.set("REQ_NO", REQ_NO);
			
			dao3.GUNA013_DEL_01(vo2, p_box);
			
		}
		
		for(int i = 0; i < voList2.size(); i++){
			
			GauceValueObject vo2 = voList2.get(i);

			vo2.set("REQ_NO", REQ_NO);
			
			this.GUNA013_INS_01(vo2, p_box, p_tr);

		}		

		p_tr.setOutDataSet( "dsT_DI_DILIGENCE_TEMP",     dao5.GUNA013_SHR_01(REQ_NO) );

	}

	
	public void GUNA013_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);

		dao.GUNA013_INS(vo, p_box);

	}	
	
	public void GUNA013_INS_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);

		dao.GUNA013_INS_01(vo, p_box);

	}		
	
	public void GUNA013_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);

		dao.GUNA013_UPT(vo, p_box);

	}		
	
	
	
	/**
	 * ���º����û���� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNA013_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA013DAO dao = new GUNA013DAO("default", p_tr);

		int i = 0;

		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		/** �ش� row�� �����Ѵ� **/
		// delete;
		dao.GUNA013_DEL(vo, p_box);

	}


}

