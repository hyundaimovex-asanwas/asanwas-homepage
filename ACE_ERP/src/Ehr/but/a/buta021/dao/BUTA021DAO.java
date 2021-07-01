package Ehr.but.a.buta021.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class BUTA021DAO extends AbstractDAO {

	/**
	 * BUTA021DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public BUTA021DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 여비계산서 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR");



		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	
	
	/**
	 * 여비지급기준 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR_01");



		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 직급에 따른 단가명 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR_02(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR_02");

		/** 동행인에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();
		if (!p_box.get("COM_CD1").equals("")) {
			sb.append("UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD1")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}
		if (!p_box.get("COM_CD2").equals("")) {
			sb.append("            UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD2")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}
		if (!p_box.get("COM_CD3").equals("")) {
			sb.append("            UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD3")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}
		if (!p_box.get("COM_CD4").equals("")) {
			sb.append("            UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD4")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}
		if (!p_box.get("COM_CD5").equals("")) {
			sb.append("            UNION ALL \n");
			sb.append("            SELECT EXT_02 \n");
			sb.append("            FROM   ASNHR.T_CM_COMMON \n");
			sb.append("            WHERE  CD_GBN = 'A2' \n");
			sb.append("            AND    COMM_CD = '"+p_box.get("COM_CD5")+"' \n");
			sb.append("            AND    (END_YMD IS NULL OR END_YMD >= SYSDATE) \n");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				"A2",
				p_box.get("JOB_CD")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	/**
	 * 식비공제를 위한 휴일 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR_03(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR_03");



		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("BUT_FR_YMD").replaceAll("-", ""),
				p_box.get("BUT_TO_YMD").replaceAll("-", "")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}

	
	/**
	 * 출장품의 현황 조회
	 * @param p_box
	 * @throws CException
	 */
	public void BUTA021_SHR_04(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_SHR_04");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ORD_NO")
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}	


	/**
	 * 여비계산서를 저장하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void BUTA021_INS(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_INS");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
			JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
			JSPUtil.rns(vo.get("GBN_CD")),				//종별구분코드
			JSPUtil.rns(vo.get("SQN_NO")),				//일련번호
			JSPUtil.rns(vo.get("ENO_NO")),				//사번
			JSPUtil.rns(vo.get("NAM_KOR")),				//성명
			JSPUtil.rns(vo.get("DPT_CD")),				//부서코드
			JSPUtil.rns(vo.get("JOB_CD")),				//직위코드
			JSPUtil.rns(vo.get("CITY_DPT")),			//출장구간출발지
			JSPUtil.rns(vo.get("CITY_AVR")),			//출장구간도착지
			JSPUtil.rns3(vo.get("PRICE_AMT")),			//단가
			JSPUtil.rns3(vo.get("BAS_CNT")),			//수량
			JSPUtil.rns3(vo.get("COST_AMT")),			//소요금액
			JSPUtil.rns(vo.get("REMARK")),				//비고

			JSPUtil.rns(p_box.get("vusrid")),
			JSPUtil.rns(p_box.get("vusrid"))
		};

		/** INSERT메소드 호출  **/
		insertProcess(sql, bind);
	}

	/**
	 * 여비계산서 수정  DAO 메서드
	 * @param p_box
	 * @param vo		GauceValueObject
	 * @throws CException
	 */
	public void BUTA021_UPT(GauceValueObject vo, CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("CITY_DPT")),			//출장구간출발지
				JSPUtil.rns(vo.get("CITY_AVR")),			//출장구간도착지
				JSPUtil.rns3(vo.get("PRICE_AMT")),			//단가
				JSPUtil.rns3(vo.get("BAS_CNT")),			//수량
				JSPUtil.rns3(vo.get("COST_AMT")),			//소요금액
				JSPUtil.rns(vo.get("REMARK")),				//비고
				JSPUtil.rns3(vo.get("DESC_AMT")),			//식비공제액
				JSPUtil.rns(p_box.get("vusrid")),
				JSPUtil.rns(vo.get("ORD_NO")),				//품의번호
				JSPUtil.rns(vo.get("GBN_CD")),				//종별구분코드
				JSPUtil.rns(vo.get("SQN_NO")),				//일련번호
		};
		/** UPDATE메소드 호출  **/
		updateProcess(sql, bind);
	}

	/**
     * 여비계산서 삭제 DAO 메서드
     * @param p_box CBox
     * @param vo	GauceValueObject
     * @throws CException
     */
	public void BUTA021_DEL(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_DEL");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),				//품의번호
				vo.get("GBN_CD"),				//종별구분코드
				vo.get("SQN_NO"),				//일련번호
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

	/**
	 * 여비계산서 전체 삭제 DAO 메서드
	 * @param p_box CBox
	 * @param vo	GauceValueObject
	 * @throws CException
	 */
	public void BUTA021_DEL_01(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("but", "BUTA021_DEL_01");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				vo.get("ORD_NO"),				//품의번호
		};


		/** DELETE메소드 호출  **/
		this.deleteProcess(sql, bind);

	}

}

