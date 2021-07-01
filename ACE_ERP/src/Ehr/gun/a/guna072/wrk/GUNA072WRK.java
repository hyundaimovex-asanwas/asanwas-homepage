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
	 * 결재세부사항 조회(변경신청) 조회 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SHR_01(CBox p_box, TrBox p_tr) throws CException {

			GUNA072DAO dao = new GUNA072DAO("default", p_tr);
			dao.GUNA072_SHR_01(p_box);

	}

	/**
	 * 결재세부사항 조회(일일근태) 조회 하는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SHR_02(CBox p_box, TrBox p_tr) throws CException {

			GUNA072DAO dao = new GUNA072DAO("default", p_tr);
			dao.GUNA072_SHR_02(p_box);

	}

	/**
	 * 결재세부사항 조회(익월근태) 조회 하는 WORK메소드.
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
	 * 결재세부사항 조회(연차촉진제) 조회 하는 WORK메소드.
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
	 * 결재자 조회 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SHR_APP(CBox p_box, TrBox p_tr) throws CException {

		GUNA072DAO dao = new GUNA072DAO("default", p_tr);
		
		dao.GUNA072_SHR_APP(p_box);

}
	/**
	 * 결재정보를 저장 하는 WORK메소드.(개인별 일일근태)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SAV(CBox p_box, TrBox p_tr) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);

		GUNA072DAO dao = new GUNA072DAO("default", p_tr);
		GUNA072DAO dao2 = new GUNA072DAO("default", p_tr);	
		GUNA072DAO dao3 = new GUNA072DAO("default", p_tr);		
		GUNA072DAO dao4 = new GUNA072DAO("default", p_tr);		
		
		//1. 결재정보 수정
		dao.GUNA072_UPT(p_box,vo);

		//2.모두 결재됐는지 Check
		GauceDataSet dsCnt = dao2.GUNA072_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");

		//System.out.println("일일근태 최종 상태 - APP_YN [" + APP_YN + "]");

		// 3. 모두 결재돼었으면 T_DI_DILIGENCE에 Update
		if("Y".equals(APP_YN)){

			/** 외부 XML에서 SQL을 읽어 온다 **/
			// 3.1 T_DI_DILIGENCE_IND 에 있는 정보를 읽어오기
			GauceDataSet dsDi = dao3.GUNA072_SHR_03(p_box);
			
			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

				String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YYMMDD");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = GauceUtils.nameValue(dsDi, i, "GUN_CD");
				String REMARK = GauceUtils.nameValue(dsDi, i, "REMARK");

				// 3.0 T_DI_LIGENCE에 있는 데이터 새로 만들기
				//dao4.GUNA072_INS_01(vo, PIS_YYMMDD, p_box, p_tr);
				this.GUNA072_INS_01(p_box, PIS_YYMMDD, p_tr);
				
				// 3.2 T_DI_DILIGENCE 에 Update
				this.GUNA072_UPT_01(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.4 T_DI_DILIGENCE 에 총계 Update
				this.GUNA072_UPT_03(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.5 T_DI_DILIGENCE_DTL에 반영
				this.GUNA072_INS_02(PIS_YYMMDD, ENO_NO,REMARK, p_box, p_tr);
				
			}
			//	3.6 T_DI_DILIGENCE_IND에 완료여부 반영여부 해줌(END_TAG)
			dao4.GUNA072_UPT_0400(p_box,APP_YN);
			
		}  //부결
		
		 else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
				//	3.6 T_DI_DILIGENCE_IND에 완료여부 반영여부 해줌(END_TAG)
				dao3.GUNA072_UPT_0400(p_box,APP_YN);
				
		}
	}

	

	public void GUNA072_INS_01(CBox p_box, String PIS_YYMMDD, TrBox p_tr ) throws CException {
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_INS_01(p_box, PIS_YYMMDD);

	}			

	public void GUNA072_INS_02(String PIS_YYMMDD, String ENO_NO, String REMARK, CBox p_box, TrBox p_tr ) throws CException {
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_INS_02(PIS_YYMMDD, ENO_NO, REMARK, p_box);

	}			
	
	public void GUNA072_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_01(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}	

	public void GUNA072_UPT_02(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_02(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}	
	
	public void GUNA072_UPT_03(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_03(PIS_YYMMDD, ENO_NO, GUN_CD, p_box);

	}		


	
	/**
	 * 결재정보를 저장 하는 WORK메소드.(변경근태)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SAV_01(CBox p_box, TrBox p_tr) throws CException {
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		
		GauceValueObject vo = voList.get(0);
		
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);
		GUNA072DAO dao2 = new GUNA072DAO("default", p_tr);	
		GUNA072DAO dao3 = new GUNA072DAO("default", p_tr);		
		GUNA072DAO dao4 = new GUNA072DAO("default", p_tr);	
		
		//1. 결재정보 수정
		dao.GUNA072_UPT(p_box,vo);
		

		//2.모두 결재됐는지 Check
		GauceDataSet dsCnt = dao2.GUNA072_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");


		// 3. 모두 결재돼었으면 T_DI_DILIGENCE에 Update
		
		if("Y".equals(APP_YN)){
			
			// 3.0 T_DI_LIGENCE에 있는 데이터 새로 만들기


			/** 외부 XML에서 SQL을 읽어 온다 **/
			// 3.1 T_DI_CHANGE 에 있는 정보를 읽어오기
			GauceDataSet dsDi = dao3.GUNA072_SHR_05(p_box);
			
			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){
				
				// 변경전 근태 Clear
				String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "REQ_YMD");
				String CHN_YMD = GauceUtils.nameValue(dsDi, i, "CHN_YMD");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = JSPUtil.rns(GauceUtils.nameValue(dsDi, i, "BF_GUN_CD"));
				String REMARK = GauceUtils.nameValue(dsDi, i, "REASON");
				
				this.GUNA072_INS_01(p_box, CHN_YMD, p_tr);

				// 3.2 T_DI_DILIGENCE 에 Update
				this.GUNA072_UPT_01(PIS_YYMMDD, ENO_NO, "", p_box, p_tr);
				
				// 3.3 T_DI_DILIGENCE 에 총계 Update(-)해준다
				this.GUNA072_UPT_02(PIS_YYMMDD, ENO_NO, GUN_CD, p_box, p_tr);


				// 변경후 근태 적용
				GUN_CD = JSPUtil.rns(GauceUtils.nameValue(dsDi, i, "GUN_CD"));

				// 3.2 T_DI_DILIGENCE 에 Update
				this.GUNA072_UPT_01(CHN_YMD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.4 T_DI_DILIGENCE 에 총계 Update
				this.GUNA072_UPT_03(CHN_YMD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.5 T_DI_DILIGENCE_DTL에 반영
				this.GUNA072_INS_02(CHN_YMD, ENO_NO,REMARK, p_box, p_tr);
				
			}

			//3.6 T_DI_CHANGE에 완료여부 반영여부 해줌(END_TAG)
			dao4.GUNA072_UPT_0401(p_box,APP_YN);
			

		}  //부결
		
		 else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
			 
			//	3.6 T_DI_CHANGE에 완료여부 반영여부 해줌(END_TAG)
			 
			dao3.GUNA072_UPT_0401(p_box,APP_YN);
			
		}
		
	}



	public void GUNA072_UPT(CBox p_box, GauceValueObject vo, TrBox p_tr) throws CException {
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT(p_box,vo);

	}		
	
	
	public void GUNA072_INS_ACC_01(String ENO_NO, String DPT_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_INS_ACC_01(ENO_NO, DPT_CD, p_box);

	}		
	
	public void GUNA072_UPT_PLAN_01(String PIS_YY, String PIS_MM, String PIS_DD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {

		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_PLAN_01(PIS_YY, PIS_MM, PIS_DD, ENO_NO, GUN_CD, p_box);

	}		
	
	public void GUNA072_UPT_PLAN_02(String PIS_YY, String PIS_MM, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);

		dao.GUNA072_UPT_PLAN_02(PIS_YY, PIS_MM, ENO_NO, GUN_CD, p_box);

	}		
	
	
		
	
	
	/**
	 * 결재정보를 저장 하는 WORK메소드.(연차촉진제)
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void GUNA072_SAV_03(CBox p_box, TrBox p_tr) throws CException {
		
		
		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_CM_DUMMY");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);
		
		GUNA072DAO dao = new GUNA072DAO("default", p_tr);
		GUNA072DAO dao2 = new GUNA072DAO("default", p_tr);		
		GUNA072DAO dao3 = new GUNA072DAO("default", p_tr);	
	
			
		
		
		//1. 결재정보 수정
		this.GUNA072_UPT(p_box,vo, p_tr);

		//2.모두 결재됐는지 Check
		GauceDataSet dsCnt = dao.GUNA072_CNT(p_box);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");
		

		

		// 3. 모두 결재돼었으면 T_DI_DILIGENCE에 Update
		if("Y".equals(APP_YN)){
			
			// 3.0 T_DI_LIGENCE에 있는 데이터 새로 만들기
			
			/** 외부 XML에서 SQL을 읽어 온다 **/
			
			// 3.1 T_DI_PLAN 에 있는 정보를 읽어오기
			
			//GauceDataSet dsDiInd = dao2.GUNA072_SHR_ACC_03(p_box);
			
			//for(int i = 1 ; i <= dsDiInd.getDataRowCnt(); i++){
				
				// T_DI_DILIGENCE에 테이블이 없으면 각각 테이블 만들기
				
				//this.GUNA072_INS_ACC_01(GauceUtils.nameValue(dsDiInd, i, "ENO_NO"),GauceUtils.nameValue(dsDiInd, i, "DPT_CD"), p_box, p_tr);
			
			//}


			/** 외부 XML에서 SQL을 읽어 온다 **/
			
			// 3.1 T_DI_ACCELERATE 에 있는 정보를 읽어오기
			
			GauceDataSet dsDi = dao2.GUNA072_SHR_ACC_02(p_box);
	
			for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

				String PIS_YY = GauceUtils.nameValue(dsDi, i, "PIS_YY");
				String PIS_MM = GauceUtils.nameValue(dsDi, i, "PIS_MM");
				String PIS_DD = GauceUtils.nameValue(dsDi, i, "LV");
				String ENO_NO = GauceUtils.nameValue(dsDi, i, "ENO_NO");
				String GUN_CD = GauceUtils.nameValue(dsDi, i, "COL_NEW");

				// 3.2 T_DI_DILIGENCE 에 Update
				this.GUNA072_UPT_PLAN_01(PIS_YY, PIS_MM, PIS_DD, ENO_NO, GUN_CD, p_box, p_tr);

				// 3.4 T_DI_DILIGENCE 에 총계 Update
				this.GUNA072_UPT_PLAN_02(PIS_YY, PIS_MM, ENO_NO, GUN_CD, p_box, p_tr);
				
			}
			
			//	3.6 연차촉진에 완료여부 반영여부 해줌(END_TAG)

			dao3.GUNA072_UPT_0403(p_box,"C");
			
		//부결
		}else  if("N".equals(APP_YN)){
			 
				//	3.6 연차촉진에 완료여부 반영여부 해줌(END_TAG)

				dao3.GUNA072_UPT_0403(p_box,APP_YN);
				
		}
	}

}
