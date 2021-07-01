package Ehr.gun.d.gund050.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;


public class GUND050DAO extends AbstractDAO {
	/**
	 * GUND040DAO 생성자
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public GUND050DAO(String p_conn, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);

	}

	/**
	 * 개인별 근태 집계 현황 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public GauceDataSet GUND050_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 개인별 근태 집계 현황 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("gun", "GUND050_SHR");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				
				p_box.get("ENO_NO"),	    	//
				p_box.get("DPT_CD"),	   		//
				p_box.get("SUBMIT_SHR"),		// 

		};

		/** FirstRow메소드 호출 **/
		//this.selectProcess(sql, bind, prop);
		return this.selectProcess(sql, bind, prop);
		//return this.selectProcessFirstRow(sql, bind, prop);
	}


}
