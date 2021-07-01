package Ehr.cod.d.codd050.dao;

import Ehr.common.util.JSPUtil;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class CODD050DAO extends AbstractDAO {

	
	public CODD050DAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_dsId, p_tr);
	}

	
    /**
     * 미확인 메세지 현황 조회
     * @param p_box CBox
     * @throws CException
     */
	public void CODD050_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 미확인 메세지 정보 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODD050_SHR");

		Object[] bind = new Object[] {
				p_box.get("ENO_NO_SHR"),
		};

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}
	

	/**
     * 미확인 메세지 확인처리 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void CODD050_UPT(GauceValueObject vo, CBox p_box ) throws CException {

		/** 외부 XML에서 확인처리 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("cod", "CODD050_UPT");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("SEQ")),				//일련번호
				JSPUtil.rns(vo.get("ENO_NO"))			//사원번호
		};

		/** UPDATE메소드 호출  **/
		this.updateProcess(sql, bind);

	}	
	

}



