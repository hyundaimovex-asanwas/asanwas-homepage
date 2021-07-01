package Ehr.gun.a.guna071.dao;

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

import Ehr.common.util.DateUtil;
import Ehr.common.util.JSPUtil;

public class GUNA071DAO extends AbstractDAO {

	/**
	 * GUNA071DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA071DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 결재세부사항 조회(변경신청) 조회
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA071_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 결재세부사항 조회(일일근태) 조회
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA071_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};


		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * 결재세부사항 조회(익월근태) 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_PLAN(CBox p_box) throws CException {


        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;

        String str_ym_val   = REQ_NO.substring(0,6)+"01";
        
        String str_ymd      = DateUtil.getAfterDate(str_ym_val, 0,1,0).substring(0,4) + "-" + DateUtil.getAfterDate(str_ym_val, 0,1,0).substring(4,6);


        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sqlCnt = XmlSqlUtils.getSQL("gun", "GUNB020_SHR_PLAN_04");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bindCnt = new Object[] {
                str_ym_val  ,str_ym_val
        };

        GauceDataSet gs = this.selectProcess(sqlCnt, bindCnt, prop);

        String day_val     = "";
        String month_val = "";
        StringBuffer sb    = new StringBuffer();
        GauceDataRow grRead = null; // 조회될 row

        for ( int i = 0; i < gs.getDataRowCnt(); i++) {
            grRead  = gs.getDataRow(i);     // fetch 된 row
            month_val = grRead.getString(0).substring(0,2);
            day_val = grRead.getString(0).substring(2,4);
            if ( grRead.getString(0).substring(2,3).equals("0") ){
                day_val = grRead.getString(0).substring(3,4);
            }
            sb.append(", MAX(DECODE(PIS_MM,"+month_val+",AT"+day_val+"_CD))");
        }


        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_PLAN_01");

        Object[] sqlParam = new Object[] {
                  sb.toString()
        };

            /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
            sql = SqlUtils.replaceQuery(sql, sqlParam);
        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
        		str_ymd,

                str_ymd,
                str_ymd,
                str_ymd,
                str_ymd,

                str_ymd,
                str_ymd,

        		REQ_NO
        };
        prop.add("HOL_GUB", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("NYRP_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 2.1, ColumnProp.CONSTRAINT_TB_NORMAL);
        prop.add("REM_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 2.1, ColumnProp.CONSTRAINT_TB_NORMAL);

        /** SELECT메소드 호출 **/
        return this.selectProcess(sql, bind, prop);

	}

    /**
     * 휴가계획 관리 테이블을 이용해 해당 달의 연차 및 휴가에 관한 합계를 구해온다
     * @param p_box	CBox
     * @throws CException
     */
    public GauceDataSet  GUNA071_SHR_PLAN_01(CBox p_box) throws CException {
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String str_ymd_val  = REQ_NO.substring(0,4) + REQ_NO.substring(4,6)+"01";

        /** 외부 XML에서 SQL을 읽어 온다 **/
        String sql = XmlSqlUtils.getSQL("gun", "GUNB020_SHR_PLAN_04");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
        Object[] bind = new Object[] {
                  str_ymd_val
                , str_ymd_val
        };

        /** SELECT메소드 호출 **/
        GauceDataSet gs = this.selectProcess(sql, bind, prop);
        prop.add("HOL_YN", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
        return gs;
    }



	/**
	 * 결재 처리내용을 반영(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_UPT(CBox p_box, GauceValueObject vo) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("APP_YN"),
				JSPUtil.rns(vo.get("APP_CMT")),				//비고 -> 필드전용  Container 역할
				p_box.get("vusrid"),
				p_box.get("SEQ_NO"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
	 * 동일 등록번호의 결재한개수세기(최종 T_DI_DILIGENCE)(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public GauceDataSet GUNA071_CNT(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_CNT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN"),
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};

		/** UPDATE메소드 호출  **/
		return selectProcess(sql, bind);
	}
	/**
	 * T_DI_DILIGENCE 에 반영(공통)
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_UPT_01(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

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
	 * 일일근태템프데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		
		return gs;
		
	}


	
	
	/**
	 * 변경데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_05(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_05");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("PENO_NO")
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}

	/**
	 * 근태총계를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void GUNA071_UPT_02(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "";
		if("".equals(JSPUtil.rns(GUN_CD))){
			return;
		}

		if("A".equals(GUN_CD)) COLNAME="ATT_A";
		else if("B".equals(GUN_CD)) COLNAME="ATT_B";
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

		sb.append(COLNAME +"= DECODE("+COLNAME+", null, 0, 0, 0, "+COLNAME+"-1),");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);

		//System.out.println("총계 구하는 마이너스 sql [" + sql + "]");
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
	public void GUNA071_UPT_03(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "";
		
		if("".equals(JSPUtil.rns(GUN_CD))){
			return;
		}
		
		if(GUN_CD.equals("E")) COLNAME="ATT_E";
		else if(GUN_CD.equals("F")) COLNAME="ATT_F";
		else if(GUN_CD.equals("G")) COLNAME="ATT_G";
		else if(GUN_CD.equals("H")) COLNAME="ATT_H";
		else if(GUN_CD.equals("I")) COLNAME="ATT_I";
		else if(GUN_CD.equals("M")) COLNAME="ATT_M";
		else if(GUN_CD.equals("P")) COLNAME="ATT_P";
		else if(GUN_CD.equals("R")) COLNAME="ATT_R";
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
	 * T_DI_MONTHLY 에 반영
	 */
	public void GUNA071_UPT_05(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_05");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				
				ENO_NO
				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	
	
	/**
	 * T_DI_MONTHLY_HISTORY 에 반영
	 */
	public void GUNA071_UPT_06(String PIS_YYMMDD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_06");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {

				ENO_NO,
				PIS_YYMMDD,
				ENO_NO,
				
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	
	
	
	
	
	
	/**
	 * T_DI_DILIGENCE_IND 에 반영
	 */
	public void GUNA071_UPT_0400(CBox p_box, String APP_YN) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_0400");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO"),
				p_box.get("PENO_NO")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	
	
	
	
	/**
	 * T_DI_CHANGE 에 반영
	 */
	public void GUNA071_UPT_0401(CBox p_box, String APP_YN) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_0401");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO"),
				p_box.get("PENO_NO")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	/**
	 *T_DI_PLAN 에 반영

	 */
	public void GUNA071_UPT_0402(CBox p_box, String APP_YN) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_0402");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO"),
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	/**
	 * T_DI_ACCELERATE 에 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_UPT_0403(CBox p_box, String APP_YN) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_0403");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				APP_YN,
				p_box.get("vusrid"),
				p_box.get("REQ_NO")
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);

	}
	/**
	 * T_DI_DILIGENCE 에 없는데이터를 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_INS_01(CBox p_box, String PIS_YYMMDD) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_INS_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				PIS_YYMMDD.substring(0,4),
				p_box.get("PENO_NO"),
				p_box.get("DPT_CD"),
				PIS_YYMMDD.substring(0,4),
				p_box.get("vusrid"),
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0,4),
				p_box.get("PENO_NO"),
		};

		/** UPDATE메소드 호출  **/
		insertProcess(sql, bind);

	}
	/**
	 * T_DI_DILIGENCE_DTL 에 INSERT OR UPDATE 데이터를 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_INS_02(String PIS_YYMMDD, String ENO_NO, String REMARK, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_INS_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				Integer.parseInt(PIS_YYMMDD.substring(6))+"",
				ENO_NO,
				REMARK,
				p_box.get("vusrid"),
				PIS_YYMMDD.substring(0, 4),
				PIS_YYMMDD.substring(4, 6),
				Integer.parseInt(PIS_YYMMDD.substring(6))+"",
				ENO_NO,
				REMARK,
				p_box.get("vusrid"),
				p_box.get("vusrid"),
		};

		/** UPDATE메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 익월근태에서 T_DI_DILIGENCE에 반영할 데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_PLAN_02(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYYMM = DateUtil.getAfterDate(REQ_NO.substring(0,8), 0,1,0);
        String YYYY   = YYYYMM.substring(0,4);
        String MM     = YYYYMM.substring(4,6);
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_PLAN_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				YYYY,
				MM,
				REQ_NO
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}
	/**
	 * 익월근태에서 T_DI_DILIGENCE에 반영할 데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_PLAN_03(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYYMM = DateUtil.getAfterDate(REQ_NO.substring(0,8), 0,1,0);
        String YYYY   = YYYYMM.substring(0,4);
        String MM     = YYYYMM.substring(4,6);
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_PLAN_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				YYYY,
				MM,
				REQ_NO
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}
	/**
	 * T_DI_DILIGENCE 에 없는데이터를 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_INS_PLAN_01(String eno_no, String dpt_cd, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_INS_01");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYYMMDD = DateUtil.getAfterDate(REQ_NO.substring(0,8), 0,1,0);
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				YYYYMMDD.substring(0,4),
				eno_no,
				dpt_cd,
				YYYYMMDD.substring(0,4),
				p_box.get("vusrid"),
				p_box.get("vusrid"),
				YYYYMMDD.substring(0,4),
				eno_no,
		};

		/** UPDATE메소드 호출  **/
		insertProcess(sql, bind);

	}
	/**
	 * T_DI_DILIGENCE 에 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_UPT_PLAN_01(String PIS_YY, String PIS_MM, String DD, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_UPT_01");
		String COLNAME = "AT"+Integer.parseInt(DD)+"_CD";
		StringBuffer sb = new StringBuffer();

		sb.append(COLNAME +"= '"+GUN_CD+"',");

		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				p_box.get("vusrid"),
				PIS_YY,
				PIS_MM,
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
	public void GUNA071_UPT_PLAN_02(String PIS_YY, String PIS_MM, String ENO_NO, String GUN_CD, CBox p_box) throws CException {

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
				PIS_YY,
				PIS_MM,
				ENO_NO,
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}


	/**
	 *연차휴가사용촉진제  조회용  DAO메소드(전체)
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND071_SHR_ACC_01(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_03");
		
		String eno_no = JSPUtil.rns(p_box.get("ENO_NO"));
		String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO"));
		String YYYY   = REQ_NO.substring(0,4);

		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				YYYY,
				YYYY,
				"",
				YYYY,
				YYYY,
				mm1,
				REQ_NO,//p_box.get("REQ_GBN"),//전체가 나오게 한
				YYYY,
				mm2,
				REQ_NO,//p_box.get("REQ_GBN"),//전체가 나오게 한
				YYYY,
				mm3,
				REQ_NO,//p_box.get("REQ_GBN"),//전체가 나오게 한
		};

		prop.add("END_TAG", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("YRP_REM", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REM_CNT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_OCT", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_NOV", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ATT_DEC", ColumnProp.COLUMN_TYPE_DECIMAL, 3.1, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);

	}
	/*
	 *근태휴일날짜  조회용  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet GUND071_SHR_ACC_02(CBox p_box) throws CException {
		String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO"));
		String YYYY   = REQ_NO.substring(0,4);
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND020_SHR_01");

		String pis_mm = JSPUtil.rns(p_box.get("PIS_MM"));
		String  mm1 = pis_mm.substring(0,2);
		String  mm2 = pis_mm.substring(2,4);
		String  mm3 = pis_mm.substring(4,6);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				YYYY+mm1+"01",
				YYYY+mm3+"31"
		};

		/**Query  실행 후 자료 결과값을 Return  **/
		return this.selectProcess(sql, bind, prop);

	}
	/**
	 * 연차촉진제에서 T_DI_DILIGENCE에 반영할 데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_ACC_03(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYYMM = DateUtil.getAfterDate(REQ_NO.substring(0,8), 0,1,0);
        String YYYY   = YYYYMM.substring(0,4);
        String MM     = YYYYMM.substring(4,6);
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_ACC_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				YYYY,
				REQ_NO
		};


		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}



	/**
	 * T_DI_DILIGENCE 에 없는데이터를 반영
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void GUNA071_INS_ACC_01(String eno_no, String dpt_cd, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_INS_01");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYY = REQ_NO.substring(0,4);
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다  **/
		Object[] bind = new Object[] {
				YYYY,
				eno_no,
				dpt_cd,
				YYYY,
				p_box.get("vusrid"),
				p_box.get("vusrid"),
				YYYY,
				eno_no
		};

		/** UPDATE메소드 호출  **/
		insertProcess(sql, bind);

	}
	/**
	 * 휴가촉진제에서 T_DI_DILIGENCE에 반영할 데이터 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUNA071_SHR_ACC_02(CBox p_box) throws CException {
        String dpt_cd  = p_box.get("DPT_CD");
        String REQ_NO = JSPUtil.rns(p_box.get("REQ_NO")) ;
        String YYYY   = REQ_NO.substring(0,4);
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_ACC_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				YYYY,
				REQ_NO
		};

		GauceDataSet gs = this.selectProcess(sql, bind, prop);
		return gs;
	}
	/**
	 * 결재자 조회
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA071_SHR_APP(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA071_SHR_APP");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO"),
				p_box.get("GUN_GBN")
		};



		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

}

