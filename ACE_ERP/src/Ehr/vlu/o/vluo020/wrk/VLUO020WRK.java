package Ehr.vlu.o.vluo020.wrk;

import java.util.Date;

import Ehr.vlu.o.vluo010.dao.VLUO010DAO;
import Ehr.vlu.o.vluo020.dao.VLUO020DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.core.log.Log;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;
import Ehr.eis.t.eist020.dao.EIST020DAO;

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

public class VLUO020WRK {

    /**
     * ��ȸ WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO020_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ����/����������ȹ (��ȸ) DAO CLASS �޼��� ȣ�� * */
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);
		
		dao.VLUO020_SHR(p_box);

	}

	/**
     * ��ȸ  WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���κ������� ��ȸ DAO CLASS �޼��� ȣ�� * */
        VLUO020DAO dao = new VLUO020DAO("default", p_tr);
        
        dao.VLUO020_SHR_01(p_box);

    }




    /**
     * ��ǥ���� (�Է�,����,����) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO020_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		// ��ǥ���� ��ü ���� �� ����
		try {
			
			dao.VLUO020_DEL_01(p_box, voList.get(0));
			
		}catch(Exception ex) {
			
		}


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

			    	this.VLUO020_INS(vo, p_box, p_tr);
			    	break;
			    	
			    case 3:

			    	this.VLUO020_INS(vo, p_box, p_tr);
				    break;
				    
			    case 4:

                    break;
			}
		}
	}

	
	public void VLUO020_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		dao.VLUO020_INS(p_box, vo);

	}		
	

	
	  /**
     * ���ó�� WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO020_SAV_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);
		
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
			    		
			    	// 
			    	this.VLUO020_SAV_01(p_box, vo, p_tr);
			    	break;
			    case 3:

				    break;
			    case 4:

                    break;
			}
		}

		
	}

	public void VLUO020_SAV_01(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/	
		
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		dao.VLUO020_SAV_01(p_box, vo);

	}		
	
	public void VLUO020_SAV_011(CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/	

		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		dao.VLUO020_SAV_011(p_box);

	}		
	
	
    /**
     * ��ǥ���� (�Է�,����,����) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO020_UPT(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		// ��ǥ���� ��ü ���� �� ����
		try {
			
			dao.VLUO020_DEL_01(p_box, voList.get(0));
			
		}catch(Exception ex) {
			
		}


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

			    	this.VLUO020_INS2(vo, p_box, p_tr);
			    	break;
			    	
			    case 3:

			    	//this.VLUO020_INS(vo, p_box, p_tr);
				    break;
				    
			    case 4:

                    break;
			}
		}
	}
	
	
	public void VLUO020_INS2(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO020DAO dao = new VLUO020DAO("default", p_tr);

		dao.VLUO020_INS2(p_box, vo);

	}		
	
    /**
     * ��ǥ���� (����) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO020_DEL(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ���� * */
        VLUO020DAO dao = new VLUO020DAO("default", p_tr);
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
                break;
                
            case 3:
                break;
                
            case 4:
            	
                dao.VLUO020_DEL(p_box, vo);
                
                break;
                
            }
        }

    }
}
