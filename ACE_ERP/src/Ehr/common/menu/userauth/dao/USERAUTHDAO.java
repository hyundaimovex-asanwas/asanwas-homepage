package common.menu.userauth.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class USERAUTHDAO extends AbstractDAO {
	/**
	 * USERAUTHDAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public USERAUTHDAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 사용자권한정보조회 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void USERAUTH_SHR_00(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("common", "USERAUTH_SHR_00");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("GUBUN"),
				p_box.get("ENO_NO")
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 권한에 따른 메뉴트리 SELECT를 수행하는 DAO 메소드(신인사시스템, 경영정보시스템 공통)
	 * @param p_box
	 * @throws CException
	 */
	public void USERAUTH_SHR_01(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("common", "USERAUTH_SHR_01");

		/** 조회 조건에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();

		if (p_box.get("MENU_ID1").length() == 3) {
			sb.append("WHERE MENU_LBL > '1'\n");
		}else if (p_box.get("MENU_ID1").length() == 4) {
			sb.append("WHERE MENU_LBL > '2'\n");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("MENU_ID1"),                    // MENU_ID1
				p_box.get("MENU_ID2"),                    // MENU_ID2
				p_box.get("MENU_ID3"),                    // MENU_ID3
				p_box.get("MENU_ID4"),                    // MENU_ID4
				p_box.get("MENU_ID5"),                    // MENU_ID5
				p_box.get("MENU_ID6"),                    // MENU_ID6
				p_box.get("MENU_ID7"),                    // MENU_ID7
				p_box.get("MENU_ID8"),                    // MENU_ID8
				p_box.get("MENU_ID9"),                    // MENU_ID9
				p_box.get("MENU_ID10"),                  // MENU_ID10

				p_box.get("ENO_NO"),                      // 사번
				p_box.get("ENO_NO"),                      // 사번
				p_box.get("ENO_NO"),                      // 사번
				p_box.get("ENO_NO"),                      // 사번

				p_box.get("ENO_NO"),                      // 사번
				p_box.get("ENO_NO"),                      // 사번
				p_box.get("ENO_NO"),                      // 사번
				p_box.get("ENO_NO")                       // 사번

		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 즐겨찾기(신인사시스템)
	 * @param p_box
	 * @throws CException
	 */
	public void USERAUTH_SHR_02(CBox p_box) throws CException {

		String sql = XmlSqlUtils.getSQL("common", "USERAUTH_SHR_02");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),                        // 사번
				p_box.get("ENO_NO"),                        // 사번
			//  p_box.get("ENO_NO"),                        // 사번
				p_box.get("ENO_NO"),                        // 사번
				p_box.get("ENO_NO"),                        // 사번
				p_box.get("ENO_NO")                         // 사번
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 사용자가 사용가능한 상위 메뉴를 가지고 온다.
	 * @param p_box
	 * @throws CException
	 */
	public void USERAUTH_SHR_03(CBox p_box) throws CException {

        //상위 메뉴 코드를 가지고 온다.
	    String sql = XmlSqlUtils.getSQL("common", "USERAUTH_SHR_03");
	    Object[] bind = new Object[] {
	    };
	    GauceValueObject voList = this.selectProcessGvo(sql, bind);
        GauceValueObject vo = null;


        //가지고 온 상위 메뉴 코드로 사용가능한 메뉴를 가지고 온다.
        StringBuffer Query = new StringBuffer();

        Query.append("    SELECT UPMENU_ID                                                                          \n");
        Query.append("         , CNT                                                                                \n");
        Query.append("         , GROUP_SEQ                                                                          \n");
        Query.append("      FROM (SELECT A.UPMENU_ID                                                                \n");
        Query.append("                 , COUNT(A.MENU_ID) AS CNT                                                    \n");
        Query.append("                 , A.GROUP_SEQ                                                                \n");
        Query.append("              FROM (                                                                          \n");

        for(int i=0; i<voList.size(); i++) {
            vo = voList.get(i);

            if(i != 0)
                Query.append("                     UNION                                                                    \n");

            Query.append("                    SELECT '"+vo.getString("MENU_ID")+"' AS UPMENU_ID                         \n");
            Query.append("                         , MENU_ID                                                            \n");
            Query.append("                         , '"+vo.getString("GROUP_SEQ")+"' AS GROUP_SEQ                       \n");
            Query.append("                      FROM T_CM_MENULST L                                                     \n");
            Query.append("                     WHERE MENU_LBL > '1'                                                     \n");
            Query.append("                       AND MENU_GBN = 'f'                                                     \n");
            Query.append("                START WITH MENU_ID IN ('"+vo.getString("MENU_ID")+"')                         \n");
            Query.append("                CONNECT BY PRIOR MENU_ID = UPMENU_ID                                          \n");
        }

        Query.append("                    ) A                                                                       \n");
        Query.append("                 , (SELECT DISTINCT MENU_ID                                                   \n");
        Query.append("                      FROM T_CM_ROLEAUTH                                                      \n");

        //법무, EIS, 사업본부장 권한을 추가해 주기 위해
        Query.append("                     WHERE ROLE_CD IN (SELECT DECODE( A.NUM                                           \n");
        Query.append("                                                    , 1, ROLE_CD                                      \n");
        Query.append("                                                    , 2, LAW_AUTHO                                    \n");
        Query.append("                                                    , 3, L3_AUTHO ) AS ROLE_CD                        \n");
        Query.append("                                         FROM (SELECT 1 AS NUM FROM DUAL                              \n");
        Query.append("                                                UNION                                                 \n");
        Query.append("                                               SELECT 2 AS NUM FROM DUAL                              \n");
        Query.append("                                                UNION                                                 \n");
        Query.append("                                               SELECT 3 AS NUM FROM DUAL                              \n");
        Query.append("                                               ) A                                                    \n");
        Query.append("                                            , (SELECT ROLE_CD                                         \n");
        Query.append("                                                    , DECODE( LAW_AUTHO                               \n");
        Query.append("                                                            , 'M'   , '2010'                          \n");
        Query.append("                                                            , NULL  , ''                              \n");
        Query.append("                                                            , '2011' ) AS LAW_AUTHO                   \n");
        Query.append("                                                    , DECODE(L3_AUTHO, 'M', '2021') AS L3_AUTHO       \n");
        Query.append("                                                 FROM T_CM_EMPLIST                                    \n");
        Query.append("                                                WHERE ENO_NO = '"+p_box.get("ENO_NO")+"'              \n");
        Query.append("                                               ) B                                                    \n");
        Query.append("                                       )                                                              \n");

        Query.append("                       AND MENU_ID IN (SELECT MENU_ID                                         \n");
        Query.append("                                         FROM T_CM_ROLEAUTH                                   \n");

        //법무, EIS, 사업본부장 권한을 추가해 주기 위해
        Query.append("                                        WHERE ROLE_CD IN (SELECT DECODE( A.NUM                                           \n");
        Query.append("                                                                       , 1, ROLE_CD                                      \n");
        Query.append("                                                                       , 2, LAW_AUTHO                                    \n");
        Query.append("                                                                       , 3, L3_AUTHO ) AS ROLE_CD                        \n");
        Query.append("                                                            FROM (SELECT 1 AS NUM FROM DUAL                              \n");
        Query.append("                                                                   UNION                                                 \n");
        Query.append("                                                                  SELECT 2 AS NUM FROM DUAL                              \n");
        Query.append("                                                                   UNION                                                 \n");
        Query.append("                                                                  SELECT 3 AS NUM FROM DUAL                              \n");
        Query.append("                                                                  ) A                                                    \n");
        Query.append("                                                               , (SELECT ROLE_CD                                         \n");
        Query.append("                                                                       , DECODE( LAW_AUTHO                               \n");
        Query.append("                                                                               , 'M'   , '2010'                          \n");
        Query.append("                                                                               , NULL  , ''                              \n");
        Query.append("                                                                               , '2011' ) AS LAW_AUTHO                   \n");
        Query.append("                                                                               , DECODE(L3_AUTHO, 'M', '2021') AS L3_AUTHO \n");
        Query.append("                                                                    FROM T_CM_EMPLIST                                    \n");
        Query.append("                                                                   WHERE ENO_NO = '"+p_box.get("ENO_NO")+"'              \n");
        Query.append("                                                                  ) B                                                    \n");
        Query.append("                                                          )                                                              \n");

        Query.append("                                        MINUS                                                 \n");
        Query.append("                                       --개인메뉴에서 설정한 모든 메뉴는 제외한다.            \n");
        Query.append("                                       SELECT MENU_ID                                         \n");
        Query.append("                                         FROM T_CM_USERAUTH                                   \n");
        Query.append("                                        WHERE ENO_NO = '"+p_box.get("ENO_NO")+"'                             \n");
        Query.append("                                       )                                                      \n");
        Query.append("                     UNION                                                                    \n");
        Query.append("                    --추가시킬 메뉴를 추가                                                    \n");
        Query.append("                    SELECT MENU_ID                                                            \n");
        Query.append("                      FROM T_CM_USERAUTH                                                      \n");
        Query.append("                     WHERE ENO_NO = '"+p_box.get("ENO_NO")+"'                                                \n");
        Query.append("                       AND ADD_GBN = 'P'                                                      \n");
        Query.append("                    ) B                                                                       \n");
        Query.append("             WHERE A.MENU_ID = B.MENU_ID                                                      \n");
        Query.append("          GROUP BY A.UPMENU_ID                                                                \n");
        Query.append("                 , A.GROUP_SEQ                                                                \n");
        Query.append("            )                                                                                 \n");
        Query.append("  ORDER BY LPAD(GROUP_SEQ, 3, ' ')                                                            \n");

        /** FirstRow메소드 호출 **/
        this.selectProcessFirstRow(Query.toString(), bind, prop);
	}

    /**
     * EIS 에서 사용하는 상위 메뉴
     * @param p_box
     * @throws CException
     */
    public void USERAUTH_SHR_04(CBox p_box) throws CException {

        String sql = XmlSqlUtils.getSQL("common", "USERAUTH_SHR_04");

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
        Object[] bind = new Object[] {
                p_box.get("ENO_NO"),                       // 사번
                p_box.get("ENO_NO"),                      // 사번
                p_box.get("ENO_NO"),                      // 사번
                p_box.get("ENO_NO")                       // 사번
        };

        /** FirstRow메소드 호출 **/
        this.selectProcessFirstRow(sql, bind, prop);
    }

    /**
     * EIS 에서 사용하는 상위 메뉴
     * @param p_box
     * @throws CException
     */
    public void USERAUTH_SHR_05(CBox p_box) throws CException {

    	String sql = XmlSqlUtils.getSQL("common", "USERAUTH_SHR_05");

    	/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
    	Object[] bind = new Object[] {
    			p_box.get("GUBUN"),
    			p_box.get("MENU_ID"),
    			//p_box.get("ENO_NO"), // 사번
    	};

    	/** FirstRow메소드 호출 **/
    	this.selectProcessFirstRow(sql, bind, prop);
    }
}
