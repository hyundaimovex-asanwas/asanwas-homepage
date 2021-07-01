package Ehr.vlu.o.vluo060.wrk;

import Ehr.vlu.k.vluk050.dao.VLUK050DAO;
import Ehr.vlu.l.vlul020.dao.VLUL020DAO;
import Ehr.vlu.o.vluo060.dao.VLUO060DAO;

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

public class VLUO060WRK {

    /**
     * ��ǥ���� (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO060_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ����/����������ȹ (��ȸ) DAO CLASS �޼��� ȣ�� * */
		VLUO060DAO dao = new VLUO060DAO("default", p_tr);
		
		dao.VLUO060_SHR(p_box);

	}

	public void VLUO060_SHR2(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ����/����������ȹ (��ȸ) DAO CLASS �޼��� ȣ�� * */
		VLUO060DAO dao = new VLUO060DAO("default", p_tr);
		
		dao.VLUO060_SHR2(p_box);

	}	
	
	/**
     * ��ȸ  WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO060_SHR_ITEM(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���κ������� ��ȸ DAO CLASS �޼��� ȣ�� * */
        VLUO060DAO dao = new VLUO060DAO("default", p_tr);
        
        dao.VLUO060_SHR_ITEM(p_box);

    }


    /**
     * ��ǥ���� (�Է�,����,����) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO060_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		VLUO060DAO dao = new VLUO060DAO("default", p_tr);

		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_EV_RQSCORE");


		
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

			    	this.VLUO060_INS(vo, p_box, p_tr);
			    	break;
			    case 3:
			    	this.VLUO060_DEL(vo, p_box,p_tr);
			    	this.VLUO060_INS(vo, p_box, p_tr);
			    	this.VLUO060_UPT(vo, p_box, p_tr);			    	
				    //dao.VLUO060_UPT(p_box, vo);
				    break;
			    case 4:

                    break;
			}
		}
	}

	
	public void VLUO060_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/		
		
		VLUO060DAO dao = new VLUO060DAO("default", p_tr);

		dao.VLUO060_INS(p_box, vo);

	}		
	
	public void VLUO060_UPT(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/		
		
		VLUO060DAO dao = new VLUO060DAO("default", p_tr);

		dao.VLUO060_UPT(p_box, vo);

	}		
	
	
	public void VLUO060_SAV_COR(CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUO060DAO dao = new VLUO060DAO("default", p_tr);

        dao.VLUO060_SAV_COR(p_box);

	}	
	
	public void VLUO060_SAV_COR_01(CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUO060DAO dao = new VLUO060DAO("default", p_tr);

        dao.VLUO060_SAV_COR_01(p_box);

	}	
	
	public void VLUO060_DEL(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

        /** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		VLUO060DAO dao = new VLUO060DAO("default", p_tr);

        dao.VLUO060_DEL(vo, p_box);

	}		

}
