package Ehr.but.a.buta020.wrk;


import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.gun.a.guna100.dao.GUNA100DAO;
import Ehr.vlu.l.vlul010.dao.VLUL010DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class BUTA020WRK {

	/**
	 * ǰ�ǹ�ȣ�� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA020_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		BUTA020DAO dao = new BUTA020DAO("default", p_tr);
		dao.BUTA020_SHR_01(p_box);

	}

	/**
	 * ��������� ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA020_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		BUTA020DAO dao = new BUTA020DAO("default", p_tr);
		dao.BUTA020_SHR_02(p_box);

	}

	/**
	 * ����ǰ�Ǽ� �ۼ� ���� �� ���� ������  ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA020_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsBusinesstrip = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA020DAO dao = new BUTA020DAO("default", p_tr);
		BUTA020DAO dao2 = new BUTA020DAO("default", p_tr);
		
		//����ǰ�Ǽ� �ۼ� ���� ��ȸ
		dsBusinesstrip = dao.BUTA020_SHR_03(p_box);
		
		//���� ������ ���� ��ȸ
		dsDecision = dao2.BUTA020_SHR_04(p_box);

		//RESPONSE�� �����ͼ��� �����ϴ� �޼ҵ�
		p_tr.setOutDataSet("dsT_DI_BUSINESSTRIP", dsBusinesstrip);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);

	}

	/**
	 * ����ǰ�Ǽ� �ۼ� ���� �� ���� ������  ��ȸ�� ���� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA020_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsBusinesstrip = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();
		GauceDataSet dsBusinesstrip_state = new GauceDataSet();
		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA020DAO dao = new BUTA020DAO("default", p_tr);
		BUTA020DAO dao2 = new BUTA020DAO("default", p_tr);
		BUTA020DAO dao3 = new BUTA020DAO("default", p_tr);		
		
		//����ǰ�Ǽ� �ۼ� ���� ��ȸ
		dsBusinesstrip = dao.BUTA020_SHR_03(p_box);
		
		//���� ������ ���� ��ȸ
		dsDecision = dao2.BUTA020_SHR_04(p_box);
		
		//������ ���� ��ȸ
		dsBusinesstrip_state = dao3.BUTA020_SHR_25(p_box);		

		//RESPONSE�� �����ͼ��� �����ϴ� �޼ҵ�
		p_tr.setOutDataSet("dsT_DI_BUSINESSTRIP", dsBusinesstrip);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);
		p_tr.setOutDataSet("dsT_DI_BUSINESSTRIP_WORKER", dsBusinesstrip_state);		
		
	}	
	
	
	public void BUTA020_SHR_PER(CBox p_box, TrBox p_tr) throws CException {

		BUTA020DAO dao = new BUTA020DAO("default", p_tr);
		dao.BUTA020_SHR_PER(p_box);

	}	
	
	/**
	 * Ʈ�������� �����Ͽ� ����ǰ�� ������ ����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void BUTA020_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP");

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList1 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA020DAO dao = new BUTA020DAO("default", p_tr);
		BUTA020DAO dao2 = new BUTA020DAO("default", p_tr);
		BUTA020DAO dao3 = new BUTA020DAO("default", p_tr);		
		BUTA020DAO dao4 = new BUTA020DAO("default", p_tr);

		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */

			switch (vo.getInt("TX_MODE")) {
			
				case 2:
					//����ǰ�Ǽ� �ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					dao.BUTA020_INS_01(vo, p_box);
					break;
				case 3:
					////����ǰ�Ǽ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					dao.BUTA020_UPT_03(p_box, vo);
					break;
				case 4:
					//delete
					break;
			}

		}

		
		//��������� ���� ��ü����
		if(voList1.size() > 0){
			
			dao2.BUTA020_DEL_01(p_box);
			
			for (int i=0; i<voList1.size(); i++) {

				/** ValueObjectList���� ValueObject�� ������ �κ� **/
				GauceValueObject vo1 = voList1.get(i);	// LIST -> ROW

				this.BUTA020_INS_03(vo1, p_box,p_tr);

				if(i==0){
					
					dao3.BUTA020_DEL_02(p_box);	//����ǰ�Ǽ� ���� ��Ȳ ����

					//����ǰ�� ������Ȳ ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
					dao4.BUTA020_INS_02(p_box);
					
				}
				
			}
			
		}

	}
	public void BUTA020_SAV_01_APP( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP");

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList1 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");


		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA020DAO dao = new BUTA020DAO("default", p_tr);
		BUTA020DAO dao2 = new BUTA020DAO("default", p_tr);
		BUTA020DAO dao3 = new BUTA020DAO("default", p_tr);
		BUTA020DAO dao4 = new BUTA020DAO("default", p_tr);
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList���� ValueObject�� ������ �κ� **/
			GauceValueObject vo = voList.get(i);

			/**
			 * Ʈ������ ��忡 ���� ó�� �ϰ� �Ǹ�, TX_MODE���� �Ʒ��� ����.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */

			switch (vo.getInt("TX_MODE")) {
			
			case 2:
				
				//����ǰ�Ǽ� �ۼ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
				dao.BUTA020_INS_01(vo, p_box);
				break;
				
			case 3:
				
				////����ǰ�Ǽ� ������ �����ϱ� ���� DAO �޼ҵ� ȣ��
				dao.BUTA020_UPT_03(p_box, vo);
				break;
				
			case 4:
				
				//delete
				break;
				
			}

		}

		
		
		if(voList1.size() > 0){
			
			//	��������� ���� ��ü����
			dao2.BUTA020_DEL_01(p_box);

			for (int i=0; i<voList1.size(); i++) {

				
		
				/** ValueObjectList���� ValueObject�� ������ �κ� **/
				
				GauceValueObject vo1 = voList1.get(i);	// LIST -> ROW

				//System.out.println("vo1==================="+vo1);						
				
				switch (vo1.getInt("TX_MODE")) {
				
				case 2:				
				
					
					
				//dao.BUTA020_INS_03(vo1, p_box);   //	��������� ���� ��ü �ű� Insert
				this.BUTA020_INS_03(vo1, p_box,p_tr);
				break;
				
				}
				//dao4.VLUL010_SAV_DTL(vo1, p_box);				
				

				//if(i==0){
					
					
					
				//}

			}
			
			dao4.BUTA020_UPT_STA(p_box);	//����ǰ�Ǽ� ���� ��Ȳ Update
			
		}

	}

	

	
	
	
	
	
	
	
	public void BUTA020_INS_03(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		BUTA020DAO dao = new BUTA020DAO("default", p_tr);

		dao.BUTA020_INS_03(vo, p_box);

	}		
	
	
	
	
	/**
	 * Ʈ�������� �����Ͽ� ����ǰ�� �����Ȳ, ��������� ���� ���� ���̺� ���, ����, ����ó�������� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void BUTA020_SAV_02( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);


		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA020DAO dao = new BUTA020DAO("default", p_tr);


		//	1. �������� ����
		dao.BUTA020_UPT_02(p_box, vo);

		//2.��� ����ƴ��� Check
		GauceDataSet dsCnt = dao.BUTA020_CNT(vo);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");

		// 3. ��� ����ž����� T_DI_DILIGENCE�� Update


		if("Y".equals(APP_YN)){

			// 3.0 T_DI_LIGENCE�� �ִ� ������ ���� �����
			// ���۳���� �������� Ʋ���� ��������...
			GauceDataSet ds = dao.BUTA020_SHR_05(vo, p_box);
			GauceDataSet dsDi;


			String ENO_NO = "";
			String DPT_CD = "";
			String BUT_FR_YMD = "";
			String BUT_TO_YMD = "";
			String COM_YN = "N";
			int COM_CNT = 0;
			String COM_NO1 = "";
			String COM_NO2 = "";
			String COM_NO3 = "";
			String COM_NO4 = "";
			String COM_NO5 = "";
			
			
			for(int i = 1; i <= ds.getDataRowCnt(); i++){
				
				 DPT_CD = GauceUtils.nameValue(ds, i, "DPT_CD");
				 ENO_NO = GauceUtils.nameValue(ds, i, "ENO_NO");
				 BUT_FR_YMD = GauceUtils.nameValue(ds, i, "BUT_FR_YMD");
				 BUT_TO_YMD = GauceUtils.nameValue(ds, i, "BUT_TO_YMD");
				 COM_YN 	= GauceUtils.nameValue(ds, i, "COM_YN");
				 COM_CNT 	= Integer.parseInt(GauceUtils.nameValue(ds, i, "COM_CNT"));
				 COM_NO1 	= GauceUtils.nameValue(ds, i, "COM_NO1");
				 COM_NO2 	= GauceUtils.nameValue(ds, i, "COM_NO2");
				 COM_NO3 	= GauceUtils.nameValue(ds, i, "COM_NO3");
				 COM_NO4 	= GauceUtils.nameValue(ds, i, "COM_NO4");
				 COM_NO5 	= GauceUtils.nameValue(ds, i, "COM_NO5");

			}


			dao.BUTA020_DIL_INS_01(BUT_FR_YMD.substring(0, 4),  ENO_NO,   DPT_CD, p_box);
			dao.BUTA020_DIL_INS_01(BUT_TO_YMD.substring(0, 4),  ENO_NO,   DPT_CD, p_box);

			// 3.1 T_DI_DILIGENCE �� �ִ� ������ �о���� - ����� ���� ����ó��

				dsDi = dao.BUTA020_DIL_SHR_01(BUT_FR_YMD.substring(0, 6), BUT_TO_YMD.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
				 
				for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

					String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YMD");

					// 3.2 T_DI_DILIGENCE �� Update // �����ڵ� 'E'�� Update
					dao.BUTA020_DIL_UPT_01(PIS_YYMMDD, ENO_NO, "E", p_box);

					// 3.4 T_DI_DILIGENCE �� �Ѱ� Update
					dao.BUTA020_DIL_UPT_03(PIS_YYMMDD, ENO_NO, "E", p_box);
				}
				
			// ������ ����ó��
			if("Y".equals(COM_YN)){
				
					// 3.1 T_DI_DILIGENCE �� �ִ� ������ �о����
				
				for(int j = 1 ; j <= COM_CNT; j++){
					
					if(j == 1){
						ENO_NO = COM_NO1;
					} else if(j == 2){
						ENO_NO = COM_NO2;
					} else if(j == 3){
						ENO_NO = COM_NO3;
					} else if(j == 4){
						ENO_NO = COM_NO4;
					} else if(j == 5){
						ENO_NO = COM_NO5;
					} else {
						break;
					}
					
					dsDi = dao.BUTA020_DIL_SHR_01(BUT_FR_YMD.substring(0, 6), BUT_TO_YMD.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
					 
					for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

						
						String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YMD");
						

						// 3.2 T_DI_DILIGENCE �� Update // �����ڵ� 'E'�� Update
						dao.BUTA020_DIL_UPT_01(PIS_YYMMDD, ENO_NO, "E", p_box);
						

						// 3.4 T_DI_DILIGENCE �� �Ѱ� Update
						dao.BUTA020_DIL_UPT_03(PIS_YYMMDD, ENO_NO, "E", p_box);
						
					}
					
				}
				
			}
			//---------------------------------------

				dao.BUTA020_UPT_01(p_box, vo,APP_YN);   //����ǰ�� ������Ȳ ���̺�
				
		}
		else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
			
				dao.BUTA020_UPT_01(p_box, vo,APP_YN);   //����ǰ�� ������Ȳ ���̺�
				
		}

	}


	/**
	 * Ʈ�������� �����Ͽ� ����ǰ�� �����Ȳ, ��������� ���� ���� ���̺� �ΰ�, �ݼ�ó�������� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void BUTA020_SAV_03( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA020DAO dao = new BUTA020DAO("default", p_tr);

		//���系�� ���� (���� ������ ���� ���� ���̺�)
		dao.BUTA020_UPT_02(p_box, vo);

	}

	/**
	 * Ʈ�������� �����Ͽ� ���� ��¥�� ���� �����ϴ� WRK �޼ҵ�
	 * @param p_box		CBox��ü (Request/Session������ ���� ��ü)
	 * @param p_tr		    TrBox��ü (���콺 ������Ʈ�� I/O����)
	 * @throws CException
	 */
	public void BUTA020_SAV_DATE( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);

		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� ���� **/
		BUTA020DAO dao = new BUTA020DAO("default", p_tr);

		//2014.11.5 �Ӻ��̾� ��û���� �̵��� ���� - ����Ϸ� �� ������ ���� ��¥ �ٲܶ� �����ʵ� �����ǵ���
		GauceDataSet ds_old = dao.BUTA020_SHR_03(p_box);	
		GauceDataSet ds = dao.BUTA020_SHR_05(vo, p_box);
		
		GauceDataSet dsDi;
		GauceDataSet dsDi2;		

		String COM_YN = "N";
		int COM_CNT = 0;
		String COM_NO1 = "";
		String COM_NO2 = "";
		String COM_NO3 = "";
		String COM_NO4 = "";
		String COM_NO5 = "";
		
		for(int i = 1; i <= ds.getDataRowCnt(); i++){

			 COM_YN 	= GauceUtils.nameValue(ds, i, "COM_YN");
			 COM_CNT 	= Integer.parseInt(GauceUtils.nameValue(ds, i, "COM_CNT"));
			 COM_NO1 	= GauceUtils.nameValue(ds, i, "COM_NO1");
			 COM_NO2 	= GauceUtils.nameValue(ds, i, "COM_NO2");
			 COM_NO3 	= GauceUtils.nameValue(ds, i, "COM_NO3");
			 COM_NO4 	= GauceUtils.nameValue(ds, i, "COM_NO4");
			 COM_NO5 	= GauceUtils.nameValue(ds, i, "COM_NO5");

		}		
		
		
		
		String BUT_FR_YMD_old = "";
		String BUT_TO_YMD_old = "";

		for(int i = 1; i <= ds_old.getDataRowCnt(); i++){

			 BUT_FR_YMD_old = GauceUtils.nameValue(ds_old, i, "BUT_FR_YMD").replaceAll("-", "");
			 BUT_TO_YMD_old = GauceUtils.nameValue(ds_old, i, "BUT_TO_YMD").replaceAll("-", "");

		}
		
		String ENO_NO = "";
		String BUT_FR_YMD = "";
		String BUT_TO_YMD = "";

		BUT_FR_YMD = vo.get("BUT_FR_YMD").replaceAll("-", "");
		BUT_TO_YMD = vo.get("BUT_TO_YMD").replaceAll("-", "");
		ENO_NO = vo.get("ENO_NO");
		 
		
		dsDi = dao.BUTA020_DIL_SHR_01(BUT_FR_YMD_old.substring(0, 6), BUT_TO_YMD_old.substring(0, 6), ENO_NO, BUT_FR_YMD_old, BUT_TO_YMD_old, p_box);
		
		for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

			String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YMD");

			// 3.2 T_DI_DILIGENCE �� Update ������// �����ڵ� null �� Update
			dao.BUTA020_DIL_UPT_02(PIS_YYMMDD, ENO_NO, "", p_box);

		}		
		
		dsDi2 = dao.BUTA020_DIL_SHR_01(BUT_FR_YMD.substring(0, 6), BUT_TO_YMD.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
		
		for(int i = 1 ; i <= dsDi2.getDataRowCnt(); i++){

			String PIS_YYMMDD = GauceUtils.nameValue(dsDi2, i, "PIS_YMD");

			// 3.2 T_DI_DILIGENCE �� Update ������// �����ڵ� 'E'�� Update
			dao.BUTA020_DIL_UPT_02(PIS_YYMMDD, ENO_NO, "E", p_box);

		}				
		
		// ������ ����ó��
		if("Y".equals(COM_YN)){
				// 3.1 T_DI_DILIGENCE �� �ִ� ������ �о����
			
			for(int j = 1 ; j <= COM_CNT; j++){
				
				if(j == 1){
					ENO_NO = COM_NO1;
				} else if(j == 2){
					ENO_NO = COM_NO2;
				} else if(j == 3){
					ENO_NO = COM_NO3;
				} else if(j == 4){
					ENO_NO = COM_NO4;
				} else if(j == 5){
					ENO_NO = COM_NO5;
				} else {
					break;
				}
				
				dsDi = dao.BUTA020_DIL_SHR_01(BUT_FR_YMD_old.substring(0, 6), BUT_TO_YMD_old.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
				 
				for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

					String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YMD");

					// 3.2 T_DI_DILIGENCE �� Update // �����ڵ� 'E'�� Update
					dao.BUTA020_DIL_UPT_02(PIS_YYMMDD, ENO_NO, "", p_box);
					
				}
				
				dsDi2 = dao.BUTA020_DIL_SHR_01(BUT_FR_YMD.substring(0, 6), BUT_TO_YMD.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
				
				for(int i = 1 ; i <= dsDi2.getDataRowCnt(); i++){

					String PIS_YYMMDD = GauceUtils.nameValue(dsDi2, i, "PIS_YMD");

					// 3.2 T_DI_DILIGENCE �� Update ������// �����ڵ� 'E'�� Update
					dao.BUTA020_DIL_UPT_02(PIS_YYMMDD, ENO_NO, "E", p_box);

				}					
				
			}
		}

		dao.BUTA020_SAV_DATE(p_box, vo);

	}

}
