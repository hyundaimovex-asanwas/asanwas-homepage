package common.popup.achpnt.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class ACHPNTDAO extends AbstractDAO {
	/** 
	 * ACHPNTDAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이 
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public ACHPNTDAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}
	
	/**
	 * 달성도배점정보를 조회해 오는  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void ACHPNT_SHR(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "ACHPNT_SHR");
		
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("GUBUN"),
				p_box.get("EVL_YY")
		};
		
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
}
