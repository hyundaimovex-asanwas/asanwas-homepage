package common.popup.empl3.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;

public class EMPL3DAO extends AbstractDAO {
	/** 
	 * EMPL3DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이 
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public EMPL3DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}
	
	/**
	 * 평가구조 설정 내용을 조회해 오는  DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void EMPL3_SHR(CBox p_box) throws CException {
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("common", "EMPL3_SHR");
		
		/** 조회 조건에 따른 처리 #1 **/
		StringBuffer sb = new StringBuffer();
		
        // 재직중인 직원
		if (p_box.get("GUBUN").equals("0")) {
			sb.append("AND (RET_YMD IS NULL\n");
		    sb.append("OR    RET_YMD >= SYSDATE)\n");
	    }
		// 퇴사자
		else if (p_box.get("GUBUN").equals("1")) {
			sb.append("AND RET_YMD IS NOT NULL");
		}
        //	재직/퇴사자 구분없이
		else if (p_box.get("GUBUN").equals("1")) {
			sb.append("AND 1 = 1 \n");
		}
		
		/** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
		Object[] sqlParam = new Object[] {
				sb.toString()
		};
		
		/** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
		sql = SqlUtils.replaceQuery(sql, sqlParam);
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO"),
				p_box.get("ENO_NO")
		};
		
		/** SELECT메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);
		
	}
	
}
