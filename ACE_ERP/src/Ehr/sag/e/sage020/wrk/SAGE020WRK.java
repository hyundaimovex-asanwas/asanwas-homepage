package Ehr.sag.e.sage020.wrk;

import Ehr.sag.e.sage020.dao.SAGE020DAO;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.CommUtil;


public class SAGE020WRK {

	/**
	 * ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGE020_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGE020DAO dao = new SAGE020DAO("default", p_tr);

		dao.SAGE020_SHR(p_box);

	}

	/**
	 * ���� ��ȸ [FirstRow ���]
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void SAGE020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ������ ���� �޼ҵ� ȣ�� * */
		SAGE020DAO dao = new SAGE020DAO("default", p_tr);

		dao.SAGE020_SHR_01(p_box);

	}

	/**
	 * ����, ����
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void SAGE020_SAV( CBox p_box, TrBox p_tr ) throws CException {

		SAGE020DAO dao = new SAGE020DAO("default", p_tr);

        GauceValueObject voList = p_tr.getInGauceValueObject("SAV");
        GauceValueObject vo = null;

        String resultMsg = "";

        for (int i=0; i<voList.size(); i++) {
        	
            vo = voList.get(i); // LIST -> ROW

            try {
            	
                if(vo.getInt("TX_MODE") == 2) {

                    dao.SAGE020_INS(p_box, vo);		//�ű� ����

                } else if(vo.getInt("TX_MODE") == 3) {

                    dao.SAGE020_UPT(p_box, vo);		// ����
                }

            } catch (Exception e) {
                resultMsg += e.getMessage();
            }
        }
        p_tr.setOutDataSet("dsRESULT", CommUtil.getResultDataSet("RESULT_MSG", resultMsg));
	}

}
