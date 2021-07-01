package Ehr.gun.a.guna071.wrk;

import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.gun.a.guna071.dao.GUNA071DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class GUNA071WRK {

	/**
	 * ���缼�λ��� ��ȸ(�����û) ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA071_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			GUNA071DAO dao = new GUNA071DAO("default", p_tr);
			dao.GUNA071_SHR_01(p_box);

	}

	/**
	 * ���缼�λ��� ��ȸ(���ϱ���) ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA071_SHR_02(CBox p_box, TrBox p_tr) throws CException {

			GUNA071DAO dao = new GUNA071DAO("default", p_tr);
			dao.GUNA071_SHR_02(p_box);

	}

	/**
	 * ���缼�λ��� ��ȸ(�Ϳ�����) ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA071_SHR_PLAN(CBox p_box, TrBox p_tr) throws CException {

			GUNA071DAO dao = new GUNA071DAO("default", p_tr);
			GUNA071DAO dao2 = new GUNA071DAO("default", p_tr);			
			
            p_tr.setOutDataSet( "DS_ONE", dao.GUNA071_SHR_PLAN(p_box) );
            
            p_tr.setOutDataSet( "dsT_DI_HOLIDAY", dao2.GUNA071_SHR_PLAN_01(p_box) );
            


	}

	/**
	 * ���缼�λ��� ��ȸ(����������) ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA071_SHR_ACC(CBox p_box, TrBox p_tr) throws CException {

			GUNA071DAO dao = new GUNA071DAO("default", p_tr);
			GUNA071DAO dao2 = new GUNA071DAO("default", p_tr);			
			
            p_tr.setOutDataSet( "dsT_DI_ACCELERATE", dao.GUND071_SHR_ACC_01(p_box) );
            
            p_tr.setOutDataSet( "dsT_DI_HOLIDAY", dao2.GUND071_SHR_ACC_02(p_box) );


	}
	/**
	 * ������ ��ȸ WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA071_SHR_APP(CBox p_box, TrBox p_tr) throws CException {

		GUNA071DAO dao = new GUNA071DAO("default", p_tr);
		
		dao.GUNA071_SHR_APP(p_box);

}
	/**
	 * ���������� ���� �ϴ� WORK�޼ҵ�.(���κ� ���ϱ���)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA071_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);

		GUNA071DAO dao = new GUNA071DAO("default", p_tr);
		GUNA071DAO dao2 = new GUNA071DAO("default", p_tr);	
		GUNA071DAO dao3 = new GUNA071DAO("default", p_tr);		
		GUNA071DAO dao4 = new GUNA071DAO("default", p_tr);		
		GUNA071DAO dao5 = new GUNA071DAO("default", p_tr);
		
		//1. �������� ����
		dao.GUNA071_UPT(p_box,vo);

		//2.��� ����ƴ��� Check
		GauceDataSet dsCnt = dao2.GUNA071_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");

		//System.out.println("���ϱ��� ���� ���� - APP_YN [" + APP_YN + "]");

		// 3. ��� ����ž����� T_DI_DILIGENCE�� Update
		if("Y".equals(APP_YN)){

			/** �ܺ� XML���� SQL�� �о� �´� **/
			// 3.1 T_DI_DILIGENCE_IND �� �ִ� ������ �о����
			GauceDataSet dsDi = dao3.GUNA071_SHR_03(p_box);
			

			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){


				String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YYMMDD");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = GauceUtils.nameValue(dsDi, i, "GUN_CD");				
				String REMARK = GauceUtils.nameValue(dsDi, i, "REMARK");	

				
				// 3.0 T_DI_LIGENCE�� �ִ� ������ ���� �����
				//dao4.GUNA071_INS_01(vo, PIS_YYMMDD, p_box, p_tr);
				this.GUNA071_INS_01(p_box, PIS_YYMMDD, p_tr);
				
				// 3.2 T_DI_DILIGENCE �� Update
				this.GUNA071_UPT_01(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.4 T_DI_DILIGENCE �� �Ѱ� Update
				this.GUNA071_UPT_03(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.5 T_DI_DILIGENCE_DTL�� �ݿ�
				this.GUNA071_INS_02(PIS_YYMMDD, ENO_NO, REMARK, p_box, p_tr);
				
				
				if("M".equals(GUN_CD)){
					
					//System.out.println("���� �ݿ�");
					
					// 3.6 T_DI_MONTHLY�� �ݿ�
					//this.GUNA071_UPT_05(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);				
					
					// 3.7 T_DI_MONTHLY_HISTORY�� �ݿ�
					this.GUNA071_UPT_06(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);	
					
				}

				
				
			}
			//	3.8 T_DI_DILIGENCE_IND�� �ϷῩ�� �ݿ����� ����(END_TAG)
			dao4.GUNA071_UPT_0400(p_box,APP_YN);
			
		}  //�ΰ�
		
		 else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
				//	3.6 T_DI_DILIGENCE_IND�� �ϷῩ�� �ݿ����� ����(END_TAG)
				dao3.GUNA071_UPT_0400(p_box,APP_YN);
				
		}
	}

	

	public void GUNA071_INS_01(CBox p_box, String PIS_YYMMDD, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);

		dao.GUNA071_INS_01(p_box, PIS_YYMMDD);

	}			

	public void GUNA071_INS_02(String PIS_YYMMDD, String ENO_NO, String REMARK, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);

		dao.GUNA071_INS_02(PIS_YYMMDD, ENO_NO, REMARK, p_box);

	}			
	
	public void GUNA071_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);

		dao.GUNA071_UPT_01(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}	

	public void GUNA071_UPT_02(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);

		dao.GUNA071_UPT_02(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}	
	
	public void GUNA071_UPT_03(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);

		dao.GUNA071_UPT_03(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}		


	/* 2019.02.15 ���� �ݿ��� ���� �߰��� */
	public void GUNA071_UPT_05(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);

		dao.GUNA071_UPT_05(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}		
	
	/* 2019.02.15 ���� �ݿ��� ���� �߰��� */
	public void GUNA071_UPT_06(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);

		dao.GUNA071_UPT_06(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}			
	
	
	/**
	 * ���������� ���� �ϴ� WORK�޼ҵ�.(�������)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA071_SAV_01(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		
		GauceValueObject vo = voList.get(0);
		
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);
		GUNA071DAO dao2 = new GUNA071DAO("default", p_tr);	
		GUNA071DAO dao3 = new GUNA071DAO("default", p_tr);		
		GUNA071DAO dao4 = new GUNA071DAO("default", p_tr);	
		
		//1. �������� ����
		dao.GUNA071_UPT(p_box,vo);
		

		//2.��� ����ƴ��� Check
		GauceDataSet dsCnt = dao2.GUNA071_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");


		// 3. ��� ����ž����� T_DI_DILIGENCE�� Update
		
		if("Y".equals(APP_YN)){
			
			// 3.0 T_DI_LIGENCE�� �ִ� ������ ���� �����


			/** �ܺ� XML���� SQL�� �о� �´� **/
			// 3.1 T_DI_CHANGE �� �ִ� ������ �о����
			GauceDataSet dsDi = dao3.GUNA071_SHR_05(p_box);
			
			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){
				
				// ������ ���� Clear
				String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "REQ_YMD");
				String CHN_YMD = GauceUtils.nameValue(dsDi, i, "CHN_YMD");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = JSPUtil.rns(GauceUtils.nameValue(dsDi, i, "BF_GUN_CD"));
				String REMARK = GauceUtils.nameValue(dsDi, i, "REASON");
				
				this.GUNA071_INS_01(p_box, CHN_YMD, p_tr);

				// 3.2 T_DI_DILIGENCE �� Update
				this.GUNA071_UPT_01(PIS_YYMMDD, ENO_NO, "", p_box, p_tr);
				
				// 3.3 T_DI_DILIGENCE �� �Ѱ� Update(-)���ش�
				this.GUNA071_UPT_02(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);


				// ������ ���� ����
				GUN_CD = JSPUtil.rns(GauceUtils.nameValue(dsDi, i, "GUN_CD"));

				// 3.2 T_DI_DILIGENCE �� Update
				this.GUNA071_UPT_01(CHN_YMD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.4 T_DI_DILIGENCE �� �Ѱ� Update
				this.GUNA071_UPT_03(CHN_YMD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.5 T_DI_DILIGENCE_DTL�� �ݿ�
				this.GUNA071_INS_02(CHN_YMD, ENO_NO,REMARK, p_box, p_tr);
				
			}

			//3.6 T_DI_CHANGE�� �ϷῩ�� �ݿ����� ����(END_TAG)
			dao4.GUNA071_UPT_0401(p_box,APP_YN);
			

		}  //�ΰ�
		
		 else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
			 
			//	3.6 T_DI_CHANGE�� �ϷῩ�� �ݿ����� ����(END_TAG)
			 
			dao3.GUNA071_UPT_0401(p_box,APP_YN);
			
		}
		
	}



	/**
	 * ���������� ���� �ϴ� WORK�޼ҵ�.(����������)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA071_SAV_03(CBox p_box, TrBox p_tr) throws CException {
		
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);
		
		GUNA071DAO dao = new GUNA071DAO("default", p_tr);
		GUNA071DAO dao2 = new GUNA071DAO("default", p_tr);	
		GUNA071DAO dao3 = new GUNA071DAO("default", p_tr);		
		GUNA071DAO dao4 = new GUNA071DAO("default", p_tr);	
		GUNA071DAO dao5 = new GUNA071DAO("default", p_tr);
		GUNA071DAO dao6 = new GUNA071DAO("default", p_tr);	
		GUNA071DAO dao7 = new GUNA071DAO("default", p_tr);		
			
		
		
		//1. �������� ����
		dao.GUNA071_UPT(p_box,vo);

		//2.��� ����ƴ��� Check
		GauceDataSet dsCnt = dao2.GUNA071_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");
		

		//System.out.println("�������� ���� ���� - APP_YN [" + APP_YN + "]");

		// 3. ��� ����ž����� T_DI_DILIGENCE�� Update
		if("Y".equals(APP_YN)){
			
			// 3.0 T_DI_LIGENCE�� �ִ� ������ ���� �����
			
			/** �ܺ� XML���� SQL�� �о� �´� **/
			
			// 3.1 T_DI_PLAN �� �ִ� ������ �о����
			
			GauceDataSet dsDiInd = dao3.GUNA071_SHR_ACC_03(p_box);
			
			for(int i = 1 ; i <= dsDiInd.getDataRowCnt(); i++){
				
				// T_DI_DILIGENCE�� ���̺��� ������ ���� ���̺� �����
				
				dao4.GUNA071_INS_ACC_01(GauceUtils.nameValue(dsDiInd, i, "ENO_NO"),GauceUtils.nameValue(dsDiInd, i, "DPT_CD"), p_box);
			
			}


			/** �ܺ� XML���� SQL�� �о� �´� **/
			
			// 3.1 T_DI_ACCELERATE �� �ִ� ������ �о����
			
			GauceDataSet dsDi = dao.GUNA071_SHR_ACC_02(p_box);
			
			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

				String PIS_YY = GauceUtils.nameValue(dsDi, i, "PIS_YY");
				String PIS_MM = GauceUtils.nameValue(dsDi, i, "PIS_MM");
				String PIS_DD = GauceUtils.nameValue(dsDi, i, "LV");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = GauceUtils.nameValue(dsDi, i, "COL_NEW");

				// 3.2 T_DI_DILIGENCE �� Update
				dao5.GUNA071_UPT_PLAN_01(PIS_YY, PIS_MM, PIS_DD, ENO_NO, GUN_CD, p_box);

				// 3.4 T_DI_DILIGENCE �� �Ѱ� Update
				dao6.GUNA071_UPT_PLAN_02(PIS_YY, PIS_MM, ENO_NO, GUN_CD, p_box);
				
			}
			
			//	3.6 ���������� �ϷῩ�� �ݿ����� ����(END_TAG)
			
			dao7.GUNA071_UPT_0403(p_box,APP_YN);
			
		}  //�ΰ�
		
		 else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
			 
				//	3.6 ���������� �ϷῩ�� �ݿ����� ����(END_TAG)
			 
				dao3.GUNA071_UPT_0403(p_box,APP_YN);
				
		}
	}

}
