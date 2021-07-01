package Ehr.ins.b.insb040.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class INSB040DAO extends AbstractDAO {
	/**
	 * INSB040DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSB040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * 주민번호로 검색해 대상자가 있는지 여부를 검사한다.
     * @param cet_no
     * @return
     * @throws CException
     */
    public String INSB040_SHR(String cet_no) throws CException {
        String sql = XmlSqlUtils.getSQL("ins", "INSB040_SHR");

        Object[] bind = new Object[] {
                JSPUtil.rns(cet_no)
        };

        GauceValueObject vo = this.selectProcessGvo(sql, bind).get(0);
        return vo.getString("CHK");
    }

	/**
	 * 국민연금등급을 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public int INSB040_UPT(GauceValueObject vo, CBox p_box) throws CException {

		//인사마스터 테이블 수정(T_CM_PERSON)
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("ins", "INSB040_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("HINU_AMT")),				
				JSPUtil.rns(vo.get("OLD_AMT")),
				JSPUtil.rns(vo.get("ENO_NO"))
		};

		/** UPDATE메소드 호출  **/
		return updateProcess(sql, bind);
	}

}
