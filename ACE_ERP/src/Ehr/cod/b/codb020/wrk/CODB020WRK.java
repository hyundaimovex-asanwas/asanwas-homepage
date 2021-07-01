package Ehr.cod.b.codb020.wrk;

import Ehr.cod.b.codb020.dao.CODB020DAO;
import Ehr.yac.a.yaca021.dao.YACA021DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODB020WRK {

	/**
	 * Ʈ����ȸ[FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODB020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		CODB020DAO dao = new CODB020DAO("default", p_tr);
		dao.CODB020_SHR(p_box);

	}

	/**
	 * �μ��ڵ� �� ��ȸ  [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODB020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		CODB020DAO dao = new CODB020DAO("default", p_tr);
		dao.CODB020_SHR_01(p_box);

	}
	
	/**
	 * HEAD_TAG �ڵ� �� ��ȸ  [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void CODB020_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		CODB020DAO dao = new CODB020DAO("default", p_tr);
		dao.CODB020_SHR_02(p_box);

	}
	
	/**
	 * �μ������� �ϳ��� ������ ȸ�������� �ִ´�.
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODB020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		CODB020DAO dao = new CODB020DAO("default", p_tr);

		//�μ������� �ϳ��� ������ ȸ�������� �ѹ��� �ֱ⶧���� insert�� �ѹ� ���
		dao.CODB020_INS(p_box);

	}

	/**
	 * �μ��ڵ� ����, ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODB020_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds01T_CM_DEPT");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		CODB020DAO dao = new CODB020DAO("default", p_tr);

		CODB020DAO dao2 = new CODB020DAO("default", p_tr);

        //�ξ簡�� ���� ������ ����ؼ� �����´�.
        //voList = dao2.YACA021_SHR_CNT_14(p_box);		
		
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
			//System.out.print(vo);
			//System.out.print("/** ValueObjectList���� ValueObject�� ������ �κ� **/");
			switch (vo.getInt("TX_MODE")) {
			
				case 2:

					// insert;
					dao.CODB020_INS_01(p_box, vo);
					
					//�����μ��� �����μ����� update�Ѵ�.(�����μ��� �����μ� �ִٰ� update)
					dao2.CODB020_UPT_02(p_box, vo);
					
					break;
					
				case 3:
					// update;
					dao.CODB020_UPT_01(p_box, vo);
					break;
					
				case 4:
					// delete;
					break;
					
			}
		}

	}

	/**
	 * �μ��ڵ� ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void CODB020_DEL( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("ds01T_CM_DEPT");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		CODB020DAO dao = new CODB020DAO("default", p_tr);

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
				// insert;
				break;
			case 3:
				// update;
				break;
			case 4:
				// delete;
				dao.CODB020_DEL_01(p_box, vo);
				//�����μ��� �����μ����� update�Ѵ�.(�����μ��� �����μ� ���ٰ� update)
				dao.CODB020_UPT_03(p_box, vo);
				break;
			}
		}

	}
}
