package Ehr.pir.a.pira030.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class PIRA030DAO extends AbstractDAO {
	/** 
	 * PIRA030DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public PIRA030DAO(String p_dsId, TrBox p_tr) throws CException {
		
		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);
		
	}
	
	/**
	 * 공조부조 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void PIRA030_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 공조부조 데이터 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("pir", "PIRA030_SHR");
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")                      // 사번
		};
		
		prop.add("ENO_NO", ColumnProp.COLUMN_TYPE_STRING , 8, ColumnProp.CONSTRAINT_TB_KEY);
		prop.add("EDGR_CD", ColumnProp.COLUMN_TYPE_STRING , 2, ColumnProp.CONSTRAINT_TB_KEY);
		
		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
	}
}
