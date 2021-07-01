package Ehr.gun.d.gund040.wrk;

import Ehr.gun.d.gund040.dao.GUND040DAO;
import Ehr.pir.a.pira013.dao.PIRA013DAO;
import Ehr.yac.a.yaca020.dao.YACA020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class GUND040WRK {

	/**
	 * ������ ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND040_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** GUND040DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		GUND040DAO dao = new GUND040DAO("default", p_tr);

        /** ���κ� ���� ���� ��Ȳ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		dao.GUND040_SHR(p_box);

	}

	/**
	 * ���κ� ���� ��Ȳ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUND040_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** GUND040DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		GUND040DAO dao = new GUND040DAO("default", p_tr);

        /** ���κ� ���� ���� ��Ȳ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		p_tr.setOutDataSet( "dsT_DI_YEARLY",       dao.GUND040_SHR_02(p_box) );
		
	}
	
	/**
	 * ���κ� ���� ��Ȳ�� ��ȸ�ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void GUND040_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** GUND040DAO ��ü ���� �� ���� �޼ҵ� ȣ�� */
		GUND040DAO dao = new GUND040DAO("default", p_tr);

        /** ���κ� ���� ���� ��Ȳ SELECT�ϴ� DAO �޼ҵ� ȣ�� */
		p_tr.setOutDataSet( "dsT_DI_CHECK",       dao.GUND040_SHR_03(p_box) );
		
	}	
	
	
	/**
	 * ���κ� ���� ���� ��Ȳ�� ���� �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUND040_SAV(CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUND040DAO dao = new GUND040DAO("default", p_tr);
		GUND040DAO dao2 = new GUND040DAO("default", p_tr);
		GUND040DAO dao3 = new GUND040DAO("default", p_tr);
		GUND040DAO dao4 = new GUND040DAO("default", p_tr);
		GUND040DAO dao5 = new GUND040DAO("default", p_tr);
		GUND040DAO dao6 = new GUND040DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			if(i==0){
					dao.GUND040_UPT(vo, p_box);	
			}else if(i==1){
					dao2.GUND040_UPT(vo, p_box);	
			}else if(i==2){
					dao3.GUND040_UPT(vo, p_box);	
			}else if(i==3){
					dao4.GUND040_UPT(vo, p_box);	
			}else if(i==4){
					dao5.GUND040_UPT(vo, p_box);	
			}else if(i==5){
					dao6.GUND040_UPT(vo, p_box);				
			}
		}
	}

    public void GUND040_UPT_END(CBox p_box, TrBox p_tr) throws CException {
    	
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		//GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_DILIGENCE");

    	//System.out.println("p_box---"+p_box);
    	
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		GUND040DAO dao = new GUND040DAO("default", p_tr);
		
		dao.GUND040_UPT_END(p_box);	
        
    }	
	
	

}
