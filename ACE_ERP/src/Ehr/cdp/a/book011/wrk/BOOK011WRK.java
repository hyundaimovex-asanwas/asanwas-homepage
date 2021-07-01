package Ehr.cdp.a.book011.wrk;

import Ehr.cdp.a.book011.dao.BOOK011DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BOOK011WRK {

    /**
     * ������ ������ �����Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	
	private BOOK011DAO dao = null;
	private String connectionName = "default";
	
    public void BOOK011_UPT_APP(CBox p_box, TrBox p_tr) throws CException {
        BOOK011DAO dao = new BOOK011DAO("default", p_tr);
        dao.BOOK011_UPT_APP(p_box);
        dao.BOOK011_UPT_HOL(p_box);
    }

    public void BOOK011_UPT_REJ(CBox p_box, TrBox p_tr) throws CException {
        BOOK011DAO dao = new BOOK011DAO("default", p_tr);
        dao.BOOK011_UPT_REJ(p_box);
        dao.BOOK011_UPT_HOL(p_box);
    }



    /**
     * ���� ������ ������ �����Ѵ�.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
    public void BOOK011_UPT_DETAIL(CBox p_box, TrBox p_tr) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_ED_BOOKDETAIL");
        GauceValueObject vo = null;

        BOOK011DAO dao = new BOOK011DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {
			vo = voList.get(i);
	        dao.BOOK011_UPT_DETAIL(p_box, vo);
		}
    }


	/**
	 * ���������� ���� �ϴ� WORK�޼ҵ�.(�������� ��û)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BOOK011_SAV_APP(CBox p_box, TrBox p_tr) throws CException {

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");

		//BOOK011DAO dao = new BOOK011DAO("default", p_tr);
		dao = new BOOK011DAO(connectionName, p_tr);
		
		//1. �������� ����
		GauceValueObject vo1 = voList.get(0);	// LIST -> ROW
		dao.BOOK011_UPT(p_box,vo1);
		
		dao = new BOOK011DAO(connectionName, p_tr);
		//2.��� ����ƴ��� Check
		GauceDataSet ds = dao.BOOK011_CNT(p_box);
		String APP_YN = GauceUtils.nameValue(ds, 1, "APP_YN");
		
		
		// 3. ��� ����ž����� T_DI_HOLIDAYWORK�� Update
			/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/

		if(!"-".equals(APP_YN)){
			for (int i=0; i<voList.size(); i++) {
				
				
				GauceValueObject vo = voList.get(i);	// LIST -> ROW
				/** ValueObjectList���� ValueObject�� ������ �κ� **/

				dao = new BOOK011DAO(connectionName, p_tr); 
				dao.BOOK011_UPT_HOL_NEW( p_box,APP_YN);
				
		
			}

		}

	}



}
