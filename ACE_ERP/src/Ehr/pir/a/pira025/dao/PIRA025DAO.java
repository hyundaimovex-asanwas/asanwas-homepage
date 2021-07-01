package Ehr.pir.a.pira025.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import common.sys.KISA_SHA256;

import Ehr.common.util.JSPUtil;

public class PIRA025DAO extends AbstractDAO {
	/**
	 * PIRA025DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA025DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 입사후경력 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA025_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 입사후경력 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};

		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("STR_YMD", ColumnProp.COLUMN_TYPE_STRING , 10, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SEQ_NO", ColumnProp.COLUMN_TYPE_STRING , 2, ColumnProp.CONSTRAINT_TB_KEY);

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 입사후경력 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 입사후경력 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("STR_YMD").replaceAll("-", ""),    // 시작일자
				vo.get("SEQ_NO"),                                 // SEQ 번호
				vo.get("OCC_CD"),                                 // 직종코드
				vo.get("END_YMD").replaceAll("-", ""),    // 종료일자
				vo.get("APP_CD"),                                 // 발령구분코드
				vo.get("HEAD_CD"),                               // 본부코드
				vo.get("DPT_CD"),                                 // 소속코드
				vo.get("TEAM_CD"),                               // 팀코드
				vo.get("DUTY_CD"),                               // 직책코드
				vo.get("SRV_CD"),                                 // 직무코드
				vo.get("PART_CD"),                               // 부문코드
				vo.get("CHIEF_YN"),                               // 장여부
				vo.get("JOB_CD"),                                 // 직위코드
				vo.get("HOB_CD"),                                 //호봉코드
				vo.get("JCD_CD"),                                 // 재직구분코드
				vo.get("APP_YMD").replaceAll("-", ""),   // 발령일자
				vo.get("REMARK"),                                // 적요사항
				vo.get("TAX_DPT"),                               // 회계부서
				p_box.get("vusrid"),            // 입력자
				p_box.get("vusrid")             // 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 인사발령사항에 따른 관련테이블에 인사발령내용 반영하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_01(GauceValueObject vo, CBox p_box, String GBN) throws CException {

		String sql = null;
		Object[][] bind =  null;

		/** 외부 XML에서 인사발령사항에 따른 관련테이블에 인사발령내용 반영하는 SQL 읽음 **/
		if (GBN.equals("1")) {
		    sql = "{ call ASNHR.PKG_XF_PIRA025_INS.SF_INS_T_CM_AHISTORY(?, ?, ?, ?) }";

		    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		    bind = new Object[][] {
			    	{"IN", "", vo.get("ENO_NO"), ""},                                     // 사번
				    {"IN", "", vo.get("STR_YMD").replaceAll("-", ""), ""},        // 시작일자
				    {"IN", "", vo.get("SEQ_NO"), ""},                                     // SEQ번호
				    {"IN", "", p_box.get("vusrid"), ""}                  // 입력자
		    };

			//System.out.println("iENO_NO  := "+"'"+JSPUtil.rns(vo.get("ENO_NO"))+"';");
			//System.out.println("iSTR_YMD := "+"'"+JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", ""))+"';");
			//System.out.println("iSEQ_NO  := "+"'"+JSPUtil.rns(vo.get("SEQ_NO"))+"';");
			//System.out.println("iIPT_MAN := "+"'"+JSPUtil.rns(p_box.get("SESSION_ENONO"))+"';");

		}
		else if (GBN.equals("2")) {
			sql = "{ call ASNHR.PKG_XF_PIRA025_INS.SF_UPT_T_CM_AHISTORY(?, ?, ?, ?,?) }";

		    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		    bind = new Object[][] {
			    	{"IN", "", vo.get("ENO_NO"), ""},                                     // 사번
				    {"IN", "", vo.get("STR_YMD").replaceAll("-", ""), ""},        // 시작일자
				    {"IN", "", vo.get("SEQ_NO"), ""},                                     // SEQ번호
				    {"IN", "", vo.get("OLD_APP_CD"), ""},                             // OLD발령구분
				    {"IN", "", p_box.get("vusrid"), ""}                  // 입력자
		    };

			//System.out.println("iENO_NO     := "+"'"+JSPUtil.rns(vo.get("ENO_NO"))+"';");
			//System.out.println("iSTR_YMD    := "+"'"+JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", ""))+"';");
			//System.out.println("iSEQ_NO     := "+"'"+JSPUtil.rns(vo.get("SEQ_NO"))+"';");
			//System.out.println("iOLD_APP_CD := "+"'"+JSPUtil.rns(vo.get("OLD_APP_CD"))+"';");
			//System.out.println("iIPT_MAN    := "+"'"+JSPUtil.rns(p_box.get("SESSION_ENONO"))+"';");

		}
		else if (GBN.equals("3")) {
		    sql = "{ call ASNHR.PKG_XF_PIRA025_INS.SF_DEL_T_CM_AHISTORY(?, ?, ?, ?) }";

		    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		    bind = new Object[][] {
			    	{"IN", "", vo.get("ENO_NO"), ""},                                     // 사번
				    {"IN", "", vo.get("STR_YMD").replaceAll("-", ""), ""},        // 시작일자
				    {"IN", "", vo.get("SEQ_NO"), ""},                                     // SEQ번호
				    {"IN", "", p_box.get("vusrid"), ""}                  // 입력자
		    };

			//System.out.println("iENO_NO  := "+"'"+JSPUtil.rns(vo.get("ENO_NO"))+"';");
			//System.out.println("iSTR_YMD := "+"'"+JSPUtil.rns(vo.get("STR_YMD").replaceAll("-", ""))+"';");
			//System.out.println("iSEQ_NO  := "+"'"+JSPUtil.rns(vo.get("SEQ_NO"))+"';");
			//System.out.println("iIPT_MAN := "+"'"+JSPUtil.rns(p_box.get("SESSION_ENONO"))+"';");

		}

		/** EXECUTEPROCEDURE 메소드 호출  **/
		this.executeProcedure(sql, bind, null);

	}

	/**
	 * 입사후경력 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 입사후경력 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("OCC_CD"),                                 // 직종코드
				vo.get("END_YMD").replaceAll("-", ""),    // 종료일자
				vo.get("APP_CD"),                                 // 발령구분코드
				vo.get("HEAD_CD"),                               // 본부코드
				vo.get("DPT_CD"),                                 // 소속코드
				vo.get("TEAM_CD"),                               // 팀코드
				vo.get("DUTY_CD"),                               // 직책코드
				vo.get("SRV_CD"),                                 // 직무코드
				vo.get("PART_CD"),                               // 부문코드
				vo.get("CHIEF_YN"),                               // 장여부
				vo.get("JOB_CD"),                                 // 직위코드
				vo.get("HOB_CD"),                                 //호봉코드
				vo.get("JCD_CD"),                                 // 재직구분코드
				vo.get("APP_YMD").replaceAll("-", ""),   // 발령일자
				vo.get("REMARK"),                                // 적요사항
				vo.get("TAX_DPT"),                               // 회계부서
				p_box.get("vusrid"),            // 수정자
				vo.get("ENO_NO"),                                 // 사번
				vo.get("STR_YMD").replaceAll("-", ""),    // 시작일자
				vo.get("SEQ_NO")                                  // SEQ 번호
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 입사후경력 DELETE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 입사후경력 테이블 삭제 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (삭제조건) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),                                 // 사번
				vo.get("STR_YMD").replaceAll("-", ""),    // 시작일자
				vo.get("SEQ_NO")                                  // SEQ 번호
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);

	}

	/**
	 * 재입사여부 조회
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA025_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 입사후경력 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 기존입사일 반영
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_UPT_01(GauceValueObject vo1, GauceValueObject vo2, CBox p_box) throws CException {

		/** 외부 XML에서 입사후경력 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_UPT_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo2.get("HIR_YMD").replaceAll("-", ""),  // 기존입사일
				vo2.get("HIRG_YMD").replaceAll("-", ""), // 기존그룹입사일
				p_box.get("vusrid"),              // 수정자
				vo1.get("ENO_NO"),                       // 현재사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
     * 인사기록정보 유무 체크
     * @param p_box CBox
     * @throws CException
     */
	public GauceDataSet PIRA025_SHR_02(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 지인등록 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),
				vo.get("ENO_NO"),
		};

		return this.selectProcess(sql, bind, this.prop);

	}

	/**
	 * 인사기록정보 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_02(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록정보 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_INS_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {

				p_box.get("vusrid"),   // 입력자
				p_box.get("vusrid"),   // 수정자
                vo.get("ENO_NO"),             // 사번
                vo.get("ENO_NO"),             // 사번
                vo.get("ENO_NO"),             // 사번
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

	/**
	 * 로그인사원 정보에 인사마스터 내용을 반영하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_03(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 로그인사원 정보를 생성하거나 수정하는 SQL 읽음 **/
		String sql = "{ call ASNHR.PKG_XF_PIRA010_INS.SF_INS_T_CM_EMPLIST(?, ?, ?, ?, ?) }";

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {
				{"IN", "", "01", ""},                        // 회계단위
				{"IN", "", vo.get("ENO_NO"), ""},                                  // 사번
				{"IN", "", "", ""},                                                // 본부코드
				{"IN", "", "", ""},                                                // 부서코드
				{"IN", "", p_box.get("vusrid"), ""}                         // 사번
		};

		/** EXECUTEPROCEDURE 메소드 호출  **/
		this.executeProcedure(sql, bind, null);

	}

	
	/**
	 * 직원 정보를 Payroll.Hiperson 에도 반영하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_04(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 로그인사원 정보를 생성하거나 수정하는 SQL 읽음 **/
		String sql = "{ call ASNHR.PKG_XF_PAYROLL_INS.SF_INS_PAYROLL_HIPERSON(?,?,?) }";

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {

				{"IN", "", vo.get("ENO_NO"), ""},                                  // 사번
				{"IN", "", vo.get("DPT_CD"), ""},                                  // 소속코드
				{"IN", "", vo.get("JOB_CD"), ""},                                  // 직위코드

		};

		/** EXECUTEPROCEDURE 메소드 호출  **/
		this.executeProcedure(sql, bind, null);

	}	
	
	
	
	
	/**
	 * 직원 로그인 정보를 COMMON.GD0080, COMMON.MENU_AUTH 에도 반영하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_05(GauceValueObject vo, CBox p_box) throws CException {

		
		
		byte pbData[]   = new byte[0];      //사용자입력 평문
		byte pbCipher[] = new byte[32];     //암호문
		
		int Plaintext_length=0;  //평문길이 
		String strEncryptPW="";  //암호문
		StringBuffer sb = new StringBuffer();
		String strEncodePW = "";             //암호문이 인코딩 된 상태

		String pwd 	= "hda"+vo.get("ENO_NO")+"!"; //디폴트 암호
		
		pbData =  pwd.getBytes();
		Plaintext_length = pwd.length();
		
		//pbData : 평문
		//Plaintext_length : 평문길이
		//pbCipher : 암호문
		
	    KISA_SHA256.SHA256_Encrpyt(pbData, Plaintext_length, pbCipher);
	    
		 sb = new StringBuffer(); 
		 
		 for(int j = 0 ; j < pbCipher.length ; j++){
                sb.append(Integer.toString((pbCipher[j]&0xff) + 0x100, 16).substring(1));
          }
		 
		 //암호문 
		strEncryptPW = sb.toString();				

		
		/** 외부 XML에서 로그인사원 정보를 생성하거나 수정하는 SQL 읽음 **/
		String sql = "{ call ASNHR.PKG_XF_COMMON_INS.SF_INS_COMMON(?, ?) }";

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {

				{"IN", "", vo.get("ENO_NO"), ""},                                  // 사번
				{"IN", "", strEncryptPW, ""},                                      // 최초 비번
		};

		/** EXECUTEPROCEDURE 메소드 호출  **/
		this.executeProcedure(sql, bind, null);

	}		
	

	/**
	 * 인사기록정보 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA025_INS_06(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록정보 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA025_INS_06");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
                vo.get("ENO_NO"),             	// 사번
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}
	
}
