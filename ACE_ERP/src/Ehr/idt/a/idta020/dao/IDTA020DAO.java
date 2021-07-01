package hr.idt.a.idta020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import common.util.JSPUtil;

public class IDTA020DAO extends AbstractDAO {
	/**
	 * IDTA020DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTA020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 증명서발급현황을 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTA020_SHR(CBox p_box) throws CException {

		String STR_YMD_SHR = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String CEF_RSN_SHR  = JSPUtil.rns(p_box.get("CEF_RSN_SHR"));
		String ENO_NO_SHR  = JSPUtil.rns(p_box.get("ENO_NO_SHR"));
		String HIR_NM  = JSPUtil.rns(p_box.get("HIR_NM"));
		String RET_NM  = JSPUtil.rns(p_box.get("RET_NM"));
		String EXP_NM  = JSPUtil.rns(p_box.get("EXP_NM"));
		String CAR_NM  = JSPUtil.rns(p_box.get("CAR_NM"));

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTA020_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {};

		/** 조회 조건(사용일자)에 따른 처리 **/
		StringBuffer sb = new StringBuffer();
		if (!STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.SPL_YMD >= '"+STR_YMD_SHR+"' \n");
			sb.append("AND A.SPL_YMD <= '"+END_YMD_SHR+"' \n");
		} else if (!STR_YMD_SHR.equals("") && END_YMD_SHR.equals("")) {
			sb.append("AND A.SPL_YMD >= '"+STR_YMD_SHR+"' \n");
		} else if (STR_YMD_SHR.equals("") && !END_YMD_SHR.equals("")) {
			sb.append("AND A.SPL_YMD <= '"+END_YMD_SHR+"' \n");
		}

		// 용도
		if( !CEF_RSN_SHR.equals("0")){
			sb.append("AND A.CEF_RSN = '"+CEF_RSN_SHR+"' \n");
		}

		if (!ENO_NO_SHR.equals("")) {
			sb.append("AND A.ENO_NO = '"+ENO_NO_SHR+"' \n");
		}

		int num = 0;
		String con = " AND( ";
		if( !HIR_NM.equals("") ){
			con += "A.CEF_SEC = '"+HIR_NM+"'";
			num++;
		}
		if( !RET_NM.equals("") ){
			if( num > 0){ con += " OR "; }
			con += "A.CEF_SEC = '"+RET_NM+"'";
			num++;
		}
		if( !EXP_NM.equals("") ){
			if( num > 0){ con += " OR "; }
			con += "A.CEF_SEC = '"+EXP_NM+"'";
			num++;
		}
		if( !CAR_NM.equals("") ){
			if( num > 0){ con += " OR "; }
			con += "A.CEF_SEC = '"+CAR_NM+"'";
			num++;
		}
		con += ")";

		if( num > 0){
			sb.append(con+" \n");
		}

		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
			sb.toString()
		};

		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);

		this.selectProcessFirstRow(sql, bind, prop);

	}
}
