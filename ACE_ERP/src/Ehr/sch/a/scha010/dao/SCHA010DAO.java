package Ehr.sch.a.scha010.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class SCHA010DAO extends AbstractDAO {
	/**
	 * SCHA010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public SCHA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	
	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void SCHA010_SHR_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"scha010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"S"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}			
	
	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void SCHA010_INS_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"scha010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"I"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}		
	
	/**
	 * 개인정보처리 접속 기록 인사기록표 SELECT를 수행하는 DAO 메소드
	 */
	public void SCHA010_UPT_ACC(CBox p_box) throws CException {

		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"HR",
				"scha010",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"U"
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);		
		
	}			
	
	
	
	/**
	 * 학자금 신청서 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void SCHA010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("PIS_YY_SHR"))
               ,JSPUtil.rns(p_box.get("QUARTER_SHR"))
               ,JSPUtil.rns(p_box.get("ENO_NO"))
		};

		prop.add("IOC_GBN", ColumnProp.COLUMN_TYPE_STRING ,    1, ColumnProp.CONSTRAINT_TB_NOTNULL);
		prop.add("BIR_YMD", ColumnProp.COLUMN_TYPE_STRING ,    8, ColumnProp.CONSTRAINT_TB_NOTNULL);

		prop.add("RET_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("EDU_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("END_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("SCO_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("OTH_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("TOT_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PAY_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 사원 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void SCHA010_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**Added by DS
	 * 학자금 신청기간을 조회해 오는 DAO메소드
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet SCHA010_SHR_02(GauceValueObject vo, CBox p_box) throws CException {
        // 년과 월을 가져오기
        String PIS_YM[] = JSPUtil.rns(vo.get("PIS_YM")).split("-");

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_SHR_02");

		String pis_qq = "";
		int pis_mm = Integer.parseInt(PIS_YM[1]);

		if(pis_mm >= 1 && pis_mm<= 3){
			pis_qq = "1";
		}else if(pis_mm >= 4 && pis_mm<= 6){
			pis_qq = "2";
		}else if(pis_mm >= 7 && pis_mm<= 9){
			pis_qq = "3";
		}else if(pis_mm >= 10 && pis_mm<= 12){
			pis_qq = "4";
		}

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
            PIS_YM[0],
			pis_qq
		};

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 학자금 신청서를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void SCHA010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_INS");

		//System.out.println("p_box=============="+p_box);
		
		// 년과 월을 가져오기
		String PIS_YM[] = JSPUtil.rns(vo.get("PIS_YM")).split("-");

		// 대상자 주민번호 잘라서 생년월일/성별/나이 넣기
		int year = Integer.parseInt(JSPUtil.rns(p_box.get("vcurdate")).substring(0,4));

		String CET_NO  = JSPUtil.rns(vo.get("BIR_YMD"));

		String OLD_AGE;

		int birthyy = Integer.parseInt(CET_NO.substring(0,2));


		
			if(birthyy >= 00 && birthyy <= 30){
				OLD_AGE =  year - (1999 + birthyy) +""; // 나이
			}else{
				OLD_AGE =  year - (1899 + birthyy) +""; // 나이
			}



		String MF      = CET_NO.substring(7,8);

		String MF_TAG  = Integer.parseInt(MF)%2 == 1 ? "M" : "F";                 // 성별


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			JSPUtil.rns(vo.get("IOC_GBN")),
			JSPUtil.rns(vo.get("ENO_NO")),
            PIS_YM[0],
            PIS_YM[1],
            JSPUtil.rns(vo.get("PAY_YMD")).replaceAll("-", ""),
            JSPUtil.rns(vo.get("BIR_YMD")).replaceAll("-", ""),
			JSPUtil.rns(vo.get("OCC_CD")),
			JSPUtil.rns(vo.get("SEL_NM")),
			MF_TAG,
			OLD_AGE,
			JSPUtil.rns(vo.get("FSCH_CD")),
			JSPUtil.rns(vo.get("SCH_CD")),
			JSPUtil.rns(vo.get("SCH_NM")),
			JSPUtil.rns(vo.get("MAJ_NM")),
			JSPUtil.rns(vo.get("RET_AMT")),
			JSPUtil.rns(vo.get("EDU_AMT")),
			JSPUtil.rns(vo.get("END_AMT")),
			JSPUtil.rns(vo.get("SCO_AMT")),
			JSPUtil.rns(vo.get("OTH_AMT")),
			JSPUtil.rns(vo.get("TOT_AMT")),
			JSPUtil.rns(vo.get("PAY_AMT")),
			JSPUtil.rns(vo.get("FILE_KEY")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 학자금 신청서를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void SCHA010_UPT(GauceValueObject vo, CBox p_box) throws CException {
        // 년과 월을 가져오기
        String PIS_YM[] = JSPUtil.rns(vo.get("PIS_YM")).split("-");

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("FSCH_CD")),
				JSPUtil.rns(vo.get("SCH_NM")),
				JSPUtil.rns(vo.get("MAJ_NM")),
				JSPUtil.rns(vo.get("RET_AMT")),
				JSPUtil.rns(vo.get("EDU_AMT")),
				JSPUtil.rns(vo.get("END_AMT")),
				JSPUtil.rns(vo.get("SCO_AMT")),
				JSPUtil.rns(vo.get("TOT_AMT")),
				JSPUtil.rns(vo.get("PAY_AMT")),
				JSPUtil.rns(vo.get("FILE_KEY")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("IOC_GBN")),
				JSPUtil.rns(vo.get("ENO_NO")),
                PIS_YM[0],
                PIS_YM[1],
				JSPUtil.rns(vo.get("BIR_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("SEL_NM"))
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 첨부파일 정보를 수정하는  DAO메소드.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SCHA010_UPT_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_UPT_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("FILE_URL")),
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}
	/**
	 * 학자금 신청서를 삭제하는  DAO메소드.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void SCHA010_DEL(CBox p_box) throws CException {
        // 년과 월을 가져오기
        String PIS_YM[] = JSPUtil.rns(p_box.get("PIS_YM")).split("-");

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA010_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("IOC_GBN")),
				JSPUtil.rns(p_box.get("ENO_NO")),
                PIS_YM[0],
                PIS_YM[1],
				JSPUtil.rns(p_box.get("BIR_YMD").replaceAll("-", "")),
				JSPUtil.rns(p_box.get("SEL_NM"))
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

}
