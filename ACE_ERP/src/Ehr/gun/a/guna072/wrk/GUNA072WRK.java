package Ehr.gun.a.guna072.wrk;

import Ehr.gun.a.guna012.dao.GUNA012DAO;
import Ehr.gun.a.guna072.dao.GUNA072DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;

public class GUNA072WRK {

	/**
	 * ���缼�λ��� ��ȸ(�����û) ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			GUNA072DAO dao = new GUNA072DAO("default", p_tr);
			dao.GUNA072_SHR_01(p_box);

	}

	/**
	 * ���缼�λ��� ��ȸ(���ϱ���) ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SHR_02(CBox p_box, TrBox p_tr) throws CException {

			GUNA072DAO dao = new GUNA072DAO("default", p_tr);
			dao.GUNA072_SHR_02(p_box);

	}

	/**
	 * ���缼�λ��� ��ȸ(�Ϳ�����) ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SHR_PLAN(CBox p_box, TrBox p_tr) throws CException {

			GUNA072DAO dao = new GUNA072DAO("default", p_tr);
			GUNA072DAO dao2 = new GUNA072DAO("default", p_tr);			
			
            p_tr.setOutDataSet( "DS_ONE", dao.GUNA072_SHR_PLAN(p_box) );
            
            p_tr.setOutDataSet( "dsT_DI_HOLIDAY", dao2.GUNA072_SHR_PLAN_01(p_box) );
            


	}

	/**
	 * ���缼�λ��� ��ȸ(����������) ��ȸ �ϴ� WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SHR_ACC(CBox p_box, TrBox p_tr) throws CException {

			GUNA072DAO dao = new GUNA072DAO("default", p_tr);
			GUNA072DAO dao2 = new GUNA072DAO("default", p_tr);			
			
            p_tr.setOutDataSet( "dsT_DI_ACCELERATE", dao.GUND072_SHR_ACC_01(p_box) );
            
            p_tr.setOutDataSet( "dsT_DI_HOLIDAY", dao2.GUND072_SHR_ACC_02(p_box) );


	}
	/**
	 * ������ ��ȸ WORK�޼ҵ�.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SHR_APP(CBox p_box, TrBox p_tr) throws CException {

		GUNA072DAO dao = new GUNA072DAO("default", p_tr);
		
		dao.GUNA072_SHR_APP(p_box);

}
	/**
	 * ���������� ���� �ϴ� WORK�޼ҵ�.(���κ� ���ϱ���)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);

		GUNA072DAO dao = new GUNA072DAO("default", p_tr);
		GUNA072DAO dao2 = new GUNA072DAO("default", p_tr);	
		GUNA072DAO dao3 = new GUNA072DAO("default", p_tr);		
		GUNA072DAO dao4 = new GUNA072DAO("default", p_tr);		
		
		//1. �������� ����
		dao.GUNA072_UPT(p_box,vo);

		//2.��� ����ƴ��� Check
		GauceDataSet dsCnt = dao2.GUNA072_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");

		//System.out.println("���ϱ��� ���� ���� - APP_YN [" + APP_YN + "]");

		// 3. ��� ����ž����� T_DI_DILIGENCE�� Update
		if("Y".equals(APP_YN)){

			/** �ܺ� XML���� SQL�� �о� �´� **/
			// 3.1 T_DI_DILIGENCE_IND �� �ִ� ������ �о����
			GauceDataSet dsDi = dao3.GUNA072_SHR_03(p_box);
			
			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

				String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YYMMDD");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = GauceUtils.nameValue(dsDi, i, "GUN_CD");
				String REMARK = GauceUtils.nameValue(dsDi, i, "REMARK");

				// 3.0 T_DI_LIGENCE�� �ִ� ������ ���� �����
				//dao4.GUNA072_INS_01(vo, PIS_YYMMDD, p_box, p_tr);
				this.GUNA072_INS_01(p_box, PIS_YYMMDD, p_tr);
				
				// 3.2 T_DI_DILIGENCE �� Update
				this.GUNA072_UPT_01(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.4 T_DI_DILIGENCE �� �Ѱ� Update
				this.GUNA072_UPT_03(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.5 T_DI_DILIGENCE_DTL�� �ݿ�
				this.GUNA072_INS_02(PIS_YYMMDD, ENO_NO,REMARK, p_box, p_tr);
				
			}
			//	3.6 T_DI_DILIGENCE_IND�� �ϷῩ�� �ݿ����� ����(END_TAG)
			dao4.GUNA072_UPT_0400(p_box,APP_YN);
			
		}  //�ΰ�
		
		 else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
				//	3.6 T_DI_DILIGENCE_IND�� �ϷῩ�� �ݿ����� ����(END_TAG)
				dao3.GUNA072_UPT_0400(p_box,APP_YN);
				
		}
	}

	

	public void GUNA072_INS_01(CBox p_box, String PIS_YYMMDD, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_INS_01(p_box, PIS_YYMMDD);

	}			

	public void GUNA072_INS_02(String PIS_YYMMDD, String ENO_NO, String REMARK, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_INS_02(PIS_YYMMDD, ENO_NO, REMARK, p_box);

	}			
	
	public void GUNA072_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_01(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}	

	public void GUNA072_UPT_02(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_02(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}	
	
	public void GUNA072_UPT_03(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_03(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}		


	
	/**
	 * ���������� ���� �ϴ� WORK�޼ҵ�.(�������)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SAV_01(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		
		GauceValueObject vo = voList.get(0);
		
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);
		GUNA072DAO dao2 = new GUNA072DAO("default", p_tr);	
		GUNA072DAO dao3 = new GUNA072DAO("default", p_tr);		
		GUNA072DAO dao4 = new GUNA072DAO("default", p_tr);	
		
		//1. �������� ����
		dao.GUNA072_UPT(p_box,vo);
		

		//2.��� ����ƴ��� Check
		GauceDataSet dsCnt = dao2.GUNA072_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");


		// 3. ��� ����ž����� T_DI_DILIGENCE�� Update
		
		if("Y".equals(APP_YN)){
			
			// 3.0 T_DI_LIGENCE�� �ִ� ������ ���� �����


			/** �ܺ� XML���� SQL�� �о� �´� **/
			// 3.1 T_DI_CHANGE �� �ִ� ������ �о����
			GauceDataSet dsDi = dao3.GUNA072_SHR_05(p_box);
			
			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){
				
				// ������ ���� Clear
				String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "REQ_YMD");
				String CHN_YMD = GauceUtils.nameValue(dsDi, i, "CHN_YMD");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = JSPUtil.rns(GauceUtils.nameValue(dsDi, i, "BF_GUN_CD"));
				String REMARK = GauceUtils.nameValue(dsDi, i, "REASON");
				
				this.GUNA072_INS_01(p_box, CHN_YMD, p_tr);

				// 3.2 T_DI_DILIGENCE �� Update
				this.GUNA072_UPT_01(PIS_YYMMDD, ENO_NO, "", p_box, p_tr);
				
				// 3.3 T_DI_DILIGENCE �� �Ѱ� Update(-)���ش�
				this.GUNA072_UPT_02(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);


				// ������ ���� ����
				GUN_CD = JSPUtil.rns(GauceUtils.nameValue(dsDi, i, "GUN_CD"));

				// 3.2 T_DI_DILIGENCE �� Update
				this.GUNA072_UPT_01(CHN_YMD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.4 T_DI_DILIGENCE �� �Ѱ� Update
				this.GUNA072_UPT_03(CHN_YMD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.5 T_DI_DILIGENCE_DTL�� �ݿ�
				this.GUNA072_INS_02(CHN_YMD, ENO_NO,REMARK, p_box, p_tr);
				
			}

			//3.6 T_DI_CHANGE�� �ϷῩ�� �ݿ����� ����(END_TAG)
			dao4.GUNA072_UPT_0401(p_box,APP_YN);
			

		}  //�ΰ�
		
		 else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
			 
			//	3.6 T_DI_CHANGE�� �ϷῩ�� �ݿ����� ����(END_TAG)
			 
			dao3.GUNA072_UPT_0401(p_box,APP_YN);
			
		}
		
	}



	public void GUNA072_UPT(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT(p_box,vo);

	}		
	
	
	public void GUNA072_INS_ACC_01(String ENO_NO, String DPT_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_INS_ACC_01(ENO_NO, DPT_CD, p_box);

	}		
	
	public void GUNA072_UPT_PLAN_01(String PIS_YY, String PIS_MM, String PIS_DD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {

		
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_PLAN_01(PIS_YY, PIS_MM, PIS_DD, ENO_NO, GUN_CD, p_box);

	}		
	
	public void GUNA072_UPT_PLAN_02(String PIS_YY, String PIS_MM, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** Ʈ�������� �����ϱ� ���ؼ� getConnection(false)�� �����Ͽ��� **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_PLAN_02(PIS_YY, PIS_MM, ENO_NO, GUN_CD, p_box);

	}		
	
	
		
	
	
	/**
	 * ���������� ���� �ϴ� WORK�޼ҵ�.(����������)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SAV_03(CBox p_box, TrBox p_tr) throws CException {
		
		
		/** GauceDataSet��ü�� GauceValueObject�� ��ȯ�Ͽ� ó�� **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList���� ValueObject�� ������ �κ� **/
		GauceValueObject vo = voList.get(0);
		
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);
		GUNA072DAO dao2 = new GUNA072DAO("default", p_tr);		
		GUNA072DAO dao3 = new GUNA072DAO("default", p_tr);	
	
			
		
		
		//1. �������� ����
		this.GUNA072_UPT(p_box,vo, p_tr);

		//2.��� ����ƴ��� Check
		GauceDataSet dsCnt = dao.GUNA072_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");
		

		

		// 3. ��� ����ž����� T_DI_DILIGENCE�� Update
		if("Y".equals(APP_YN)){
			
			// 3.0 T_DI_LIGENCE�� �ִ� ������ ���� �����
			
			/** �ܺ� XML���� SQL�� �о� �´� **/
			
			// 3.1 T_DI_PLAN �� �ִ� ������ �о����
			
			//GauceDataSet dsDiInd = dao2.GUNA072_SHR_ACC_03(p_box);
			
			//for(int i = 1 ; i <= dsDiInd.getDataRowCnt(); i++){
				
				// T_DI_DILIGENCE�� ���̺��� ������ ���� ���̺� �����
				
				//this.GUNA072_INS_ACC_01(GauceUtils.nameValue(dsDiInd, i, "ENO_NO"),GauceUtils.nameValue(dsDiInd, i, "DPT_CD"), p_box, p_tr);
			
			//}


			/** �ܺ� XML���� SQL�� �о� �´� **/
			
			// 3.1 T_DI_ACCELERATE �� �ִ� ������ �о����
			
			GauceDataSet dsDi = dao2.GUNA072_SHR_ACC_02(p_box);
	
			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

				String PIS_YY = GauceUtils.nameValue(dsDi, i, "PIS_YY");
				String PIS_MM = GauceUtils.nameValue(dsDi, i, "PIS_MM");
				String PIS_DD = GauceUtils.nameValue(dsDi, i, "LV");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = GauceUtils.nameValue(dsDi, i, "COL_NEW");

				// 3.2 T_DI_DILIGENCE �� Update
				this.GUNA072_UPT_PLAN_01(PIS_YY, PIS_MM, PIS_DD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.4 T_DI_DILIGENCE �� �Ѱ� Update
				this.GUNA072_UPT_PLAN_02(PIS_YY, PIS_MM, ENO_NO, GUN_CD, p_box, p_tr);
				
			}
			
			//	3.6 ���������� �ϷῩ�� �ݿ����� ����(END_TAG)

			dao3.GUNA072_UPT_0403(p_box,"C");
			
		//�ΰ�
		}else  if("N".equals(APP_YN)){
			 
				//	3.6 ���������� �ϷῩ�� �ݿ����� ����(END_TAG)

				dao3.GUNA072_UPT_0403(p_box,APP_YN);
				
		}
	}

}
