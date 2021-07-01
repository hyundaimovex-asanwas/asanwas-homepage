package common.menu.userauth.wrk;

import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.menu.userauth.dao.USERAUTHDAO;

public class USERAUTHWRK {
	/**
	/**
	 * 사용자권한정보조회
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void USERAUTH_SHR_00(CBox p_box, TrBox p_tr) throws CException {

		/** USERAUTHDAO 객체 생성 후 관련 메소드 호출 */
		USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);

        /** 사용자권한정보조회 SELECT하는 DAO 메소드 호출 */
		dao.USERAUTH_SHR_00(p_box);

	}

	/**
	 * 권한에 따른 메뉴트리 데이터를 조회하는 WRK 메소드(신인사시스템)
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void USERAUTH_SHR_01(CBox p_box, TrBox p_tr) throws CException {

		/** USERAUTHDAO 객체 생성 후 관련 메소드 호출 */
		USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);

		//첫번째 메뉴가 fav인 경우 즐겨찾기를 불러온다.
		if(!p_box.get("MENU_ID1").equals("fav")){
			/** 권한에 따른 메뉴트리 SELECT하는 DAO 메소드 호출 */
			dao.USERAUTH_SHR_01(p_box);
		}else{
			//즐겨찾기
			dao.USERAUTH_SHR_02(p_box);
		}

	}
	
	/**
	 * 권한에 따른 메뉴트리 데이터를 조회하는 WRK 메소드(경영정보시스템)
	 * @param p_box		CBox객체 (Request/Session정보를 담은 객체)
	 * @param p_tr		    TrBox객체 (가우스 컴포넌트와 I/O수행)
	 * @throws CException
	 */
	public void USERAUTH_SHR_02(CBox p_box, TrBox p_tr) throws CException {
		
		/** USERAUTHDAO 객체 생성 후 관련 메소드 호출 */
		USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);
		
		dao.USERAUTH_SHR_01(p_box);
		
	}
    
    /**
     * 사용자가 사용가능한 상위 메뉴를 가지고 온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void USERAUTH_SHR_03(CBox p_box, TrBox p_tr) throws CException {
	    
	    /** USERAUTHDAO 객체 생성 후 관련 메소드 호출 */
	    USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);
	    
	    dao.USERAUTH_SHR_03(p_box);
	    
	}
    
    /**
     * EIS에서 사용 가능한 상위 메뉴를 가지고 온다.
     * @param p_box
     * @param p_tr
     * @throws CException
     */
	public void USERAUTH_SHR_04(CBox p_box, TrBox p_tr) throws CException {
	    
	    /** USERAUTHDAO 객체 생성 후 관련 메소드 호출 */
	    USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);
	    
	    dao.USERAUTH_SHR_04(p_box);
	    
	}
	
	/**
	 * sso
	 * @param p_box
	 * @param p_tr
	 * @throws CException
	 */
	public void USERAUTH_SHR_05(CBox p_box, TrBox p_tr) throws CException {
		
		/** USERAUTHDAO 객체 생성 후 관련 메소드 호출 */
		USERAUTHDAO dao = new USERAUTHDAO("default", p_tr);
		
		dao.USERAUTH_SHR_05(p_box);
		
	}
}
