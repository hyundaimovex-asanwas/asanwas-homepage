package Ehr.common.popup.codenm.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;


public class CODENMDAO extends AbstractDAO {
	/**
	 * COMMNMDAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public CODENMDAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 공통 정보를 조회해 오는  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void CODENM_SHR(CBox p_box) throws CException {

		StringBuffer sb = new StringBuffer();

		if (p_box.get("GBN").equals("DEPT")) {						//소속
			sb.append("SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN						\n");
			sb.append("FROM 		ASNHR.T_CM_DEPT																				\n");
			sb.append("WHERE 		CD_GBN = 'A4'																					\n");
			sb.append("AND          SORT_NO BETWEEN 100 AND 750														\n");
			sb.append("AND (DPT_CD LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'				\n");
			sb.append("OR 			DPT_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%')		\n");
			sb.append("ORDER BY SORT_NO, COUNT_REM");

		} else if (p_box.get("GBN").equals("KPI")) {				//KPI POOL
			sb.append("SELECT 	KPI_CD AS CODE_CD, KPI_NM AS CODE_NM, 'KPI' AS CD_GBN					\n");
			sb.append("FROM 		ASNHR.T_EV_KPIPOOL																				\n");
			sb.append("WHERE 		GUBUN = "+p_box.get("SESSION_GUBUN")+" 										\n");
			sb.append(" AND (                KPI_CD LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'	\n");
			sb.append("OR 			KPI_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%' )			\n");
			sb.append("ORDER BY KPI_CD");

		} else if (p_box.get("GBN").equals("HEAD")) {				//사업본부
			sb.append("SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN							\n");
			sb.append("FROM 		ASNHR.T_CM_DEPT																					\n");
			sb.append("WHERE 		CD_GBN = 'B2'																						\n");
			sb.append("AND 	    	(END_YMD IS NULL OR LENGTH(END_YMD) = 0 OR END_YMD > '"+p_box.get("vcurdate").replaceAll("-", "")+"')\n");
			sb.append("AND (DPT_CD LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'					\n");
			sb.append("OR 			DPT_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%')			\n");
			sb.append("ORDER BY SORT_NO, COUNT_REM");

		} else if (p_box.get("GBN").equals("TEAM")) {				//팀
			sb.append("SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN							\n");
			sb.append("FROM 		ASNHR.T_CM_DEPT																					\n");
			sb.append("WHERE 		CD_GBN = 'A6'																						\n");
			sb.append("AND 	    	(END_YMD IS NULL OR LENGTH(END_YMD) = 0 OR END_YMD > '"+p_box.get("vcurdate").replaceAll("-", "")+"')\n");
			sb.append("AND (DPT_CD LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'					\n");
			sb.append("OR 			DPT_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%')			\n");
			sb.append("AND          UPDPT_CD LIKE '" +p_box.get("UP_CD") + "%'");
			sb.append("ORDER BY SORT_NO, COUNT_REM");

		}
		else if (p_box.get("GBN").equals("DEPT2")) {				//본부 및 소속
			sb.append("SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN							\n");
			sb.append("FROM 		ASNHR.T_CM_DEPT																					\n");
			sb.append("WHERE 	 (CD_GBN = 'A4'																						\n");
			sb.append("AND          SORT_NO BETWEEN 100 AND 750)															\n");
			
			sb.append("AND        (DPT_CD LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'			\n");
			sb.append("OR 		   DPT_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%')			\n");			
			//sb.append("AND        (DPT_CD LIKE '%"+p_box.get("COMM_CD")+"%'\n");
			//sb.append("OR 		   DPT_NM LIKE '%"+p_box.get("COMM_CD")+"%')\n");
			sb.append("ORDER BY SORT_NO, COUNT_REM");

		}
		else if (p_box.get("GBN").equals("BRCH")) {					//지점
			sb.append("SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN							\n");
			sb.append("FROM 		ASNHR.T_CM_DEPT																					\n");
			sb.append("WHERE 		CD_GBN = 'A4'																						\n");
			sb.append("AND          SORT_NO BETWEEN 200 AND 750															\n");
			sb.append("AND          GBN2_TAG <> '1'\n");
			sb.append("AND         (DPT_CD LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'			\n");
			sb.append("OR 			DPT_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%')			\n");
			sb.append("ORDER BY SORT_NO");
		}


		else if (p_box.get("GBN").equals("HUGA")) {					//연차촉진제
			sb.append("SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN																\n");
			sb.append("FROM 		ASNHR.T_CM_DEPT																								\n");
			sb.append("WHERE 		CD_GBN = 'A4' 																							\n");
			sb.append("AND DPT_CD NOT IN ('A050','A200','A400','C001','I200','I300','K001','I131','II01','F000','J000','C130','A450','A451','A470','A700','W001','A201')		\n");
			sb.append("AND          SORT_NO BETWEEN 100 AND 750																				\n");
			sb.append("AND (DPT_CD LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'																		\n");
			sb.append("OR 			DPT_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%')																\n");
			sb.append("UNION ALL																											\n");
			sb.append("SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN																\n");
			sb.append("FROM 		ASNHR.T_CM_DEPT																								\n");
			sb.append("WHERE 		CD_GBN = 'A6' 																							\n");

			sb.append(" AND UPDPT_CD IN ('I100','I200','I300')																				\n");
			sb.append("AND DPT_CD NOT IN ('I134','A200','A400','C001','I100','I200','I300','K001','I131','II01','F000','J000')				\n");
			sb.append("AND END_YMD IS NULL AND SORT_NO BETWEEN 100 AND 750																	\n");
			sb.append("AND (DPT_CD LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'																		\n");
			sb.append("OR 			DPT_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%')																\n");

		}

		String sql = sb.toString();

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, null, prop);

	}
	
	
	public void CODENM_SHR_SEL(CBox p_box) throws CException {

		StringBuffer sb = new StringBuffer();	
		
		if (p_box.get("GBN").equals("2050046")) {						//정진한CJ
			sb.append("		SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN		\n");
			sb.append("		FROM 		T_CM_DEPT																\n");
			sb.append("		WHERE 		CD_GBN = 'A6'															\n");
			sb.append("			AND DPT_CD IN ('I219','I187','I192')											\n");
			sb.append("			ORDER BY SORT_NO, COUNT_REM											\n");

		} else if (p_box.get("GBN").equals("2080028")) {				//박제성 GJ 화성,금담
			sb.append("		SELECT 	DPT_CD AS CODE_CD, DPT_NM AS CODE_NM, CD_GBN		\n");
			sb.append("		FROM 		T_CM_DEPT																\n");
			sb.append("		WHERE 		CD_GBN = 'A6'															\n");
			sb.append("			AND DPT_CD IN ('I141','I145')													\n");
			sb.append("			ORDER BY SORT_NO, COUNT_REM											\n");
		}
		
		String sql = sb.toString();

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, null, prop);

	}
	
	
	
	public void CODENM_SHR_DOC(CBox p_box) throws CException {

		StringBuffer sb = new StringBuffer();	
		

		
		if (p_box.get("GBN").equals("DOC1")) {						//대분류
			sb.append("SELECT 	COMM_CD AS CODE_CD, COMM_NM AS CODE_NM, '' CD_GBN					\n");
			sb.append("FROM 		ASNHR.T_ACT_COMMON												\n");
			sb.append("WHERE 		1 = 1															\n");
			sb.append("AND LENGTH(COMM_CD) = 1														\n");
			sb.append("AND COMM_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'				\n");
			sb.append("ORDER BY COMM_CD"                                                    		   );

		} else if (p_box.get("GBN").equals("DOC2")) {				//중분류
			sb.append("SELECT 	COMM_CD AS CODE_CD, COMM_NM AS CODE_NM, '' CD_GBN					\n");
			sb.append("FROM 		ASNHR.T_ACT_COMMON												\n");
			sb.append("WHERE 		1 = 1															\n");
			sb.append("AND LENGTH(COMM_CD) = 2														\n");
			sb.append("AND COMM_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'				\n");
			sb.append("AND COMM_CD LIKE '"+JSPUtil.rns(p_box.getString("UP_CD"))+"%'				\n");
			sb.append("ORDER BY COMM_CD"                                                    		   );

		} else if (p_box.get("GBN").equals("DOC3")) {				//세부분류
			sb.append("SELECT 	COMM_CD AS CODE_CD, COMM_NM AS CODE_NM, '' CD_GBN					\n");
			sb.append("FROM 		ASNHR.T_ACT_COMMON												\n");
			sb.append("WHERE 		1 = 1															\n");
			sb.append("AND LENGTH(COMM_CD) = 4														\n");
			sb.append("AND COMM_NM LIKE '%"+JSPUtil.rns(p_box.getString("COMM_CD"))+"%'				\n");
			sb.append("AND COMM_CD LIKE '"+JSPUtil.rns(p_box.getString("UP_CD"))+"%'				\n");			
			sb.append("ORDER BY COMM_CD"                                                    		   );


		}		
		

		String sql = sb.toString();

		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, null, prop);

	}	
	

}
