package Ehr.sag.d.sagd030.dao;

//import oracle.jdbc.driver.OracleTypes;
import oracle.jdbc.OracleTypes;

import com.gauce.GauceDataRow;
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

public class SAGD030DAO extends AbstractDAO {

	/**
	 * SAGD030DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SAGD030DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 급여계산처리 조회
	 * @param p_box
	 * @throws CException
	 */
	public void SAGD030_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YYMM_SHR").substring(0,4),
				p_box.get("PIS_YYMM_SHR").substring(5,7),
				p_box.get("SEQ_SHR"),
		};

		prop.add("PIS_YY", ColumnProp.COLUMN_TYPE_STRING, 4, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PIS_MM", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("SEQ", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("PRO_STS", ColumnProp.COLUMN_TYPE_STRING, 1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PAY_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("WOM_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 6.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APY_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BPAY_PCT", ColumnProp.COLUMN_TYPE_DECIMAL, 4.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BYY_PCT", ColumnProp.COLUMN_TYPE_DECIMAL, 4.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BBYY_PCT", ColumnProp.COLUMN_TYPE_DECIMAL, 4.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PRO_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 5.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ERR_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 5.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REMARK", ColumnProp.COLUMN_TYPE_STRING, 60, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("RET_TAG", ColumnProp.COLUMN_TYPE_STRING, 1, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	/**
	 * 작업로그 신규저장 (작업 OPEN)
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_INS(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),		//pk
				JSPUtil.rns(vo.get("PIS_MM")),		//pk
				"A",
				"0",
				JSPUtil.rns(vo.get("SEQ")),				//pk
				JSPUtil.rns(vo.get("PRO_STS")),		//1
				JSPUtil.rns(vo.get("PAY_YMD").replaceAll("-", "")),
				JSPUtil.rns3(vo.get("WOM_AMT")),
				JSPUtil.rns(vo.get("APY_YMD").replaceAll("-", "")),
				"0",							//상여지급율(상여)
				"0",							//년상여지급율(상여)
				"0",							//현지급상여율(상여)
				"",								//REMARK
				"",								//RET_TAG
				JSPUtil.rns(p_box.get("vusrid")),		//입력자
				JSPUtil.rns(p_box.get("vusrid"))			//수정자
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}



	/**
	 * 대상자 선정
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_INS_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 대상자 선정 패키지 실행  **/
		String sql = "{ call ASNHR.PKG_XF_SAGD200_INS_00.SF_INS_T_CP_NPAYMASTER(?, ?, ?, ?, ?, ?, ?, ?, ?) }";

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {
				{"IN", 			"", 						"A", 														""						},//직종
				{"IN", 			"", 						JSPUtil.rns(vo.get("PIS_YY")), 					""						},//년
				{"IN", 			"", 						JSPUtil.rns(vo.get("PIS_MM")), 					""						},//월
				{"IN", 			"", 						"0", 														""						},//
				{"IN",				"", 						JSPUtil.rns(p_box.get("vusrid")),					""						},//작업자
				{"IN/OUT", 		"PRO_CNT", 			JSPUtil.rns(vo.get("PRO_CNT")), 					String.valueOf(OracleTypes.VARCHAR)},//처리인원
				{"IN/OUT", 		"ERR_CNT", 				JSPUtil.rns(vo.get("ERR_CNT")), 					String.valueOf(OracleTypes.VARCHAR)},//예외인원
				{"IN/OUT", 		"PRO_STS", 			JSPUtil.rns(vo.get("PRO_STS")), 					String.valueOf(OracleTypes.VARCHAR)},//작업단계
				{"IN/OUT", 		"PRO_STS_MSG", 		"MSG", 													String.valueOf(OracleTypes.VARCHAR)} //작업완료메세지
		};

		/** EXECUTEPROCEDURE 메소드 호출  **/
		CBox box = (CBox)this.executeProcedure(sql, bind, null);

	}


	/**
	 * 금액·세액계산
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_INS_03(CBox p_box, GauceValueObject vo) throws CException {

		/** 금액·세액계산 패키지 실행  **/
		String sql = "{ call ASNHR.PKG_XF_SAGD200_INS_01.SF_INS_T_CP_NPAYMASTER(?, ?, ?, ?, ?, ?, ?, ?, ?) }";

		//System.out.print(">>>>>>>>>>>>>>>>>>  PKG_XF_SAGD200_INS_01\n");		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
		Object[][] bind = new Object[][] {
				{"IN", 			"", 						"A", 														""						},//직종
				{"IN", 			"", 						JSPUtil.rns(vo.get("PIS_YY")), 					""						},//년
				{"IN", 			"", 						JSPUtil.rns(vo.get("PIS_MM")), 					""						},//월
				{"IN", 			"", 						"0", 														""						},//
				{"IN",				"", 						JSPUtil.rns(p_box.get("vusrid")),					""						},//작업자
				{"IN/OUT", 		"PRO_CNT", 			JSPUtil.rns(vo.get("PRO_CNT")), 					String.valueOf(OracleTypes.VARCHAR)},//처리인원
				{"IN/OUT", 		"ERR_CNT", 				JSPUtil.rns(vo.get("ERR_CNT")), 					String.valueOf(OracleTypes.VARCHAR)},//예외인원
				{"IN/OUT", 		"PRO_STS", 			JSPUtil.rns(vo.get("PRO_STS")), 					String.valueOf(OracleTypes.VARCHAR)},//작업단계
				{"IN/OUT", 		"PRO_STS_MSG", 		"MSG", 													String.valueOf(OracleTypes.VARCHAR)} //작업완료메세지
		};

		//System.out.print(">>>>>>>>>>>>>>>>>>  PKG_XF_SAGD200_INS_02\n");	
		
		/** EXECUTEPROCEDURE 메소드 호출  **/
		CBox box = (CBox)this.executeProcedure(sql, bind, null);

	}



	/**
	 * 대상자 선정(작업 LOG 수정)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_02(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("SEQ")),
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("SEQ")),
				JSPUtil.rns(vo.get("PIS_YY")),
				JSPUtil.rns(vo.get("PIS_MM")),
				JSPUtil.rns(vo.get("SEQ")),
				JSPUtil.rns(vo.get("WOM_AMT")),//여직원회비
				JSPUtil.rns(p_box.get("vusrid")),//수정자
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 대상자 초기화 - 작업로그 대상자 선정 가능 상태로 변경
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_03(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PRO_STS")),//1
				"0",//PRO_CNT
				"0",//ERR_CNT
				JSPUtil.rns(p_box.get("vusrid")),//수정
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	/**
	 * PRO_STS : 2, 계산 초기화( 금액, 세액 계산으로 변경) - 작업로그 금액, 세액 계산 가능 상태로 변경
	 * PRO_STS : 6, 작업로그 작업CLOSE 상태로 변경
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_04(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PRO_STS")),				//2
				JSPUtil.rns(p_box.get("vusrid")),	//수정
				JSPUtil.rns(vo.get("PIS_YY")),	//pk
				JSPUtil.rns(vo.get("PIS_MM")),	//pk
				JSPUtil.rns(vo.get("SEQ")),		//pk
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 계산 초기화( 금액, 세액 계산으로 변경) - T_CP_PAYMASTER 계산금액 0으로 초기화
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_05(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_05");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),//수정
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 계산 초기화( 금액, 세액 계산으로 변경) - T_SV_SAVELIST(저축금관리목록) 계산 전으로 초기화
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_UPT_06(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_UPT_06");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("vusrid")),//수정
				JSPUtil.rns(vo.get("PIS_YY")+vo.get("PIS_MM")),
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	/**
	 * 대상자 초기화 - T_CP_PAYMASTER 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
	 * 대상자 초기화 - T_CP_PAYMASTER_OFFICE 삭제
	 * @param p_box
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL_01(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
	 * 계산 초기화( 금액, 세액 계산으로 변경) - T_CP_CHANGE 계산 전으로 초기화
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL_02(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
	 * 계산 초기화( 금액, 세액 계산으로 변경) - T_AC_LOAN(대출금/출자금) 계산 전으로 초기화
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL_03(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")),//pk
				JSPUtil.rns(vo.get("PIS_MM")),//pk
				JSPUtil.rns(vo.get("SEQ")),//pk
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}



	/**
	 * 계산 초기화( 금액, 세액 계산으로 변경) - T_SV_SAVEBOOK(저축금납입관리) 계산 전으로 초기화
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void SAGD030_DEL_04(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sag", "SAGD030_DEL_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("PIS_YY")+vo.get("PIS_MM")),
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}


}
