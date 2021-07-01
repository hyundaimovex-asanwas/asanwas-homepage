package Ehr.gun.f.gunf085.wrk;

import Ehr.gun.f.gunf085.dao.GUNF085DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUNF085WRK {

	/**
	 * ����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF085_SHR(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsOvertimework = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNF085DAO dao = new GUNF085DAO("default", p_tr);
		GUNF085DAO dao2 = new GUNF085DAO("default", p_tr);
		

		//�ۼ� ���� ��ȸ
		dsOvertimework = dao.GUNF085_SHR(p_box);

		//������ ���� ��ȸ
		dsDecision = dao2.GUNF085_SHR_01(p_box);
		
		//RESPONSE�� �����ͼ��� �����ϴ� �޼ҵ�
		p_tr.setOutDataSet("dsT_DI_OVERTIMESCHEDULE", dsOvertimework);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);
		
	}
	
	/**
	 * ����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNF085_SHR2(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsOvertimework = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNF085DAO dao = new GUNF085DAO("default", p_tr);
		GUNF085DAO dao2 = new GUNF085DAO("default", p_tr);
		

		//�ۼ� ���� ��ȸ
		dsOvertimework = dao.GUNF085_SHR(p_box);

		//������ ���� ��ȸ
		dsDecision = dao2.GUNF085_SHR_02(p_box);
		
		//RESPONSE�� �����ͼ��� �����ϴ� �޼ҵ�
		p_tr.setOutDataSet("dsT_DI_OVERTIMESCHEDULE", dsOvertimework);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);
		
	}	

	/**
	 * Ʈ�������� �����Ͽ� �Ѵޱٹ� �����Ȳ, �Ѵޱٹ� ���� ���� ���̺� ���, ����, ����ó�������� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNF085_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_OVERTIMESCHEDULE_STATE");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNF085DAO dao = new GUNF085DAO("default", p_tr);
		GUNF085DAO dao2 = new GUNF085DAO("default", p_tr);
		
		//	1. �������� ����
		dao.GUNF085_UPT_01(p_box, vo);

		//  2. T_DI_OVERTIMSCHEDULE�� UPDATE
		dao2.GUNF085_UPT_02(p_box, vo);
		
	}


	
	/**
	 * Ʈ�������� �����Ͽ� �����ٹ� �����Ȳ, �Ѵޱٹ� ���� ���� ���̺� ���, ����, ����ó�������� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNF085_SAV2( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_OVERTIMESCHEDULE_STATE");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNF085DAO dao = new GUNF085DAO("default", p_tr);
		GUNF085DAO dao2 = new GUNF085DAO("default", p_tr);
		
		//	1. �������� ����
		dao.GUNF085_UPT_03(p_box, vo);

		//  2. T_DI_OVERTIMSCHEDULE�� UPDATE
		dao2.GUNF085_UPT_04(p_box, vo);
		
	}	
	
}
