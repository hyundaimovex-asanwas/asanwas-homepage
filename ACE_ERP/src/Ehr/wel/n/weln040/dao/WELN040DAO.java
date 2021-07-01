package Ehr.wel.n.weln040.dao;

import com.gauce.GauceDataSet;
import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;

public class WELN040DAO extends AbstractDAO {
	/**
	 * WELN010DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public WELN040DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

    /**
     * 정보 SELECT를 수행하는 DAO 메소드
     * @param p_box
     * @throws CException
     */
    public void WELN040_SHR(CBox p_box) throws CException {

        //System.out.println("p_box=>"+p_box);

        /** 외부 XML에서 정보 조회 SQL 읽음 **/
        String sql = XmlSqlUtils.getSQL("wel", "WELN040_SHR");


        /** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
        Object[] bind = new Object[] {
                p_box.get("CON_YMD_SHR").replaceAll("-", ""),                // 결재년월
                p_box.get("ENO_NO_SHR"),                						// 결재년월
        };

		/**Query  실행 후 자료 결과값을 Request한 Client Dataset에 직접 반환(FirstRow방식)  **/
		this.selectProcessFirstRow(sql, bind, prop);

    }



}
