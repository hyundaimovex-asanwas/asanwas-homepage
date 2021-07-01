package Ehr.idt.c.idtc080.dao;


import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.SqlUtils;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;
import Ehr.common.util.JSPUtil;


public class IDTC080DAO extends AbstractDAO {
	
	/**
	 * IDTC080DAO 생성자 이며, FirstRow 기능을 지원하기 위해서는 아래와 같이
	 * Connection, TrBox객체를 이용해서 생성자를 만들어 주어야 한다.
	 * @param p_conn	Connection
	 * @param p_tr		TrBox
	 * @throws CException
	 */
	public IDTC080DAO(String p_conn, TrBox p_tr) throws CException {
		/** SuperClass의 생성자 호출 **/
		super(p_conn, p_tr);
	}

	
	
	/**
	 * 주간업무보고 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC080_SHR(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC080_SHR");

		
		/** 조회 조건(조건1)에 따른 처리 #1  상태**/
		StringBuffer sb1 = new StringBuffer();

		if (p_box.get("ENO_NO").equals("")) {

		}else {
			
		}		
		
        /** DynamicSQL을 적용하는 부분 [1] ~ [xx]에 순차적으로 맵핑하게 된다 **/
        Object[] sqlParam = new Object[] {

				sb1.toString(),
        		
        };
        

        /** [1] ~ [xx] 정보를 위의 sqlParam을 적용해서 SQL문을 반환하게 된다 **/
        sql = SqlUtils.replaceQuery(sql, sqlParam);


		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

                //JSPUtil.rns(p_box.get("PIS_YY"))
				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	
	
	

	/**
	 * 주간업무보고 정보를 조회해 오는 DAO메소드
	 * @param p_box	CBox
	 * @throws CException
	 */
	public void IDTC080_SHR_DTL(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC080_SHR_DTL");

		int WEEK_NO2 = Integer.parseInt(p_box.get("WEEK_NO")) + 1 ;	
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {
				p_box.get("WEEK_NO"),
				p_box.get("WEEK_NO"),
				WEEK_NO2,
				WEEK_NO2,				
				p_box.get("ENO_NO"),
				p_box.get("WEEK_NO"),
				WEEK_NO2,
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}

	


	
	
	public void IDTC080_SHR_ALL(CBox p_box) throws CException {
		
		/** 외부 XML에서 SQL을 읽어 온다 **/
		String sql = XmlSqlUtils.getSQL("idt", "IDTC080_SHR_ALL");



		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 **/
		Object[] bind = new Object[] {

            JSPUtil.rns(p_box.get("ENO_NO"))
				
		};

		this.selectProcessFirstRow(sql, bind, prop);
		
	}	
	
	

}