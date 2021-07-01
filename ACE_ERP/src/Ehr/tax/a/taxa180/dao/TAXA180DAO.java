package Ehr.tax.a.taxa180.dao;

import com.shift.gef.core.exception.CException;
import com.shift.gef.dbms.utility.XmlSqlUtils;
import com.shift.gef.enterprise.dao.AbstractDAO;
import com.shift.gef.gauce.utility.ColumnProp;
import com.shift.gef.gauce.utility.TrBox;
import com.shift.gef.support.collection.CBox;
import com.shift.gef.support.vo.GauceValueObject;

public class TAXA180DAO extends AbstractDAO {
	/**
	 * TAXA180DAO 생성자
	 * @param p_conn	   Connection
	 * @param p_tr		   TrBox
	 * @throws CException
	 */
	public TAXA180DAO(String p_dsId, TrBox p_tr) throws CException {

		/** SuperClass의 생성자 호출 **/
		super(p_dsId, p_tr);

	}

	/**
	 * 정보 SELECT를 수행하는 DAO 메소드
	 * @param p_box
	 * @throws CException
	 */
	public void TAXA180_SHR(CBox p_box) throws CException {

		/** 외부 XML에서 지점정보 테이블 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("tax", "TAXA180_SHR");

		//System.out.println(p_box);
		
		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("PIS_YM_TO").replaceAll("-", ""), 				
				p_box.get("PIS_YM_FR").replaceAll("-", ""), 
				p_box.get("ENO_NO")
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}

	public void TAXA180_SHR2(CBox p_box) throws CException {

		/** 외부 XML에서 지점정보 테이블 조회 SQL 읽음 **/
		String sql = XmlSqlUtils.getSQL("tax", "TAXA180_SHR2");

		/** SQL에 바인딩 될 값을 순차적으로 넣어 준다 (검색조건) **/
		Object[] bind = new Object[] {
				p_box.get("ENO_NO")
		};

		/** FirstRow메소드 호출 **/
		this.selectProcessFirstRow(sql, bind, prop);

	}	
	
}
