package common.menu.login.wrk;


import java.sql.Connection;

import hr.pir.c.pirc090.dao.PIRC090DAO;
import hr.but.a.buta020.dao.BUTA020MSDAO;

import javax.servlet.http.HttpSession;

import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.gauce.http.HttpGauceRequest;
import com.gauce.http.HttpGauceResponse;
import com.shift.gef.core.exception.CException;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.utility.StringUtil;
import com.shift.gef.support.vo.GauceValueObject;

import common.menu.login.dao.LOGINDAO;
import common.util.DateUtil;
import common.util.DbManager;
import common.util.EncryptUtil;


public class LOGINWRK  {

    /**
     * LOGIN WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void LOGIN_SHR(HttpGauceRequest p_req, HttpGauceResponse p_res, CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 직무기초(조사회차 조회) DAO CLASS 메서드 호출 * */
        LOGINDAO dao = new LOGINDAO("default", p_tr);

        //패스워드 주민번호 비교
        GauceDataSet ds = dao.LOGIN_SHR(p_box);
        GauceDataSet ds2 = dao.LOGIN_SHR_02(p_box);

        GauceDataRow grAdd = new GauceDataRow(ds2.getDataColCnt());

        for(int i=0; i<19; i++){
            grAdd.setString(i, "");
        }

        //패스워드와 주민번호가 같으면 패스워드 변경후 로그인해야 함
        if (ds.getDataRowCnt() == 1){

            /** Request 세션 정보 **/
            HttpSession Session = p_req.getSession();
            if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(StringUtil.encrypt(p_box.get("KS_PASSWD")))) {
	            Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//회계단위
	            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//사번
	            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//성명
	            Session.setAttribute("SESSION_HEADCD" , GauceUtils.nameValue(ds, 1, "HEAD_CD"));//본부코드
	            Session.setAttribute("SESSION_HEADNM" , GauceUtils.nameValue(ds, 1, "HEAD_NM"));//본부명
	            Session.setAttribute("SESSION_DPTCD" , GauceUtils.nameValue(ds, 1, "DPT_CD"));//소속코드
	            Session.setAttribute("SESSION_DPTNM" , GauceUtils.nameValue(ds, 1, "DPT_NM"));//소속명
	            Session.setAttribute("SESSION_TEAMCD"   , GauceUtils.nameValue(ds, 1, "TEAM_CD"  ));   //팀코드
	            Session.setAttribute("SESSION_TEAMNM"   , GauceUtils.nameValue(ds, 1, "TEAM_NM"  ));   //팀
	            Session.setAttribute("SESSION_DPTSAUP" , GauceUtils.nameValue(ds, 1, "DPT_SAUP"));//사업부
	            Session.setAttribute("SESSION_TAXCD" , GauceUtils.nameValue(ds, 1, "TAX_CD"));//회계소속코드
	            Session.setAttribute("SESSION_TAXNM" , GauceUtils.nameValue(ds, 1, "TAX_NM"));//회계소속명
	            Session.setAttribute("SESSION_JOBCD" , GauceUtils.nameValue(ds, 1, "JOB_CD"));//직위코드
	            Session.setAttribute("SESSION_JOBNM" , GauceUtils.nameValue(ds, 1, "JOB_NM"));//직위
	            Session.setAttribute("SESSION_DUTYCD" , GauceUtils.nameValue(ds, 1, "DUTY_CD"));//직책코드
	            Session.setAttribute("SESSION_DUTYNM" , GauceUtils.nameValue(ds, 1, "DUTY_NM"));//직책
	            Session.setAttribute("SESSION_TODAY" , GauceUtils.nameValue(ds, 1, "TO_DAY"));//시스템날짜


	            /*권한 관리 부분 추가*/
	            Session.setAttribute("SESSION_ROLE_CD"   , GauceUtils.nameValue(ds, 1, "ROLE_CD"  ));   //공통 세부 코드


	            Session.setAttribute("SESSION_LAW_AUTHO" , GauceUtils.nameValue(ds, 1, "LAW_AUTHO"));   //법무권한
	            Session.setAttribute("SESSION_DOC_AUTHO" , GauceUtils.nameValue(ds, 1, "DOC_AUTHO"));   //문서권한
	            Session.setAttribute("SESSION_DIL_AUTHO" , GauceUtils.nameValue(ds, 1, "DIL_AUTHO"));   //근태권한
	            Session.setAttribute("SESSION_EDU_AUTHO" , GauceUtils.nameValue(ds, 1, "EDU_AUTHO"));   //교육권한
	            Session.setAttribute("SESSION_PLN_AUTHO" , GauceUtils.nameValue(ds, 1, "PLN_AUTHO"));   //사업계획권한
	            Session.setAttribute("SESSION_SEL_AUTHO" , GauceUtils.nameValue(ds, 1, "SEL_AUTHO"));   //셀프서비스권한
	            Session.setAttribute("SESSION_EIS_AUTHO" , GauceUtils.nameValue(ds, 1, "EIS_AUTHO"));   //EIS권한
	            Session.setAttribute("SESSION_CON_AUTHO" , GauceUtils.nameValue(ds, 1, "CON_AUTHO"));   //콘도권한
	            Session.setAttribute("SESSION_YAC_AUTHO" , GauceUtils.nameValue(ds, 1, "YAC_AUTHO"));   //콘도권한
	            Session.setAttribute("SESSION_L3_AUTHO"  , GauceUtils.nameValue(ds, 1, "L3_AUTHO" ));   //사업본부장권한
	            Session.setAttribute("SESSION_ADV_AUTHO" , GauceUtils.nameValue(ds, 1, "ADV_AUTHO"));   //사내공모권한
	            Session.setAttribute("SESSION_CETNO" , "");   //사내공모권한

	            Session.setAttribute("SESSION_GBN_CD" , GauceUtils.nameValue(ds, 1, "GBN_CD"));//근무지코드
            }

            //세션 유지시간
            Session.setMaxInactiveInterval(60*90);
            if (p_box.get("KS_PASSWD").equals("")) {//관리자 패스워드
                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds);

            //주민번호가 없을때
            }else if(GauceUtils.nameValue(ds, 1, "CET_NO") == null || GauceUtils.nameValue(ds, 1, "CET_NO").length() == 0){
                //row가 3개이면 비밀번호 초기화가 되지 않았다. emplist에 주민번호 없음 (기존row(1)에 +2한다.)
                ds2.addDataRow(grAdd);
                ds2.addDataRow(grAdd);

                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);

            //주민번호와 저장된 패스워드가 같고 저장된 패스워드와 사용자 입력 패스워드가 같으면
            }else if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(GauceUtils.nameValue(ds, 1, "CET_NO").substring(7,14)) &&
                GauceUtils.nameValue(ds, 1, "PWD_NO").equals(p_box.get("KS_PASSWD"))) {
                //row수가 0이면 패드워드 다시 등록
            	Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//회계단위
	            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//사번
	            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//성명
                p_tr.setOutDataSet("dsT_CM_EMPLIST", new GauceDataSet());

            //저장된 패스워드와 암호화 시킨 패스워드가 같을때(이미 암호화된 패스워드가 db에 있어야한다)
            }else if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(StringUtil.encrypt(p_box.get("KS_PASSWD")))) {

                //패스워드 틀린횟수 초기화(pwd_hlc_cnt = 0), 5회이상 틀리면 맞더라로 로그인 못한다. 그래서 초기화 못함
            	if(Integer.parseInt(GauceUtils.nameValue(ds, 1, "PWD_HLC_CNT")) < 5){
            		dao.LOGIN_UPT_01(p_box);
            	}

                //변경한지 90일 지났으면 다시 변경하게
                if(GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD") != null &&
                  !GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD").trim().equals("") &&
                  Integer.parseInt(DateUtil.getAfterDate(GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD"),0,0,90)) <= Integer.parseInt(DateUtil.getCurrentDateStr()) ){

                    //row가 4개이면 비밀번호를 다시 설정하게 한다.

                    ds2.addDataRow(grAdd);
                    ds2.addDataRow(grAdd);
                    ds2.addDataRow(grAdd);

                    p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);

                }else{
                    //정상적인 로그인
                    p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
                }

            }else{
                //아이디나 패스워드가 일치하지 않는다.(예외처리가 않먹혀서 row수로 체크하게 )
                //throw new BizException("사용자 아이디, 패스워드가 일치하지 않습니다.");
            	Session.setAttribute("SESSION_ENONO" ,  "");//사번
            	Session.setAttribute("SESSION_ENONM" ,  "");//성명
                //패스워드 틀린횟수 카운터 증가(pwd_hlc_cnt+1)
                dao.LOGIN_UPT(p_box, GauceUtils.nameValue(ds, 1, "PWD_HLC_CNT"));

                //row가 2개이면 아이디나 패스워드가 일치하지 않는다.(기존row(1)에 +1한다.)
                ds2.addDataRow(grAdd);

                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
            }

        }else{
            //row가 5개이면 등록된 사용자가 아님
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);

            p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
        }

    }

    
    
    /**
     * LOGIN WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void LOGIN_SHR_00(HttpGauceRequest p_req, HttpGauceResponse p_res, CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 직무기초(조사회차 조회) DAO CLASS 메서드 호출 * */
        LOGINDAO dao = new LOGINDAO("default", p_tr);

        //패스워드 주민번호 비교
        GauceDataSet ds = dao.LOGIN_SHR(p_box);
        
		//System.out.println("1111111111111111111 !!!!" + GauceUtils.nameValue(ds, 1, "PWD_NO"));  
        
        GauceDataSet ds2 = dao.LOGIN_SHR_02(p_box);
      
		String PASSWD_SHA256 = EncryptUtil.SHA256Encrypt(p_box.get("KS_PASSWD"));        
        
        GauceDataRow grAdd = new GauceDataRow(ds2.getDataColCnt());

        for(int i=0; i<19; i++){
            grAdd.setString(i, "");
        }

        //패스워드와 주민번호가 같으면 패스워드 변경후 로그인해야 함
        if (ds.getDataRowCnt() == 1){

        	
    		//System.out.println("p_box !!!!" + EncryptUtil.SHA256Encrypt(p_box.get("KS_PASSWD")));           	
    		System.out.println("p_box1 !!!!" + PASSWD_SHA256);         
    		System.out.println("p_box2 !!!!" + GauceUtils.nameValue(ds, 1, "PWD_NO"));          		
    		
            /** Request 세션 정보 **/
            HttpSession Session = p_req.getSession();
            if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(PASSWD_SHA256)) {
            	
        		//System.out.println("이것좀 보자 !!!!");              	               	
            	
	            Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//회계단위
	            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//사번
	            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//성명
	            Session.setAttribute("SESSION_HEADCD" , GauceUtils.nameValue(ds, 1, "HEAD_CD"));//본부코드
	            Session.setAttribute("SESSION_HEADNM" , GauceUtils.nameValue(ds, 1, "HEAD_NM"));//본부명
	            Session.setAttribute("SESSION_DPTCD" , GauceUtils.nameValue(ds, 1, "DPT_CD"));//소속코드
	            Session.setAttribute("SESSION_DPTNM" , GauceUtils.nameValue(ds, 1, "DPT_NM"));//소속명
	            Session.setAttribute("SESSION_TEAMCD"   , GauceUtils.nameValue(ds, 1, "TEAM_CD"  ));   //팀코드
	            Session.setAttribute("SESSION_TEAMNM"   , GauceUtils.nameValue(ds, 1, "TEAM_NM"  ));   //팀
	            Session.setAttribute("SESSION_DPTSAUP" , GauceUtils.nameValue(ds, 1, "DPT_SAUP"));//사업부
	            Session.setAttribute("SESSION_TAXCD" , GauceUtils.nameValue(ds, 1, "TAX_CD"));//회계소속코드
	            Session.setAttribute("SESSION_TAXNM" , GauceUtils.nameValue(ds, 1, "TAX_NM"));//회계소속명
	            Session.setAttribute("SESSION_JOBCD" , GauceUtils.nameValue(ds, 1, "JOB_CD"));//직위코드
	            Session.setAttribute("SESSION_JOBNM" , GauceUtils.nameValue(ds, 1, "JOB_NM"));//직위
	            Session.setAttribute("SESSION_DUTYCD" , GauceUtils.nameValue(ds, 1, "DUTY_CD"));//직책코드
	            Session.setAttribute("SESSION_DUTYNM" , GauceUtils.nameValue(ds, 1, "DUTY_NM"));//직책
	            Session.setAttribute("SESSION_TODAY" , GauceUtils.nameValue(ds, 1, "TO_DAY"));//시스템날짜


	            /*권한 관리 부분 추가*/
	            Session.setAttribute("SESSION_ROLE_CD"   , GauceUtils.nameValue(ds, 1, "ROLE_CD"  ));   //공통 세부 코드


	            Session.setAttribute("SESSION_LAW_AUTHO" , GauceUtils.nameValue(ds, 1, "LAW_AUTHO"));   //법무권한
	            Session.setAttribute("SESSION_DOC_AUTHO" , GauceUtils.nameValue(ds, 1, "DOC_AUTHO"));   //문서권한
	            Session.setAttribute("SESSION_DIL_AUTHO" , GauceUtils.nameValue(ds, 1, "DIL_AUTHO"));   //근태권한
	            Session.setAttribute("SESSION_EDU_AUTHO" , GauceUtils.nameValue(ds, 1, "EDU_AUTHO"));   //교육권한
	            Session.setAttribute("SESSION_PLN_AUTHO" , GauceUtils.nameValue(ds, 1, "PLN_AUTHO"));   //사업계획권한
	            Session.setAttribute("SESSION_SEL_AUTHO" , GauceUtils.nameValue(ds, 1, "SEL_AUTHO"));   //셀프서비스권한
	            Session.setAttribute("SESSION_EIS_AUTHO" , GauceUtils.nameValue(ds, 1, "EIS_AUTHO"));   //EIS권한
	            Session.setAttribute("SESSION_CON_AUTHO" , GauceUtils.nameValue(ds, 1, "CON_AUTHO"));   //콘도권한
	            Session.setAttribute("SESSION_YAC_AUTHO" , GauceUtils.nameValue(ds, 1, "YAC_AUTHO"));   //콘도권한
	            Session.setAttribute("SESSION_L3_AUTHO"  , GauceUtils.nameValue(ds, 1, "L3_AUTHO" ));   //사업본부장권한
	            Session.setAttribute("SESSION_ADV_AUTHO" , GauceUtils.nameValue(ds, 1, "ADV_AUTHO"));   //사내공모권한
	            Session.setAttribute("SESSION_CETNO" , "");   //사내공모권한

	            Session.setAttribute("SESSION_GBN_CD" , GauceUtils.nameValue(ds, 1, "GBN_CD"));//근무지코드
            }
       
            
            //세션 유지시간
            Session.setMaxInactiveInterval(60*90);
            if (p_box.get("KS_PASSWD").equals("")) {//관리자 패스워드
                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds);

            //주민번호가 없을때
            }else if(GauceUtils.nameValue(ds, 1, "CET_NO") == null || GauceUtils.nameValue(ds, 1, "CET_NO").length() == 0){
                //row가 3개이면 비밀번호 초기화가 되지 않았다. emplist에 주민번호 없음 (기존row(1)에 +2한다.)
                ds2.addDataRow(grAdd);
                ds2.addDataRow(grAdd);

                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);

            //주민번호와 저장된 패스워드가 같고 저장된 패스워드와 사용자 입력 패스워드가 같으면
            }else if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(GauceUtils.nameValue(ds, 1, "CET_NO").substring(7,14)) &&
                GauceUtils.nameValue(ds, 1, "PWD_NO").equals(p_box.get("KS_PASSWD"))) {
                //row수가 0이면 패드워드 다시 등록
            	Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//회계단위
	            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//사번
	            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//성명
                p_tr.setOutDataSet("dsT_CM_EMPLIST", new GauceDataSet());

            //저장된 패스워드와 암호화 시킨 패스워드가 같을때(이미 암호화된 패스워드가 db에 있어야한다)
            }else if(GauceUtils.nameValue(ds, 1, "PWD_NO").equals(PASSWD_SHA256)) {

            	
        		//System.out.println("이것도 좀 보자 !!!!");                  	
            	
                //패스워드 틀린횟수 초기화(pwd_hlc_cnt = 0), 5회이상 틀리면 맞더라로 로그인 못한다. 그래서 초기화 못함
            	if(Integer.parseInt(GauceUtils.nameValue(ds, 1, "PWD_HLC_CNT")) < 5){
            		dao.LOGIN_UPT_01(p_box);
            	}

                //변경한지 90일 지났으면 다시 변경하게
                if(GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD") != null &&
                  !GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD").trim().equals("") &&
                  Integer.parseInt(DateUtil.getAfterDate(GauceUtils.nameValue(ds, 1, "PWD_HLC_YMD"),0,0,90)) <= Integer.parseInt(DateUtil.getCurrentDateStr()) ){

                    //row가 4개이면 비밀번호를 다시 설정하게 한다.

                    ds2.addDataRow(grAdd);
                    ds2.addDataRow(grAdd);
                    ds2.addDataRow(grAdd);

                    p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);

                }else{
                    //정상적인 로그인
                    p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
                }

            }else{
                //아이디나 패스워드가 일치하지 않는다.(예외처리가 않먹혀서 row수로 체크하게 )
                //throw new BizException("사용자 아이디, 패스워드가 일치하지 않습니다.");
            	Session.setAttribute("SESSION_ENONO" ,  "");//사번
            	Session.setAttribute("SESSION_ENONM" ,  "");//성명
                //패스워드 틀린횟수 카운터 증가(pwd_hlc_cnt+1)
                dao.LOGIN_UPT(p_box, GauceUtils.nameValue(ds, 1, "PWD_HLC_CNT"));

                //row가 2개이면 아이디나 패스워드가 일치하지 않는다.(기존row(1)에 +1한다.)
                ds2.addDataRow(grAdd);

                p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
            }

        }else{
            //row가 5개이면 등록된 사용자가 아님
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);
            ds2.addDataRow(grAdd);

            p_tr.setOutDataSet("dsT_CM_EMPLIST", ds2);
        }

    }    
    
    
    /**
     * LOGIN WRK 메소드.
     * @param p_box     CBox객체 (Request/Session정보를 담은 객체)
     * @param p_tr          TrBox객체 (가우스 컴포넌트와 I/O수행)
     * @throws CException
     */
    public void LOGIN_SHR_03(HttpGauceRequest p_req, HttpGauceResponse p_res, CBox p_box, TrBox p_tr) throws CException {

        /** DAO Class 객체 생성후 직무기초(조사회차 조회) DAO CLASS 메서드 호출 * */
        LOGINDAO dao = new LOGINDAO("default", p_tr);

        //패스워드 주민번호 비교
        GauceDataSet ds = dao.LOGIN_SHR(p_box);

        //패스워드와 주민번호가 같으면 패스워드 변경후 로그인해야 함
        if (ds.getDataRowCnt() == 1){
            /** Request 세션 정보 **/
            HttpSession Session = p_req.getSession();
            Session.setAttribute("SESSION_GUBUN" , GauceUtils.nameValue(ds, 1, "GUBUN"));//회계단위
            Session.setAttribute("SESSION_ENONO" , GauceUtils.nameValue(ds, 1, "ENO_NO"));//사번
            Session.setAttribute("SESSION_ENONM" , GauceUtils.nameValue(ds, 1, "ENO_NM"));//성명
            Session.setAttribute("SESSION_HEADCD" , GauceUtils.nameValue(ds, 1, "HEAD_CD"));//본부코드
            Session.setAttribute("SESSION_HEADNM" , GauceUtils.nameValue(ds, 1, "HEAD_NM"));//본부명
            Session.setAttribute("SESSION_DPTCD" , GauceUtils.nameValue(ds, 1, "DPT_CD"));//소속코드
            Session.setAttribute("SESSION_DPTNM" , GauceUtils.nameValue(ds, 1, "DPT_NM"));//소속명
            Session.setAttribute("SESSION_DPTSAUP" , GauceUtils.nameValue(ds, 1, "DPT_SAUP"));//사업부
            Session.setAttribute("SESSION_TAXCD" , GauceUtils.nameValue(ds, 1, "TAX_CD"));//회계소속코드
            Session.setAttribute("SESSION_TAXNM" , GauceUtils.nameValue(ds, 1, "TAX_NM"));//회계소속명
            Session.setAttribute("SESSION_JOBCD" , GauceUtils.nameValue(ds, 1, "JOB_CD"));//직위코드
            Session.setAttribute("SESSION_JOBNM" , GauceUtils.nameValue(ds, 1, "JOB_NM"));//직위
            Session.setAttribute("SESSION_DUTYCD" , GauceUtils.nameValue(ds, 1, "DUTY_CD"));//직책코드
            Session.setAttribute("SESSION_DUTYNM" , GauceUtils.nameValue(ds, 1, "DUTY_NM"));//직책
            Session.setAttribute("SESSION_TODAY" , GauceUtils.nameValue(ds, 1, "TO_DAY"));//시스템날

            /*권한 관리 부분 추가*/
            Session.setAttribute("SESSION_ROLE_CD"   , GauceUtils.nameValue(ds, 1, "ROLE_CD"  ));   //공통 세부 코드
            Session.setAttribute("SESSION_LAW_AUTHO" , GauceUtils.nameValue(ds, 1, "LAW_AUTHO"));   //법무권한
            Session.setAttribute("SESSION_DOC_AUTHO" , GauceUtils.nameValue(ds, 1, "DOC_AUTHO"));   //문서권한
            Session.setAttribute("SESSION_DIL_AUTHO" , GauceUtils.nameValue(ds, 1, "DIL_AUTHO"));   //근태권한
            Session.setAttribute("SESSION_EDU_AUTHO" , GauceUtils.nameValue(ds, 1, "EDU_AUTHO"));   //교육권한
            Session.setAttribute("SESSION_PLN_AUTHO" , GauceUtils.nameValue(ds, 1, "PLN_AUTHO"));   //사업계획권한
            Session.setAttribute("SESSION_SEL_AUTHO" , GauceUtils.nameValue(ds, 1, "SEL_AUTHO"));   //셀프서비스권한
            Session.setAttribute("SESSION_EIS_AUTHO" , GauceUtils.nameValue(ds, 1, "EIS_AUTHO"));   //EIS권한
            Session.setAttribute("SESSION_CON_AUTHO" , GauceUtils.nameValue(ds, 1, "CON_AUTHO"));   //콘도권한
            Session.setAttribute("SESSION_YAC_AUTHO" , GauceUtils.nameValue(ds, 1, "YAC_AUTHO"));   //콘도권한
            Session.setAttribute("SESSION_L3_AUTHO"  , GauceUtils.nameValue(ds, 1, "L3_AUTHO"));    //사업본부장권한
            Session.setAttribute("SESSION_ADV_AUTHO" , GauceUtils.nameValue(ds, 1, "ADV_AUTHO"));   //사내공모권한

            //세션 유지시간
            Session.setMaxInactiveInterval(60*90);

            p_tr.setOutDataSet("dsT_CM_EMPLIST", ds);

        }else{
            p_tr.setOutDataSet("dsT_CM_EMPLIST", new GauceDataSet());
        }

    }


		public void LOGIN_SHR_05(CBox p_box, TrBox p_tr) throws CException {


			LOGINDAO dao = new LOGINDAO("default", p_tr);


			 p_tr.setOutDataSet("dsT_CM_PERSON", dao.LOGIN_SHR_05(p_box));

		}


		public void LOGIN_UPT_05(CBox p_box, TrBox p_tr) throws CException {


			LOGINDAO dao = new LOGINDAO("default", p_tr);

			  dao.LOGIN_UPT_05(p_box);
			 // dao.LOGIN_INS_05(p_box);

				GauceDataSet dsGW = dao.LOGIN_SHR_05(p_box);

	            Connection conn = DbManager.getGrwConnection();// MS SQL 연동
	        try {

	            BUTA020MSDAO msDao = new BUTA020MSDAO(p_tr);

	            msDao.BUTA020_SMS_SAV(conn, p_box, dsGW );//G/W SMS Master 에 저장

			} catch(Exception e) {
	    			throw new CException(e.getMessage());
			} finally {
				try{
					conn.close();
				}catch(Exception e){e.printStackTrace();}
			}
		}

		public void LOGIN_SHR_06(CBox p_box, TrBox p_tr) throws CException {


			LOGINDAO dao = new LOGINDAO("default", p_tr);

			p_tr.setOutDataSet("dsT_CM_PERSON", dao.LOGIN_SHR_06(p_box));
		}

		public void LOGIN_SHR_07(CBox p_box, TrBox p_tr) throws CException {

			LOGINDAO dao = new LOGINDAO("default", p_tr);

			p_tr.setOutDataSet("dsT_CM_PERSON", dao.LOGIN_SHR_07(p_box));
		}

		public void LOGIN_UPT_06(CBox p_box, TrBox p_tr) throws CException {

			LOGINDAO dao = new LOGINDAO("default", p_tr);

			  dao.LOGIN_UPT_06(p_box);
		}


		/**
		 * GROUPWARE 로그인정보를 저장하는 WORK메소드
		 * @param p_box
		 * @param p_tr
		 * @throws CException
		 */
		public void GROUPWARE_SAV(CBox p_box, TrBox p_tr) throws CException {
			/** 트랜젝션을 수행하기 위해서 getConnection(false)로 설정 **/
			LOGINDAO dao = new LOGINDAO("default", p_tr);

			String GUN_YMD = p_box.get("GUN_YMD");
			String ENO_NO = p_box.get("ENO_NO");

			// 직원여부 체크
			GauceDataSet ds = dao.GROUPWARE_SHR_02(p_box);
			int rowCnt = ds.getDataRowCnt();
			System.out.println("직원여부 rowCnt [" + rowCnt + "]");
			if(rowCnt > 0){
				String DPT_CD = GauceUtils.nameValue(ds, 1, "DPT_CD");
				// 이전휴일에 Y 값 세팅
				dao.GROUPWARE_UPT_01(p_box);
				// T_DI_DILIGENCE 에 값이 없을때 값 새로 작성
				dao.GROUPWARE_INS_01(p_box, GUN_YMD, DPT_CD);
				// T_DI_DILIGENCE에 근태코드값 수정
				dao.GROUPWARE_UPT_01(GUN_YMD, ENO_NO, "W", p_box);
				// T_DI_DILIGENCE에 근태총계값 수정
				dao.GROUPWARE_UPT_02(GUN_YMD, ENO_NO, p_box);
			}else{

			}

		}

}