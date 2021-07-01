package Ehr.acq.a.acqa002.dao;


import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

import Ehr.common.util.JSPUtil;


public class ACQA002DAO extends AbstractDAO {
	
	/**
	 * ACQA002DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACQA002DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}


	/**
	 * 문서 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACQA002_SHR_ACC(CBox p_box) throws CException {
		
		
		/** 프로그램 사용 로그 정보를 기록한다 **/
		String sql = XmlSqlUtils.getSQL("acq", "ACCESS_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				"PC",
				"전체 진행 현황",
				p_box.get("vusrid"),
				p_box.get("vusrip"),
				"D",
				p_box.get("FILE_NM"),
		};

		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);				

	}		
	

	
}
