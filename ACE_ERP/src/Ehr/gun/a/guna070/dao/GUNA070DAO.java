package Ehr.gun.a.guna070.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class GUNA070DAO extends AbstractDAO {

	/**
	 * GUNA070DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUNA070DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 근태현황 결재처리 조회
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA070_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA070_SHR");
		
		String STR_YMD_SHR = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String STR_YYYY = STR_YMD_SHR.substring(0,6);
		String END_YYYY = END_YMD_SHR.substring(0,6);
		String APP_YN_SHR = JSPUtil.rns(p_box.get("APP_YN_SHR"));

		StringBuffer sb = new StringBuffer();
		
		if(!"".equals(APP_YN_SHR) ) {
			
			sb.append("AND DECODE(A.APP_YN, NULL, 'A', A.APP_YN) = '").append(APP_YN_SHR).append("'         \n");
			
		}

		/*  결재 목록  조회 권한 */
		StringBuffer sb3 = new StringBuffer();
		
		//String SESSION_ENO_NO = JSPUtil.rns(p_box.get("vusrid"));
		
		if(!p_box.get("SESSION_ROLE_CD").equals("1001") && !p_box.get("SESSION_ROLE_CD").equals("1002") ){
			
			 //sb3.append("AND   (A.PENO_NO = '"+ SESSION_ENO_NO + "' OR A.ENO_NO = '"+ SESSION_ENO_NO +"') ");
			 sb3.append("AND   1 =1  ");			 
		}else{
			
			 sb3.append("AND   1 =1  ");
			 
		}
		
		
		Object[] sqlParam = new Object[] {
				sb.toString(),
                sb3.toString()
        };
        sql = SqlUtils.replaceQuery(sql, sqlParam);

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(p_box.get("ENO_NO")),
				JSPUtil.rns(p_box.get("OUR_MAN")),
				JSPUtil.rns(p_box.get("GUN_GBN_SHR")),
				STR_YMD_SHR,
				END_YMD_SHR,
				STR_YMD_SHR,
				END_YMD_SHR,
				STR_YYYY,
				END_YYYY,
				STR_YMD_SHR,
				END_YMD_SHR,
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		prop.add("GUN_GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		this.selectProcessFirstRow(sql, bind, prop);


	}

	/**
	 * 관리자 조회
	 * @param p_box
	 * @throws CException
	 */
	public void GUNA070_SHR_01(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUNA070_SHR_01");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("STR_YMD").replaceAll("-", ""),
				p_box.get("END_YMD").replaceAll("-", ""),
				p_box.get("STR_YMD").replaceAll("-", ""),
				p_box.get("END_YMD").replaceAll("-", ""),
				p_box.get("STR_YMD").replaceAll("-", ""),
				p_box.get("END_YMD").replaceAll("-", ""),
				p_box.get("STR_YMD").replaceAll("-", ""),
				p_box.get("END_YMD").replaceAll("-", ""),
				p_box.get("DPT_CD")

		};

		prop.add("GUN_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("REQ_YMD", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);
	}


}

