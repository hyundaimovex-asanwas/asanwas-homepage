package Ehr.but.a.buta025.wrk;


import Ehr.but.a.buta020.dao.BUTA020DAO;
import Ehr.but.a.buta025.dao.BUTA025DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class BUTA025WRK {

	/**
	 * 품의번호를 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA025_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		dao.BUTA025_SHR_01(p_box);

	}

	/**
	 * 교통수단을 조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA025_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		dao.BUTA025_SHR_02(p_box);

	}

	/**
	 * 출장품의서 작성 내용 및 결재 정보를  조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA025_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsBusinesstrip = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao2 = new BUTA025DAO("default", p_tr);
		
		//출장품의서 작성 내용 조회
		dsBusinesstrip = dao.BUTA025_SHR_03(p_box);
		
		//출장 결재자 정보 조회
		dsDecision = dao2.BUTA025_SHR_04(p_box);

		//RESPONSE로 데이터셋을 전송하는 메소드
		p_tr.setOutDataSet("dsT_DI_BUSINESSTRIP", dsBusinesstrip);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);

	}

	/**
	 * 출장품의서 작성 내용 및 결재 정보를  조회해 오는 WORK메소드.
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void BUTA025_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		GauceDataSet dsBusinesstrip = new GauceDataSet();
		GauceDataSet dsDecision = new GauceDataSet();
		GauceDataSet dsBusinesstrip_state = new GauceDataSet();
		
		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao2 = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao3 = new BUTA025DAO("default", p_tr);		
		
		//System.out.println("1==================="+p_box);			
		
		//출장품의서 작성 내용 조회
		dsBusinesstrip = dao.BUTA025_SHR_03(p_box);
		
		//System.out.println("2==================="+p_box);	
		
		//출장 결재자 정보 조회
		dsDecision = dao2.BUTA025_SHR_04(p_box);
		
		//System.out.println("3==================="+p_box);			
		//동행자 정보 조회
		dsBusinesstrip_state = dao3.BUTA025_SHR_05(p_box);	

		//RESPONSE로 데이터셋을 전송하는 메소드
		p_tr.setOutDataSet("dsT_DI_BUSINESSTRIP", dsBusinesstrip);
		p_tr.setOutDataSet("dsT_DI_APPROVAL", dsDecision);
		p_tr.setOutDataSet("dsT_DI_BUSINESSTRIP_WORKER", dsBusinesstrip_state);		
		
	}	
	
	
	public void BUTA025_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {

		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		dao.BUTA025_SHR_PRINT(p_box);

	}
	
	
	public void BUTA025_SHR_PRINT2(CBox p_box, TrBox p_tr) throws CException {

		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		dao.BUTA025_SHR_PRINT2(p_box);

	}
	
	public void BUTA025_SHR_PRINT3(CBox p_box, TrBox p_tr) throws CException {

		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		dao.BUTA025_SHR_PRINT3(p_box);

	}	
	
	public void BUTA025_SHR_PRINT4(CBox p_box, TrBox p_tr) throws CException {

		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		dao.BUTA025_SHR_PRINT4(p_box);

	}
	
	/**
	 * 트랜젝션을 수행하여 출장품서 내용을 등록하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void BUTA025_SAV_01( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP");

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList1 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao2 = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao3 = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao4 = new BUTA025DAO("default", p_tr);		
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */

			switch (vo.getInt("TX_MODE")) {
			case 2:
				//출장품의서 작성 내용을 저장하기 위한 DAO 메소드 호출
				dao.BUTA025_INS_01(vo, p_box);
				break;
			case 3:
				////출장품의서 정보를 수정하기 위한 DAO 메소드 호출
				dao.BUTA025_UPT_03(p_box, vo);
				break;
			case 4:
				//delete
				break;
			}

		}

		//출장결재자 정보 전체삭제
		if(voList1.size() > 0){
			dao2.BUTA025_DEL_01(p_box);
			for (int i=0; i<voList1.size(); i++) {

				/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
				GauceValueObject vo1 = voList1.get(i);	// LIST -> ROW

				this.BUTA025_INS_03(vo1, p_box, p_tr);

				if(i==0){
					dao3.BUTA025_DEL_02(p_box);	//출장품의서 결재 현황 삭제

					//출장품의 결재현황 내용을 저장하기 위한 DAO 메소드 호출
					dao4.BUTA025_INS_02(p_box);
				}
			}
		}

	}
	
	
	public void BUTA025_INS_03(GauceValueObject vo, CBox p_box, TrBox p_tr) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정하였다 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);

		dao.BUTA025_INS_03(vo, p_box);

	}			
	
	public void BUTA025_SAV_01_APP( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP");

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList1 = p_tr.getInGauceValueObject("dsT_DI_APPROVAL");


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao2 = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao3 = new BUTA025DAO("default", p_tr);

		//System.out.println("1==================="+p_box);
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */

			switch (vo.getInt("TX_MODE")) {
			
			case 2:
				//System.out.println("2==================="+p_box);
				//출장품의서 작성 내용을 저장하기 위한 DAO 메소드 호출
				dao.BUTA025_INS_01(vo, p_box);
				break;
				
			case 3:
				//System.out.println("2.5==================="+p_box);
				////출장품의서 정보를 수정하기 위한 DAO 메소드 호출
				dao.BUTA025_UPT_03(p_box, vo);
				break;
				
			case 4:
				
				//delete
				break;
				
			}

		}
		
		//System.out.println("3==================="+p_box);
		
		if(voList1.size() > 0){
			
			//	출장결재자 정보 전체삭제
			dao2.BUTA025_DEL_01(p_box);
			//System.out.println("4==================="+p_box);
			for (int i=0; i<voList1.size(); i++) {

				/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
				
				GauceValueObject vo1 = voList1.get(i);	// LIST -> ROW

				this.BUTA025_INS_03(vo1, p_box, p_tr);   //	출장결재자 정보 전체 신규 Insert

				if(i==0){
					
					dao3.BUTA025_UPT_STA(p_box);	//출장품의서 결재 현황 Update
					
				}

			}
		}

	}

	/**
	 * 트랜젝션을 수행하여 출장품의 결재상황, 출장결재자 정보 관리 테이블에 상신, 결재, 전결처리내용을 저장하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void BUTA025_SAV_02( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);


		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao2 = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao3 = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao4 = new BUTA025DAO("default", p_tr);
		BUTA025DAO dao5 = new BUTA025DAO("default", p_tr);

		//	1. 결재정보 수정
		dao.BUTA025_UPT_02(p_box, vo);

		//System.out.println("111111111111111111111111111111111111111");
		
		//2.모두 결재됐는지 Check
		GauceDataSet dsCnt = dao2.BUTA025_CNT(vo);
		
		String APP_YN = GauceUtils.nameValue(dsCnt, 1, "APP_YN");

		// 3. 모두 결재돼었으면 T_DI_DILIGENCE에 Update


		if("Y".equals(APP_YN)){

			// 3.0 T_DI_LIGENCE에 있는 데이터 새로 만들기
			// 시작년월과 종료년월이 틀릴수 있음으로...
			GauceDataSet ds = dao3.BUTA025_SHR_06(vo, p_box);
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


			//dao4.BUTA025_DIL_INS_01(BUT_FR_YMD.substring(0, 4),  ENO_NO,   DPT_CD, p_box);
			//dao5.BUTA025_DIL_INS_01(BUT_TO_YMD.substring(0, 4),  ENO_NO,   DPT_CD, p_box);

			// 3.1 T_DI_DILIGENCE 에 있는 정보를 읽어오기 - 상신자 본인 근태처리

				dsDi = dao4.BUTA025_DIL_SHR_01(BUT_FR_YMD.substring(0, 6), BUT_TO_YMD.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
				 
				for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

					String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YMD");

					// 3.2 T_DI_DILIGENCE 에 Update // 출장코드 'E'로 Update
					this.BUTA025_DIL_UPT_01(PIS_YYMMDD, ENO_NO, "E", p_box, p_tr);

					// 3.4 T_DI_DILIGENCE 에 총계 Update
					this.BUTA025_DIL_UPT_03(PIS_YYMMDD, ENO_NO, "E", p_box, p_tr);
				}
				
			// 동행인 근태처리
			if("Y".equals(COM_YN)){
				
					// 3.1 T_DI_DILIGENCE 에 있는 정보를 읽어오기
				
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
					
					dsDi = this.BUTA025_DIL_SHR_01(BUT_FR_YMD.substring(0, 6), BUT_TO_YMD.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box, p_tr);
					 
					for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

						
						String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YMD");
						

						// 3.2 T_DI_DILIGENCE 에 Update // 출장코드 'E'로 Update
						this.BUTA025_DIL_UPT_01(PIS_YYMMDD, ENO_NO, "E", p_box, p_tr);
						

						// 3.4 T_DI_DILIGENCE 에 총계 Update
						this.BUTA025_DIL_UPT_03(PIS_YYMMDD, ENO_NO, "E", p_box, p_tr);
						
					}
					
				}
				
			}


				//dao5.BUTA025_UPT_01(p_box, vo,APP_YN);   //출장품의 결재현황 테이블
				
		}
		else  if("N".equals(APP_YN) || "E".equals(APP_YN)){
			
				//dao5.BUTA025_UPT_01(p_box, vo,APP_YN);   //출장품의 결재현황 테이블
				
		}
		
		
		dao5.BUTA025_UPT_01(p_box, vo,APP_YN);   //출장품의 결재현황 테이블

	}


	
	public void BUTA025_DIL_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);

		dao.BUTA025_DIL_UPT_01(PIS_YYMMDD, ENO_NO, "E", p_box);

	}
	
	public void BUTA025_DIL_UPT_03(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);

		dao.BUTA025_DIL_UPT_03(PIS_YYMMDD, ENO_NO, "E", p_box);

	}	
	

	public GauceDataSet BUTA025_DIL_SHR_01(String STR_YYYYMM, String END_YYYYMM, String ENO_NO, String STR_YYYYMMDD, String END_YYYYMMDD, CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);

		return dao.BUTA025_DIL_SHR_01(STR_YYYYMM, END_YYYYMM, ENO_NO, STR_YYYYMMDD, END_YYYYMMDD, p_box);		
		
	}		
	

	
	/**
	 * 트랜젝션을 수행하여 출장품의 결재상황, 출장결재자 정보 관리 테이블에 부결, 반송처리내용을 저장하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void BUTA025_SAV_03( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP_STATE");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);

		//결재내용 저장 (출장 결재자 정보 관리 테이블)
		dao.BUTA025_UPT_02(p_box, vo);

	}

	/**
	 * 트랜젝션을 수행하여 출장 날짜를 새로 저장하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void BUTA025_SAV_DATE( CBox p_box, TrBox p_tr ) throws CException {

		/** GauceDataSet객체를 GauceValueObject로 변환하여 처리 **/
		GauceValueObject voList = p_tr.getInGauceValueObject("dsT_DI_BUSINESSTRIP");

		/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
		GauceValueObject vo = voList.get(0);

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		BUTA025DAO dao = new BUTA025DAO("default", p_tr);

		//2014.11.5 임보이씨 요청으로 이동훈 수정 - 결재완료 후 강제로 출장 날짜 바꿀때 근태쪽도 연동되도록
		GauceDataSet ds_old = dao.BUTA025_SHR_03(p_box);	
		GauceDataSet ds = dao.BUTA025_SHR_06(vo, p_box);
		
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
		 
		
		dsDi = dao.BUTA025_DIL_SHR_01(BUT_FR_YMD_old.substring(0, 6), BUT_TO_YMD_old.substring(0, 6), ENO_NO, BUT_FR_YMD_old, BUT_TO_YMD_old, p_box);
		
		for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

			String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YMD");

			// 3.2 T_DI_DILIGENCE 에 Update 오리진// 근태코드 null 로 Update
			dao.BUTA025_DIL_UPT_02(PIS_YYMMDD, ENO_NO, "", p_box);

		}		
		
		dsDi2 = dao.BUTA025_DIL_SHR_01(BUT_FR_YMD.substring(0, 6), BUT_TO_YMD.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
		
		for(int i = 1 ; i <= dsDi2.getDataRowCnt(); i++){

			String PIS_YYMMDD = GauceUtils.nameValue(dsDi2, i, "PIS_YMD");

			// 3.2 T_DI_DILIGENCE 에 Update 오리진// 근태코드 'E'로 Update
			dao.BUTA025_DIL_UPT_02(PIS_YYMMDD, ENO_NO, "E", p_box);

		}				
		
		// 동행인 근태처리
		if("Y".equals(COM_YN)){
				// 3.1 T_DI_DILIGENCE 에 있는 정보를 읽어오기
			
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
				
				dsDi = dao.BUTA025_DIL_SHR_01(BUT_FR_YMD_old.substring(0, 6), BUT_TO_YMD_old.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
				 
				for(int i = 1 ; i <= dsDi.getDataRowCnt(); i++){

					String PIS_YYMMDD = GauceUtils.nameValue(dsDi, i, "PIS_YMD");

					// 3.2 T_DI_DILIGENCE 에 Update // 출장코드 'E'로 Update
					dao.BUTA025_DIL_UPT_02(PIS_YYMMDD, ENO_NO, "", p_box);
					
				}
				
				dsDi2 = dao.BUTA025_DIL_SHR_01(BUT_FR_YMD.substring(0, 6), BUT_TO_YMD.substring(0, 6), ENO_NO, BUT_FR_YMD, BUT_TO_YMD, p_box);
				
				for(int i = 1 ; i <= dsDi2.getDataRowCnt(); i++){

					String PIS_YYMMDD = GauceUtils.nameValue(dsDi2, i, "PIS_YMD");

					// 3.2 T_DI_DILIGENCE 에 Update 오리진// 근태코드 'E'로 Update
					dao.BUTA025_DIL_UPT_02(PIS_YYMMDD, ENO_NO, "E", p_box);

				}					
				
			}
		}

		dao.BUTA025_SAV_DATE(p_box, vo);

	}

}
