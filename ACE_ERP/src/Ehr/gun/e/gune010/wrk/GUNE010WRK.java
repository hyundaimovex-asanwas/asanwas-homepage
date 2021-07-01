package Ehr.gun.e.gune010.wrk;

import java.sql.Connection;
import java.sql.SQLException;

import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.gun.e.gune010.dao.GUNE010DAO;
import Ehr.sch.a.scha010.dao.SCHA010DAO;
import Ehr.but.a.buta020.dao.BUTA020DAO;




import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.DbManager;
import Ehr.common.util.JSPUtil;

public class GUNE010WRK {

	/**
	 * �������� ��ȸ�ϱ�
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE010_SHR_APP(CBox p_box, TrBox p_tr) throws CException {

		GUNE010DAO dao = new GUNE010DAO("default", p_tr);
		dao.GUNE010_SHR_APP(p_box);
		
	}
	
	/**
	 * �������� ��ȸ�ϱ�
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE010_SHR_WK(CBox p_box, TrBox p_tr) throws CException {

		GUNE010DAO dao = new GUNE010DAO("default", p_tr);
		dao.GUNE010_SHR_WK(p_box);
		
	}
	
	/**
	 * ��������� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE010_SHR_01(CBox p_box, TrBox p_tr) throws CException {
		
		GUNE010DAO dao = new GUNE010DAO("default", p_tr);
		dao.GUNE010_SHR_01(p_box);
	}

	/**
	 * ��� ����ٹ� �����ð��� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE010_SHR_ACC(CBox p_box, TrBox p_tr) throws CException {
		
		GUNE010DAO dao = new GUNE010DAO("default", p_tr);
		dao.GUNE010_SHR_ACC(p_box);
	}
	
	/**
	 * ��� ����ٹ� ��ϰ������ڸ� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */	
	public void GUNE010_SHR_OTD(CBox p_box, TrBox p_tr)  throws CException {
		
		//GUNE010DAO dao = new GUNE010DAO("default", p_tr);

		//dao.GUNE010_SHR_OTD(p_box);
		

		GUNE010DAO dao = new GUNE010DAO("default", p_tr);
		
		p_tr.setOutDataSet( "dsOTPossibleDt",  dao.GUNE010_SHR_OTD(p_box) );
		
	}
	
	/**
	 * ��û��ȣ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE010_SHR_MAX(CBox p_box, TrBox p_tr) throws CException {
		
		GUNE010DAO dao = new GUNE010DAO("default", p_tr);
		dao.GUNE010_SHR_MAX(p_box);
	}	
	
	/**
	 * ������ ������ ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE010_UPT_APP(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_OVERTIMEWORK");

		// ���缱 ���� ��� ����
		GauceValueObject voList2 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNE010DAO dao = new GUNE010DAO("default", p_tr);
		GUNE010DAO dao2 = new GUNE010DAO("default", p_tr);
		String REQ_NO = "";
		
		
		if(voList.size() > 0){
			
			GauceValueObject vo = voList.get(0);
			
			vo.set("REQ_NO", REQ_NO);

			dao.GUNE010_UPT_APP(vo, p_box) ;
			//p_tr.setOutDataSet( "dsT_DI_OVERTIMEWORK",     dao.GUNE010_UPT_APP(vo, p_box) );
		}
		

	
		
		for(int i = 0; i < voList2.size(); i++){
			
			GauceValueObject vo2 = voList2.get(i);

			vo2.set("REQ_NO", REQ_NO);
			
			//dao2.GUNE010_UPT_APP_01(vo2, p_box) ; �̰� ���� �ȵ� �� ������ 2021.02.01
			
			this.GUNE010_UPT_APP_01(vo2, p_box, p_tr);

		}
		

		
		//p_tr.setOutDataSet( "dsT_DI_APPROVAL",      dao2.GUNE010_UPT_APP_01(p_box) );

	}
	
	
	
	public void GUNE010_UPT_APP_01(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNE010DAO dao = new GUNE010DAO("default", p_tr);

		dao.GUNE010_UPT_APP_01(vo, p_box);

	}	
	


	public void GUNE010_SMS(CBox p_box, TrBox p_tr) throws CException, SQLException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_OVERTIMEWORK");
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNE010DAO dao = new GUNE010DAO("default", p_tr);

		//String REQ_NO = "";
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//GUNE010DAO dao = new GUNE010DAO("default", p_tr);
		//System.out.print("---------------------------   333333333333333   ---------");
		//System.out.print(p_box);	
		
		dao.GUNE010_SMS(p_box);

	}	
	

	
}


