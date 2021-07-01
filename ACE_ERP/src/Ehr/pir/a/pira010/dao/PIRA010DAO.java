package Ehr.pir.a.pira010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class PIRA010DAO extends AbstractDAO {
	/**
	 * PIRA010DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA010DAO(String p_dsId, TrBox p_tr) throws CException {


		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void PIRA010_SHR_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pira010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}	
	
	
	/**
	 * 개인정보처리 접속 기록 인사기록표 INSERT를 수행하는 DAO 메소드
	 */
	public void PIRA010_INS_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pira010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"I"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}			
	
	/**
	 * 개인정보처리 접속 기록 인사기록표 UPDATE를 수행하는 DAO 메소드
	 */
	public void PIRA010_UPT_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pira010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"U"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}			
	
	/**
	 * 개인정보처리 접속 기록 인사기록표 PRINT를 수행하는 DAO 메소드
	 */
	public void PIRA010_PRT_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"pira010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"P"
		};
		
		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	

	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),                      // 사번조건
				p_box.get("ENO_NO")                       // 성명조건
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {

				p_box.get("ENO_NO"),                      // 사번조건

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT2(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // 사번조건

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT3(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT3");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // 사번조건

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT4(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT4");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // 사번조건

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT5(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT5");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // 사번조건

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT6(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT6");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // 사번조건

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT7(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT7");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // 사번조건

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * 인사기록표 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA010_SHR_PRINT8(CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_SHR_PRINT8");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                      // 사번조건

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	
	
	/**
	 * 인사기록표 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				"01",  											// 회계단위
				vo.get("ENO_NO"),                      // 사번
				vo.get("OCC_CD"),                      // 직종
				vo.get("ENO_NM"),                      // 성명
				vo.get("NAM_ENG"),                    // 영문성명
				vo.get("NAM_CHI"),                      // 한문성명
				vo.get("MF_TAG"),                       // 성별
				vo.get("BIR_YMD"),                      // 생년월일
				vo.get("BIR_TAG"),                      // 양력구분
				vo.get("CET_NO"),                       // 주민번호
				vo.get("HEAD_CD"),                     // 본부
				vo.get("DPT_CD"),                      // 소속(본사/지역구분 조회)
				vo.get("REG_CD"),                       // 지역구분
				vo.get("DPT_CD"),                       // 소속
				vo.get("JOB_CD"),                       // 직위
				vo.get("JPR_YMD"),                     // 승진일
				vo.get("DUTY_CD"),                     // 직책
				vo.get("TEAM_CD"),                     // 팀
				vo.get("HOB_CD"),                       // 호봉
				vo.get("HBA_YMD"),                     // 승급일
				vo.get("HIR_YMD"),                      // 입사일
				vo.get("HIRG_YMD"),                    // 그룹입사일
				vo.get("HIR_YMD"),                      // 입사일(퇴직금기준일)
				vo.get("ENO_NO"),                      // 상선사번(신규일때는 생성사번을 넣는다)
				p_box.get("vusrid"),   // 입력자
				p_box.get("vusrid")    // 수정자
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
	public void PIRA010_INS_01(CBox p_box) throws CException {

		/** 외부 XML에서 로그인사원 정보를 생성하거나 수정하는 SQL 읽음 **/
		String sql = "{ call ASNHR.PKG_XF_PIRA010_INS.SF_INS_T_CM_EMPLIST(?, ?, ?, ?, ?) }";

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {
				{"IN", "", "01", ""},                       	 					// 회계단위
				{"IN", "", p_box.get("ENO_NO"), ""},                    // 사번
				{"IN", "", p_box.get("HEAD_CD"), ""},                  // 본부코드
				{"IN", "", p_box.get("DPT_CD"), ""},                     // 부서코드
				{"IN", "", p_box.get("vusrid"), ""}                         // 사번
		};

		/** EXECUTEPROCEDURE 메소드 호출  **/
		this.executeProcedure(sql, bind, null);

	}

	/**
	 * 신입사원 정보 인사마스터에 반영하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_INS_02(CBox p_box) throws CException {

		/** 외부 XML에서 채용관리에서 수험번호/주민번호를 읽어들여 인사마스터 데이터를 일괄 생성하는 SQL 읽음 **/
		String sql = "{ call PKG_XF_PIRA010_INS.SF_INS_T_CM_PERSON(?, ?, ?, ?, ?) }";

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {
				{"IN", "", p_box.get("SESSION_GUBUN"), ""},                        // 회계단위
				{"IN", "", p_box.get("ENO_NO"), ""},                                      // 사번
				{"IN", "", p_box.get("REG_NO"), ""},                                      // 수험번호
				{"IN", "", p_box.get("CET_NO"), ""},                                      // 주민번호
				{"IN", "", p_box.get("vusrid"), ""}                         // 사번
		};
		
		//System.out.println("IGUBUN   := "+"'"+JSPUtil.rns(p_box.get("SESSION_GUBUN"))+"';");
		//System.out.println("IENO_NO  := "+"'"+JSPUtil.rns(p_box.get("ENO_NO"))+"';");
		//System.out.println("IREG_NO := "+"'"+JSPUtil.rns(p_box.get("REG_NO"))+"';");
		//System.out.println("ICET_NO  := "+"'"+JSPUtil.rns(p_box.get("CET_NO"))+"';");
		//System.out.println("IIPT_MAN := "+"'"+JSPUtil.rns(p_box.get("SESSION_ENONO"))+"';");

		/** EXECUTEPROCEDURE 메소드 호출  **/
		this.executeProcedure(sql, bind, null);

	}

	/**
	 * 인사기록표 UPDATE를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터 수정 SQL 읽음  **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_UPT");

		//System.out.println(p_box);
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (수정대상 및 조건) **/
		Object[] bind = new Object[] {
				vo.get("OCC_CD"),                      // 직종
				vo.get("ENO_NM"),                      // 성명
				vo.get("NAM_ENG"),                    // 영문성명
				vo.get("NAM_CHI"),                      // 한문성명
				vo.get("MF_TAG"),                       // 성별
				vo.get("BIR_YMD"),                      // 생년월일
				vo.get("BIR_TAG"),                      // 양력구분
				vo.get("CET_NO"),                       // 주민번호
				vo.get("HEAD_CD"),                     // 본부
				vo.get("DPT_CD"),                      // 소속(본사/지역구분 조회)
				vo.get("REG_CD"),                       // 지역구분
				vo.get("DPT_CD"),                       // 소속
				vo.get("JOB_CD"),                       // 직위
				vo.get("JPR_YMD"),                     // 승진일
				vo.get("DUTY_CD"),                     // 직책
				vo.get("TEAM_CD"),                     // 팀
				vo.get("HOB_CD"),                       // 호봉
				vo.get("TAX_DPT"),                       // 회계소속				
				vo.get("RETP_YMD"),                     // 계약만료일
				vo.get("HIR_YMD"),                      // 입사일
				vo.get("HIRG_YMD"),                    // 그룹입사일
				p_box.get("vusrid"),     					// 수정자
				vo.get("ENO_NO")                          // 사번
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	/**
	 * 인사기록표 임시테이블 INSERT를 수행하는 DAO 메소드.
	 * @param vo	      GauceValueObject
	 * @param p_box CBox
	 * @throws CException
	 */
	public void PIRA010_INS_03(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 인사기록표 데이터  생성하는 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA010_INS_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (입력대상) **/
		Object[] bind = new Object[] {
				vo.get("ENO_NO"),
				vo.get("ENO_NO"),
				"1",//정규직
				vo.get("ENO_NM"),
				vo.get("NAM_ENG"),
				vo.get("NAM_CHI"),
				vo.get("MF_TAG"),
				vo.get("BIR_YMD"),
				vo.get("BIR_TAG"),
				vo.get("CET_NO"),
				vo.get("HIR_YMD"),
				vo.get("HIRG_YMD"),//정규직만 사용
				vo.get("JPR_YMD"),//정규직만 사용
				vo.get("HBA_YMD"),//정규직만 사용
				vo.get("RETP_YMD"),//계약만료일 2020.11.11 빼빼로 데이에 추가			
				"",//파견직만 사용
				p_box.get("vusrid"),   // 입력자
				p_box.get("vusrid")    // 수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);

	}

}
