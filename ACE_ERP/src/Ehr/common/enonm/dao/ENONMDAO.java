package Ehr.common.enonm.dao;

import Ehr.common.util.JSPUtil;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class ENONMDAO extends AbstractDAO {
	/**
	 * EDUG010DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ENONMDAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 *정규직 또는 파견사원명 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void ENONM_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR_01");

		/** 조회 조건에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

		/** 검색조건이 정규직인 경우 */
		if (p_box.get("GBN").equals("0")) {
			// 재직/퇴직 구분없이
			if (p_box.get("RET_CD").equals("0")) {
				sb.append("                   ACC_NO,\n");
                sb.append("                   TO_CHAR(HIRG_YMD, 'YYYY-MM-DD')       AS HIRG_YMD,\n");
				sb.append("                   TO_CHAR(RAM_YMD, 'YYYY-MM-DD')       AS RAM_YMD,\n");
				sb.append("                   TO_CHAR(RAM_YMD2, 'YYYY-MM-DD')       AS RAM_YMD2,\n");
				sb.append("                   TO_CHAR(RAM_YMD3, 'YYYY-MM-DD')       AS RAM_YMD3\n");
			    sb.append("FROM ASNHR.T_CM_PERSON\n");
			    sb.append("WHERE 1 = 1\n");
		    }
			// 재직중인 사원만
			else if (p_box.get("RET_CD").equals("1")) {
				sb.append("                   ' ' AS ACC_NO,\n");
				sb.append("                   TO_CHAR(HIRG_YMD, 'YYYY-MM-DD')       AS HIRG_YMD,\n");
				sb.append("                   TO_CHAR(RAM_YMD, 'YYYY-MM-DD')       AS RAM_YMD,\n");
				sb.append("                   TO_CHAR(RAM_YMD2, 'YYYY-MM-DD')       AS RAM_YMD2,\n");
				sb.append("                   TO_CHAR(RAM_YMD3, 'YYYY-MM-DD')       AS RAM_YMD3\n");
				sb.append("FROM ASNHR.T_CM_PERSON\n");
				sb.append("WHERE (RET_YMD IS NULL\n");
			    sb.append("OR    RET_YMD >= SYSDATE)\n");
			}
		}
		/** 검색조건이 파견사원인 경우 */
		else if (p_box.get("GBN").equals("2")) {
            // 재직/퇴직 구분없이
			if (p_box.get("RET_CD").equals("0")) {
				sb.append("                   TO_CHAR(HIR_YMD, 'YYYY-MM-DD')       AS HIRG_YMD,\n");
				sb.append("                   NULL       AS RAM_YMD,\n");
				sb.append("                   NULL       AS RAM_YMD2,\n");
				sb.append("                   NULL       AS RAM_YMD3\n");
			    sb.append("FROM ASNHR.T_ME_PERSON\n");
			    sb.append("WHERE 1 = 1\n");
		    }
			// 재직중인 사원만
			else if (p_box.get("RET_CD").equals("1")) {
				sb.append("                   TO_CHAR(HIR_YMD, 'YYYY-MM-DD')       AS HIRG_YMD,\n");
				sb.append("                   NULL       AS RAM_YMD,\n");
				sb.append("                   NULL       AS RAM_YMD2,\n");
				sb.append("                   NULL       AS RAM_YMD3\n");
				sb.append("FROM ASNHR.T_ME_PERSON\n");
				sb.append("WHERE (RET_YMD IS NULL\n");
			    sb.append("OR         RET_YMD >= SYSDATE)\n");
			}
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")              // 사번
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 전체사원명  SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void ENONM_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR_02");

		/** 조회 조건에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

        // 재직/퇴직 구분없이
		if (p_box.get("RET_CD").equals("0")) {
		    sb.append("AND 1 = 1\n");
	    }
		// 재직중인 사원만
		else if (p_box.get("RET_CD").equals("1")) {
			sb.append("AND (A.RET_YMD IS NULL\n");
		    sb.append("OR    A.RET_YMD >= SYSDATE)\n");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")              // 사번
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 *정규직 또는 파견사원의 사번 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void ENONM_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR_03");

		/** 조회 조건에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

		/** 검색조건이 정규직인 경우 */
		if (p_box.get("GBN").equals("0")) {
			// 재직/퇴직 구분없이
			if (p_box.get("RET_CD").equals("0")) {
				sb.append(", \nTO_CHAR(HIRG_YMD, 'YYYY-MM-DD')       AS HIRG_YMD\n");
				sb.append("FROM ASNHR.T_CM_PERSON\n");
			    sb.append("WHERE 1 = 1\n");
		    }
			// 재직중인 사원만
			else if (p_box.get("RET_CD").equals("1")) {
				sb.append(", \nTO_CHAR(HIRG_YMD, 'YYYY-MM-DD')       AS HIRG_YMD\n");
				sb.append("FROM ASNHR.T_CM_PERSON\n");
				sb.append("WHERE (RET_YMD IS NULL\n");
			    sb.append("OR    RET_YMD >= SYSDATE)\n");
			}
		}
		/** 검색조건이 파견사원인 경우 */
		else if (p_box.get("GBN").equals("2")) {
            // 재직/퇴직 구분없이
			if (p_box.get("RET_CD").equals("0")) {
			    sb.append("FROM ASNHR.T_ME_PERSON\n");
			    sb.append("WHERE 1 = 1\n");
		    }
			// 재직중인 사원만
			else if (p_box.get("RET_CD").equals("1")) {
				sb.append("FROM ASNHR.T_ME_PERSON\n");
				sb.append("WHERE (RET_YMD IS NULL\n");
			    sb.append("OR         RET_YMD >= SYSDATE)\n");
			}
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		//System.out.println("p_box   =========================================== " + p_box);
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.getString("ENO_NM")),
				//JSPUtil.rns(p_box.get("ENO_NM")),
				//p_box.get("ENO_NM")              // 성명
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 전체사원 사번  SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void ENONM_SHR_04(CBox p_box) throws CException {

		/** 외부 XML에서 공통코드명 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL_SHR_04");

		/** 조회 조건에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

        // 재직/퇴직 구분없이
		if (p_box.get("RET_CD").equals("0")) {
		    sb.append("AND 1 = 1\n");
	    }
		// 재직중인 사원만
		else if (p_box.get("RET_CD").equals("1")) {
			sb.append("AND (A.RET_YMD IS NULL OR A.RET_YMD >= SYSDATE) \n");
		    //sb.append("OR    A.RET_YMD >= SYSDATE)\n");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

        //System.out.println("p_box   =========================================== " + p_box);	
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				//JSPUtil.rns(p_box.get("ENO_NM")),
				p_box.getString("ENO_NM")              // 성명
		};

        /** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
}
