package Ehr.ins.f.insf020.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import Ehr.common.util.JSPUtil;

public class INSF020DAO extends AbstractDAO {
	/**
	 * INSB020DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public INSF020DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * 개인연금 공제내역 리스트를 조회한다.
     * @param p_box
     * @throws CException
     */
    public void INSF020_SHR(CBox p_box) throws CException {
        String Query = XmlSqlUtils.getSQL("ins", "INSF020_SHR");

        //param binding 하기
        Object[] bind = new Object[] {
                 JSPUtil.rns(p_box.get("SAV_CD2"))

        };

        //값 보내고 DataSet 가져오기
        this.selectProcessFirstRow(Query, bind, prop);
    }
}
