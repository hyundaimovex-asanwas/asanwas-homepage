package Ehr.vlu.o.vluo050.wrk;

import Ehr.vlu.o.vluo050.dao.VLUO050DAO;

import java.util.Date;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;
import java.io.File;
import java.io.IOException;
import jxl.Workbook;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

public class VLUO050WRK {

    /**
     * ��ǥ���� (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO050_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ����/����������ȹ (��ȸ) DAO CLASS �޼��� ȣ�� * */
		VLUO050DAO dao = new VLUO050DAO("default", p_tr);
		
		dao.VLUO050_SHR(p_box);

	}

	/**
     * ��  ��ȸ  WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO050_SHR_TEAM(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���κ������� ��ȸ DAO CLASS �޼��� ȣ�� * */
        VLUO050DAO dao = new VLUO050DAO("default", p_tr);
        
        dao.VLUO050_SHR_TEAM(p_box);

    }


    /**
     * ��ǥ���� (�Է�,����,����) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO050_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		VLUO050DAO dao = new VLUO050DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");


		for (int i=0; i<voList.size(); i++) {
			GauceValueObject vo = voList.get(i);

            /**
             * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
             *  - 1 : NORMAL
             *  - 2 : INSERT
             *  - 3 : UPDATE
             *  - 4 : DELETE
             */
	        switch(vo.getInt("TX_MODE")) {
		 	    case 1:

                    break;
			    case 2:

			    	this.VLUO050_INS(vo, p_box, p_tr);
			    	break;
			    case 3:

			    	this.VLUO050_INS(vo, p_box, p_tr);
				    //dao.VLUO050_UPT(p_box, vo);
				    break;
			    case 4:

                    break;
			}
		}
	}

	
	public void VLUO050_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/		
		
		VLUO050DAO dao = new VLUO050DAO("default", p_tr);

		dao.VLUO050_INS(p_box, vo);

	}		
	

}
