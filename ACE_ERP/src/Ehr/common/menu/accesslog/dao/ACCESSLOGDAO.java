package common.menu.accesslog.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;


public class ACCESSLOGDAO extends AbstractDAO {
    /**
     * ACQA040DAO 생성자
     * @param p_conn       Connection
     * @param p_tr         TrBox
     * @throws CException
     */
	public ACCESSLOGDAO(String p_dsId, TrBox p_tr) throws CException {

			/** SuperClass의 생성자 호출 **/
			super(p_dsId, p_tr);
	}

    /**
     * 프로그램 사용 로그 정보 저장 DAO 메서드
     * @param p_box CBox
     * @throws CException
     */
	public void ACCESSLOG_INS(CBox p_box ) throws CException {

		/** 외부 XML에서 프로그램 사용 로그 정보 (저장) SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACCESSLOG_INS");

		/** 검색 조건 Mapping(PrepareStatement ) **/
		Object[] bind = new Object[] {
				p_box.get("SESS_ID"),
				p_box.get("PROG_ID"),
				p_box.get("SESSION_ENONO"),
				p_box.get("SESSION_ENONM"),
				p_box.get("SESSION_DPTCD"),
				p_box.get("SESSION_JOBCD"),
				p_box.get("IPADDRESS"),
				p_box.get("ACT_GBN")
		};


		/** INSERT메소드 호출  **/
		this.insertProcess(sql, bind);

	}



}
