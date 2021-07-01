package Ehr.edu.e.edue040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;


public class EDUE040DAO extends AbstractDAO {

	/**
	 * GUNA070DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EDUE040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	/**
	 * 근태현황 결재처리 조회
	 * @param p_box
	 * @throws CException
	 */
	public void EDUE040_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("edu", "EDUE040_SHR");
		
		String STR_YMD_SHR = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String END_YMD_SHR = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String APP_YN_SHR = JSPUtil.rns(p_box.get("APP_YN_SHR"));

		StringBuffer sb = new StringBuffer();

		if(!"".equals(APP_YN_SHR) ) {
			sb.append("AND DECODE(A.APP_YN, NULL, 'A', A.APP_YN) = '").append(APP_YN_SHR).append("'         \n");
		}
		
		if(!"".equals(STR_YMD_SHR)) {
            sb.append("AND A.IPT_YMD >= TO_DATE('"+STR_YMD_SHR+"', 'YYYYMMDD') \n");
        }
		
		if(!"".equals(END_YMD_SHR)) {
            sb.append("AND TO_CHAR(A.IPT_YMD, 'YYYYMMDD') <= '"+END_YMD_SHR+"'  \n");
        }
		
		String ENO_NO = "";
		
		ENO_NO = JSPUtil.rns(p_box.get("vusrid"));

		if("6060002".equals(p_box.get("vusrid"))||"2020008".equals(p_box.get("vusrid"))||"6180001".equals(p_box.get("vusrid"))||"2070019".equals(p_box.get("vusrid"))||"2070020".equals(p_box.get("vusrid"))){

			ENO_NO = "";

	    }		
		
		Object[] sqlParam = new Object[] {
				
                sb.toString(),
                
        };

        sql = SqlUtils.replaceQuery(sql, sqlParam);

        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				ENO_NO,
				ENO_NO
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		prop.add("GUN_GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 20, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_STATUS", ColumnProp.COLUMN_TYPE_STRING, 100, ColumnProp.CONSTRAINT_TB_NORMAL);
		
		this.selectProcessFirstRow(sql, bind, prop);

	}

}

