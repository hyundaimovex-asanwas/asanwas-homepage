package Ehr.gun.e.gune015.wrk;


import Ehr.but.a.buta025.dao.BUTA025DAO;
import Ehr.gun.e.gune015.dao.GUNE015DAO;


import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUNE015WRK {

	/**
	 * ����ٹ� ��Ȳ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNE015_SHR(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsOvertimework = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNE015DAO dao = new GUNE015DAO("default", p_tr);
		GUNE015DAO dao2 = new GUNE015DAO("default", p_tr);
		
		System.out.println("1==================="+p_box);			
		
		//�ۼ� ���� ��ȸ
		dsOvertimework = dao.GUNE015_SHR(p_box);
		
		System.out.println("2==================="+p_box);	
		
		//������ ���� ��ȸ
		dsDecision = dao2.GUNE015_SHR_01(p_box);
		
		
		//RESPONSE�� �����ͼ��� �����ϴ� �޼ҵ�
		p_tr.setOutDataSet("dsT_DI_OVERTIMEWORK", dsOvertimework);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);
		
	}

	/**
	 * Ʈ�������� �����Ͽ� ����ٹ� �����Ȳ, ����ٹ� ���� ���� ���̺� ���, ����, ����ó�������� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNE015_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_OVERTIMEWORK_STATE");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);
		
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNE015DAO dao = new GUNE015DAO("default", p_tr);
		GUNE015DAO dao2 = new GUNE015DAO("default", p_tr);
		


		//	1. �������� ����
		dao.GUNE015_UPT_01(p_box, vo);

		//System.out.println("111111111111111111111111111111111111111");
		
		//  2. T_DI_OVERTIMEWORK�� UPDATE
		dao2.GUNE015_UPT_02(p_box, vo);
		
		
	}

	/**
	 * Ʈ�������� �����Ͽ� ����ǰ�� �����Ȳ, ��������� ���� ���� ���̺� �ΰ�, �ݼ�ó�������� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUNE015_SAV_03( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUNE015DAO dao = new GUNE015DAO("default", p_tr);

		//���系�� ���� (���� ������ ���� ���� ���̺�)
		dao.GUNE015_UPT_01(p_box, vo);

	}

}
