package Ehr.vlu.o.vluo100.wrk;

import java.util.Date;

import Ehr.vlu.o.vluo020.dao.VLUO020DAO;
import Ehr.vlu.o.vluo100.dao.VLUO100DAO;

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

public class VLUO100WRK {

    /**
     * ��ǥ���� (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO100_SHR(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ����/����������ȹ (��ȸ) DAO CLASS �޼��� ȣ�� * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		//p_box.set("GOAL_NO", "1");
		
		dao.VLUO100_SHR(p_box);

	}

	
    public void VLUO100_SHR_22(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���κ������� ��ȸ DAO CLASS �޼��� ȣ�� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        
        dao.VLUO100_SHR_22(p_box);

    }
	
    /**
     * ��ǥ���� (��¿�) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO100_SHR_PRT(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ����/����������ȹ (��ȸ) DAO CLASS �޼��� ȣ�� * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		
		dao.VLUO100_SHR_PRT(p_box);

	}	
	
	/**
     * ���κ�������  ��ȸ  WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO100_SHR_00(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���κ������� ��ȸ DAO CLASS �޼��� ȣ�� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_00(p_box);

    }

    /**
     * ���� ��ȸ  WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO100_SHR_01(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ���� ��ȸ DAO CLASS �޼��� ȣ�� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        GauceDataSet ds = new GauceDataSet();

        ds = dao.VLUO100_SHR_01(p_box);

        // �� �������̺� ���� ����Ʈ�� ���� �� �򰡴�󸮽�Ʈ���� ������
        if(ds.getDataRowCnt() < 1) {
        	ds = dao.VLUO100_SHR_02(p_box);
        }

		//RESPONSE�� �����ͼ��� �����ϴ� �޼ҵ�
		p_tr.setOutDataSet("dsT_EVL_APPROVAL", ds);

    }

    /**
     * ��ǥ���� �ִ밪  (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO100_SHR_01_OLD(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ����(��ȸ) DAO CLASS �޼��� ȣ�� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_01_OLD(p_box);

    }

    /**
     * ��ǥ���ο���  (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO100_SHR_02(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ����(��ȸ) DAO CLASS �޼��� ȣ�� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_02(p_box);

    }

    /**
     * ��ǥ�Է� �Ⱓ ����  (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO100_SHR_03(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ��ǥ�Է� �Ⱓ ���� (��ȸ) DAO CLASS �޼��� ȣ�� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_03(p_box);

    }

    /**
     * �򰡴����  (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO100_SHR_04(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ �򰡴����  (��ȸ) DAO CLASS �޼��� ȣ�� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_04(p_box);

    }

    /**
     * ������ (��ȸ) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO100_SHR_YMD(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ������ ������  (��ȸ) DAO CLASS �޼��� ȣ�� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
        dao.VLUO100_SHR_YMD(p_box);

    }

    /**
     * ��ǥ���� (�Է�,����,����) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO100_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		// ��ǥ���� ��ü ���� �� ����
		try {
			dao.VLUO100_DEL_01(p_box, voList.get(0));
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
		 	    	//Log.main.println(vo);
                    break;
			    case 2:
			    	//Log.main.println(vo);
			    	this.VLUO100_INS(vo, p_box, p_tr);
			    	break;
			    case 3:
			        //Log.main.println(vo);
			    	this.VLUO100_INS(vo, p_box, p_tr);
				    //dao.VLUO100_UPT(p_box, vo);
				    break;
			    case 4:
				    //Log.main.println(vo);
			    	//dao.VLUO100_DEL_01(p_box, voList.get(0));
                    break;
			}
		}
	}

	
	public void VLUO100_INS(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_INS(p_box, vo);

	}		
	

	
	 /**
     * �������� ���� WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO100_EXL(CBox p_box, TrBox p_tr) throws CException, WriteException, Exception {

		/** DAO Class ��ü ���� * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		WritableWorkbook workbook = null;
		WritableSheet sheet = null;

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
		 	    	Log.main.println(vo);
                    break;
			    case 2:
			    	Log.main.println(vo);

			    	workbook = Workbook.createWorkbook(new File("C:\\teest.xls"));
					workbook.createSheet("Sheet", 0);                    //������ ��ũ�Ͽ� ��Ʈ�� ����ϴ�. "Sheet" �� ��Ʈ���� �˴ϴ�.
					sheet = workbook.getSheet(0);                         //��Ʈ�� �����ɴϴ�.

					WritableCellFormat cellFormat = new WritableCellFormat();    //���� ��Ÿ���� �����ϱ� ���� �κ��Դϴ�.
					cellFormat.setBorder(Border.ALL , BorderLineStyle.THIN);      //���� ��Ÿ���� �����մϴ�. �׵θ��� ���α׸��°ſ���

					//System.out.println("��¯��2");
					 // ���ۺ��� �����鼭 ������ �����͸� �ۼ��մϴ�.
					 Label label = new jxl.write.Label(i , 1 , vo.get("KPI").toString() , cellFormat);
					 sheet.addCell(label);

					workbook.write();

			    	break;
			    case 3:
			        Log.main.println(vo);
				    break;
			    case 4:
				    Log.main.println(vo);
                    break;
			}
		}

		/*try {


			workbook = Workbook.createWorkbook(new File("C:\test.xls"));
			workbook.createSheet("Sheet", 0);                    //������ ��ũ�Ͽ� ��Ʈ�� ����ϴ�. "Sheet" �� ��Ʈ���� �˴ϴ�.
			sheet = workbook.getSheet(0);                         //��Ʈ�� �����ɴϴ�.

			WritableCellFormat cellFormat = new WritableCellFormat();    //���� ��Ÿ���� �����ϱ� ���� �κ��Դϴ�.
			cellFormat.setBorder(Border.ALL , BorderLineStyle.THIN);      //���� ��Ÿ���� �����մϴ�. �׵θ��� ���α׸��°ſ���

			System.out.println("��¯��2");
			for (int i=0; i<voList.size(); i++) {
				GauceValueObject vo = voList.get(i);

				 // ���ۺ��� �����鼭 ������ �����͸� �ۼ��մϴ�.
				 Label label = new jxl.write.Label(i , 1 , vo.get("KPI") , cellFormat);
				 sheet.addCell(label);
			}

			workbook.write();

		} catch(Exception e) {
				e.printStackTrace();
				throw e;
		} finally {
			try {
			if(workbook != null) workbook.close();
			}catch (IOException e) {

			}

		}*/
	}

	  /**
     * ���ó�� WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO100_SAV_01(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
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
			    	this.VLUO100_SAV_01(p_box, vo, p_tr);
			    	//dao.VLUO100_INS_01(p_box, vo);
			    	break;
			    case 3:

				    break;
			    case 4:

                    break;
			}
		}

		if(voList.size() > 0) {
	    	// ��ǥ���� ���λ��� ������Ʈ
            //p_box.set("STATUS"		, "R");		//����(R:�̰�,Y:����,N:�ΰ�)
            //p_box.set("EVL_YYYY"	, voList.get(0).get("EVL_YYYY"));	//�ش�⵵
            //p_box.set("ENO_NO"		, voList.get(0).get("ENO_NO"));		//�����ڻ��

	    	//dao.VLUO100_SAV_01(p_box, p_tr);
		}
		
	}

	public void VLUO100_SAV_01(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_SAV_01(p_box, vo);

	}		

	public void VLUO100_SAV_011(CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//System.out.println(p_box);		
		//System.out.println(vo);			

		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_SAV_011(p_box);

	}		
	
    /**
     * ���� �Ǵ� �ΰ� WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
	public void VLUO100_SAV_02(CBox p_box, TrBox p_tr) throws CException {

		/** DAO Class ��ü ���� * */
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);
		
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

			    	this.VLUO100_SAV_02(vo, p_box, p_tr);
			    	break;
			    	
			    case 3:

			    	this.VLUO100_SAV_02(vo, p_box, p_tr);
				    break;
				    
			    case 4:

                    break;
			}
		}
	}	
	
	public void VLUO100_SAV_02(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		//System.out.println(p_box);		
		//System.out.println(vo);			
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_SAV_02(p_box, vo);

	}		
	
	public void VLUO100_UPT_02(CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/	
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_UPT_02(p_box);

	}		
	
	public void VLUO100_UPT_03(CBox p_box, TrBox p_tr) throws CException {
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/	
		
		VLUO100DAO dao = new VLUO100DAO("default", p_tr);

		dao.VLUO100_UPT_03(p_box);

	}		
	
    /**
     * ��ǥ���� (����) WRK �޼ҵ�.
     * @param p_box     CBox��ü (Request/Session������ ���� ��ü)
     * @param p_tr          TrBox��ü (���콺 ������Ʈ�� I/O����)
     * @throws CException
     */
    public void VLUO100_DEL(CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class ��ü ���� * */
        VLUO100DAO dao = new VLUO100DAO("default", p_tr);
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
                Log.main.println(vo);
                break;
            case 2:
                Log.main.println(vo);
                break;
            case 3:
                Log.main.println(vo);
                break;
            case 4:
                Log.main.println(vo);
                dao.VLUO100_DEL(p_box, vo);
                break;
            }
        }

    }
}
