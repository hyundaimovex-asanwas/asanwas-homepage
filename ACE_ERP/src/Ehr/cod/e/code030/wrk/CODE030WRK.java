package Ehr.cod.e.code030.wrk;

import Ehr.cod.e.code030.dao.CODE030DAO;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class CODE030WRK {

	/**
	 * 사용자  조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		CODE030DAO dao2 = new CODE030DAO("default", p_tr);    
		
		//작업완료 여부를 조회
		GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}		 		
		
		//관리자가 아닌경우 완료된 작업만 조회
		if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){

        /** 사용자 권한 SELECT하는 DAO 메소드 호출 */
		dao2.CODE030_SHR(p_box);

		}
		
	}



	/**
	 * 급여지급액을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		CODE030DAO dao2 = new CODE030DAO("default", p_tr);
		
		//작업완료 여부를 조회
		GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}

		//관리자가 아닌경우 완료된 작업만 조회
		if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){

			/** 급상여지급액 SELECT하는 DAO 메소드 호출 */
			dao2.CODE030_SHR_01(p_box);

		}

	}



	/**
	 * 급여지급액을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR_02(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		CODE030DAO dao2 = new CODE030DAO("default", p_tr);
		
		//작업완료 여부를 조회
		GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}

		//관리자가 아닌경우 완료된 작업만 조회
		if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){

	        /** 급상여지급액 SELECT하는 DAO 메소드 호출 */
			dao2.CODE030_SHR_02(p_box);

		}

	}



	/**
	 * 급여지급액을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR_03(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		CODE030DAO dao2 = new CODE030DAO("default", p_tr);
		
		//작업완료 여부를 조회
		GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		if (ds.getDataRowCnt() <= 0){
			return;
		}

		//관리자가 아닌경우 완료된 작업만 조회
		if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){

	        /** 급상여지급액 SELECT하는 DAO 메소드 호출 */
			dao2.CODE030_SHR_03(p_box);

		}

	}



	/**
	 * 누계조회
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR_05(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);
		//CODE030DAO dao2 = new CODE030DAO("default", p_tr);
		
		//작업완료 여부를 조회
		//GauceDataSet ds = dao.CODE030_SHR_04(p_box);

		//if (ds.getDataRowCnt() <= 0){
		//	return;
		//}
		
		//관리자가 아닌경우 완료된 작업만 조회
		//if(p_box.get("vusrid").equals("6060002") || p_box.get("vusrid").equals("6070001") || Integer.parseInt(GauceUtils.nameValue(ds, 1, "PRO_STS")) == 6){		
		
			dao.CODE030_SHR_05(p_box);
		
		//}

	}



	/**
	 * 개인정보 조회
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR_06(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);

		dao.CODE030_SHR_06(p_box);

	}

	/**
	 * 급여지급액을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR_PRINT(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);

		dao.CODE030_SHR_PRINT(p_box);

	}	
	
	
	/**
	 * 급여지급액을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR_PRINT2(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);

		dao.CODE030_SHR_PRINT2(p_box);

	}		
	
	/**
	 * 급여지급액을 조회하는 WRK 메소드
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void CODE030_SHR_PRINT3(CBox p_box, TrBox p_tr) throws CException {

		/** CODE030DAO 객체 생성 후 관련 메소드 호출 */
		CODE030DAO dao = new CODE030DAO("default", p_tr);

		dao.CODE030_SHR_PRINT3(p_box);

	}			
	
}

