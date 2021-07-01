package Ehr.pir.a.pira010.wrk;


import Ehr.pir.a.pira010.dao.PIRA010DAO;

import com.shift.gef.core.exception.BizException;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.FileUtils;
import com.shift.gef.support.utility.FtpUtils;
import com.shift.gef.support.vo.GauceValueObject;

public class PIRA010WRK {

	/**
	 * 인사기록표 데이터를 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** PIRA010DAO 객체 생성 후 관련 메소드 호출 */
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);
		
		/** 개인정보처리 접속 기록  **/		
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);
		
        /** 인사기록표 SELECT하는 DAO 메소드 호출 */
		dao.PIRA010_SHR(p_box);
		dao2.PIRA010_SHR_ACC(p_box);
		
	}

	/**
	 * 트랜젝션을 수행하여 로그인사원정보에 대한 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_01( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);

        /** 인사기록표 INSERT하는 DAO 메소드 호출 */
		dao.PIRA010_INS_02(p_box);

	    /** 최신 목록으로 인사기록표 데이터를 재조회 **/
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);

		/** 인사기록표  SELECT하는 DAO 메소드 호출 */
		dao2.PIRA010_SHR(p_box);

	}

	/**
	 * 트랜젝션을 수행하여 신입사원에 대한 인사기록표 데이터를 생성하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_02( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);

        /** 인사기록표 INSERT하는 DAO 메소드 호출 */
		dao.PIRA010_INS_02(p_box);

	    /** 최신 목록으로 인사기록표 데이터를 재조회 **/
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);

		/**ftp에서 사진화일을 was로 다운받는다. **/

		/**FTP에서 파일 다운로드 (파일명은 주민번호로 되어있고 jpg형식) **/
		
		
		
		try{
			String filePath = FtpUtils.ftpDownloadFile(p_box.get("CET_NO").replaceAll("-", "")+".jpg");
			
			/**
			 * 사번으로 파일명 변경
			 * 변경하면서 download에 원본을 두고 upload로 이동
			 **/
			
			//System.out.println("old filePath : "+filePath);
			//System.out.println("new filePath : "+filePath.substring(0,filePath.length()-17-9)+"upload/"+p_box.get("ENO_NO").replaceAll("-", "")+".jpg");
			FileUtils.rename(filePath, filePath.substring(0,filePath.length()-17-9)+"upload/"+p_box.get("ENO_NO").replaceAll("-", "")+".jpg");

			//주민번호로된 파일 삭제
			//FileUtils.deleteFile(filePath);
			
		}catch(BizException e) {
			//throw new BizException("확장자가 틀리거나 해당 사진이 없습니다.");
		}

		/** 인사기록표  SELECT하는 DAO 메소드 호출 */
		dao2.PIRA010_SHR(p_box);

	}

	
	
	
	/**
	 * 트랜젝션을 수행하여 로그인사원정보에 대한 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);
		
        /** 인사기록표 INSERT하는 DAO 메소드 호출 */
		dao.PIRA010_SHR_PRINT(p_box);

		/** 개인정보처리 접속 기록  **/
		dao2.PIRA010_PRT_ACC(p_box);
		
	    /** 최신 목록으로 인사기록표 데이터를 재조회 **/
		//PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);

		/** 인사기록표  SELECT하는 DAO 메소드 호출 */
		//dao2.PIRA010_SHR(p_box);

	}	
	
	
	/**
	 * 트랜젝션을 수행하여 학력사항 조회 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT2( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** 인사기록표 학력사항 조회하는 DAO 메소드 호출 */
		dao.PIRA010_SHR_PRINT2(p_box);	
		
	}		
	
	/**
	 * 트랜젝션을 수행하여 자격증 조회 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT3( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** 인사기록표 자격증 조회하는 DAO 메소드 호출 */
		dao.PIRA010_SHR_PRINT3(p_box);	
		
	}		
	
	
	/**
	 * 트랜젝션을 수행하여 자격증 조회 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT4( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** 인사기록표 자격증 조회하는 DAO 메소드 호출 */
		dao.PIRA010_SHR_PRINT4(p_box);	
		
	}		
	
	/**
	 * 트랜젝션을 수행하여 입사후 조회 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT5( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** 인사기록표 자격증 조회하는 DAO 메소드 호출 */
		dao.PIRA010_SHR_PRINT5(p_box);	
		
	}		
	
	/**
	 * 트랜젝션을 수행하여 입사전 조회 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT6( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** 인사기록표 자격증 조회하는 DAO 메소드 호출 */
		dao.PIRA010_SHR_PRINT6(p_box);	
		
	}	
	
	/**
	 * 트랜젝션을 수행하여 상벌 조회 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT7( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** 인사기록표 자격증 조회하는 DAO 메소드 호출 */
		dao.PIRA010_SHR_PRINT7(p_box);	
		
	}	
	
	/**
	 * 트랜젝션을 수행하여 교육사항 조회 데이터를 생성 또는 수정하고 재조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT8( CBox p_box, TrBox p_tr ) throws CException {

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);	
		
        /** 인사기록표 자격증 조회하는 DAO 메소드 호출 */
		dao.PIRA010_SHR_PRINT8(p_box);	
		
	}		
	
	
	/**
	 * 트랜젝션을 수행하여 인사기록표 데이터를 입력/수정하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void PIRA010_SAV( CBox p_box, TrBox p_tr ) throws CException {

		/**
		 * 인사기록표 데이터를 담은 DATASET를 VO에 저장
		 * GauceDataSet객체를 GauceValueObject로 변환하여 처리
		 * **/
		GauceValueObject voList = p_tr.getInGauceValueObject("SAV");

		/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
		PIRA010DAO dao = new PIRA010DAO("default", p_tr);
		PIRA010DAO dao2 = new PIRA010DAO("default", p_tr);
		PIRA010DAO dao3 = new PIRA010DAO("default", p_tr);		
		
		for (int i=0; i<voList.size(); i++) {

			/** ValueObjectList에서 ValueObject를 꺼내는 부분 **/
			GauceValueObject vo = voList.get(i);	// LIST -> ROW

			/**
			 * 트랜젝션 모드에 따라 처리 하게 되며, TX_MODE값은 아래와 값다.
			 *  - 1 : NORMAL
			 *  - 2 : INSERT
			 *  - 3 : UPDATE
			 *  - 4 : DELETE
			 */
			switch (vo.getInt("TX_MODE")) {
				case 2:

    				/** 인사기록표 INSERT하는  DAO 메소드 호출 */
					//dao.PIRA010_INS(vo, p_box);
					//dao.PIRA010_INS_01(p_box);

					//입사후 경력에 데이터가 들어가기전까지는 임시 테이블에 저장한다.
					dao.PIRA010_INS_03(vo, p_box);
					
					/** 개인정보처리 접속 기록  **/
					dao3.PIRA010_INS_ACC(p_box);
					
					break;

				case 3:
					/** 인사기록표 UPDATE하는 DAO 메소드 호출 */
					dao.PIRA010_UPT(vo, p_box);
					dao2.PIRA010_INS_01(p_box);
					
					/** 개인정보처리 접속 기록  **/					
					dao3.PIRA010_UPT_ACC(p_box);		
					
					break;

				case 4:
					//delete
					break;
			}
		}
	}
}

