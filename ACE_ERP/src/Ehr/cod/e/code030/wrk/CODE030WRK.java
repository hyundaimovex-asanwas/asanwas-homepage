package Ehr.cod.e.code030.wrk;

import Ehr.cod.e.code030.dao.CODE030DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class CODE030WRK {

	/**
	 * �����  ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		CODE030DAO dao2 = new CODE030DAO("default", p_tr);    
		
		//�۾��Ϸ� ���θ� ��ȸ
		GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}		 		
		
		//�����ڰ� �ƴѰ�� �Ϸ�� �۾��� ��ȸ
		if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){

        /** ����� ���� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao2.CODE030_SHR(p_box);

		}
		
	}



	/**
	 * �޿����޾��� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		CODE030DAO dao2 = new CODE030DAO("default", p_tr);
		
		//�۾��Ϸ� ���θ� ��ȸ
		GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}

		//�����ڰ� �ƴѰ�� �Ϸ�� �۾��� ��ȸ
		if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){

			/** �޻����޾� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao2.CODE030_SHR_01(p_box);

		}

	}



	/**
	 * �޿����޾��� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		CODE030DAO dao2 = new CODE030DAO("default", p_tr);
		
		//�۾��Ϸ� ���θ� ��ȸ
		GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}

		//�����ڰ� �ƴѰ�� �Ϸ�� �۾��� ��ȸ
		if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){

	        /** �޻����޾� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao2.CODE030_SHR_02(p_box);

		}

	}



	/**
	 * �޿����޾��� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		CODE030DAO dao2 = new CODE030DAO("default", p_tr);
		
		//�۾��Ϸ� ���θ� ��ȸ
		GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}

		//�����ڰ� �ƴѰ�� �Ϸ�� �۾��� ��ȸ
		if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){

	        /** �޻����޾� SELECT�ϴ� DAO �޼ҵ� ȣ�� */
			dao2.CODE030_SHR_03(p_box);

		}

	}



	/**
	 * ������ȸ
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		//CODE030DAO dao2 = new CODE030DAO("default", p_tr);
		
		//�۾��Ϸ� ���θ� ��ȸ
		//GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		//if (ds.getDataRowCnt() <= 0){
		//	return;
		//}
		
		//�����ڰ� �ƴѰ�� �Ϸ�� �۾��� ��ȸ
		//if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){		
		
			dao.CODE030_SHR_05(p_box);
		
		//}

	}



	/**
	 * �������� ��ȸ
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);

		dao.CODE030_SHR_06(p_box);

	}

	/**
	 * �޿����޾��� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);

		dao.CODE030_SHR_PRINT(p_box);

	}	
	
	
	/**
	 * �޿����޾��� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR_PRINT2(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);

		dao.CODE030_SHR_PRINT2(p_box);

	}		
	
	/**
	 * �޿����޾��� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODE030_SHR_PRINT3(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		CODE030DAO dao = new CODE030DAO("default", p_tr);

		dao.CODE030_SHR_PRINT3(p_box);

	}			
	
}

