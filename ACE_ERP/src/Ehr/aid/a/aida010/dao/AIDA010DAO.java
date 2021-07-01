package Ehr.aid.a.aida010.dao;

import java.io.FileOutputStream;
import java.io.IOException;

import oracle.jdbc.OracleTypes;

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

import Ehr.common.util.CommUtil;
import Ehr.common.util.JSPUtil;

public class AIDA010DAO extends AbstractDAO {
	/**
	 * AIDA010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public AIDA010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}


	/**
     * 값이 이미 들어 있는지 여부를 검증함
     * @param vo
     * @return
     * @throws CException
	 */
	public int AIDA010_CHK(GauceValueObject vo) throws CException {
		
	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_CHK");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(vo.get("REQ_NO"))
	    };

	    GauceValueObject rstVO = this.selectProcessGvo(sql, bind);
        return rstVO.get(0).getInt("CNT");
	}

    /**
     * 결재자 정보가 이미 들어 있는지 여부를 검증함
     * @param vo
     * @return
     * @throws CException
     */
	public int AIDA010_CHK_01(GauceValueObject vo) throws CException {
	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_CHK_01");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(vo.get("ORD_NO"))
	    };

	    GauceValueObject rstVO = this.selectProcessGvo(sql, bind);
	    return rstVO.get(0).getInt("CNT");
	}

    /**
     * 경공조금 결재자 2명 다 결재했는지 여부 파악한다
     * @param vo
     * @return
     * @throws CException
     */
	public int AIDA010_CHK_02(GauceValueObject vo) throws CException {
	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_CHK_02");

	    System.out.print(vo);
	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(vo.get("REQ_NO"))
	    };

	    GauceValueObject rstVO = this.selectProcessGvo(sql, bind);
	    return rstVO.get(0).getInt("CNT");
	}
	/**
	 * 경공조금 신청서 정보를 조회해 오는 DAO메소드 -> 기존
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
               ,JSPUtil.rns(p_box.get("ENO_NO_SHR"))
               ,JSPUtil.rns(p_box.get("REQ_YMD_STDT_SHR")).replaceAll("-", "")
               ,JSPUtil.rns(p_box.get("REQ_YMD_ENDT_SHR")).replaceAll("-", "")
               ,JSPUtil.rns(p_box.get("AID_STS_SHR"))
        };

		prop.add("HLP1_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("HLP2_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);

		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * 사원 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
		        JSPUtil.rns(p_box.get("ENO_NO"))
		};

        //prop.add("LSE_YY", ColumnProp.COLUMN_TYPE_STRING, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        //prop.add("LSE_MM", ColumnProp.COLUMN_TYPE_STRING, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		//prop.add("LSE_YY", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);		
		//prop.add("LSE_MM", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		
		this.selectProcessFirstRow(sql, bind, prop);
	}
	/**
	 * 권한 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			JSPUtil.rns(p_box.get("vusrid"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 신청자에 해당하는 지급금액을 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_03(CBox p_box) throws CException {
		
		// 신청일자(REQ_NO)를 기준으로 근속 년월일 구하는 메서드
		String yyyymmdd = JSPUtil.Gunsok_Date( JSPUtil.rns(p_box.get("HIR_YMD")).replaceAll("-", ""), JSPUtil.rns(p_box.get("REQ_YMD")).replaceAll("-", "") );

		int year = Integer.parseInt(yyyymmdd.substring(0,4));
		int month = Integer.parseInt(yyyymmdd.substring(5,6));


		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_03");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			year+"",
			month+"",
			JSPUtil.rns(p_box.get("AID_CD")),
			year+"",
			JSPUtil.rns(p_box.get("JOB_CD"))
		};

		this.selectProcessFirstRow(sql, bind, prop);
	}


	/**
	 * 신청번호(REQ_NO)에 해당하는 신청서를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet AIDA010_SHR_04(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))
		};

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 입력한 결재자 정보를 조회 한다.
	 * @param p_box	CBox
	 * @throws CException
	 */
	public GauceDataSet AIDA010_SHR_05(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_05");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("REQ_NO"))
	    };

        prop.add("APP_YN_NM", ColumnProp.COLUMN_TYPE_STRING, 20.0, ColumnProp.CONSTRAINT_TB_NORMAL);
        
	    return this.selectProcess(sql, bind, prop);
	    
	}
	/**
	 * 사원 정보를 조회해 오는 DAO메소드 =  신청목록(A2중심) 2009.12.24 By KHS
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_06(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_06");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                ,JSPUtil.rns(p_box.get("ENO_NO_SHR"))
                ,JSPUtil.rns(p_box.get("REQ_YMD_STDT_SHR")).replaceAll("-", "")
                ,JSPUtil.rns(p_box.get("REQ_YMD_ENDT_SHR")).replaceAll("-", "")
                ,JSPUtil.rns(p_box.get("AID_STS_SHR"))
         };

 		prop.add("HLP1_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);
 		prop.add("HLP2_AMT", ColumnProp.COLUMN_TYPE_DECIMAL, 10.0, ColumnProp.CONSTRAINT_TB_NORMAL);

 		this.selectProcessFirstRow(sql, bind, prop);
 	}
	/**
	 * 근속년수를 조회해 옴
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_LSE(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_LSE");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("STR_YMD")).replaceAll("-", ""),
	            JSPUtil.rns(p_box.get("END_YMD")).replaceAll("-", "")

	    };

	    this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * 
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_PRINT0(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_PRINT0");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))
	    };

	    this.selectProcessFirstRow(sql, bind, prop);
	}		
	
	/**
	 * 
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_SHR_PRINT(CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_SHR_PRINT");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("REQ_NO"))
	    };

	    this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	
	/**
	 * 경공조금 신청서를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			JSPUtil.rns(vo.get("REQ_NO")),
			JSPUtil.rns(vo.get("ENO_NO")),
			JSPUtil.rns(vo.get("OCC_CD")),
			JSPUtil.rns(vo.get("DPT_CD")),
			JSPUtil.rns(vo.get("JOB_CD")),
			JSPUtil.rns(vo.get("LSE_YY")),
			JSPUtil.rns(vo.get("LSE_MM")),
			JSPUtil.rns(vo.get("ABA_CD")),
			JSPUtil.rns(vo.get("ACC_NO")),
			JSPUtil.rns(vo.get("REC_NM")),
			JSPUtil.rns(vo.get("AID_CD")),
			JSPUtil.rns(vo.get("AID_NM")),
			JSPUtil.rns(vo.get("AID_YMD").replaceAll("-", "")),
			JSPUtil.rns(vo.get("AID_RPT")),
			JSPUtil.rns(vo.get("REQ_YMD").replaceAll("-", "")),
			JSPUtil.rns(vo.get("HLP1_AMT")),
			JSPUtil.rns(vo.get("HLP2_AMT")),
			JSPUtil.rns(vo.get("AID_CET")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(vo.get("FILE_KEY"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 경공조금 신청서를 수정하고, 결재정보를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_INS_01(GauceValueObject vo, CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_INS_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ORD_NO"))
			   ,JSPUtil.rns(vo.get("ENO_NO"))
			   ,JSPUtil.rns(vo.get("ENO_NM"))
			   ,JSPUtil.rns(vo.get("DPT_CD"))
			   ,JSPUtil.rns(vo.get("JOB_CD"))
			   ,JSPUtil.rns(vo.get("AUTHO_CD"))
               ,JSPUtil.rns(vo.get("APP_YN"))
               ,JSPUtil.rns(vo.get("ARR_TIME"))
			   ,JSPUtil.rns(vo.get("ENO_NO"))
			   ,JSPUtil.rns(p_box.get("vusrid"))
			   ,JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 경공조금 신청서를 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("ABA_CD")),
				JSPUtil.rns(vo.get("ACC_NO")),
				JSPUtil.rns(vo.get("REC_NM")),
				JSPUtil.rns(vo.get("AID_CD")),
				JSPUtil.rns(vo.get("AID_NM")),
				JSPUtil.rns(vo.get("AID_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("REQ_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("HLP1_AMT")),
				JSPUtil.rns(vo.get("HLP2_AMT")),
				JSPUtil.rns(vo.get("SPL_YMD").replaceAll("-", "")),
				JSPUtil.rns(vo.get("AID_CET")),
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("FILE_KEY")),
				JSPUtil.rns(vo.get("REQ_NO")),
		};

		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

    /**
     * 경공조금 정보를 수정 한다.
     * @param vo
     * @param p_box
     * @throws CException
     */
	public void AIDA010_UPT_01(GauceValueObject vo, CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT_01");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("AID_STS"))
               ,JSPUtil.rns(vo.get("AID_STS"))
               ,JSPUtil.rns(vo.get("RET_RSN"))
               ,JSPUtil.rns(p_box.get("vusrid"))
               ,JSPUtil.rns(vo.get("REQ_NO"))
	    };

	    /** UPDATE메소드 호출  **/
	    updateProcess(sql, bind);
	}
    /**
     * 경공조금 정보를 수정 한다. 2명 다 결재 완료 OK
     * @param vo
     * @param p_box
     * @throws CException
     */
	public void AIDA010_UPT_OK(GauceValueObject vo, CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT_OK");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid"))
               ,JSPUtil.rns(vo.get("REQ_NO"))
	    };

	    /** UPDATE메소드 호출  **/
	    updateProcess(sql, bind);
	}

	/**
     * 결재정보를 수정한다.
     * @param vo
     * @param p_box
     * @param autho_cd
     * @throws CException
	 */
	public void AIDA010_UPT_02(GauceValueObject vo, CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT_02");
	    

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
	            JSPUtil.rns(p_box.get("APP_YN"))
               ,JSPUtil.rns(p_box.get("vusrid"))
	           ,JSPUtil.rns(vo.get("REQ_NO"))
	           ,JSPUtil.rns(p_box.get("vusrid"))
	    };

	    /** UPDATE메소드 호출  **/
	    updateProcess(sql, bind);
	}

	/**
     * 2차 결재자 미결재 상태로  변경 수정한다.
     * @param vo
     * @param p_box
     * @param autho_cd
     * @throws CException
	 */
	public void AIDA010_UPT_02_NEXT(GauceValueObject vo, CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_UPT_02_NEXT");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/

		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("vusrid"))
	           ,JSPUtil.rns(vo.get("REQ_NO"))
	           ,JSPUtil.rns(vo.get("REQ_NO"))
	           ,JSPUtil.rns(p_box.get("vusrid"))
	    };

	    /** UPDATE메소드 호출  **/
	    updateProcess(sql, bind);
	}
	/**
	 * 경공조금 신청서를 삭제하는  DAO메소드.
     * @param vo
     * @param p_box
	 * @throws CException
	 */
	public void AIDA010_DEL(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_DEL");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("REQ_NO")),
				JSPUtil.rns(p_box.get("vusrid"))
		};

		/** DELETE메소드 호출  **/
		deleteProcess(sql, bind);
	}

	/**
     * 등록한 결재자 내역을 삭제한다.
     * @param vo
     * @param p_box
     * @throws CException
	 */
	public void AIDA010_DEL_01(GauceValueObject vo, CBox p_box) throws CException {

	    /** 외부 XML에서 SQL을 읽어 온다 **/
	    String sql = XmlSqlUtils.getSQL("aid", "AIDA010_DEL_01");

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
	    Object[] bind = new Object[] {
                JSPUtil.rns(vo.get("ORD_NO"))
	    };

	    /** DELETE메소드 호출  **/
	    deleteProcess(sql, bind);
	}

	/**
     * 경공조금 신청건에 대한 유효성 검증
     * @param p_box
     * @param vo
     * @return - 결과 메세지
     * @throws CException
	 */
    public String PROC_CHK(CBox p_box, GauceValueObject vo) throws CException {

        /** 경공조금 신청건 **/
        String sql = "{ call ASNHR.PKG_XF_AIDA010.PROC_CHK(?, ?, ?, ?, ?, ?, ?, ?) }";

        /*
        System.out.println(JSPUtil.rns(vo.get("ENO_NO")));
        System.out.println(JSPUtil.rns(vo.get("AID_CD")));
        System.out.println(JSPUtil.rns(vo.get("AID_CET")));
        System.out.println(JSPUtil.rns(vo.get("AID_NM")));
        System.out.println(JSPUtil.rns(vo.get("AID_YMD")));
        System.out.println(JSPUtil.rns(vo.get("REQ_YMD")));
        System.out.println(JSPUtil.rns(vo.get("ACC_NO")));
         */

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {
                {"IN",      "",         JSPUtil.rns(vo.get("ENO_NO"))       },
                {"IN",      "",         JSPUtil.rns(vo.get("AID_CD"))       },
                {"IN",      "",         JSPUtil.rns(vo.get("AID_CET"))      },
                {"IN",      "",         JSPUtil.rns(vo.get("AID_NM"))       },
                {"IN",      "",         JSPUtil.rns(vo.get("AID_YMD")).replaceAll("-", "")      },
                {"IN",      "",         JSPUtil.rns(vo.get("REQ_YMD")).replaceAll("-", "")      },
                {"IN",      "",         JSPUtil.rns(vo.get("ACC_NO"))       },

                {"OUT",     "RESULT_MSG"    ,""     ,String.valueOf(OracleTypes.VARCHAR)} //작업완료메세지
        };

        System.out.println(  JSPUtil.rns(vo.get("ENO_NO"))                      +"\n"
                +JSPUtil.rns(vo.get("AID_CD"))                      +"\n"
                +JSPUtil.rns(vo.get("AID_CET"))                     +"\n"
                +JSPUtil.rns(vo.get("AID_YMD")).replaceAll("-", "") +"\n"
                +JSPUtil.rns(vo.get("REQ_YMD")).replaceAll("-", "") +"\n"
                +JSPUtil.rns(vo.get("ACC_NO"))                      +"\n"
               );

        /** EXECUTEPROCEDURE 메소드 호출  **/
        CBox box = (CBox)this.executeProcedure(sql, bind, null);
        return box.getString("RESULT_MSG");
    }


	/**
	 * 경공조금 전표 처리
	 * @param p_box
	 * @throws CException
	 */
	public void PROC_D(CBox p_box) throws CException {

	    /** 경공조금 지급 처리  **/
	    String sql = "{ call ASNHR.PKG_XF_AIDA010.PROC_D(?, ?) }";

	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
	    Object[][] bind = new Object[][] {
	            {"IN",      "",         JSPUtil.rns(p_box.get("REQ_NO"))        },
	            {"IN",      "",         JSPUtil.rns(p_box.get("vusrid")) }
	    };

	    /** EXECUTEPROCEDURE 메소드 호출  **/
	    this.executeProcedure(sql, bind, null);
	}

    /**
     * 경공조금 지급 처리
     * @param p_box
     * @throws CException
     */
    public void PROC_E(CBox p_box) throws CException {

        /** 경공조금 지급 처리  **/
        String sql = "{ call ASNHR.PKG_XF_AIDA010.PROC_E(?, ?, ?) }";

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (조건대상) **/
        Object[][] bind = new Object[][] {
                {"IN",      "",         JSPUtil.rns(p_box.get("REQ_NO"))                        },
                {"IN",      "",         JSPUtil.rns(p_box.get("SPL_YMD")).replaceAll("-", "")   },
                {"IN",      "",         JSPUtil.rns(p_box.get("vusrid"))                 }
        };

        /** EXECUTEPROCEDURE 메소드 호출  **/
        this.executeProcedure(sql, bind, null);
    }

    /// 이하 전표 발생에 관한것들.....
	/**
	 * 전표 발생에 필요한 변수값을 가져옴 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet AIDA010_PRC_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_PRC_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("REQ_NO")
		};

		return this.selectProcess(sql, bind, prop);
	}

	/**
	 * 결재에 필요한 변수값을 가져옴 조회
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet AIDA010_PRC_SHR_02(GauceDataSet ds) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("sch", "SCHA030_PRC_SHR_03");


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(GauceUtils.nameValue(ds, 1, 	"FILE_KEY"))
        };

		return this.selectProcess(sql, bind, prop);
	}

	/**
     * 경조금신청Table에 경조금신청정보 Update DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void AIDA010_PRC_UPT_01(CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA010_PRC_UPT_01");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("WRK_NO1"),
				p_box.get("REQ_NO")
		};

		/** DELETE메소드 호출  **/
		this.updateProcess(sql, bind);

	}



	/**
     * 전표발생시에 만들어줄 html
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void AIDA010_PRC_MAKE_HTML(CBox p_box,GauceDataSet ds, GauceDataSet dsDecision, GauceDataSet dsFile) throws CException {

		String REQ_NO		= GauceUtils.nameValue(ds, 1, "REQ_NO");
		String DPT_NM       = GauceUtils.nameValue(ds, 1, "DPT_NM");
		String JOB_NM	    = GauceUtils.nameValue(ds, 1, "JOB_NM");
		String ENO_NO   	= GauceUtils.nameValue(ds, 1, "ENO_NO");
		String NAM_KOR		= GauceUtils.nameValue(ds, 1, "NAM_KOR");
		String CET_NO		= GauceUtils.nameValue(ds, 1, "CET_NO");
		String HIR_YMD		= GauceUtils.nameValue(ds, 1, "HIR_YMD");
		String RET_YMD		= JSPUtil.rns(GauceUtils.nameValue(ds, 1, "RET_YMD"));
		String LSE_YY		= GauceUtils.nameValue(ds, 1, "LSE_YY");
		String LSE_MM		= GauceUtils.nameValue(ds, 1, "LSE_MM");
		String AID_CD_NM	= GauceUtils.nameValue(ds, 1, "AID_CD_NM");
		String AID_CET		= GauceUtils.nameValue(ds, 1, "AID_CET");
		String AID_NM		= GauceUtils.nameValue(ds, 1, "AID_NM");
		String AID_YMD		= GauceUtils.nameValue(ds, 1, "AID_YMD");
		String ABA_NM		= GauceUtils.nameValue(ds, 1, "ABA_NM");
		String REC_NM		= GauceUtils.nameValue(ds, 1, "REC_NM");
		String ACC_NO		= GauceUtils.nameValue(ds, 1, "ACC_NO");
		String REQ_YMD		= GauceUtils.nameValue(ds, 1, "REQ_YMD");
		String HLP1_AMT		= JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "HLP1_AMT").replaceAll(",", "."));
		String HLP2_AMT		= JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "HLP2_AMT").replaceAll(",", "."));
		String SUM_AMT		= JSPUtil.getMFormat(GauceUtils.nameValue(ds, 1, "COST_AMT").replaceAll(",", "."));
		String SPL_YMD		= JSPUtil.rns(GauceUtils.nameValue(ds, 1, "SPL_YMD"));
		String WORK_NO1		= JSPUtil.rns(GauceUtils.nameValue(ds, 1, "WORK_NO1"));
		String AID_STS_NM	= GauceUtils.nameValue(ds, 1, "AID_STS_NM");
		String RET_RSN		= JSPUtil.rns(GauceUtils.nameValue(ds, 1, "RET_RSN"));
		String FILE_NAME       = GauceUtils.nameValue(ds, 1, "FILE_NAME");

		StringBuffer content = new StringBuffer();
		content.append(" <html>                                                                                       																														");
		content.append(" <head>                                                                                                                                                   ");
		content.append(" 	<title>경공조금신청서상세</title>                                                                                                          ");
		content.append(" 	<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>                                                                                    ");
		content.append(" 	<link href='/css/style.css' rel='stylesheet' type='text/css'>                                                                                           ");
		content.append(" 	<link href='/css/general.css' rel='stylesheet' type='text/css'>                                                                                         ");
		content.append(" 	<script language=javascript src='/common/common.js'></script>                                                                                                               \n");
		content.append(" 	<script language=javascript src='/common/input.js'></script>                                                                                                                \n");
		content.append(" 	<script language=javascript src='/common/mdi_common.js'></script>                                                                                                           \n");
		content.append(" 	<script language='javascript' src='/common/calendar/calendar.js'></script>                                                                                                  \n");
		content.append("	<SCRIPT LANGUAGE='JavaScript'>											\n");
		content.append("	<!--                                                \n");
		content.append("	function fnc_FileDownload(vFILE_NAME, vFILE_URL){   \n");
		content.append("            // 첨부 파일이 존재하는 경우만 수행하게~  \n");
		content.append("            if (vFILE_NAME != '' && vFILE_URL != '') {\n");
		content.append("                cfDownload(vFILE_NAME, vFILE_URL);    \n");
		content.append("            }                                         \n");
		content.append("	}                                                   \n");
		content.append("	//-->                                               \n");
		content.append("	</SCRIPT>                                           \n");
		content.append(" <body leftmargin='20' topmargin='14' rightmargin='20' bottommargin='15' marginwidth='0' marginheight='0' scroll=auto >                                   ");
		content.append(" 	<form name='form1'>                                                                                                                                     ");
		content.append(" 	<table width='800' border='0' cellspacing='0' cellpadding='0'>                                                                                          ");
		content.append(" 	<tr>                                                                                                                                                    ");
		content.append(" 		<td>                                                                                                                                                  ");
		content.append(" 		<table width='100%' border='0' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>           ");
		content.append(" 		<tr height='50'>                                                                                                                                      ");
		content.append(" 			<td colspan='8'>                                                                                                                                    ");
		content.append(" 				<table width='100%' border='0' cellspacing='0' cellpadding='0'>                                                                                   ");
		content.append(" 				<tr align='center'>                                                                                                                               ");
		content.append(" 					<td>&nbsp;</td>                                                                                                                                 ");
		content.append(" 					<td align='right'>                                                                                                                              ");
		content.append("     					<table border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse'  bordercolor='#999999' align='right'>                   ");
		content.append("         					<tr align='center' height='25'>                                                                                                         ");
		content.append("         						<td rowspan='2' class='creamBold' width='50'>결재<br>현황                                                                             ");
		content.append("                                     &nbsp;                                                                              ");
		content.append("                                 </td>                                                                                                                    ");
		content.append("                                 <td id='txtA1_ENO_NM' width='120'>").append(GauceUtils.nameValue(dsDecision, 1, "JOB_NM")).append(" ").append(GauceUtils.nameValue(dsDecision, 1, "ENO_NM")).append("</td>");
		content.append("                                 <td id='txtA2_ENO_NM' width='120'>").append(GauceUtils.nameValue(dsDecision, 2, "JOB_NM")).append(" ").append(GauceUtils.nameValue(dsDecision, 2, "ENO_NM")).append("</td>");
		content.append("         					</tr>                                                                                                                                   ");
		content.append("         					<tr align='center' height='25'>                                                                                                         ");
		content.append("                                 <td id='txtA1_APP_STS'>").append(GauceUtils.nameValue(dsDecision, 1, "APP_YN_NM")).append("</td>             ");
		content.append("                                 <td id='txtA2_APP_STS'>").append(GauceUtils.nameValue(dsDecision, 2, "APP_YN_NM")).append("</td>             ");
		content.append("         					</tr>                                                                                                                                   ");
		content.append("     					</table>                                                                                                                                    ");
		content.append(" 					</td>                                                                                                                                           ");
		content.append(" 				</tr>                                                                                                                                             ");
		content.append(" 				</table>                                                                                                                                          ");
		content.append(" 			</td>                                                                                                                                               ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		</table>                                                                                                                                              ");
		content.append(" 		</td>                                                                                                                                                 ");
		content.append(" 	</tr>                                                                                                                                                   ");
		content.append(" 	<tr>                                                                                                                                                    ");
		content.append(" 		<td class='paddingTop8'>                                                                                                                              ");
		content.append(" 		<table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>           ");
		content.append(" 			<colgroup>                                                                                                                                          ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='100'></col>                                                                                                                            ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='80'></col>                                                                                                                           ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='80'></col>                                                                                                                            ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='*'></col>                                                                                                                             ");
		content.append(" 			</colgroup>                                                                                                                                         ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append(" 			<td align='center' class='creamBold'>신청번호</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(REQ_NO).append("</td>                             ");
		content.append("                                                                                                                                                          ");
		content.append("             <td align='center' class='creamBold'>사&nbsp;&nbsp;번</td>                                                                                   ");
		content.append("             <td class='padding2423'>").append(ENO_NO).append("</td>                                                                                      ");
		content.append("             <td align='center' class='creamBold'>성&nbsp;&nbsp;명</td>                                                                                   ");
		content.append("             <td class='padding2423'>").append(NAM_KOR).append("</td>                                                                                     ");
		content.append(" 			<td align='center' class='creamBold'>직위</td>                                                                                                      ");
		content.append(" 			<td class='padding2423'>").append(JOB_NM).append("</td>                                                                                                                                               ");
		content.append(" 			<td align='center' class='creamBold'>부서</td>                                                                                                      ");
		content.append(" 			<td class='padding2423'>").append(DPT_NM).append("</td>                                                                                                                                               ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append(" 			<td align='center' class='creamBold'>주민번호</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(CET_NO).append("</td>                             ");
		content.append(" 			<td align='center' class='creamBold'>입사일</td>                                                                                                    ");
		content.append(" 			<td class='padding2423'>").append(HIR_YMD).append("</td>                            ");
		content.append(" 			<td align='center' class='creamBold'>퇴사일</td>                                                                                                    ");
		content.append(" 			<td class='padding2423'>").append(RET_YMD).append("</td>                            ");
		content.append(" 			<td align='center' class='creamBold'>근속년수</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(LSE_YY).append("</td>                              ");
		content.append(" 			<td align='center' class='creamBold'>근속월수</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(LSE_MM).append("</td>                              ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		</table>                                                                                                                                              ");
		content.append(" 		</td>                                                                                                                                                 ");
		content.append(" 	</tr>                                                                                                                                                   ");
		content.append(" 	<tr>                                                                                                                                                    ");
		content.append(" 		<td colspan='8' class='paddingTop8'>                                                                                                                  ");
		content.append("      <img src='/images/specialHr/dotGreen.gif' width='10' height='10' align='absmiddle'> 공조사항이 발생하게 된 대상자의 성명, 주민번호, 발생일자        ");
		content.append("   </td>                                                                                                                                                  ");
		content.append(" 	</tr>                                                                                                                                                   ");
		content.append(" 	<tr>                                                                                                                                                    ");
		content.append(" 		<td>                                                                                                                                                  ");
		content.append(" 		<table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse;' bordercolor='#999999' class='table_cream'>          ");
		content.append(" 			<colgroup>                                                                                                                                          ");
		content.append(" 				<col width='60'></col>                                                                                                                            ");
		content.append(" 				<col width='110'></col>                                                                                                                           ");
		content.append(" 				<col width='100'></col>                                                                                                                           ");
		content.append(" 				<col width='110'></col>                                                                                                                           ");
		content.append(" 				<col width='80'></col>                                                                                                                            ");
		content.append(" 				<col width='110'></col>                                                                                                                           ");
		content.append(" 				<col width='80'></col>                                                                                                                            ");
		content.append(" 				<col width='*'></col>                                                                                                                             ");
		content.append(" 			</colgroup>                                                                                                                                         ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append(" 			<td align='center' class='creamBold'>신청사유</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(AID_CD_NM).append("</td>                                                                                                                                             ");
		content.append(" 			<td align='center' class='creamBold'>대상자주민번호</td>                                                                                            ");
		content.append(" 			<td class='padding2423'>").append(AID_CET).append("</td>              ");
		content.append(" 			<td align='center' class='creamBold'>대상자성명</td>                                                                                                ");
		content.append(" 			<td class='padding2423'>").append(AID_NM).append("</td>                                                                         ");
		content.append(" 			<td align='center' class='creamBold'>발생일자</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(AID_YMD).append("</td>                                                                                                                                               ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append("             <td align='center' class='creamBold' rowspan='4'>제출서류<br>첨부</td>                                                                                           \n");
		content.append("             <td class='padding2423' colspan='5'  align='right' valign='top'>                                                                                     \n");
		content.append(" 				<table width='100%' border='1' cellspacing='0' cellpadding='0' style='border-collapse: collapse' bordercolor='#999999' class='table_cream'>	                          \n");
		content.append(" 					<tr >                                                                                                                                                               \n");
		content.append(" 					<th width='30' class='creamBold'>NO</th>                                                                                                                            \n");
		content.append(" 					<th class='creamBold'>파일명</th>                                                                                                                                   \n");
		content.append(" 					</tr>                                                                                                                                                               \n");
		String str = "<tr onClick=\"fnc_FileDownload('";
		String end = "')\"  style='cursor:hand'>";
		for(int i = 1; i <= dsFile.getDataRowCnt(); i ++){
			String fileName = GauceUtils.nameValue(dsFile, i, "FILE_NAME");
			String fileURL  = GauceUtils.nameValue(dsFile, i, "FILE_URL");

			content.append(str).append(fileName).append("', '").append(fileURL).append(end).append("                                                         \n");
			content.append(" 					<td>").append(i).append("</th>                                                                                                                                                          \n");
			content.append(" 					<td>").append(fileName).append("</td>                                                                                                                                                  \n");
			content.append(" 					</tr>                                                                                                                                                               \n");
		}

		content.append(" 				</table>                                                                                                                                                              \n");
		content.append("             </td>                                                                                                                                                            \n");
		content.append(" 			<td align='center' class='creamBold'>신청일자</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(REQ_YMD).append("</td> ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 		<tr>                                                                                                                                                  ");
		content.append(" 			<td align='center' class='creamBold'>공조금</td>                                                                                                    ");
		content.append(" 			<td class='padding2423'>                                                                                                                            ");
		content.append(" 			<table width='100%' border='0' >                                                                                                                    ");
		content.append(" 			<tr>                                                                                                                                                ");
		content.append(" 				<td width='90%'>").append(HLP1_AMT).append("</td>                                                                                                                                             ");
		content.append(" 				<td align='left'>원</td>                                                                                                                          ");
		content.append(" 			</tr>                                                                                                                                               ");
		content.append(" 			</table>                                                                                                                                            ");
		content.append(" 			</td>                                                                                                                                               ");
		content.append(" 			<td align='center' class='creamBold'>경조금</td>                                                                                                    ");
		content.append(" 			<td class='padding2423'>                                                                                                                            ");
		content.append(" 				<table width='100%' border='0' >                                                                                                                  ");
		content.append(" 				<tr>                                                                                                                                              ");
		content.append(" 					<td width='90%'>").append(HLP2_AMT).append("</td>                                                                                                                                             ");
		content.append(" 				<td align='left'>원</td>                                                                                                                          ");
		content.append(" 			</tr>                                                                                                                                               ");
		content.append(" 			</table>                                                                                                                                            ");
		content.append(" 			</td>                                                                                                                                               ");
		content.append(" 			<td align='center' class='creamBold'>지급금액</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>                                                                                                                            ");
		content.append(" 				<table width='100%' border='0' >                                                                                                                  ");
		content.append(" 				<tr>                                                                                                                                              ");
		content.append(" 					<td width='90%'>").append(SUM_AMT).append("</td>                                                                                                                                         ");
		content.append(" 						<td align='left'>원</td>                                                                                                                      ");
		content.append(" 					</tr>                                                                                                                                           ");
		content.append(" 					</table>                                                                                                                                        ");
		content.append(" 				</td>                                                                                                                                             ");
		content.append(" 				<td align='center' class='creamBold'>지급일자</td>                                                                                                ");
		content.append(" 				<td class='padding2423'>").append(SPL_YMD).append("</td>                                                                                                                                             ");
		content.append(" 			</tr>                                                                                                                                               ");
		content.append(" 			<tr>                                                                                                                                                ");
		content.append(" 			<td align='center' class='creamBold'>관리번호</td>                                                                                                  ");
		content.append(" 			<td class='padding2423'>").append(WORK_NO1).append("</td>                                       ");
		content.append(" 			<td align='center' class='creamBold'>상태</td>                                                                                                      ");
		content.append(" 			<td class='padding2423'>").append(AID_STS_NM).append("</td>                                                                                                                                               ");
		content.append(" 			<td align='center' class='creamBold'>반송사유</td>                                                                                                  ");
		content.append(" 				<td class='padding2423' colspan='3'>").append(RET_RSN).append("</td>                         ");
		content.append(" 			</tr>                                                                                                                                               ");
		content.append(" 			</table>                                                                                                                                            ");
		content.append(" 			</td>                                                                                                                                               ");
		content.append(" 		</tr>                                                                                                                                                 ");
		content.append(" 	</table>                                                                                                                                                ");
		content.append(" 	</form>                                                                                                                                                 ");
		content.append(" </body>                                                                                                                                                  ");
		content.append(" </html>                                                                                                                                                  ");

		try{
			FileOutputStream fos = new FileOutputStream(CommUtil.getHtmlFilePath()+FILE_NAME+".html");
			fos.write(content.toString().getBytes());
			fos.close();
		}catch(IOException e){
			e.printStackTrace();
		}

	}


}