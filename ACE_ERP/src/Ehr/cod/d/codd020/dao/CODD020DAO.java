package Ehr.cod.d.codd020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class CODD020DAO extends AbstractDAO {
    /**
     * ATCB013DAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public CODD020DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_dsId, p_tr);
	}

    /**
     * 통합결재현황 조회
     * @param p_box CBox
     * @throws CException
     */
	public void CODD020_SHR(CBox p_box ) throws CException {
		
		String eno_no = JSPUtil.rns(p_box.get("ENO_NO_SHR"));
		String str_ymd = JSPUtil.rns(p_box.get("STR_YMD_SHR")).replaceAll("-", "");
		String end_ymd = JSPUtil.rns(p_box.get("END_YMD_SHR")).replaceAll("-", "");
		String app_yn = JSPUtil.rns(p_box.get("APP_YN_SHR"));
		
		/** 외부 XML에서 프로그램 사용 로그 정보 (조회) SQL을 읽어 온다 **/
		
		String sql = XmlSqlUtils.getSQL("cod", "CODD020_SHR");


		Object[] bind = new Object[] {
				str_ymd,
				end_ymd,
				eno_no,

				str_ymd,
				end_ymd,
				eno_no,

				str_ymd,
				end_ymd,
				eno_no,

				app_yn

		};

		prop.add("GBN_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("PENO_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("ENO_NM", ColumnProp.COLUMN_TYPE_STRING, 50, ColumnProp.CONSTRAINT_TB_NORMAL);
		prop.add("APP_YN", ColumnProp.COLUMN_TYPE_STRING, 10, ColumnProp.CONSTRAINT_TB_NORMAL);
		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}
	
}

