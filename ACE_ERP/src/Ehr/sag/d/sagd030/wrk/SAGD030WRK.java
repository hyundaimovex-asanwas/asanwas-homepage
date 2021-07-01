package Ehr.sag.d.sagd030.wrk;

import Ehr.sag.d.sagd030.dao.SAGD030DAO;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class SAGD030WRK {

	/**
	 * �޿����ó�� ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGD030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		dao.SAGD030_SHR(p_box);

	}

	/**
	 * �۾��α� �ű����� (�۾� OPEN)
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD030_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);

		int i=0;

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		dao.SAGD030_INS(p_box, vo);

	}

	/**
	 * ����� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD030_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao2 = new SAGD030DAO("default", p_tr);
		
		int i=0;

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		//���ν��� ����� ����
		dao.SAGD030_INS_01(p_box, vo);

		//�۾� LOG ����(ó���ο�)
		dao2.SAGD030_UPT_02(p_box, vo);

	}



	/**
	 * ����� �ʱ�ȭ
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD030_SAV_02( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao2 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao3 = new SAGD030DAO("default", p_tr);
		
		int i=0;

		/** ValueObjectList���� ValueObject�� ������ �κ� **/

		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		dao.SAGD030_UPT_03(p_box, vo);//�۾��α� ����� ���� �� ���·� ����

		dao2.SAGD030_DEL(p_box, vo);//T_CP_PAYMASTER ����

		dao3.SAGD030_DEL_01(p_box, vo);//T_CP_PAYMASTER_OFFICE ����

	}

	/**
	 * �ݾס����װ��
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD030_SAV_03( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao2 = new SAGD030DAO("default", p_tr);
		int i=0;

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		//���ν��� ��� �ݾס����װ�� �ϰ� ó��

		dao.SAGD030_INS_03(p_box, vo);

		//�۾� LOG ����(ó���ο�)
		//dao2.SAGD030_UPT_02(p_box, vo);		
		
	}

	/**
	 * ��� �ʱ�ȭ
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD030_SAV_04( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao2 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao3 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao4 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao5 = new SAGD030DAO("default", p_tr);
		SAGD030DAO dao6 = new SAGD030DAO("default", p_tr);
		
		int i=0;

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		dao.SAGD030_UPT_04(p_box, vo);//�۾��α� �ݾ�, ���� ��� �� ���·� ����

		dao2.SAGD030_UPT_05(p_box, vo);//T_CP_PAYMASTER ���ݾ� 0���� �ʱ�ȭ

		dao3.SAGD030_DEL_02(p_box, vo);//T_CP_NCHANGE ��� ������ �ʱ�ȭ = ����

		dao4.SAGD030_DEL_03(p_box, vo);//T_AC_LOAN(�����/���ڱ�) ��� ������ �ʱ�ȭ

		dao5.SAGD030_UPT_06(p_box, vo);//T_SV_SAVELIST(����ݰ������) ��� ������ �ʱ�ȭ

		dao6.SAGD030_DEL_04(p_box, vo);//T_SV_SAVEBOOK(����ݳ��԰���) ��� ������ �ʱ�ȭ
	}

	/**
	 * �۾�CLOSE
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGD030_SAV_05( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		SAGD030DAO dao = new SAGD030DAO("default", p_tr);

		int i=0;

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(i);	// LIST -> ROW

		dao.SAGD030_UPT_04(p_box, vo);//�۾��α� �۾�CLOSE ���·� ����


	}

}

