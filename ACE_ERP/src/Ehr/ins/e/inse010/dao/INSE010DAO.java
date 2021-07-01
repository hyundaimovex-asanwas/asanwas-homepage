package Ehr.ins.e.inse010.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class INSE010DAO extends AbstractDAO {
	/**
	 * INSE010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSE010DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}



    /**
     *
     * @param cet_no
     * @return
     * @throws CException
     */
    public void INSE010_SHR(CBox p_box) throws CException {

        String sql = XmlSqlUtils.getSQL("ins", "INSE010_SHR");

        Object[] bind = new Object[] {

        };

		this.selectProcessFirstRow(sql, bind, prop);

    }




	/**
	 * 보증보험을 수정하는 DAO메소드.
	 * @param vo	GauceValueObject
	 * @param p_box	CBox
	 * @throws CException
	 */
	public int INSE010_UPT(GauceValueObject vo, CBox p_box) throws CException {

		//인사마스터 테이블 수정(T_CM_PERSON)
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("ins", "INSE010_UPT");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				JSPUtil.rns(vo.get("INSU_AMT")),
				JSPUtil.rns(vo.get("ENO_NO"))
		};

		/** UPDATE메소드 호출  **/
		return updateProcess(sql, bind);
	}

}
