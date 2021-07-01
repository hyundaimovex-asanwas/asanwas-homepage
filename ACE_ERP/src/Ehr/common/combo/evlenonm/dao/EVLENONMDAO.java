package common.combo.evlenonm.dao;

import java.sql.Connection;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import common.util.JSPUtil;


public class EVLENONMDAO extends AbstractDAO {
    /**
     * EVLENONMDAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public EVLENONMDAO(String p_dsId, TrBox p_tr) throws CException {

        /** SuperClass의 생성자 호출 **/
        super(p_dsId, p_tr);
	}

    /**
     * 피평가자에 대한 평가자 조회 (조회) DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void EVLENONM_SHR(CBox p_box ) throws CException {

		/** 외부 XML에서 피평가자에 대한 평가자 조회 (조회) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "EVLENONM_SHR");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
                p_box.get("SESSION_GUBUN"),
				p_box.get("txtEVL_YY_SHR"),
                p_box.get("txtEVL_FRQ_SHR"),
                p_box.get("txtENO_NO_SHR")
		};
		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환  **/
		this.selectProcessFirstRow(sql, bind, this.prop);

	}

}
