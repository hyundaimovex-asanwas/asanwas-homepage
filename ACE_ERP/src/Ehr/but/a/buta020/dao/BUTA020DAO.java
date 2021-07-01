package Ehr.but.a.buta020.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BUTA020DAO extends AbstractDAO {

	/**
	 * BUTA020DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BUTA020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 품의번호 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA020_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 교통수단 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA020_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				"C%"
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 출장품의서 작성 내용  조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO"),
		};

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 출장 결재자정보  조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_04(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO"),
				"B",
				p_box.get("ORD_NO"),
				"B"				
		};

		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK1", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 동행자 내용  조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_25(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA025_PRT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO"),
		};

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}	
	
	
	public void BUTA020_SHR_PER(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_PER");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * 출장품의서 작성 내용을 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA020_INS_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_INS_01");


		String cnt = JSPUtil.rns(vo.get("COM_CNT"));
		if(cnt == ""){//저장
			cnt = "0";
		}

		//System.out.println("==================="+vo);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
			JSPUtil.rns(vo.get("ENO_NO")),				//품의자사번
			JSPUtil.rns(vo.get("NAM_KOR")),			//성명
			JSPUtil.rns(vo.get("DPT_CD")),				//부서코드
			JSPUtil.rns(vo.get("JOB_CD")),				//직위코드
			JSPUtil.rns(vo.get("BUT_FR_YMD").replaceAll("-", "")),		//출장시작일
			JSPUtil.rns(vo.get("BUT_FR_GBN")),		//출장시작일구분(A:오전,P:오후)
			JSPUtil.rns(vo.get("BUT_TO_YMD").replaceAll("-", "")),		//출장종료일
			JSPUtil.rns(vo.get("BUT_TO_GBN")),		//출장종료일구분(A:오전,P:오후)
			JSPUtil.rns(vo.get("OFFER_GBN")),			//숙식제공교육 구분
			JSPUtil.rns(vo.get("START_GBN")),			//숙식제공교육 출발구분
			JSPUtil.rns(vo.get("SLEEP_DAY")),			//숙박일수
			JSPUtil.rns(vo.get("BUT_DAY")),			//출장일수
			JSPUtil.rns(vo.get("BUT_CITY")),			//출장지
			JSPUtil.rns(vo.get("CITY_DPT1")),			//출장구간1출발지
			JSPUtil.rns(vo.get("CITY_ARV1")),			//출장구간1도착지
			JSPUtil.rns(vo.get("CITY_GBN1")),			//출장구간1교통수단
			JSPUtil.rns(vo.get("CITY_DPT2")),			//출장구간2출발지
			JSPUtil.rns(vo.get("CITY_ARV2")),			//출장구간2도착지
			JSPUtil.rns(vo.get("CITY_GBN2")),			//출장구간2교통수단
			JSPUtil.rns(vo.get("CITY_DPT3")),			//출장구간3출발지
			JSPUtil.rns(vo.get("CITY_ARV3")),			//출장구간3도착지
			JSPUtil.rns(vo.get("CITY_GBN3")),			//출장구간3교통수단
			JSPUtil.rns(vo.get("CITY_DPT4")),			//출장구간4출발지
			JSPUtil.rns(vo.get("CITY_ARV4")),			//출장구간4도착지
			JSPUtil.rns(vo.get("CITY_GBN4")),			//출장구간4교통수단
			JSPUtil.rns(vo.get("CITY_DPT5")),			//출장구간5출발지
			JSPUtil.rns(vo.get("CITY_ARV5")),			//출장구간5도착지
			JSPUtil.rns(vo.get("CITY_GBN5")),			//출장구간5교통수단
			JSPUtil.rns(vo.get("CITY_DPT6")),			//출장구간6출발지
			JSPUtil.rns(vo.get("CITY_ARV6")),			//출장구간6도착지
			JSPUtil.rns(vo.get("CITY_GBN6")),			//출장구간6교통수단
			JSPUtil.rns(vo.get("CITY_DPT7")),			//출장구간7출발지
			JSPUtil.rns(vo.get("CITY_ARV7")),			//출장구간7도착지
			JSPUtil.rns(vo.get("CITY_GBN7")),			//출장구간7교통수단
			JSPUtil.rns(vo.get("CITY_DPT8")),			//출장구간8출발지
			JSPUtil.rns(vo.get("CITY_ARV8")),			//출장구간8도착지
			JSPUtil.rns(vo.get("CITY_GBN8")),			//출장구간8교통수단
			JSPUtil.rns(vo.get("BUT_OBJ")),			//출장목적
			JSPUtil.rns(vo.get("BUT_ADDR")),			//긴급연락주소
			JSPUtil.rns(vo.get("BUT_NAME")),			//긴급연락성명
			JSPUtil.rns(vo.get("BUT_PHONE")),		//긴급연락전화번호
			JSPUtil.rns(vo.get("REMARK")),			//비고
			JSPUtil.rns(vo.get("COM_YN")),			//동행인여부

			//JSPUtil.rns(vo.get("COM_CNT")),			//동행인수
			cnt,
			JSPUtil.rns(vo.get("COM_CD1")),			//동행인직위코드1
			JSPUtil.rns(vo.get("COM_NM1")),			//동행인직위1
			JSPUtil.rns(vo.get("COM_NO1")),			//동행인사번1
			JSPUtil.rns(vo.get("COM_NAM1")),		//동행인이름1
			JSPUtil.rns(vo.get("COM_CD2")),			//동행인직위코드2
			JSPUtil.rns(vo.get("COM_NM2")),			//동행인직위2
			JSPUtil.rns(vo.get("COM_NO2")),			//동행인사번2
			JSPUtil.rns(vo.get("COM_NAM2")),		//동행인이름2
			JSPUtil.rns(vo.get("COM_CD3")),			//동행인직위코드3
			JSPUtil.rns(vo.get("COM_NM3")),			//동행인직위3
			JSPUtil.rns(vo.get("COM_NO3")),			//동행인사번3
			JSPUtil.rns(vo.get("COM_NAM3")),		//동행인이름3
			JSPUtil.rns(vo.get("COM_CD4")),			//동행인직위코드4
			JSPUtil.rns(vo.get("COM_NM4")),			//동행인직위4
			JSPUtil.rns(vo.get("COM_NO4")),			//동행인사번4
			JSPUtil.rns(vo.get("COM_NAM4")),		//동행인이름4
			JSPUtil.rns(vo.get("COM_CD5")),			//동행인직위코드5
			JSPUtil.rns(vo.get("COM_NM5")),			//동행인직위5
			JSPUtil.rns(vo.get("COM_NO5")),			//동행인사번5
			JSPUtil.rns(vo.get("COM_NAM5")),		//동행인이름5
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(vo.get("BUT_AFF")),		//출장효과
			JSPUtil.rns(vo.get("BUT_GBN")), 		//출장유형
			JSPUtil.rns(vo.get("PC_GBN")),		//전표구분
			JSPUtil.rns(vo.get("PC_CCTRCD")),	//전표코드
			JSPUtil.rns(vo.get("PC_CCTRNM")) 	//전표명
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 출장품의 결재현황을 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA020_INS_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_INS_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("ORD_NO")),				//품의번호
			JSPUtil.rns(p_box.get("ENO_NO")),				//품의자사번
			JSPUtil.rns(p_box.get("NAM_KOR")),			//성명
			JSPUtil.rns(p_box.get("DPT_CD")),				//부서코드
			JSPUtil.rns(p_box.get("JOB_CD")),				//직위코드
			"SV",														//결재상태
			"N",														//결재완료여부
			JSPUtil.rns(p_box.get("APP_CMT")),		//결재장의견
			"N",														//전표처리여부
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 출장 결재자정보를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA020_INS_03(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_INS_03");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")),			//근태일
				"B",
				JSPUtil.rns(vo.get("DPT_CD")),			//부서
				JSPUtil.rns(vo.get("SEQ_NO")),			//일련번호
				JSPUtil.rns(vo.get("ENO_NO")),			//결재자사번
				JSPUtil.rns(vo.get("JOB_CD")),			//직위코드
				JSPUtil.rns(p_box.get("vusrid")),			//상신자사번
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("ORD_NO")),		//결재번호
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 출장품의 결재현황(상신, 결재, 전결) 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_01(CBox p_box, GauceValueObject vo, String APP_YN) throws CException {


		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_01");

		/** 상태에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

		if(vo.get("APP_STATUS").equals("SV")){//저장
				sb.append("ORD_YMD = TO_CHAR(SYSDATE,'YYYYMMDD'),\n");
				sb.append("                   ORD_TIME = TO_CHAR(SYSDATE,'HH24MISS'),\n");
				sb.append("                   APP_CMT = '저장',\n");//상신

		}else if(APP_YN.equals("Y")){ //결재완료
			sb.append("                   APP_COMP  = 'Y',\n");
			sb.append("                   TRANS_GBN = 'R',\n");//전표처리가능
			sb.append("                   APP_CMT = '결재완료',\n");//결재완료
		}else if(APP_YN.equals("N")){ // 부결완료
			sb.append("                   APP_COMP  = 'N',\n");
			sb.append("                   TRANS_GBN = 'N',\n");//전표처리불가
			sb.append("                   APP_CMT = '부결',\n");//부결처리
		}else if(APP_YN.equals("E")){ // 반송
			sb.append("                   APP_COMP  = 'E',\n");
			sb.append("                   TRANS_GBN = 'N',\n");//전표처리불가
			sb.append("                   APP_CMT = '반송',\n");//반송처리
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),	//수정자
				JSPUtil.rns(vo.get("ORD_NO")),						//품의번호
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 출장 결재자정보(결재여부) 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_YN")),							//결재여부
				JSPUtil.rns(vo.get("APP_CMT")),						//REMARK
				JSPUtil.rns(p_box.get("vusrid")), 	//수정자
				JSPUtil.rns(vo.get("ORD_NO")),						    //품의번호
				JSPUtil.rns(p_box.get("vusrid"))	   //사번
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	public void BUTA020_UPT_APP(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),	   //사번
				p_box.get("ORD_NO")  					    //품의번호

		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	public void BUTA020_UPT_STA(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_STA");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),	   //사번
				p_box.get("ORD_NO")  					    //품의번호

		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	/**
	 * 상신자외 결재여부 'N' 변경
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_06(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_06");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				"N",										//결재여부
				JSPUtil.rns(p_box.get("vusrid")),	//수정자
				JSPUtil.rns(vo.get("ORD_NO")),						//품의번호
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	/**
	 * 출장품의서 정보 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_03");


		String cnt = JSPUtil.rns(vo.get("COM_CNT"));
		if(cnt == ""){//저장
			cnt = "0";
		}
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("BUT_FR_YMD").replaceAll("-", "")),		//출장시작일
				JSPUtil.rns(vo.get("BUT_FR_GBN")),		//출장시작일구분(A:오전,P:오후)
				JSPUtil.rns(vo.get("BUT_TO_YMD").replaceAll("-", "")),		//출장종료일
				JSPUtil.rns(vo.get("BUT_TO_GBN")),		//출장종료일구분(A:오전,P:오후)
				JSPUtil.rns(vo.get("OFFER_GBN")),			//숙식제공교육 구분
				JSPUtil.rns(vo.get("START_GBN")),			//숙식제공교육 출발구분
				JSPUtil.rns(vo.get("SLEEP_DAY")),			//숙박일수
				JSPUtil.rns(vo.get("BUT_DAY")),			//출장일수
				JSPUtil.rns(vo.get("BUT_CITY")),			//출장지
				JSPUtil.rns(vo.get("CITY_DPT1")),			//출장구간1출발지
				JSPUtil.rns(vo.get("CITY_ARV1")),			//출장구간1도착지
				JSPUtil.rns(vo.get("CITY_GBN1")),			//출장구간1교통수단
				JSPUtil.rns(vo.get("CITY_DPT2")),			//출장구간2출발지
				JSPUtil.rns(vo.get("CITY_ARV2")),			//출장구간2도착지
				JSPUtil.rns(vo.get("CITY_GBN2")),			//출장구간2교통수단
				JSPUtil.rns(vo.get("CITY_DPT3")),			//출장구간3출발지
				JSPUtil.rns(vo.get("CITY_ARV3")),			//출장구간3도착지
				JSPUtil.rns(vo.get("CITY_GBN3")),			//출장구간3교통수단
				JSPUtil.rns(vo.get("CITY_DPT4")),			//출장구간4출발지
				JSPUtil.rns(vo.get("CITY_ARV4")),			//출장구간4도착지
				JSPUtil.rns(vo.get("CITY_GBN4")),			//출장구간4교통수단
				JSPUtil.rns(vo.get("CITY_DPT5")),			//출장구간5출발지
				JSPUtil.rns(vo.get("CITY_ARV5")),			//출장구간5도착지
				JSPUtil.rns(vo.get("CITY_GBN5")),			//출장구간5교통수단
				JSPUtil.rns(vo.get("CITY_DPT6")),			//출장구간6출발지
				JSPUtil.rns(vo.get("CITY_ARV6")),			//출장구간6도착지
				JSPUtil.rns(vo.get("CITY_GBN6")),			//출장구간6교통수단
				JSPUtil.rns(vo.get("CITY_DPT7")),			//출장구간7출발지
				JSPUtil.rns(vo.get("CITY_ARV7")),			//출장구간7도착지
				JSPUtil.rns(vo.get("CITY_GBN7")),			//출장구간7교통수단
				JSPUtil.rns(vo.get("CITY_DPT8")),			//출장구간8출발지
				JSPUtil.rns(vo.get("CITY_ARV8")),			//출장구간8도착지
				JSPUtil.rns(vo.get("CITY_GBN8")),			//출장구간8교통수단
				JSPUtil.rns(vo.get("BUT_OBJ")),			//출장목적
				JSPUtil.rns(vo.get("BUT_ADDR")),			//긴급연락주소
				JSPUtil.rns(vo.get("BUT_NAME")),			//긴급연락성명
				JSPUtil.rns(vo.get("BUT_PHONE")),		//긴급연락전화번호
				JSPUtil.rns(vo.get("REMARK")),				//비고
				JSPUtil.rns(vo.get("COM_YN")),				//동행인여부

				cnt,
				//JSPUtil.rns(vo.get("COM_CNT")),			//동행인수


				JSPUtil.rns(vo.get("COM_CD1")),			//동행인직위코드1
				JSPUtil.rns(vo.get("COM_NM1")),			//동행인직위1
				JSPUtil.rns(vo.get("COM_NO1")),			//동행인사번1
				JSPUtil.rns(vo.get("COM_NAM1")),			//동행인이름1
				JSPUtil.rns(vo.get("COM_CD2")),			//동행인직위코드2
				JSPUtil.rns(vo.get("COM_NM2")),			//동행인직위2
				JSPUtil.rns(vo.get("COM_NO2")),			//동행인사번2
				JSPUtil.rns(vo.get("COM_NAM2")),			//동행인이름2
				JSPUtil.rns(vo.get("COM_CD3")),			//동행인직위코드3
				JSPUtil.rns(vo.get("COM_NM3")),			//동행인직위3
				JSPUtil.rns(vo.get("COM_NO3")),			//동행인사번3
				JSPUtil.rns(vo.get("COM_NAM3")),			//동행인이름3
				JSPUtil.rns(vo.get("COM_CD4")),			//동행인직위코드4
				JSPUtil.rns(vo.get("COM_NM4")),			//동행인직위4
				JSPUtil.rns(vo.get("COM_NO4")),			//동행인사번4
				JSPUtil.rns(vo.get("COM_NAM4")),			//동행인이름4
				JSPUtil.rns(vo.get("COM_CD5")),			//동행인직위코드5
				JSPUtil.rns(vo.get("COM_NM5")),			//동행인직위5
				JSPUtil.rns(vo.get("COM_NO5")),			//동행인사번5
				JSPUtil.rns(vo.get("COM_NAM5")),			//동행인이름5
				p_box.get("vusrid"),
				JSPUtil.rns(vo.get("BUT_AFF")),				//출장효과
				JSPUtil.rns(vo.get("BUT_GBN")),				//출장유형
				JSPUtil.rns(vo.get("PC_GBN")),				//전표구분
				JSPUtil.rns(vo.get("PC_CCTRCD")),				//전표코드
				JSPUtil.rns(vo.get("PC_CCTRNM")),				//전표명
				JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
				JSPUtil.rns(vo.get("ENO_NO"))				//사번
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 출장 결재자정보 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_04(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("AUTHO_CD")),					//결재자작업권한코드
				JSPUtil.rns(p_box.get("vusrid")),	//수정자
				JSPUtil.rns(vo.get("ORD_NO")),						//품의번호
				JSPUtil.rns(vo.get("ENO_NO"))						//사번
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	/**
	 * 출장 날짜정보 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_SAV_DATE(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_DATE");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("BUT_FR_YMD").replaceAll("-", "")),		//출장시작일
				JSPUtil.rns(vo.get("BUT_FR_GBN")),							//출장시작일구분(A:오전,P:오후)
				JSPUtil.rns(vo.get("BUT_TO_YMD").replaceAll("-", "")),		//출장종료일
				JSPUtil.rns(vo.get("BUT_TO_GBN")),							//출장종료일구분(A:오전,P:오후)
				JSPUtil.rns(vo.get("SLEEP_DAY")),							//숙박일수
				JSPUtil.rns(vo.get("BUT_DAY")),								//출장일수
				JSPUtil.rns(vo.get("ORD_NO"))								//품의번호

		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 출장 날짜정보 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_DILIGENCE(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_DATE");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("BUT_FR_YMD").replaceAll("-", "")),		//출장시작일
				JSPUtil.rns(vo.get("BUT_FR_GBN")),							//출장시작일구분(A:오전,P:오후)
				JSPUtil.rns(vo.get("BUT_TO_YMD").replaceAll("-", "")),		//출장종료일
				JSPUtil.rns(vo.get("BUT_TO_GBN")),							//출장종료일구분(A:오전,P:오후)
				JSPUtil.rns(vo.get("SLEEP_DAY")),							//숙박일수
				JSPUtil.rns(vo.get("BUT_DAY")),								//출장일수
				JSPUtil.rns(vo.get("ORD_NO"))								//품의번호

		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}	
	
	/**
	 * 출장품의 결재현황(부결, 반송) 수정
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_UPT_05(CBox p_box, GauceValueObject vo) throws CException {

		int sel = Integer.parseInt(vo.get("APP_STATUS").substring(1, 2))+1;

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_UPT_01");

		/** 상태에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

		sb.append("APP_STATUS = 'A"+sel+"',\n");
		sb.append("                   OUR_YMD"+sel+" = TO_CHAR(SYSDATE,'YYYYMMDD'),\n");
		sb.append("                   OUR_TIM"+sel+" = TO_CHAR(SYSDATE,'HH24MISS'),\n");

		if(vo.get("KIND").equals("부결")){
			sb.append("                   OUR_TAG"+sel+" = 'D',\n");
		}else if(vo.get("KIND").equals("반송")){
			sb.append("                   OUR_TAG"+sel+" = 'E',\n");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("APP_CMT")),					//결재장의견
				JSPUtil.rns(p_box.get("vusrid")),	//수정자
				JSPUtil.rns(vo.get("ORD_NO")),						//품의번호
				JSPUtil.rns(vo.get("ENO_NO"))						//사번
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	/**
     * 출장결재자정보 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA020_DEL_01(CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTC020_DEL_01");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ORD_NO")),
				"B"
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	/**
     * 출장품의서결재현황 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA020_DEL_02(CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA010_DEL_02");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ORD_NO")),
				JSPUtil.rns(p_box.get("ENO_NO"))
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}



	/**
	 * 출장 결재정보  조회(T_DI_DILIGENCE에 Update 하기 위한 자료)
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_05(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_05");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ORD_NO")),						//품의번호
				JSPUtil.rns(vo.get("ENO_NO"))						//사번
		};


		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * 출장 결재정보  조회(T_DI_DILIGENCE에 Update 하기 위한 자료)
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_SHR_06(String NEXT_ENO, String Next_msg,CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_06");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				Next_msg,
				NEXT_ENO						//사번
		};

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}
	public GauceDataSet BUTA020_SHR_07(String NEXT_ENO, String Next_msg,CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_SHR_07");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				Next_msg,
				NEXT_ENO						//사번
		};

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);
	}
	/**
	 * T_DI_DILIGENCE 에 없는데이터를 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_DIL_INS_01(String YYYY, String ENO_NO,  String DPT_CD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_DIL_IND_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				YYYY,
				ENO_NO,
				DPT_CD,
				YYYY,
				p_box.get("vusrid"),
				p_box.get("vusrid"),
				YYYY,
				ENO_NO
		};

		/** UPDATE메소드 호출  **/
		this.insertProcess(sql, bind);

	}


	/**
	 * 일일근태템프데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet BUTA020_DIL_SHR_01(String STR_YYYYMM, String END_YYYYMM, String ENO_NO, String STR_YYYYMMDD, String END_YYYYMMDD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_DIL_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				STR_YYYYMM,
				END_YYYYMM,
				ENO_NO,
				STR_YYYYMMDD,
				END_YYYYMMDD
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;

	}
	/**
	 * T_DI_DILIGENCE 에 반영(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_DIL_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= '"+GUN_CD+"',");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}

	
	/**
	 * T_DI_DILIGENCE 에 반영(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA020_DIL_UPT_02(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_02");
		
		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD";
		
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= '"+GUN_CD+"',");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}	
	
	
	
	/**
	 * 근태총계를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA020_DIL_UPT_03(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "";
		if("".equals(JSPUtil.rns(GUN_CD))){
			return;
		}
		if(GUN_CD.equals("A")) COLNAME="ATT_A";
		else if(GUN_CD.equals("B")) COLNAME="ATT_B";
		else if(GUN_CD.equals("C")) COLNAME="ATT_C";
		else if(GUN_CD.equals("D")) COLNAME="ATT_D";
		else if(GUN_CD.equals("E")) COLNAME="ATT_E";
		else if(GUN_CD.equals("F")) COLNAME="ATT_F";
		else if(GUN_CD.equals("G")) COLNAME="ATT_G";
		else if(GUN_CD.equals("H")) COLNAME="ATT_H";
		else if(GUN_CD.equals("I")) COLNAME="ATT_I";
		else if(GUN_CD.equals("J")) COLNAME="ATT_J";
		else if(GUN_CD.equals("K")) COLNAME="ATT_K";
		else if(GUN_CD.equals("L")) COLNAME="ATT_L";
		else if(GUN_CD.equals("M")) COLNAME="ATT_M";
		else if(GUN_CD.equals("N")) COLNAME="ATT_N";
		else if(GUN_CD.equals("O")) COLNAME="ATT_O";
		else if(GUN_CD.equals("P")) COLNAME="ATT_P";
		else if(GUN_CD.equals("Q")) COLNAME="ATT_Q";
		else if(GUN_CD.equals("R")) COLNAME="ATT_R";
		else if(GUN_CD.equals("S")) COLNAME="ATT_S";
		else if(GUN_CD.equals("U")) COLNAME="ATT_U";
		else if(GUN_CD.equals("V")) COLNAME="ATT_V";
		else if(GUN_CD.equals("X")) COLNAME="ATT_X";
		else if(GUN_CD.equals("Z")) COLNAME="ATT_Z";
		else if(GUN_CD.equals("W")) COLNAME="ATW_CNT";
		else if(GUN_CD.equals("Y")) COLNAME="HOL_CNT";
		else if(GUN_CD.equals("T")) COLNAME="HOW_CNT";

		if("".equals(COLNAME))
			return;

		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= DECODE("+COLNAME+", null, 0, "+COLNAME+"+1),");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				ENO_NO,
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}
	/**
	 * 동일 등록번호의 결재한개수세기(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet BUTA020_CNT(GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA020_CNT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
				"B",
				JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
				"B",
				JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
				"B",
				JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
				"B",
				JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
				"B"
		};

		/** UPDATE메소드 호출  **/
		return selectProcess(sql, bind);
	}
}

