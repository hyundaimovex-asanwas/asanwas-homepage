package Ehr.gun.a.guna013.dao;

import com.gauce.GauceDataColumn;
import com.gauce.GauceDataRow;
import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.GauceUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class GUNA013DAO extends AbstractDAO {
	/**
	 * GUNA013DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA013DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}
	/**
	 * 목록를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_LST(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_LST");

		String STR_YMD_SHR  = JSPUtil.rns(p_box.get("STR_YMD_SHR").replaceAll("-", ""));
		String END_YMD_SHR  = JSPUtil.rns(p_box.get("END_YMD_SHR").replaceAll("-", ""));
		String GUN_CD_SHR  = JSPUtil.rns(p_box.get("GUN_CD_SHR"));
		String ENO_NO_SHR = JSPUtil.rns(p_box.get("ENO_NO_SHR"));
		
		if("0".equals(GUN_CD_SHR)){
			GUN_CD_SHR = "";
		}

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				ENO_NO_SHR,

				STR_YMD_SHR,
				END_YMD_SHR,
				ENO_NO_SHR
        };
		prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 30, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_A_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_Y_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN_N_CNT", ColumnProp.COLUMN_TYPE_INTEGER, 2, ColumnProp.CONSTRAINT_TB_NORMAL);
		return this.selectProcess(sql, bind, prop);
	}
	
	/**
	 * 개인의 근태현황을 조회하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_00");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO_SHR"))
		};
		prop.add("BF_REMARK", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BF_YMD", ColumnProp.COLUMN_TYPE_STRING, 12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BF_GUN_CD", ColumnProp.COLUMN_TYPE_STRING, 12, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("BF_GUN_NM", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("AF_GUN_NM", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("AF_REMARK", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;

	}
	
	/**
	 * 날짜로 근태코드를 조회하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_CD(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_CD");
		String PIS_YYMMDD = JSPUtil.rns(p_box.get("PIS_YYMMDD"));
		String YYYY = PIS_YYMMDD.substring(0,4);
		String MM = PIS_YYMMDD.substring(4,6);
		String ENO_NO = JSPUtil.rns(p_box.get("ENO_NO"));


		String COLNAME = "AT"+Integer.parseInt(PIS_YYMMDD.substring(6,8))+"_CD AS GUN_CD";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME );

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				YYYY,
				MM,
				ENO_NO,
				PIS_YYMMDD.substring(6,8)

		};
		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		prop.add("GUN_CD", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		return gs;

	}
	
	/**
	 * 결재선을 조회 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 조회권한 CHECK 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_01");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO_SHR"))
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}

	/**
	 * 결재선을 조회 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_01(String REQ_NO) throws CException {

		/** 외부 XML에서 조회권한 CHECK 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				REQ_NO
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}

	/**
	 * 근태변경신청서를 저장 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA013_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

				JSPUtil.rns(vo.get("REQ_NO")),

				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("BF_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("CHN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("BF_GUN_CD")),
				JSPUtil.rns(vo.get("BF_REMARK")),
				JSPUtil.rns(vo.get("AF_GUN_CD")),
				"",
				JSPUtil.rns(vo.get("AF_REMARK")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 결재선을 저장 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA013_INS_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_INS_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("DPT_CD")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(vo.get("PENO_NO")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("REQ_NO"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 해당부서의 근태현황을 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA013_UPT(GauceValueObject vo, CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_UPT");

		StringBuffer sb = new StringBuffer();

		Object[] sqlParam = new Object[] {};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

		Object[] bind = new Object[] {

			JSPUtil.rns(vo.get("CHN_YMD")).replaceAll("-", ""),
			JSPUtil.rns(vo.get("AF_GUN_CD")),
			JSPUtil.rns(vo.get("AF_REMARK")),
			JSPUtil.rns(p_box.get("vusrid")),

			JSPUtil.rns(p_box.get("REQ_NO")),
			JSPUtil.rns(vo.get("ENO_NO")),
			JSPUtil.rns(vo.get("BF_YMD")).replaceAll("-", "")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 근태변경신청서를 삭제하는  DAO메소드.
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void GUNA013_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO")),                        //신청번호
				JSPUtil.rns(p_box.get("ENO_NO")),                        //사원번호
				JSPUtil.rns(p_box.get("REQ_YMD")).replaceAll("-", ""),   //신청일자
				JSPUtil.rns(vo.get("CHN_YMD")).replaceAll("-", ""),      //변경요청일
		};

		/** DELETE메소드 호출 **/
		deleteProcess(sql, bind);
	}

    /**
     * 근태결재목록 삭제 DAO메소드
     * @param vo
     * @param p_box
     * @throws CException
     */
 	public void GUNA013_DEL_02(GauceValueObject vo, CBox p_box) throws CException {


		/**외부 XML에서 SQL을 읽어온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_DEL_02");

        /** SQL에 바인딩 될 값을 순차적으로 넣어준다 **/
        Object[] bind = new Object[] {
        		JSPUtil.rns(p_box.get("REQ_NO")),                         //신청번호
        };

        /** DELETE메소드 호출 **/
        deleteProcess(sql, bind);
	}



	/**
	 * 결재선을 저장 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA013_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_UPT_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO")),
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(vo.get("JOB_CD")),
				JSPUtil.rns(p_box.get("vusrid")),

				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("GUN_DPT")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("PENO_NO")),

		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	//부결여부 조회
	public GauceDataSet GUNA013_SHR_02(GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("GUN_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("GUN_GBN")),
				JSPUtil.rns(vo.get("GUN_DPT")),
				JSPUtil.rns(vo.get("SEQ_NO")),
				JSPUtil.rns(vo.get("PENO_NO")),
		};

		return this.selectProcess(sql, bind, prop);
	}

	//신청번호 생성
	public GauceDataSet GUNA013_SHR_03(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ENO_NO")),
				JSPUtil.rns(p_box.get("REQ_YMD")).replaceAll("-", ""),
				JSPUtil.rns(vo.get("CHN_YMD")).replaceAll("-", ""),
		};

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 조회시 결재선이 지정되어 있지 않으면 최근 결재선 가져오고 없으면 부서장 자동지정
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA013_SHR_04(CBox p_box) throws CException {

		/** 외부 XML에서 조회권한 CHECK 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_04");

		String STR_YMD_SHR  = JSPUtil.rns(p_box.get("STR_YMD_SHR"));
		String END_YMD_SHR  = JSPUtil.rns(p_box.get("END_YMD_SHR"));
		String ENO_NO_SHR  = JSPUtil.rns(p_box.get("ENO_NO_SHR"));

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				ENO_NO_SHR,
				STR_YMD_SHR,
				END_YMD_SHR
		};


        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 결재선 삭제
	 * @param vo
	 * @throws CException
	 */
	public void GUNA013_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_DEL_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
	 * 신청번호 조회
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA013_SHR_05(CBox p_box) throws CException {
		String STR_YMD_SHR  = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR  = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String ENO_NO_SHR  = JSPUtil.rns(p_box.get("ENO_NO_SHR"));
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_05");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				ENO_NO_SHR,
				STR_YMD_SHR,
				END_YMD_SHR
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 등록번호의 MaxPlusOne 하는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public String GUNA013_SHR_MAX() throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_REG_MAX");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

		};

		GauceDataSet ds = selectProcess(sql, bind);
		String reg_no = GauceUtils.nameValue(ds, 1, "REQ_NO");
		return reg_no;
	}

	/**
	 * 지난 근태사항을 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUNA013_SHR_06(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA013_SHR_06");

		String ENO_NO_SHR = JSPUtil.rns(p_box.get("ENO_NO"));

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				ENO_NO_SHR
        };
		prop.add("PIS_YMD", ColumnProp.COLUMN_TYPE_STRING, 8, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("GUN_CD", ColumnProp.COLUMN_TYPE_STRING, 2, ColumnProp.CONSTRAINT_TB_NORMAL);

		return this.selectProcess(sql, bind, prop);
	}
}
