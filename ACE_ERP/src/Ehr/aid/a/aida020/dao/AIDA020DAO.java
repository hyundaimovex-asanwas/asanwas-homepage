package Ehr.aid.a.aida020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class AIDA020DAO extends AbstractDAO {
	/**
	 * AIDA020DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public AIDA020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 경공조금 지급처리 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void AIDA020_SHR(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("aid", "AIDA020_SHR");

		String REQ_YMD_STDT_SHR = JSPUtil.rns(p_box.get("REQ_YMD_STDT_SHR")).replaceAll("-", "");
		String REQ_YMD_ENDT_SHR = JSPUtil.rns(p_box.get("REQ_YMD_ENDT_SHR")).replaceAll("-", "");

		/** 조회 조건(지급일자)에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		if (!REQ_YMD_STDT_SHR.equals("") && !REQ_YMD_ENDT_SHR.equals("")) {
			sb.append("AND REQ_YMD >= '"+REQ_YMD_STDT_SHR+"' \n");
			sb.append("AND REQ_YMD <= '"+REQ_YMD_ENDT_SHR+"' \n");
		} else if (!REQ_YMD_STDT_SHR.equals("") && REQ_YMD_ENDT_SHR.equals("")) {
			sb.append("AND REQ_YMD >= '"+REQ_YMD_STDT_SHR+"' \n");
		} else if (REQ_YMD_STDT_SHR.equals("") && !REQ_YMD_ENDT_SHR.equals("")) {
			sb.append("AND REQ_YMD <= '"+REQ_YMD_ENDT_SHR+"' \n");
		} 

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
                JSPUtil.rns(p_box.get("AID_STS_SHR"))
        };

		this.selectProcessFirstRow(sql, bind, prop);
	}
}
