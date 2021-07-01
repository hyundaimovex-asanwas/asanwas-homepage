package Ehr.common.commnm.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class COMMNMDAO extends AbstractDAO {
	/**
	 * EDUG010DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public COMMNMDAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 *공통코드명 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN"),                // 구분
				p_box.get("COMM_CD"),             // 코드
				p_box.get("COMM_CD")              // 코드
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

    /**
     * 공통코드명을 조회해 온다.
     * @param p_box
     * @throws CException
     */
	public void COMMNM_SHR_00(CBox p_box) throws CException {

	    /** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
	    String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_00");

        //System.out.println("p_box   =========================================== " + p_box);	
    	//System.out.println("p_box"+p_box.toString());	    
	    
	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
	    Object[] bind = new Object[] {
	            p_box.get("CODE_GUBUN"),                // 구분
	            p_box.get("CODE_GUBUN")                // 구분
	    };

	    /** FirstRow메소드 호출 **/
	    this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 *부서/팀/본부명 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_02");

		/** 조회 조건에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

		/** 검색조건이 부서인 경우 */
		if (p_box.get("CD_GBN").equals("A4")) {
			sb.append("AND   (SORT_NO BETWEEN 100 AND 750 OR DPT_CD = 'IT')");
		}
		/** 검색조건이 팀인 경우 */
		else if (p_box.get("CD_GBN").equals("A6")) {
			sb.append("AND    UPDPT_CD LIKE '" + p_box.get("UP_CD") + "'||'%'");
			sb.append("AND 	  (END_YMD IS NULL OR LENGTH(END_YMD) = 0 OR END_YMD > '"+p_box.get("SESSION_TODAY").replaceAll("-", "")+"')");
		}
		/** 검색조건이 본부인 경우 */
		else if (p_box.get("CD_GBN").equals("B2")) {
			sb.append("AND 	  (END_YMD IS NULL OR LENGTH(END_YMD) = 0 OR END_YMD > '"+p_box.get("SESSION_TODAY").replaceAll("-", "")+"')");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN"),                // 구분
				p_box.get("COMM_CD"),             // 코드
				p_box.get("COMM_CD")              // 코드
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 직무코드명 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("COMM_CD"),             // 코드
				p_box.get("COMM_CD")              // 코드
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 직무코드명 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_04(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_05");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("COMM_CD")              // 직무레벨
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 콤보박스 코드 변경(인사평가)
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_06(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_06");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN"),
				p_box.get("EVL_YY")
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 해당 소속의 부문을 가져온다
	 * @param p_box
	 * @throws CException
	 */
	public void COMMNM_SHR_07(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_07");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("CD_GBN"),
				p_box.get("DPT_CD")
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

    /**
     * 부서코드명을 조회해 온다.
     * @param p_box
     * @throws CException
     */
	public void COMMNM_SHR_DPT(CBox p_box) throws CException {
	    /** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
	    String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_DPT");
	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
	    Object[] bind = new Object[] {
	    };
	    /** FirstRow메소드 호출 **/
	    this.selectProcessFirstRow(sql, bind, prop);
	}
	public void COMMNM_SHR_DPT2(CBox p_box) throws CException {
	    /** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
	    String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_DPT2");
	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
	    Object[] bind = new Object[] {
	    };
	    /** FirstRow메소드 호출 **/
	    this.selectProcessFirstRow(sql, bind, prop);
	}
	public void COMMNM_SHR_DPT3(CBox p_box) throws CException {
	    /** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
	    String sql = XmlSqlUtils.getSQL("common", "COMMNM_SHR_DPT3");
	    /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
	    Object[] bind = new Object[] {
	    };
	    /** FirstRow메소드 호출 **/
	    this.selectProcessFirstRow(sql, bind, prop);
	}

}
